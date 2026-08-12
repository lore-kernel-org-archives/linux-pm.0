Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC97C47D92D;
	Wed, 12 Aug 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554615; cv=none; b=DlbSByzA1lT/Sk05V82gs5xveeElPvna1ZMHNgZzq4JXuF3fADmjKLQ8Ss61Ju1clgHp7+l+aU+OVdfafFV/nvj5yTmgJD/it89ZgaWNo3tB6wxUUYkP7KNZgmUkQkNEJDzEPZcwpfHLkzxKETAv+aGBvPnUwti3/1UaC0ouO+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554615; c=relaxed/simple;
	bh=Ga7SLZ6QerTdFI13h6GOfRV4LDJKUI9xMjNShzkX5rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGMrW7Thjz6GcAiX58Du+HVi3KdSRlVbUSIodvvib1kgzQKmYcAOZJGyLafhWBX8TdYmUWQH7Ns4JAyEBwMUXruSiLr16T8N8pHQfCyaN8AWo0xz+pVzG/xRGhrx5AC+KgYhpmHP7GEql2lYFYo4NPXMyyPkNtxuUEIKVQ8/VyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HG7pTEmQ; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HG7pTEmQ"
Received: from device-101.home ([10.64.95.103])
	by smtp.orange.fr with ESMTP
	id uCRnwXtuVUFw4uCRnwhbt1; Wed, 12 Aug 2026 19:08:59 +0200
Received: from device-101.home ([IPv6:2a01:cb10:785:b00:6128:9b8c:c203:905])
	by smtp.orange.fr with ESMTPSA
	id uCRdwygoWAdG7uCRewwjP3; Wed, 12 Aug 2026 19:08:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1786554530;
	bh=x9grDJF6l/rOjarQIuI0kSaum8t0Sh3hPENxVlSh0h8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=HG7pTEmQb8QKi930awxizPAHeA1S0HHKnM0oYtkUBqJPmuX6k9yGVsqIqIRrAx452
	 LUiODqMa5fz2MsoE1IBClUAVs2lZxSoImymgh6weS2MfLrTG2Kw4x+oLnHuzSBUm3t
	 g+hKI5oCxkpghJOeIamIfh25MwdPHC3SJ3y0QJP9V+kUPcVVA7bw1g6HlUTv9db3pV
	 wE2s+kOpb4oeWYJjXGnYOZE2PwN2pwYl05WClCnppF5S3wlw/9aaPhIhI85eQ1fLPQ
	 WOs0Wnj7iWSbqHCRtE3ezyDx9e2DKDXciOSgYHGevdUUvkUK3ALDROIevRXSOyBr72
	 N1g2H4U4rTZGA==
X-ME-Helo: device-101.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 12 Aug 2026 19:08:50 +0200
X-ME-IP: 2a01:cb10:785:b00:6128:9b8c:c203:905
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: qcom: Constify struct qcom_icc_qosbox
Date: Wed, 12 Aug 2026 19:08:42 +0200
Message-ID: <f9d9ab49e961b3bf3f9bad39f22cf8b06afb2381.1786554463.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct qcom_icc_qosbox' are not modified in these drivers.

Constifying these structures moves some data to a read-only section, so
increases overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   7807	  18632	      0	  26439	   6747	drivers/interconnect/qcom/eliza.o
  10027	  20176	      0	  30203	   75fb	drivers/interconnect/qcom/milos.o
   8768	  22640	      0	  31408	   7ab0	drivers/interconnect/qcom/sm6350.o
   7626	  22000	      0	  29626	   73ba	drivers/interconnect/qcom/sm8650.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   8095	  18344	      0	  26439	   6747	drivers/interconnect/qcom/eliza.o
  11079	  19120	      0	  30199	   75f7	drivers/interconnect/qcom/milos.o
   9668	  21744	      0	  31412	   7ab4	drivers/interconnect/qcom/sm6350.o
   8746	  20880	      0	  29626	   73ba	drivers/interconnect/qcom/sm8650.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/interconnect/qcom/eliza.c  | 18 ++++----
 drivers/interconnect/qcom/milos.c  | 66 ++++++++++++++--------------
 drivers/interconnect/qcom/sm6350.c | 56 ++++++++++++------------
 drivers/interconnect/qcom/sm8650.c | 70 +++++++++++++++---------------
 4 files changed, 105 insertions(+), 105 deletions(-)

