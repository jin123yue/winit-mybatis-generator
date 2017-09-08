<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${namespace}">
  <resultMap id="BaseResultMap" type="${entityType}">
    <id column="ID" jdbcType="BIGINT" property="id" />
${resultMap}
  </resultMap>
  
  <!-- 基本列 -->
  <sql id="Base_Column_List">
    ${baseColumn}
  </sql>
  
  <!-- 单个插入 -->
  <insert id="insert${entityName}" parameterType="${entityType}" useGeneratedKeys="true" keyProperty="id">
    insert into ${tableName}
    <trim prefix="(" suffix=")" suffixOverrides=",">
${insertIfColumns}
    </trim>
    <trim prefix="values (" suffix=")" suffixOverrides=",">
${insertIfProps}
    </trim>
  </insert>
  
  <!-- 批量新增 -->
  <insert id="insert${entityName}Batch" parameterType="java.util.List">
    INSERT INTO ${tableName}
    (${insertBatchColumns})
    VALUES
    <foreach collection="list" item="item" index="index" separator=",">
       (${insertBatchProps})
    </foreach>
  </insert>
  
  <!-- 单个更新 -->
  <update id="update${entityName}" parameterType="${entityType}">
    update ${tableName}
    <set>
${updateColProps}
    </set>
    where ID = <#noparse>#{id,jdbcType=BIGINT}</#noparse>
  </update>
  
  <!-- 批量更新 -->
  <update id="update${entityName}Batch" parameterType="java.util.List">
    <foreach collection="list" item="item" index="index" open="" close="" separator=";">  
        UPDATE ${tableName}
        <set>
${updateBatchColProps}
        </set>
        WHERE ID = <#noparse>#{item.id,jdbcType=BIGINT}</#noparse>
    </foreach> 
  </update>
  
  <!-- 删除 -->
  <update id="delete${entityName}" parameterType="${entityType}" >
    update ${tableName} set UPDATED = <#noparse>#{updated,jdbcType=TIMESTAMP}</#noparse>,UPDATEDBY = <#noparse>#{updatedby,jdbcType=VARCHAR}</#noparse>, IS_DELETE = 'Y'
    where ID = <#noparse>#{id,jdbcType=BIGINT}</#noparse>
  </update>
  
  <!-- 批量删除 -->
  <update id="delete${entityName}Batch" parameterType="java.util.List" >
    <foreach collection="list" item="item" index="index" open="" close="" separator=";">  
        update ${tableName}
        set UPDATED = <#noparse>#{item.updated,jdbcType=TIMESTAMP}</#noparse>,UPDATEDBY = <#noparse>#{item.updatedby,jdbcType=VARCHAR}</#noparse>, IS_DELETE = 'Y'
        where ID = <#noparse>#{item.id,jdbcType=BIGINT}</#noparse>
    </foreach> 
  </update>
  
  <!-- 查询所有 -->
  <select id="query${entityName}List" parameterType="java.util.Map" resultMap="BaseResultMap" >
    SELECT * FROM ${tableName} 
  </select>
  
  <!-- 分页查询 -->
  <select id="query${entityName}ListPage" parameterType="java.util.Map" resultMap="BaseResultMap" >
    SELECT * FROM ${tableName} 
  </select>
  
  <!-- 单个查询 -->
  <select id="query${entityName}First" parameterType="${entityType}" resultMap="BaseResultMap">
    SELECT
    <include refid="Base_Column_List" />
    FROM ${tableName} 
    WHERE IS_DELETE = 'N'
    <if test="id != null">
      AND id = <#noparse>#{id, jdbcType=BIGINT}</#noparse>
    </if>
  </select>
</mapper>