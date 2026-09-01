Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A423CF046
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273405; cv=none; b=evY49BKOS+WB73oNDB7IpOTCLO7cGwabEMx6h8riU2IorL0ZWwJTt7GxX1/txFzjVKljNR7dCpvifEn38ymw0gjiwjNr1j+kCNsxdTb8iDSq/l44fr+d1LzJkNqhB4JFpGFZYbKpPxH1DAXT/9ygDrmIDN98WsESGqFPbUbiq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273405; c=relaxed/simple;
	bh=8Yq6wA6m597vsL2jPetlIgaUwdUajeAMwBBwubaUTuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aL9lu7risKq3EI3cMYdbdUDe2t6nobo4uFB1rNTOHy48/TPMNVeIUBXmiVP+KE/cMMFjK5vLb0affFW3LppTSrbdJ7PE1rdpfnAliRagHguyu3TP3dXBCVju9u0GBtqjS11monu69BipVifkF8Umqm5QskEWZGERQLJfnhE/J0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k2d2pV/l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AJeQHHyf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k2d2pV/l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AJeQHHyf"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8XII2270314
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 14:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Vts8c29USZkd3oUusvtXRpscx8Ph+Zcc0s/
	0yEsYKiE=; b=k2d2pV/lvVru5YRizmlLEw0a1C+uvOmyxT1MG+VnhwgvW+Y1fDH
	OBfEYk/cJnWOAYzr9INzjY4Wqgfus4hfK1gHvaLyjms45WhlbqbzEKYU2Zy5j1aa
	C/MKzWtf6sQCSsTrL/yZ7U5m1V/eV7vi2/A53iMHMlhQgiOOqoBL3WAZgtWQnXv+
	sR2OuGiZsyGTPfCJ3qoO5c8OIXlZN3mk9A3EHg//OihlA/69lEBduzxvLTIYAaUi
	QXbv/y+O21MIlxdUkx1aIHfOvg28DufWGCXcy8w+3OHYA9JPneNJSYxRLVjIntRw
	AJSMowMHJdNR2OZEYoH91qkmfq6upF9udZA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdjtx3stm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 14:36:42 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848d21bbb55so7662972b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788273402; x=1788878202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vts8c29USZkd3oUusvtXRpscx8Ph+Zcc0s/0yEsYKiE=;
        b=AJeQHHyfL4vBzMVEMTClqST9lfv0onhx31qx6qf6PXX1EZt73RH1Uk+ZG9O+Wyulgl
         W1FLqtdoXx4PjWlIBGBVja5yK4m/wu6YzyuLg4rarDaJe3UdNhEBfDmGruHqLyDAaL/J
         Q52OPRrwG5sCsbY6Naot32Ccb6KPzyFaiuQwgTf518H5oqHWFFAzAoeEwiHnwdCu0+kl
         8SBq4tBFuxh9Thcx+RN2tXXAxN2DRPEPIvH/xvSDBxEw7FHmEOQzRh8mow1hGRGxBk3F
         1aWXpSgThPPaIyKO6BczZu9RgAwz1fMmw2HgUwn2i0rDwFxQXH+JIEmahaXRiOrTRhMj
         capA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273402; x=1788878202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vts8c29USZkd3oUusvtXRpscx8Ph+Zcc0s/0yEsYKiE=;
        b=RT8g5Ey0eHJbNRjcdQ3xpW9XNfsycx9Wc0V/LUb/zpMUG1gDTR6lZdZBgKBg1+AQZr
         MJK21CYTLW27EcWcv4OWLxqUluo7w+y/118lZCI8GLLnakA/VHJ7yBt1Q3iiwkMgryPY
         XPk2fAkjXrlLJ0w3NHRrx5cwSt10Fp5dwv2sRaWaaxzIwDbQXrrb0sBZAt4tifY8U0tV
         VxbULBnceVeLwrN+ke++hkP35YOeazHoLfw1d9DHz3ldpTXxr0OYazPm96zDZKN0JQqP
         Xg+kvMvoVLZP35gwK1Qlv/vAh30739R4MgZ7VR77kHQWnh9gZYBXkjfxfGJQwBGY9OJS
         o+MQ==
X-Gm-Message-State: AFuF++nQp0p2dCoWsNkhsSHLWMDXStTlcKCL6bkopmhGBMZSQ0Q4Fe78
	OxWsISTJVk1sRV4Q+3ViQ9/OeIr26MdNg6xBBFMSZW0gkCvAZP5LHpRe7dYri6uiUKreJUQyQzG
	Rgm+GUDk/74546XsczSJJKjsRn1LVYZPx5K+1LT+tIhLf0RExc8d94PtMDYn+IqqK4Ejskmmn