diff --git a/drivers/interconnect/qcom/eliza.c b/drivers/interconnect/qcom/eliza.c
index 891e4e6e8ba8..ad03adef79ba 100644
--- a/drivers/interconnect/qcom/eliza.c
+++ b/drivers/interconnect/qcom/eliza.c
@@ -451,7 +451,7 @@ static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.link_nodes = { &qnm_gemnoc_cnoc },
 };
 
-static struct qcom_icc_qosbox alm_gpu_tcu_qos = {
+static const struct qcom_icc_qosbox alm_gpu_tcu_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x155000 },
 	.prio = 1,
@@ -468,7 +468,7 @@ static struct qcom_icc_node alm_gpu_tcu = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox alm_sys_tcu_qos = {
+static const struct qcom_icc_qosbox alm_sys_tcu_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x157000 },
 	.prio = 6,
@@ -494,7 +494,7 @@ static struct qcom_icc_node chm_apps = {
 			&qns_pcie },
 };
 
-static struct qcom_icc_qosbox qnm_gpu_qos = {
+static const struct qcom_icc_qosbox qnm_gpu_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x31000, 0xb1000 },
 	.prio = 0,
@@ -511,7 +511,7 @@ static struct qcom_icc_node qnm_gpu = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_lpass_gemnoc_qos = {
+static const struct qcom_icc_qosbox qnm_lpass_gemnoc_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x159000 },
 	.prio = 0,
@@ -538,7 +538,7 @@ static struct qcom_icc_node qnm_mdsp = {
 			&qns_pcie },
 };
 
-static struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
+static const struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x33000, 0xb3000 },
 	.prio = 0,
@@ -555,7 +555,7 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
+static const struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x35000, 0xb5000 },
 	.prio = 0,
@@ -572,7 +572,7 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
+static const struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x37000, 0xb7000 },
 	.prio = 0,
@@ -590,7 +590,7 @@ static struct qcom_icc_node qnm_nsp_gemnoc = {
 			&qns_pcie },
 };
 
-static struct qcom_icc_qosbox qnm_pcie_qos = {
+static const struct qcom_icc_qosbox qnm_pcie_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x15b000 },
 	.prio = 2,
@@ -688,7 +688,7 @@ static struct qcom_icc_node qnm_lpiaon_noc = {
 	.link_nodes = { &qns_lpass_ag_noc_gemnoc },
 };
 
-static struct qcom_icc_qosbox qnm_camnoc_nrt_icp_sf_qos = {
+static const struct qcom_icc_qosbox qnm_camnoc_nrt_icp_sf_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x25000 },
 	.prio = 4,
diff --git a/drivers/interconnect/qcom/milos.c b/drivers/interconnect/qcom/milos.c
index d010b106728a..8b5b5ee53e3b 100644
--- a/drivers/interconnect/qcom/milos.c
+++ b/drivers/interconnect/qcom/milos.c
@@ -137,7 +137,7 @@ static struct qcom_icc_node srvc_pcie_aggre_noc;
 static struct qcom_icc_node qns_gemnoc_gc;
 static struct qcom_icc_node qns_gemnoc_sf;
 
-static struct qcom_icc_qosbox qhm_qup1_qos = {
+static const struct qcom_icc_qosbox qhm_qup1_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xc000 },
 	.prio = 2,
