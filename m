Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59348E0C1
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101637; cv=none; b=aftofabLyJnsjv1GUXuYLzr5l5PyxoufOrCWaj3CdI/miioxeom9nO9OXEs84oCelvQ1LTaL08BQ2ZND7qYdfH1gCKSBDZjDeb/3C6tjJAYxLJHl9bD/0Folj7AETUH3riSn4Y95ad58byk8je3hUE/Yja201fJb4qiKXC3onzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101637; c=relaxed/simple;
	bh=V88NOLkF/IJ670wq75ooUkU1C+dvWqwkp/u6sy43TNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRdgPMCjaeopJjk0L7DjMgoZYnzr8XiSmc4wutVjhHTbx3dGhL6nHEE0j3Gor73gXGRne9ONdEoi4xKQlxSXd0nSQBlEYa/+h5SZWJ9GURVwi/yI+8o7MN6mmZm6b+6QigMgaGqF9dPJthZadPz3SZyoIhjhceXXLKMyX9dLdw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsY8SA/4; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsY8SA/4"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-530e28a62abso2255241cf.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101634; x=1790706434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nVeL+7vTFvXkSE5mBaWcD6vVnIFM7Y6q6/+RTD7RliM=;
        b=lsY8SA/4lwFuGz+r3SoS00ijtDNWKhbMpl6Isc2c/YIgBZVQsQUFTy/+CqFUjQhVRl
         Rt4DgRG/2TmT3+6BII4QebnwT9uAv2Z9uP12dLAJbK0UTeDQC6BFWNEuDf0pUrLcbv02
         27XhCWi+tu9dlpxYGFfS4xwbiDccT/mgMn21oer+qi6Rm+jHBONhh8ZtWAaZG9rZC3Pk
         c0FqgJVcPAxYT7LkIFTTQJYrTgmLHlagJNCm+DJi0x6qYkE/20maXubHzJ+B9gHNNnfR
         LOl5AjmcfW+Gc+/6YRPjKgdKYKXGgVCyuuXnJRRDrWbIF5PvmX68XHQlwCPFw+g1znBN
         hoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101634; x=1790706434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nVeL+7vTFvXkSE5mBaWcD6vVnIFM7Y6q6/+RTD7RliM=;
        b=s7edeGWg36FlozugJ/arCdwSQ3W2Ejj18pU6ACx0CbSXM5ASk5w5cYz8bifUD/LYvh
         ImQwmFnzcgJSRjTRIdbZjGKOHN2wYbqx3XeYx2LWyohKd/qkgfBHplcbL5nlSClftN3n
         ZGbL1Uxdv1tr5UONzvg5fLMaIDxHc3yJFlwqKQeSDVS9JFODaOpd4srTOz86/dBOONPE
         HB/26SvVCPvhsOl20MIM5E4Ntv4YhKmuMn1ECqJVb+t0yRnaezH5KC+2Hdv0znueKjnv
         MGvsNrdHZzMxT0ceARgeEVU08WBVKbAiJTpNIfRF/Ajj8gX+CaTTP9wqw7lqNKmxyKu2
         +3yw==
X-Gm-Message-State: AFuF++nnv+a5sAoqmO1sUZxhHJdiUpBdWoWgjhQgm8Po1oEOMqb6P5uC
	s1cCBu07Upb/qlQuehnPsblA+UtrempMdhcb+R5uSSMXl2DAwTh3aifpq/3FXQ==
X-Gm-Gg: AYBFou0nM5A772jrfu266ytwWleDqGTE0kKnTn21Zl0ZmL+n0DZ23tI5kEQYgDMJRKY
	8La4PrjgWbmsFfezpKRUYsfBrwiDRyqFgbYOoFMJ2Kfv7yq/YipDJhE34S8umV8dpEoi1PF0sXX
	5W1WTmn6QV5vnIk0eMgFXp4Gv/rAkSGJ8hTb6YFWkLzgiJXdzUeHsVh6j+slJf8tRE8B6uFGL2a
	EdF0cWoLa1RTAGpZJ/ai0sWZP5xNlvzL3Qxk7RqnNdRy741lKRfYuKjn4lzoLe/g7Jv9mHiWTQB
	2SUWUkrPAZ7rPNAmwgl1C+l/AsbTEyy5ZcMprlTxduOwLjXOy95Yfy5BAveo+JjJKrmAeHTV04m
	n/SezmEoFgSbWogGmpFeBKW8hhKcXuSf4z3O4znEah4jKJJKjaO3isimObY0LbPllWW6akgYoo9
	GRL+alVgbgqUqz12w5f3bGyrms/pjfwxoURnWHyc/I1dRmH+thlg+k3CnV+R5k8zlQroLJffUQE
	7+JD8kMsKLGCNTRo2QQQ/q7nnAQvQVOd403MAuWxdWTCcBtW1E8Mgsoh+haETwTn30ftLKhBrAz
	P+qjvdtrt87JFQMyY0sXWsXf2iyId1DzerzLsLyCli1fkvbTeQ9ajNsH5ISJBS1zM791kQ==
X-Received: by 2002:a05:622a:248c:b0:530:e0e4:b1ec with SMTP id d75a77b69052e-532eac93283mr6057871cf.9.1790101634364;
        Tue, 22 Sep 2026 11:27:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eaec2751sm3064991cf.1.2026.09.22.11.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:27:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Georgi Djakov <djakov@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] interconnect: qcom: fix endian annotations of BCM aux data
Date: Tue, 22 Sep 2026 11:27:11 -0700
Message-ID: <20260922182711.25176-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct qcom_icc_bcm::aux_data stores the values parsed from the command
db, converted to native byte order, but is typed as the raw little-endian
struct bcm_db. Sparse therefore complains when the converted values are
assigned to the __le32/__le16 fields and when those restricted fields
are used in bandwidth calculations.

Give aux_data its own native-endian struct type so the parsed values are
stored with matching annotations, keeping struct bcm_db as the on-disk
format returned by cmd_db_read_aux_data(). No functional change.

Fixes: c96fc14322ce ("interconnect: qcom: add COMPILE_TEST")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609221350.3Y8MOce9-lkp@intel.com/
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/interconnect/qcom/icc-rpmh.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 09d8791402dc..30ec31eafcfb 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -45,6 +45,9 @@ struct qcom_icc_provider {
  * @width: multiplier used to convert bytes/sec bw value to an RPMh msg
  * @vcd: virtual clock domain that this bcm belongs to
  * @reserved: reserved field
+ *
+ * This is the little-endian on-disk format returned by
+ * cmd_db_read_aux_data().
  */
 struct bcm_db {
 	__le32 unit;
@@ -53,6 +56,20 @@ struct bcm_db {
 	u8 reserved;
 };
 
+/**
+ * struct bcm_aux_data - Auxiliary data of a BCM in native byte order
+ * @unit: divisor used to convert bytes/sec bw value to an RPMh msg
+ * @width: multiplier used to convert bytes/sec bw value to an RPMh msg
+ * @vcd: virtual clock domain that this bcm belongs to
+ * @reserved: reserved field
+ */
+struct bcm_aux_data {
+	u32 unit;
+	u16 width;
+	u8 vcd;
+	u8 reserved;
+};
+
 #define MAX_PORTS		4
 
 /**
@@ -135,7 +152,7 @@ struct qcom_icc_bcm {
 	u32 enable_mask;
 	bool dirty;
 	bool keepalive;
-	struct bcm_db aux_data;
+	struct bcm_aux_data aux_data;
 	struct list_head list;
 	struct list_head ws_list;
 	size_t num_nodes;
-- 
2.55.0

