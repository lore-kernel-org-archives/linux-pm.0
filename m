Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779800;
	b=BC+I1Q5Krn/a05l4jodUwjSzSPXOGOuUu1HjvgRTsK6XafT1fnRuvzdPxo38X7VgGvtf
	 qRvi0grl6ZqpG5HXIeGrmwADm59tcTKaj/7COizGNV9+BJ3gHrDP2StXq6ZfGdSPgT7CE
	 6rKJeRQEQSNyogl3eTmsOL0AXxW6Sa4DbAry1Cd4b2z4AMdwT4rvFWO9QYQqEzubjvlxd
	 FJ2vNGi4+LqMBSrI74MV0Y/Ek0GYKfnaFGScQpVfT2ZFjszNsw+UmE+h5Ral8bRzVfRTy
	 aHlpsKxFanX7SfR4vZZY/5XiFMVzmsBlh9rAkbhH0l03TA9IbhxW6wPBgi9+rOrng2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779800;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+L60qjUW8xy9FlaJ+WlqcRIDFQJPjBBfFcMD9Et2b7U=;
	b=41yUXYIX+NvvkCQP8wCTqxq28mLxNFdWC1dkXbwEj5NggyuC+pGKX/Eq78t5b+Jf8K33
	 DhXMyy3MUmDdTLPIt5CIVn0Cr9ptzWwkHkaD2Ls9R94yAoQ6o0GnVKdnzoBbH8c5Irqzv
	 dJw+1/QW8WE6Msqfx6wpzFKHLpiXsEx2wblgPxegEB40iD+attwr1TMVYoAqon4J0+Yu/
	 lh38WikLyQkPBwqa64UXwu0vqfLahf6evqN7ghVHe/KqRramQyMc7FrjMILRBedhNn6c0
	 BlqvW6mX44Ok/wCPJzJbk8gNwP5JS6pWCEv+xx+ck2DamxF9x+seX22kdUww4ydDdnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VYlH18hg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=en8Xff0C;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9C606A32F
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75E9C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VYlH18hg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=en8Xff0C
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAp9Kx2268650
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+L60qjUW8xy9FlaJ+WlqcRIDFQJPjBBfFcMD9Et2b7U=; b=VYlH18hgdnreoNRd
	QMBTf1IbE/dY9SKqvo5z+FBx7ztH3q7O6hTR6yIUPcJSmAV5AP8oAEeMBnXZD2F3
	e6rWgcOMmpDmz+twC6kqy+gNfqJZ89ui23TZqhtNdKlzV3RY5NNb8s734kDHLEM4
	hJUPOz7oxbXqJ4p6IRGq34kyY5FVgFgSPy1DlnegwOPB9AB6MxxpRz7b1QgHW2mx
	sV3a10lyKedpm3ZIUFFflVabQPD7GW3sIZhFFgiWdf3AkscmANOvdhC9Sp/u/kv0
	oyaTa2fu5JAW7mQE/hvssE+eJ3K0IXFz9tJMvCSYQ1ViiWidr1yZL5wgEW5ZwiVG
	DR13Vw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhhe5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:43:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9493e89d4f9so1078786485a.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 03:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795779799; x=1796384599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+L60qjUW8xy9FlaJ+WlqcRIDFQJPjBBfFcMD9Et2b7U=;
        b=en8Xff0CV3QzlHMu+kmARwl8VbP4pc4CiPkhm4ofn6HTJvnPTKiQBxAqSK+O0uBnKz
         vbhDnUBGLR7X7454e073BIMa4iUUmKoyFiubyxaOxYz6uoPzMASbjeVtaef17tOllakO
         +BYHqY/scb0olfCZteuInter7ynNtx6ela+5Ow26OUsxYAj1dwzxATjfrrGd87mN20FO
         +pfvkKdgPIYHiZuIobeSYG4a+cwF1SRsjSuSzSflNBdyV+UXZBpnUlrPplWR3Tg4KnR/
         rrcRcsasvMRFCHBIylreWvB/xBaj8i0rfuf25hE8pp73WvIBvyX1kPza0upcLTPCZ72y
         P+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779799; x=1796384599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+L60qjUW8xy9FlaJ+WlqcRIDFQJPjBBfFcMD9Et2b7U=;
        b=XIn64MRlfiNsY/cGNkCoy+X8P3uEkxCYAJ33wxxU6JC1MOYwiVSv9Q4/KrNazT+jxj
         bOZCNH9m0mOO/jbaOlXfXWh8VvEjVSF60vCtoAEb/7rBKhG6PCJ3x6S+gClgYHus/rzK
         p3CgLa5doSCGruwKQX6wvX6B3+7L0R9+tVbrgSwpB1hZ7pdCwnEY+xYY8h6CgU+QRt9D
         yxIO7i47MZvde28TKLX22X5F7XCn4t9vmjmwHOmk1N2Pl1pr5VF+lFygnXyqLTvg7gNI
         z+guHDAnB4WHdoBl+Bscuh1obCp40o/0waBrltRZ79x3iimSh30emC0sKtBkTSYceIJB
         H+UA==