@@ -154,7 +154,7 @@ static struct qcom_icc_node qhm_qup1 = {
 	.link_nodes = { &qns_a1noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_ufs_mem_qos = {
+static const struct qcom_icc_qosbox xm_ufs_mem_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xf200 },
 	.prio = 2,
@@ -171,7 +171,7 @@ static struct qcom_icc_node xm_ufs_mem = {
 	.link_nodes = { &qns_a1noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_usb3_0_qos = {
+static const struct qcom_icc_qosbox xm_usb3_0_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x10000 },
 	.prio = 2,
@@ -188,7 +188,7 @@ static struct qcom_icc_node xm_usb3_0 = {
 	.link_nodes = { &qns_a1noc_snoc },
 };
 
-static struct qcom_icc_qosbox qhm_qdss_bam_qos = {
+static const struct qcom_icc_qosbox qhm_qdss_bam_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x14000 },
 	.prio = 2,
@@ -205,7 +205,7 @@ static struct qcom_icc_node qhm_qdss_bam = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox qhm_qspi_qos = {
+static const struct qcom_icc_qosbox qhm_qspi_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x12000 },
 	.prio = 2,
@@ -222,7 +222,7 @@ static struct qcom_icc_node qhm_qspi = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox qhm_qup0_qos = {
+static const struct qcom_icc_qosbox qhm_qup0_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x13000 },
 	.prio = 2,
@@ -239,7 +239,7 @@ static struct qcom_icc_node qhm_qup0 = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox qxm_crypto_qos = {
+static const struct qcom_icc_qosbox qxm_crypto_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x15000 },
 	.prio = 2,
@@ -256,7 +256,7 @@ static struct qcom_icc_node qxm_crypto = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox qxm_ipa_qos = {
+static const struct qcom_icc_qosbox qxm_ipa_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x16000 },
 	.prio = 2,
@@ -273,7 +273,7 @@ static struct qcom_icc_node qxm_ipa = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_qdss_etr_0_qos = {
+static const struct qcom_icc_qosbox xm_qdss_etr_0_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x17000 },
 	.prio = 2,
@@ -290,7 +290,7 @@ static struct qcom_icc_node xm_qdss_etr_0 = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_qdss_etr_1_qos = {
+static const struct qcom_icc_qosbox xm_qdss_etr_1_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x18000 },
 	.prio = 2,
@@ -307,7 +307,7 @@ static struct qcom_icc_node xm_qdss_etr_1 = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_sdc1_qos = {
+static const struct qcom_icc_qosbox xm_sdc1_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x1a000 },
 	.prio = 2,
@@ -324,7 +324,7 @@ static struct qcom_icc_node xm_sdc1 = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_sdc2_qos = {
+static const struct qcom_icc_qosbox xm_sdc2_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x19000 },
 	.prio = 2,
@@ -404,7 +404,7 @@ static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.link_nodes = { &xs_pcie_0, &xs_pcie_1 },
 };
 
-static struct qcom_icc_qosbox alm_gpu_tcu_qos = {
+static const struct qcom_icc_qosbox alm_gpu_tcu_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xf1000 },
 	.prio = 1,
@@ -421,7 +421,7 @@ static struct qcom_icc_node alm_gpu_tcu = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox alm_sys_tcu_qos = {
+static const struct qcom_icc_qosbox alm_sys_tcu_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xf3000 },
 	.prio = 6,
@@ -447,7 +447,7 @@ static struct qcom_icc_node chm_apps = {
 		   &qns_pcie },
 };
 
-static struct qcom_icc_qosbox qnm_gpu_qos = {
+static const struct qcom_icc_qosbox qnm_gpu_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x31000, 0x71000 },
 	.prio = 0,
@@ -464,7 +464,7 @@ static struct qcom_icc_node qnm_gpu = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_lpass_gemnoc_qos = {
+static const struct qcom_icc_qosbox qnm_lpass_gemnoc_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xf5000 },
 	.prio = 0,
@@ -491,7 +491,7 @@ static struct qcom_icc_node qnm_mdsp = {
 		   &qns_pcie },
 };
 
-static struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
+static const struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x33000, 0x73000 },
 	.prio = 0,
@@ -508,7 +508,7 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
+static const struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x35000, 0x75000 },
 	.prio = 0,
@@ -525,7 +525,7 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
+static const struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x37000, 0x77000 },
 	.prio = 0,
@@ -543,7 +543,7 @@ static struct qcom_icc_node qnm_nsp_gemnoc = {
 		   &qns_pcie },
 };
 
-static struct qcom_icc_qosbox qnm_pcie_qos = {
+static const struct qcom_icc_qosbox qnm_pcie_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xf7000 },
 	.prio = 2,
@@ -560,7 +560,7 @@ static struct qcom_icc_node qnm_pcie = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_snoc_gc_qos = {
+static const struct qcom_icc_qosbox qnm_snoc_gc_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xf9000 },
 	.prio = 0,
