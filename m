Received: from sonic310-11.consmr.mail.ir2.yahoo.com (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259D270575
	for <linux-pm@vger.kernel.org>; Sun, 10 May 2026 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778442933; cv=none; b=dToJxjQSWtif4AP7qjxk7/H7OaARIgrCHv+iBXgOJAzZOAVWi4qtS1XYV30bYQS1zh8AoGqSD5ru9O7XuKZg8rx0fXhu/pSCBSt3B+nfqlXIKjf/r6WIkgq6ef1qTC9AfdTzuFZkQTk+Di3Sxs+dvPQiICCU0QhCaYAvFFFIcBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778442933; c=relaxed/simple;
	bh=4XpeV4lF/a3HLV4YD1Rv9ICiEsfHbHExdHPabgjl0nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdi/62vHCdOktoiSR6NTb6slIJvnvI1LL1aKqAFzf3BG250WCuKoEnTPR5FtC7P4Oc45dImyua45fno08K0PTQSs9/UHudePk7ELhEN2QbljKVhozwMa+fXTvJcKhv4qjHQBlCyh/M64uO1tHWrlGmp1Ghbe0f3ccLvb7fokBVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=KeVSt6nL; arc=none smtp.client-ip=77.238.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KeVSt6nL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778442924; bh=EEXchYaNLhNNKyHPk7lxnuJFOBFGN9beR+dureZixG4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KeVSt6nLRPrAF2QrfMCJXHf+vnB2n3njElm3BpPHimm3b1yMA8RAq34DyJcmcVPUuIzkorIKSA8dRcRCv9WO1EtCKG99PDK3S0+hcBUeSCtknR+VsLxGZbKlzq0KAutEZkewKmXeCguqwHBi1QB/P8HeZvVQpkh9hQYJTFtxOifsq6ug4lpntBl4aNxU8qpqczNutXPkxsd7bOc9uX+B+f6z54YSiEfykYZ1DCudsHzVsYmkUugEZYG8iomyAFazOxgeW1hAcrejnfZ3ZMXVY/Ql16BF+Retig7qNoKFZ1Srcnu0I7Db9S63X0577MclcRfQLBrKN4tAPvuV6cAaaA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778442924; bh=F9GHdIQKtxCF96vK5blMuCCa7po3UDiqu9IeyTaiWIA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=paRc/RJP4X7MPTr/KHelO+fk825oZxDuiu3BkBMDaHs5/npR/aHWaCUbadmVHSi8F0AvwsYOEtt9Id+q3e51G0p3sKNHlhJSHCCB0wzryuR2WAs0V8wrVdJ/LTRmwNKCuwKgdgBL/YHu+xVGw60RgP+idNuAn0hV7hOW8sGzEkIkChVOAhrWHXKhNKWRvZi8pyPgT7rr1rGt17s2H7qYo+75Hf5xqTKMKq6ZId3Z3obuQ9rSJ+1XGfsSV5SQuaYbXP5o8ssLTx1+y7+9NBsusm/GLsclmGiBnbMT0LnJjr0esrvqhyWYu1sgnFvSWikbbY46tc6VbanJt4fB8ckSjQ==
X-YMail-OSG: FyYv4_wVM1ku7J63ZyubnD7NoBC8tWnae3gl0D2.juzkmrfyHKtjtBW6gnjZdR3
 6tKJXFxO3txhWSwP1o4Pzmcqcp8Z1rjEU8eq8Q6m1ZVemiJdvq1U83.wZFlVOcVgVw9I9c5HSkdo
 GMa0Wlsm1Yu98Py2FoyoWrSncgid.9Zm6V4FKtzkIMs1x.FlLWni6FUlQ.O0KPhlVggMKngGFfsv
 o4DOkqNuLRVu.QWJm8KU4q4aYkFH4Afg58fyjpxpGkMgRHiI2tS0m93My2Baqm39eEKIFPWWG_kh
 S9DUJsgSoeytGtYyCgAaiETed_EcR6AYFJnqyIqIV9qwvZ1EzPMbFIePLtxTBY8PZnYDv7GqpbA7
 O4VTlMSjHBIYh0neWz2uJt3VYIp1LoVwfcFi3XiDzu7ck94F72IhusidFOZQJxfm0sodsXEMQOoo
 FPNbR5gKvJ45l3hnxPTx1DLcfwjNLmS3iC1Ufv5JXegkquSPc_4AavEvTERDczCNAnmyETStjwe_
 eTUNdlaW5OsErERcTA6sACm7lH1VtqAWtxM8H7g0mUEDioAozNpQA8jO8JGFiSSdpsVbVJWXXt2O
 BKmTflO1UImnjIdgwSOtS3LJQ0q2Vg7XuV4iho37UPzldO0jbu49xjfKHrRnFmmY7TC22PRvF.e0
 es88EBla3GDrqDdD7sf346znjLVcTBGpopfJH2B1m1oa1Fg0pkuBSyeb9HM68yMJGWyNiWQ62Jbm
 7vJZuZXiuYuZNN.D2lHPZGvPT1ZrbfPkaXbe8W7A8JTCDolDuy44ZlZgeprhulsXkE7p6C_3WuMB
 WXu1K.sDS3Sn5bK1qLIGzt3Qjco8GiLYsogSpOtlJdnzYGeGj5V_htsCJ00vavRaGOAm7q3LoD7T
 GbRH9iSgpoDfA4mICeIjVqi295T9FG83vP1YpolaFK7v3IacntYRGfqyw4KMfMvr3z4chgp54nmm
 daYU3HAWzkJM.3TbKRkfEKnXxyicpQXtSWE2yNZ6Lrzv0DeeDNZcatyWHzsL3Y1038Z6AqIXtNGg
 ERtYKL4f6ZW9ACsWlN71oSHaBBRluFxTMGYv6GKO4.ev6Ek5HfL5EsU0RKcLKm7erdrSsP1a07j_
 E_zwFGv0oE6kJ3oXLbFWy1sZkU1xSE0M5CTlanN4OTvxg.uLl20bUyDicHeUW2McfhAyAsuT2dkV
 PkY.ln.PI7JzsMpjBiErtEhRBjQIXNJvL1n7B2FcTTcit4ctqgXiplXHoUeqOq6R35jyFBrgnCGW
 x0TFJc2PV56F7LOVgikoc5nWTI3mclPS7dz93c49HQ0AkJe3XXnsRJ7XtjJLLJqNfuDz1f3t1bag
 NbozMYG5T0pHHhoFzKEt8XeQ1WL_NL5KRVbZVLjYNXl_4TjlDqm1aR0eZCyLQutRxUjDj9f5s5Nx
 uGYgGqOgsc1wC45cTaljPMGkxLyvzrQj0LcinLqLxujB4xel5ZxVZVfNdM981btoOylFsVqhErkJ
 .5.5G_Sn1Eki4eswyTHY2dOV_jn4ENFnL1co7OPNn57511m3LFHqJMaSxyMSmfJ_baHNPuQ5OLJv
 0K07gFrxwLT4y0oaXTVZhhwREvfCliTNM2PjnxIgIn8iNnx.q3QGwdhIPrf4E3p5FKngaqN3B_TO
 TLSxxUVPyDnX8msF4.8KMXNTKFlx0i0DqJNxaelyOuafaGB_7IgKzEsgO8weWl5o3SJrJA6HPUQl
 2vkxpjcdAYTDuZCC7Q59eeQjm_kUEAp6D1qDnM4SkOqO3.Kh9TCRpq03S_zvJdTjbvgDQfW04x05
 yD6zTTiuwcnOT53iFEY17XHUVIQqmYW6XJbeRhNdu76BFhTXep8HfukbgA7pU1c9bzFmhtdojj0J
 qPyCHr_uf46kAyEchrnbrfKEHe7S8ZArygAkchEnpSX0m0CoDguQE.9yHRZfhaEnfGQGLuBbsexT
 Cj7Id1W_MmRVAxRNa2_eYsAnwNswRYdDp5g0TSA_9q.vZq8YxUm6Bu3eL509TiAthYJwQ4CaIjxT
 5VnJCahfHSwBLtxGuwlsP_Z9WG2RSRAe4ZdeIYlXoqegQiX6rab4QE3pSMe4MGju_cJBKsHdIl9f
 cwlWilXf.p2..0xcR7mWPVPi8BiIsrIwd7MzfcMQdCHsnx8SpcH5Dk6NTwjI5CCBON.yn9TIIG8m
 HdeyYVWP6rX5mPkF7YPgoT38z4jioZn3NBOt.Xgr75MPOV49UVM_V2oWCfP_2huj_k2KVFJIB61T
 vucCVI9tUYuBcXTOV5aGRpP0aymhlYK3Uxrx2XCRJg.vPHScepCPwoWubL57f5ug_PIo-
X-Sonic-MF: <nicobsc4@yahoo.com>
X-Sonic-ID: 70ade669-a801-4f51-81e2-7672d7c61e27
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Sun, 10 May 2026 19:55:24 +0000
Received: by hermes--production-ir2-89844b765-p4qxl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0241877a80b841ba8e83704e7616a54a;
          Sun, 10 May 2026 19:34:41 +0000 (UTC)
From: NicoErdmann <nicobsc4@yahoo.com>
To: linux-pm@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	NicoErdmann <nicobsc4@yahoo.com>
Subject: [PATCH v2] cpufreq-stats: document limitations on modern cpufreq drivers
Date: Sun, 10 May 2026 21:33:52 +0200
Message-ID: <20260510193352.195181-1-nicobsc4@yahoo.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <b23cee4d-dd82-4828-9f38-72cfb05eff32@infradead.org>
References: <b23cee4d-dd82-4828-9f38-72cfb05eff32@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a note clarifying that cpufreq-stats may not be present or may not provide meaningful statistics depending
on the active CPU frequency scaling driver.

In particular, drivers such as intel_pstate and amd_pstate may use alternative mechanisms for frequency scaling
and accounting.

v2:
 - Add missing period at end of sentence (reported by Randy)

Signed-off-by: NicoErdmann <nicobsc4@yahoo.com>
---
 Documentation/cpu-freq/cpufreq-stats.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/cpu-freq/cpufreq-stats.rst b/Documentation/cpu-freq/cpufreq-stats.rst
index 9ad695b1c7db..6ffa5a6a63c9 100644
--- a/Documentation/cpu-freq/cpufreq-stats.rst
+++ b/Documentation/cpu-freq/cpufreq-stats.rst
@@ -28,6 +28,13 @@ Various statistics will form read_only files under this directory.
 This driver is designed to be independent of any particular cpufreq_driver
 that may be running on your CPU. So, it will work with any cpufreq_driver.
 
+.. note::
+	
+   On some modern systems, this interface may not be available or may not
+   expose meaningful statistics depending on the active CPU frequency scaling driver.
+
+   In particular, drivers such as intel_pstate or amd_pstate may use alternative
+   mechanisms for frequency scaling and accounting.
 
 2. Statistics Provided (with example)
 =====================================
-- 
2.54.0