X-Gm-Gg: AR+sD12pUZCvYqPKKy/L/6SUsf4LpoiB8I3z7hcDtezjikuWkX9paYnDRS5Ldf3w8tu
	Wg2eNli8PXBg6ryXG7f3mQbrWFQqfmMnLVbp4kzR+6hD2OeBFJqcZeyLaLM1BFC3HiAEd2j9rdo
	p/Q+dpKWWPAnqhMwFzvdViG50g9W3PmDweiJ6Xk3dXQnKomRsEHW4W/WaHquA1DahVogdfX12/y
	oNGosmU+QcUIrYad3egAlpknX8e12TXVfGRSXlnDzRjRvgNs/USetGuiLM8zUr1O1bxtf+FDyOe
	JNMDaVuq80FMHutUGSXLPV0MWvLiKitVLQYvDOmmag8p7akKmP/VLd4TF/OydAkS5nDXthrGE2l
	2rZtut/ExHtVD/b5hlAgUHe/ihGdJW4ZaE70Pf2i1i2xZ8ilFLRzuxQ0N8cy904U+ZEs=
X-Received: by 2002:a05:6a00:a220:b0:84f:a82e:d32f with SMTP id d2e1a72fcca58-85b5968a145mr11062778b3a.3.1788273402124;
        Tue, 01 Sep 2026 07:36:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:a220:b0:84f:a82e:d32f with SMTP id d2e1a72fcca58-85b5968a145mr11062694b3a.3.1788273401603;
        Tue, 01 Sep 2026 07:36:41 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be99255a5sm1259669b3a.61.2026.09.01.07.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:36:41 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com, stable@vger.kernel.org
Subject: [PATCH] cpufreq: zero-initialize policy cpumask before sysfs publication
Date: Tue,  1 Sep 2026 22:36:35 +0800
Message-ID: <20260901143635.4106960-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K78S2SWI c=1 sm=1 tr=0 ts=6a96e2fa cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hVcsQZ9HNR-0QQQrEgAA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEzMCBTYWx0ZWRfXyDPbybkoOvQo
 H5Xt5krHHSl6+qfuB5DvHOcbEl0zFtt/+BlC/cfc5vM+y+fs7ok/5fpWAPy7yynKj6IHT/9jGwS
 9uMAE9U9b2dG064qYjqN7FQL+yruIt8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEzMCBTYWx0ZWRfXwunkIdGyfrG2
 V9mvkPLTY5hskf5p+1oSnIXVaGOylseRi/7NldiryyxHqxG3stcXCHCbFqNYKEPcwEIDgs2HFGi
 dtFVoDL9h9ZOvznkAXcHNcD9ziV924trT8kAWYFLCJQZXATmSwzy0+B611ni7CEiWdvdYDN9DuX
 Fbh0K6DjIpoK5hb1NLad9LPYwUWD09Lyp9E4JljgRws40pU7Q9O+dmpo8EC/mvRNpGdXgvJLyEx
 R7YacUWbKvU8HqZWsrdma3UZTb0pQXS2jv+7mfFv+cO7emP05YHCuPDtHZbC6kjN4Jz7J1Ido3r
 c7RRCO1d2/rsY8ZL1rqjNrg7asK93oHVdYc+QfLArX1P1fKQHcmJa9KndHQJ7cTStROU/9QnUh6
 5sD9QKl2wKJYFV6zzdM5fj1qQjX7jtjVWBqrYGJ//tCFOk9L8cVkJ4eIJWn8wT7bwX0208wysDL
 dTLSlmyEogmJTE4s/WA==
X-Proofpoint-GUID: xc5jFJGcPbzsuVF51WvJqPepoy2FW2b2
X-Proofpoint-ORIG-GUID: xc5jFJGcPbzsuVF51WvJqPepoy2FW2b2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010130

cpufreq_policy_alloc() allocates policy->cpus with alloc_cpumask_var(),
i.e. without __GFP_ZERO, unlike the sibling related_cpus and real_cpus
masks. With CONFIG_CPUMASK_OFFSTACK=y the mask is a separate
kmalloc_node() allocation, so its bitmap holds whatever the slab allocator
left behind:

  cpufreq_online()
    cpufreq_policy_alloc()
      alloc_cpumask_var(&policy->cpus)    /* bitmap is uninitialized */
      kobject_init_and_add()              /* policy%u/ appears in sysfs */
    cpufreq_policy_online()
      cpumask_copy(policy->cpus, cpumask_of(cpu))  /* first valid value */

This leaves a window in which the sysfs attributes are already reachable
while policy->cpus is still garbage. show()/store() gate on
policy_is_inactive(), i.e. cpumask_empty(policy->cpus), so a non-zero
bitmap makes them run the attribute callbacks on a policy that is not
initialized yet.

Fix this by using zalloc_cpumask_var() for policy->cpus.

Fixes: 2fc3384dc75b ("cpufreq: Initialize policy->kobj while allocating policy")
Cc: stable@vger.kernel.org
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
This patch is based on https://lore.kernel.org/all/83f87db8-fa13-41d0-ae52-544d22e228e6@oss.qualcomm.com/

 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0d0df986fa3d..3b1b2ed86cc3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1249,7 +1249,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	if (!policy)
 		return NULL;
 
-	if (!alloc_cpumask_var(&policy->cpus, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&policy->cpus, GFP_KERNEL))
 		goto err_free_policy;
 
 	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
-- 
2.43.0