@@ -577,7 +577,7 @@ static struct qcom_icc_node qnm_snoc_gc = {
 	.link_nodes = { &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_snoc_sf_qos = {
+static const struct qcom_icc_qosbox qnm_snoc_sf_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xfb000 },
 	.prio = 0,
@@ -620,7 +620,7 @@ static struct qcom_icc_node llcc_mc = {
 	.link_nodes = { &ebi },
 };
 
-static struct qcom_icc_qosbox qnm_camnoc_hf_qos = {
+static const struct qcom_icc_qosbox qnm_camnoc_hf_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0xa8000, 0xa9000 },
 	.prio = 0,
@@ -637,7 +637,7 @@ static struct qcom_icc_node qnm_camnoc_hf = {
 	.link_nodes = { &qns_mem_noc_hf },
 };
 
-static struct qcom_icc_qosbox qnm_camnoc_icp_qos = {
+static const struct qcom_icc_qosbox qnm_camnoc_icp_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x2a000 },
 	.prio = 5,
@@ -654,7 +654,7 @@ static struct qcom_icc_node qnm_camnoc_icp = {
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
-static struct qcom_icc_qosbox qnm_camnoc_sf_qos = {
+static const struct qcom_icc_qosbox qnm_camnoc_sf_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x2b000, 0x2c000 },
 	.prio = 0,
@@ -671,7 +671,7 @@ static struct qcom_icc_node qnm_camnoc_sf = {
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
-static struct qcom_icc_qosbox qnm_mdp_qos = {
+static const struct qcom_icc_qosbox qnm_mdp_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xad000 },
 	.prio = 0,
@@ -688,7 +688,7 @@ static struct qcom_icc_node qnm_mdp = {
 	.link_nodes = { &qns_mem_noc_hf },
 };
 
-static struct qcom_icc_qosbox qnm_video_qos = {
+static const struct qcom_icc_qosbox qnm_video_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x30000 },
 	.prio = 0,
@@ -737,7 +737,7 @@ static struct qcom_icc_node qsm_pcie_anoc_cfg = {
 	.link_nodes = { &srvc_pcie_aggre_noc },
 };
 
-static struct qcom_icc_qosbox xm_pcie3_0_qos = {
+static const struct qcom_icc_qosbox xm_pcie3_0_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xb000 },
 	.prio = 2,
@@ -754,7 +754,7 @@ static struct qcom_icc_node xm_pcie3_0 = {
 	.link_nodes = { &qns_pcie_mem_noc },
 };
 
-static struct qcom_icc_qosbox xm_pcie3_1_qos = {
+static const struct qcom_icc_qosbox xm_pcie3_1_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xc000 },
 	.prio = 2,
@@ -787,7 +787,7 @@ static struct qcom_icc_node qnm_aggre2_noc = {
 	.link_nodes = { &qns_gemnoc_sf },
 };
 
-static struct qcom_icc_qosbox qnm_apss_noc_qos = {
+static const struct qcom_icc_qosbox qnm_apss_noc_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x1c000 },
 	.prio = 2,
@@ -804,7 +804,7 @@ static struct qcom_icc_node qnm_apss_noc = {
 	.link_nodes = { &qns_gemnoc_sf },
 };
 
-static struct qcom_icc_qosbox qnm_cnoc_data_qos = {
+static const struct qcom_icc_qosbox qnm_cnoc_data_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x1d000 },
 	.prio = 2,
@@ -821,7 +821,7 @@ static struct qcom_icc_node qnm_cnoc_data = {
 	.link_nodes = { &qns_gemnoc_sf },
 };
 
-static struct qcom_icc_qosbox qxm_pimem_qos = {
+static const struct qcom_icc_qosbox qxm_pimem_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x1e000 },
 	.prio = 2,
@@ -838,7 +838,7 @@ static struct qcom_icc_node qxm_pimem = {
 	.link_nodes = { &qns_gemnoc_gc },
 };
 
-static struct qcom_icc_qosbox xm_gic_qos = {
+static const struct qcom_icc_qosbox xm_gic_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x1f000 },
 	.prio = 2,
diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index c098c608b836..8680d242ccfa 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -149,7 +149,7 @@ static struct qcom_icc_node qhm_a1noc_cfg = {
 	.link_nodes = { &srvc_aggre1_noc },
 };
 
-static struct qcom_icc_qosbox qhm_qup_0_qos = {
+static const struct qcom_icc_qosbox qhm_qup_0_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xa000 },
 	.prio = 2,
@@ -165,7 +165,7 @@ static struct qcom_icc_node qhm_qup_0 = {
 	.link_nodes = { &qns_a1noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_emmc_qos = {
+static const struct qcom_icc_qosbox xm_emmc_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x7000 },
 	.prio = 2,
@@ -181,7 +181,7 @@ static struct qcom_icc_node xm_emmc = {
 	.link_nodes = { &qns_a1noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_ufs_mem_qos = {
+static const struct qcom_icc_qosbox xm_ufs_mem_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x8000 },
 	.prio = 4,
@@ -205,7 +205,7 @@ static struct qcom_icc_node qhm_a2noc_cfg = {
 	.link_nodes = { &srvc_aggre2_noc },
 };
 
-static struct qcom_icc_qosbox qhm_qdss_bam_qos = {
+static const struct qcom_icc_qosbox qhm_qdss_bam_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xb000 },
 	.prio = 2,
@@ -221,7 +221,7 @@ static struct qcom_icc_node qhm_qdss_bam = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox qhm_qup_1_qos = {
+static const struct qcom_icc_qosbox qhm_qup_1_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x9000 },
 	.prio = 2,
@@ -236,7 +236,7 @@ static struct qcom_icc_node qhm_qup_1 = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox qxm_crypto_qos = {
+static const struct qcom_icc_qosbox qxm_crypto_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x6000 },
 	.prio = 2,
@@ -252,7 +252,7 @@ static struct qcom_icc_node qxm_crypto = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox qxm_ipa_qos = {
+static const struct qcom_icc_qosbox qxm_ipa_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x7000 },
 	.prio = 2,
@@ -268,7 +268,7 @@ static struct qcom_icc_node qxm_ipa = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_qdss_etr_qos = {
+static const struct qcom_icc_qosbox xm_qdss_etr_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xc000 },
 	.prio = 2,
@@ -284,7 +284,7 @@ static struct qcom_icc_node xm_qdss_etr = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_sdc2_qos = {
+static const struct qcom_icc_qosbox xm_sdc2_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x18000 },
 	.prio = 2,
@@ -300,7 +300,7 @@ static struct qcom_icc_node xm_sdc2 = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_usb3_0_qos = {
+static const struct qcom_icc_qosbox xm_usb3_0_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xd000 },
 	.prio = 2,
@@ -356,7 +356,7 @@ static struct qcom_icc_node qup1_core_master = {
 	.link_nodes = { &qup1_core_slave },
 };
 
-static struct qcom_icc_qosbox qnm_npu_qos = {
+static const struct qcom_icc_qosbox qnm_npu_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0xf000, 0x11000 },
 	.prio = 0,
@@ -372,7 +372,7 @@ static struct qcom_icc_node qnm_npu = {
 	.link_nodes = { &qns_cdsp_gemnoc },
 };
 
-static struct qcom_icc_qosbox qxm_npu_dsp_qos = {
+static const struct qcom_icc_qosbox qxm_npu_dsp_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x13000 },
 	.prio = 0,
@@ -495,7 +495,7 @@ static struct qcom_icc_node qhm_cnoc_dc_noc = {
 			&qhs_gemnoc },
 };
 
-static struct qcom_icc_qosbox acm_apps_qos = {
+static const struct qcom_icc_qosbox acm_apps_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x2f100, 0x2f000 },
 	.prio = 0,
@@ -512,7 +512,7 @@ static struct qcom_icc_node acm_apps = {
 			&qns_gem_noc_snoc },
 };
 
-static struct qcom_icc_qosbox acm_sys_tcu_qos = {
+static const struct qcom_icc_qosbox acm_sys_tcu_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x35000 },
 	.prio = 6,
@@ -539,7 +539,7 @@ static struct qcom_icc_node qhm_gemnoc_cfg = {
 			&qhs_mdsp_ms_mpu_cfg },
 };
 
-static struct qcom_icc_qosbox qnm_cmpnoc_qos = {
+static const struct qcom_icc_qosbox qnm_cmpnoc_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x2e000 },
 	.prio = 0,
@@ -556,7 +556,7 @@ static struct qcom_icc_node qnm_cmpnoc = {
 			&qns_gem_noc_snoc },
 };
 
-static struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
+static const struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x30000 },
 	.prio = 0,
@@ -573,7 +573,7 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 			&qns_gem_noc_snoc },
 };
 
-static struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
+static const struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x34000 },
 	.prio = 0,