X-Forwarded-Encrypted: i=1; AL+hErFX5ZjkVw78pVzjSLRlGZEBtC3BJcPJJtSBDEqwsKaWjbRkDU9470z4LOBSV2n6caeKwj3g2Z9VcA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/HzF6id9mrabTq2iMe6z2mFVFqbZFl8N705k1IWqip80unlthA
	Culd8hf/m8dO7J984INdh+e05xvh2+6c8OfuQMJJMlCArRMtkHyVo3GuEqUJtdMv3hDRgoD9Mvo
	xSLQdMXrgDKrLr++wFRYrTjnWgHX2yOtIz179vp761TNq+CTuwYso7B42tgDj9aDrqy1fgw==
X-Gm-Gg: AZFdTZdH0BfhjJEnr9Xo94KvZ0XNqCze/RulavVVwjGeQSv+kp/slfXmmBHmRD13FoH
	F7Q/Sa5TGi3togMX6X0sVn7ZpwytETgI+GeIw+3KZp3eG9JtSGR6D050cZlmXDMrduiYNuMtPjh
	je5bo9q18tj37higCUXsZOVxcEYNWv0gXfH1Se15fTBn2469kv2zIyVkxlbSnHCPsy31+vwGDua
	2GE9D2o8e2GBge97NrP2/RyqG0yhuVO3w1td2A+sAZPAdiBrp7jHXBF2mYTaUZfDCLFoUSQTyhf
	KPlsuwn5lteJRgXFSeWLS1sP0DwyhuJnAY1gI+nPtTvJ0N1Cdb9Wb5hXYEGJepA4QVV0NYVtq07
	i7rRiFYVrbqLCuVl08EHZq2tP3/gs9FoLpfAtUMIXnUgckBObpZklpE1thiTHKB/kLK03K5C4gE
	ZdYThnGyyg1S/5LvVIJAp15cKWCORqOqKyspdcXi6gmCv9TnVdj9nlRu1kNYzpQP4=
X-Received: by 2002:a05:620a:4453:b0:947:7691:731c with SMTP id af79cd13be357-949bab47e86mr4160817285a.65.1795779798803;
        Fri, 27 Nov 2026 03:43:18 -0800 (PST)
X-Received: by 2002:a05:620a:4453:b0:947:7691:731c with SMTP id af79cd13be357-949bab47e86mr4160812885a.65.1795779798339;
        Fri, 27 Nov 2026 03:43:18 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm716120385e9.8.2026.11.27.03.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:43:17 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 12:43:10 +0100
Subject: [PATCH 2/2] pmdomain: qcom: rpmhpd: add RPMh power domains for
 Seca
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-seca-pm-domains-v1-2-013c28eafc5f@oss.qualcomm.com>
References: <20261127-seca-pm-domains-v1-0-013c28eafc5f@oss.qualcomm.com>
In-Reply-To: <20261127-seca-pm-domains-v1-0-013c28eafc5f@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZY/S8jq4xzcaI0oRzyGVUH8xf+3xmtZAucNpXtUkAE8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrCWzRqKHWDNl8e8baPxMR5NXp95eEZ43F5u76f
 rg5ppTEYXeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawls0QAKCRAFnS7L/zaE
 wycXEACyAt2woKsrbDBGRNfHBQ/andcjt9vFnpMXezG6ktHdcv8bUfNIJKSdR2jlLjJ/tXZ/ByM
 Igan/SbKjBnfcjfFrYcFHzXsF8xGXyJ675vUs6soInJwrHxXPETg+QAan8wjVFxFTMXMS6Ywv/S
 BAvi0KdvDF+65AwFIkQoQbKXoihQyiIhkrH2AVvRJMhD/GKgYdeGD+lGLHMqLxqxSfjYiLtrrv2
 H06/MtwuYYckU/qKzJmvmauqRVxJ4ugSe77vXKF8YaIfbm4lHNOPrgNhCZ7zF1o8MSJfgulgVgE
 mnbCMwtb7bi+4zbpvxNm+vIAkYtebWdMOpWddLxaw8UP0VMcV4HFlEs9nKoWdx6b7Pf+n25jbP2
 /6StMaNnymTrKicQq+qWFvJYeCCo8HQ107nbE5XriANOuadfJH78ktMY1PTX+KLsuMmUik6eSx2
 lHFj9qdy1aRGuEv3SSl3y8sA8U7fKKIbki+0reHlywshk0WawK8+swNOzHgSmYJ4QQM8lEsS5Hp
 k66omyjee+7XU6et6g0QAiLc9cSuq8kbaKNmIrJDYi9fXrqf/SWj+k0xDvCwrPTzcK30uehXkzZ
 LJZZqE5vK/eyD7xoWmu4RqDNxMYXxta3ZvzUBT6tz6gF2NjaUiIiKh92FGd2fej87BCLyucKBEb
 bYZ+TyggG/ADx9w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfX5Mw5lTkj7Q8u
 0S9GcSr8bXfdNiy9J7QawqY51h/zMlF1AB3Z/DFEWjfmBH0ibW47HRe0AJc1PDjyPm3593QMslv
 KIOZ+iEv9b2+OLS6oUdjd0lq/HWWyRk=