@@ -590,7 +590,7 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 			&qns_gem_noc_snoc },
 };
 
-static struct qcom_icc_qosbox qnm_snoc_gc_qos = {
+static const struct qcom_icc_qosbox qnm_snoc_gc_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x32000 },
 	.prio = 0,
@@ -606,7 +606,7 @@ static struct qcom_icc_node qnm_snoc_gc = {
 	.link_nodes = { &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_snoc_sf_qos = {
+static const struct qcom_icc_qosbox qnm_snoc_sf_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x31000 },
 	.prio = 0,
@@ -622,7 +622,7 @@ static struct qcom_icc_node qnm_snoc_sf = {
 	.link_nodes = { &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qxm_gpu_qos = {
+static const struct qcom_icc_qosbox qxm_gpu_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x33000, 0x33080 },
 	.prio = 0,
@@ -655,7 +655,7 @@ static struct qcom_icc_node qhm_mnoc_cfg = {
 	.link_nodes = { &srvc_mnoc },
 };
 
-static struct qcom_icc_qosbox qnm_video0_qos = {
+static const struct qcom_icc_qosbox qnm_video0_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xf000 },
 	.prio = 2,
@@ -671,7 +671,7 @@ static struct qcom_icc_node qnm_video0 = {
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
-static struct qcom_icc_qosbox qnm_video_cvp_qos = {
+static const struct qcom_icc_qosbox qnm_video_cvp_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xe000 },
 	.prio = 5,
@@ -687,7 +687,7 @@ static struct qcom_icc_node qnm_video_cvp = {
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
-static struct qcom_icc_qosbox qxm_camnoc_hf_qos = {
+static const struct qcom_icc_qosbox qxm_camnoc_hf_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0xa000, 0xb000 },
 	.prio = 3,
@@ -703,7 +703,7 @@ static struct qcom_icc_node qxm_camnoc_hf = {
 	.link_nodes = { &qns_mem_noc_hf },
 };
 
-static struct qcom_icc_qosbox qxm_camnoc_icp_qos = {
+static const struct qcom_icc_qosbox qxm_camnoc_icp_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xd000 },
 	.prio = 5,
@@ -719,7 +719,7 @@ static struct qcom_icc_node qxm_camnoc_icp = {
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
-static struct qcom_icc_qosbox qxm_camnoc_sf_qos = {
+static const struct qcom_icc_qosbox qxm_camnoc_sf_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x9000 },
 	.prio = 3,
@@ -735,7 +735,7 @@ static struct qcom_icc_node qxm_camnoc_sf = {
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
-static struct qcom_icc_qosbox qxm_mdp0_qos = {
+static const struct qcom_icc_qosbox qxm_mdp0_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xc000 },
 	.prio = 3,
@@ -822,7 +822,7 @@ static struct qcom_icc_node qnm_gemnoc = {
 			&xs_qdss_stm },
 };
 
-static struct qcom_icc_qosbox qxm_pimem_qos = {
+static const struct qcom_icc_qosbox qxm_pimem_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xd000 },
 	.prio = 2,
@@ -839,7 +839,7 @@ static struct qcom_icc_node qxm_pimem = {
 			&qxs_imem },
 };
 
-static struct qcom_icc_qosbox xm_gic_qos = {
+static const struct qcom_icc_qosbox xm_gic_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xb000 },
 	.prio = 3,
diff --git a/drivers/interconnect/qcom/sm8650.c b/drivers/interconnect/qcom/sm8650.c
index cf3ae734d4c3..1967475b9132 100644
--- a/drivers/interconnect/qcom/sm8650.c
+++ b/drivers/interconnect/qcom/sm8650.c
@@ -154,7 +154,7 @@ static const struct regmap_config icc_regmap_config = {
 	.fast_io = true,
 };
 
-static struct qcom_icc_qosbox qhm_qspi_qos = {
+static const struct qcom_icc_qosbox qhm_qspi_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xc000 },
 	.prio = 2,
@@ -171,7 +171,7 @@ static struct qcom_icc_node qhm_qspi = {
 	.link_nodes = { &qns_a1noc_snoc },
 };
 
-static struct qcom_icc_qosbox qhm_qup1_qos = {
+static const struct qcom_icc_qosbox qhm_qup1_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xd000 },
 	.prio = 2,
@@ -196,7 +196,7 @@ static struct qcom_icc_node qxm_qup02 = {
 	.link_nodes = { &qns_a1noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_sdc4_qos = {
+static const struct qcom_icc_qosbox xm_sdc4_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xe000 },
 	.prio = 2,
@@ -213,7 +213,7 @@ static struct qcom_icc_node xm_sdc4 = {
 	.link_nodes = { &qns_a1noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_ufs_mem_qos = {
+static const struct qcom_icc_qosbox xm_ufs_mem_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xf000 },
 	.prio = 2,
@@ -230,7 +230,7 @@ static struct qcom_icc_node xm_ufs_mem = {
 	.link_nodes = { &qns_a1noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_usb3_0_qos = {
+static const struct qcom_icc_qosbox xm_usb3_0_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x10000 },
 	.prio = 2,
@@ -247,7 +247,7 @@ static struct qcom_icc_node xm_usb3_0 = {
 	.link_nodes = { &qns_a1noc_snoc },
 };
 
-static struct qcom_icc_qosbox qhm_qdss_bam_qos = {
+static const struct qcom_icc_qosbox qhm_qdss_bam_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x12000 },
 	.prio = 2,
@@ -264,7 +264,7 @@ static struct qcom_icc_node qhm_qdss_bam = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox qhm_qup2_qos = {
+static const struct qcom_icc_qosbox qhm_qup2_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x13000 },
 	.prio = 2,
@@ -281,7 +281,7 @@ static struct qcom_icc_node qhm_qup2 = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox qxm_crypto_qos = {
+static const struct qcom_icc_qosbox qxm_crypto_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x15000 },
 	.prio = 2,
@@ -298,7 +298,7 @@ static struct qcom_icc_node qxm_crypto = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox qxm_ipa_qos = {
+static const struct qcom_icc_qosbox qxm_ipa_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x16000 },
 	.prio = 2,
@@ -323,7 +323,7 @@ static struct qcom_icc_node qxm_sp = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_qdss_etr_0_qos = {
+static const struct qcom_icc_qosbox xm_qdss_etr_0_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x17000 },
 	.prio = 2,
@@ -340,7 +340,7 @@ static struct qcom_icc_node xm_qdss_etr_0 = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_qdss_etr_1_qos = {
+static const struct qcom_icc_qosbox xm_qdss_etr_1_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x18000 },
 	.prio = 2,
@@ -357,7 +357,7 @@ static struct qcom_icc_node xm_qdss_etr_1 = {
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
-static struct qcom_icc_qosbox xm_sdc2_qos = {
+static const struct qcom_icc_qosbox xm_sdc2_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x19000 },
 	.prio = 2,
@@ -448,7 +448,7 @@ static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.link_nodes = { &xs_pcie_0, &xs_pcie_1 },
 };
 
-static struct qcom_icc_qosbox alm_gpu_tcu_qos = {
+static const struct qcom_icc_qosbox alm_gpu_tcu_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xbf000 },
 	.prio = 1,
@@ -465,7 +465,7 @@ static struct qcom_icc_node alm_gpu_tcu = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox alm_sys_tcu_qos = {
+static const struct qcom_icc_qosbox alm_sys_tcu_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xc1000 },
 	.prio = 6,
@@ -482,7 +482,7 @@ static struct qcom_icc_node alm_sys_tcu = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox alm_ubwc_p_tcu_qos = {
+static const struct qcom_icc_qosbox alm_ubwc_p_tcu_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xc5000 },
 	.prio = 1,
@@ -508,7 +508,7 @@ static struct qcom_icc_node chm_apps = {
 			&qns_pcie },
 };
 
-static struct qcom_icc_qosbox qnm_gpu_qos = {
+static const struct qcom_icc_qosbox qnm_gpu_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x31000, 0x71000 },
 	.prio = 0,
@@ -525,7 +525,7 @@ static struct qcom_icc_node qnm_gpu = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_lpass_gemnoc_qos = {
+static const struct qcom_icc_qosbox qnm_lpass_gemnoc_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xb5000 },
 	.prio = 0,
@@ -552,7 +552,7 @@ static struct qcom_icc_node qnm_mdsp = {
 			&qns_pcie },
 };
 
-static struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
+static const struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x33000, 0x73000 },
 	.prio = 0,
@@ -569,7 +569,7 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
+static const struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x35000, 0x75000 },
 	.prio = 0,
@@ -586,7 +586,7 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
+static const struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x37000, 0x77000 },
 	.prio = 0,
@@ -604,7 +604,7 @@ static struct qcom_icc_node qnm_nsp_gemnoc = {
 			&qns_pcie },
 };
 
-static struct qcom_icc_qosbox qnm_pcie_qos = {
+static const struct qcom_icc_qosbox qnm_pcie_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xb7000 },
 	.prio = 2,
@@ -621,7 +621,7 @@ static struct qcom_icc_node qnm_pcie = {
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
-static struct qcom_icc_qosbox qnm_snoc_sf_qos = {
+static const struct qcom_icc_qosbox qnm_snoc_sf_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xbb000 },
 	.prio = 0,
@@ -639,7 +639,7 @@ static struct qcom_icc_node qnm_snoc_sf = {
 			&qns_pcie },
 };
 
-static struct qcom_icc_qosbox qnm_ubwc_p_qos = {
+static const struct qcom_icc_qosbox qnm_ubwc_p_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xc3000 },
 	.prio = 1,
@@ -656,7 +656,7 @@ static struct qcom_icc_node qnm_ubwc_p = {
 	.link_nodes = { &qns_llcc },
 };
 
-static struct qcom_icc_qosbox xm_gic_qos = {
+static const struct qcom_icc_qosbox xm_gic_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xb9000 },
 	.prio = 4,
@@ -705,7 +705,7 @@ static struct qcom_icc_node llcc_mc = {
 	.link_nodes = { &ebi },
 };
 
-static struct qcom_icc_qosbox qnm_camnoc_hf_qos = {
+static const struct qcom_icc_qosbox qnm_camnoc_hf_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x28000, 0x29000 },
 	.prio = 0,
@@ -722,7 +722,7 @@ static struct qcom_icc_node qnm_camnoc_hf = {
 	.link_nodes = { &qns_mem_noc_hf },
 };
 
-static struct qcom_icc_qosbox qnm_camnoc_icp_qos = {
+static const struct qcom_icc_qosbox qnm_camnoc_icp_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x2a000 },
 	.prio = 4,
@@ -739,7 +739,7 @@ static struct qcom_icc_node qnm_camnoc_icp = {
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
-static struct qcom_icc_qosbox qnm_camnoc_sf_qos = {
+static const struct qcom_icc_qosbox qnm_camnoc_sf_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x2b000, 0x2c000 },
 	.prio = 0,
@@ -756,7 +756,7 @@ static struct qcom_icc_node qnm_camnoc_sf = {
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
-static struct qcom_icc_qosbox qnm_mdp_qos = {
+static const struct qcom_icc_qosbox qnm_mdp_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x2d000, 0x2e000 },
 	.prio = 0,
@@ -781,7 +781,7 @@ static struct qcom_icc_node qnm_vapss_hcp = {
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
-static struct qcom_icc_qosbox qnm_video_qos = {
+static const struct qcom_icc_qosbox qnm_video_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x30000, 0x31000 },
 	.prio = 0,
@@ -798,7 +798,7 @@ static struct qcom_icc_node qnm_video = {
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
-static struct qcom_icc_qosbox qnm_video_cv_cpu_qos = {
+static const struct qcom_icc_qosbox qnm_video_cv_cpu_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x32000 },
 	.prio = 4,
@@ -815,7 +815,7 @@ static struct qcom_icc_node qnm_video_cv_cpu = {
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
-static struct qcom_icc_qosbox qnm_video_cvp_qos = {
+static const struct qcom_icc_qosbox qnm_video_cvp_qos = {
 	.num_ports = 2,
 	.port_offsets = { 0x33000, 0x34000 },
 	.prio = 0,
@@ -832,7 +832,7 @@ static struct qcom_icc_node qnm_video_cvp = {
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
-static struct qcom_icc_qosbox qnm_video_v_cpu_qos = {
+static const struct qcom_icc_qosbox qnm_video_v_cpu_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x35000 },
 	.prio = 4,
@@ -873,7 +873,7 @@ static struct qcom_icc_node qsm_pcie_anoc_cfg = {
 	.link_nodes = { &srvc_pcie_aggre_noc },
 };
 
-static struct qcom_icc_qosbox xm_pcie3_0_qos = {
+static const struct qcom_icc_qosbox xm_pcie3_0_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xb000 },
 	.prio = 3,
@@ -890,7 +890,7 @@ static struct qcom_icc_node xm_pcie3_0 = {
 	.link_nodes = { &qns_pcie_mem_noc },
 };
 
-static struct qcom_icc_qosbox xm_pcie3_1_qos = {
+static const struct qcom_icc_qosbox xm_pcie3_1_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0xc000 },
 	.prio = 2,
@@ -923,7 +923,7 @@ static struct qcom_icc_node qnm_aggre2_noc = {
 	.link_nodes = { &qns_gemnoc_sf },
 };
 
-static struct qcom_icc_qosbox qnm_apss_noc_qos = {
+static const struct qcom_icc_qosbox qnm_apss_noc_qos = {
 	.num_ports = 1,
 	.port_offsets = { 0x1c000 },
 	.prio = 2,
-- 
2.55.0