X-Proofpoint-ORIG-GUID: gzQE9m3H609sGS60FW1XmFMJ_6PltMSm
X-Proofpoint-GUID: gzQE9m3H609sGS60FW1XmFMJ_6PltMSm
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b096cd7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Em1930O1owdZqrsm1f8A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfX5VFcIWAJIggT
 4bojEx0mLQbgShGeyQaCI7BosYe8kmeZUvUGtaozMpXT4WbioXYsm4ftS2s4C3D19TPpz2U/ayj
 V8Jy7YHLL2EyeoLEwC8fATq4XlzxtqsWd6FEKgePTujZszoymJXQXa+LfbPkHfL5bCzv/xeBZqn
 NRH4zb4sUXnLkkKdpYFK2xELmSMpz1CXpjdAU109gkafL5LrXw2EVqLgtNFWzeAk6RuvXuYcy7T
 SKP2k8Y2WOnr6DVMgGCwwbRGcfg9qu4Ru2Crzl9a384y52IpTIb3b4EXC+y49lhm9+348YXXTM6
 Gx+gNJDWNbbpbgQHkX18Tgv3w4HnN9EMs49A6cIC69nwH10A0VFxj4t31EGbxpkDkXxCldekhAt
 H8k1WJ1O0MHRrnosd8irYJr6+KZ0Fz2aucrTfCEs3FFiHBBSbLnSzvIMh60t19/ESUua5hNkgv4
 pI7np3ISqo26KaCag4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270046

Add the RPMh power domains for the Qualcomm Seca SoC.

Co-developed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 3f50e7d5dd109ec9f6a28c3b667ae0394fa3b32d..a0ca4f0332243fb3919391e061472fd93be768cc 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -344,6 +344,29 @@ static const struct rpmhpd_desc nord_desc = {
 	.num_pds = ARRAY_SIZE(nord_rpmhpds),
 };
 
+/* Seca RPMH powerdomains */
+static struct rpmhpd *seca_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_GMXC] = &gmxc,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_NMXC] = &nmxc,
+	[RPMHPD_NSP0] = &nsp0,
+	[RPMHPD_NSP1] = &nsp1,
+};
+
+static const struct rpmhpd_desc seca_desc = {
+	.rpmhpds = seca_rpmhpds,
+	.num_pds = ARRAY_SIZE(seca_rpmhpds),
+};
+
 /* SAR2130P RPMH powerdomains */
 static struct rpmhpd *sar2130p_rpmhpds[] = {
 	[RPMHPD_CX] = &cx,
@@ -943,6 +966,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sdx55-rpmhpd", .data = &sdx55_desc},
 	{ .compatible = "qcom,sdx65-rpmhpd", .data = &sdx65_desc},
 	{ .compatible = "qcom,sdx75-rpmhpd", .data = &sdx75_desc},
+	{ .compatible = "qcom,seca-rpmhpd", .data = &seca_desc },
 	{ .compatible = "qcom,sm4450-rpmhpd", .data = &sm4450_desc },
 	{ .compatible = "qcom,sm6350-rpmhpd", .data = &sm6350_desc },
 	{ .compatible = "qcom,sm7150-rpmhpd", .data = &sm7150_desc },

-- 
2.47.3

