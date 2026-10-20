Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505869;
	b=w/sF175nk48TSMvTugUXGcW5nlqpxTlhQ4moXVq/eqPS8scS0ZiRsyJ43F+rQBGmYEBl
	 k7zDoc+gG3Ujvnlk5NWaYodC6qNoXjnVbnK6yUq0Pwxehb6KBEwYrjpf65RHpcyPoUZUA
	 GBe5X4NLqIqU9Cw49zu4h+S+n3hqacww0QHQyHuZiPT/mCN7BJ9BmmpkW2Z/5z9xRZRI4
	 rP9+3V/vgZjDVWAhBOdlT6CnDnObFg4DG0voHPgR792j24u5ziY3qpf2YYG6PMmJC7Uio
	 fT3VtJKfZSwHNjejKvhyGo5aFKE0AD0ZvBgdWjlTAOegGVcZuAlnougCsJ/VFOn4p9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505869;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Yt8E290dh+tISv7RUY4FIj09Mh2VhHp+yj63FHALQjc=;
	b=dzXRyWoB9WWnbRP3deriEe1tI6G/sda/jpwsd7ezkpyWXZj2JVHhEpCk6QFigM7dSdfx
	 msp1acBuw2dB+qScQFfj0mlggeZ785QW6/jTebF+KVtEO3grq3tjoBYLZO+bjHaocsjim
	 BDGECx2n7kImMvJ2Yjpc3axvHbu4VVbQdNaHI2CTGnUXaVMtNtZARJMOsV1jdFH5W75lQ
	 1juVKldr9wQ4JjjkJx380OlF74peorEuIvt/MhlwsIqB151wQPAOB/O12tT9dJbcyB6Nj
	 8jDY9nS5FnGKc0bClmmd3/5W9Ng/0PbxfSo0yKPU8tf0AubmNzHGxFaYisYtpEqLVaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HTPDiGzf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DK7ggB2R;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC060A6F64
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FCC060A6F64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HTPDiGzf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DK7ggB2R
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KD9wMu270844
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Yt8E290dh+t
	ISv7RUY4FIj09Mh2VhHp+yj63FHALQjc=; b=HTPDiGzfWdVUe/V1+jG0cjMtZDg
	whabYYTeFVEldVcYw0qR6EO1OYDdKi0ZaVAjAkOznL+PaOwru5/S7K6yF9njp9ld
	17R056nH4/QOBZ9gO2sRZgbXH9yTwvYuJ9+NWwlezCC9mmJsjVkZJCoCT1dVjXms
	lnBjyV8wDGo2eoV9WDnBQ0h8uydGxNYPUM4sNtdAS5siRok672umX+l+eg9L/Bqk
	XqA8wtOC3j4pEowXgV0hvvxN8ltatQaGNrD65uk+FKexRvO2+g5OT5FsG/il4Jp1
	VHMQYiDa/jW4fcxk2eIVxX3FM6Rej5JY+EnUK4HOlVEOekTTTWDrrSuQK9w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hv8hvm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb6391e89so733208185a.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792505867; x=1793110667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yt8E290dh+tISv7RUY4FIj09Mh2VhHp+yj63FHALQjc=;
        b=DK7ggB2RHo+8/cyBV2sHoU6EjvyD2TPMZYElVi8EBpcH2fgcBS+OTN5M4g9bERnxyw
         hf8IPcBsCb/XMepL9Y5pFXGljJswxCIfmhZ4DQ7BMuFMMMxV9xZRqDHV/lwShuCr3u+b
         9BBwi/lnf6NfarvOf7diUULZkVNVh9KfhXz4S7w8HHbrdRVNR/dNQF6Q/O2zZ8rvSrYO
         xQkGNpRbu3qC/h2cfqJU1f1Xr40RNEDHfWORrGmP8IvmAqGfixnY4IR+MpjWMIIOVSZg
         lCOigfL8DA4FyFL3HYQrKaBLylSjDvDD6uD26mRw8afj1xwzmuBUlXz8HclQM1suKTxF
         iqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505867; x=1793110667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yt8E290dh+tISv7RUY4FIj09Mh2VhHp+yj63FHALQjc=;
        b=wZnQVlxZdxnIH1pqcw/cboQK3kvpmBLrUNVDnt+kXz5H9+7CjgUWcrQpjSgBf7Erm8
         jqoHljnFxzN+IIbPUDKcfrWN2awtMqQIeu1AoC3Ovl+fl3lmooEmd1v3Zemo6JLwBs2+
         PD6SSC5NUYP2bs7rFAqCur6F/PGkzBkDKYY9b+vCgbXqx7kxk4UTdavDkrXriG6nIiJP
         QZFOno4kAjm/voWkfg5scvX78Q0lRl0QjvQPMXKEtVkF5z/c53nDB2ASk6DBmQK7M3fd
         LVZy9uuy2B7QlxCCU0oje7OWlKbRQbeNe11sQzi0UuJZQkbSZugwHgtmaeMTrAB7jvtv
         4/Uw==
X-Forwarded-Encrypted: i=1; AKwUvBxgcLeysYu7iR4GgbpH/O59pmEAEkiCBOfloNaB1O/xf/gi5+y/VEQuQmcN54j0zsmTy3gE0Cntkw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKAMuBhCqv3UaA9ZzRT+dYow2HKewYZvzjDAMHyD1FdPocVjIwi
	dNG3ZlWEJ/j5cVTxPm9ZVzGlhML+fGajtls4jQpaPQdGdEg1EFQOpZ4ygM8O7WbKc/C+EgfRZVA
	/O2nrWzh9OcQl5pUtvxUMeHXnZeGO9GhcKQwqFB9qJNMgwqThlkQLxtpg3ZVnKQ==
X-Gm-Gg: AYBFou0DLXM6HhKKp6TKsNvCr4cjJya45dLlUGbLJLdxyltITyU2WTxUgdzb8IgLLY5
	MpVYbOwljt3HhhGltx9OKyFaX0X8P5stEywXg6+9LzDgwIVBg31Y91tFjVdMdd1TIKeeOKh6K9X
	8fL3BWdLrBfNZW1bfe7t3wFADy8Rledb0eukBsqs+5FHw6tD01K4aXgE7ajAj7bsHp0g9LaXR4v
	eFzN1X+BMru5YL2MGSbmQK3iOUqslnmSt//63c2UJR7a5yJM6Ml0lzgLsCvatvKgVxyPH7LkNw6
	PEtKRp217DCrZ9kx2b2RcfuTIy6p0HkqStshYP2xwbUA0Kz+VRRHBZRvqIMGDb6OqrjvqhwB5fp
	RtM7SfDZvfK0B7kWCqlzugfPlP4g=
X-Received: by 2002:a05:620a:2609:b0:93e:9934:d179 with SMTP id af79cd13be357-93f29d8f1b2mr1783592285a.56.1792505866777;
        Tue, 20 Oct 2026 07:17:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2609:b0:93e:9934:d179 with SMTP id af79cd13be357-93f29d8f1b2mr1783586085a.56.1792505866248;
        Tue, 20 Oct 2026 07:17:46 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:4884:6e9a:d9ff:9fa6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d810043sm6642276f8f.16.2026.10.20.07.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:17:45 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 6/6] powercap: dtpm: Add RK3588 hierarchy
Date: Tue, 20 Oct 2026 16:16:56 +0200
Message-ID: <e271d25192830ee02fe75bf0d5e698487b1579f7.1792504834.git.daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792504834.git.daniel.lezcano@oss.qualcomm.com>
References: <cover.1792504834.git.daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfXxv/M/AwxVsEi
 Rd8sRPMruF3q4BpKsK4xJVNOad6iz4VTqXrgSR7fFWa0FoXKNsZu7l8iclswhm7s3Da7hmQ1Myk
 MKYbKF0ucgOl+tprj+BcweWa5pu4P/pohfetJVQ6U96PdDgB6AW08p5/dUiiWSruNDk3JyXfUa7
 fcd/5gCBkCEU+vGsMcqHN8u0NJeSZ5EMANrTKK5slLgIudAPeRybeLCNcRxo6bU/jBS6KyLO1oV
 TweY14cT8WOSe9evDENE1ifirbDcHRPZpJ7IqLc7njwCfV3J3c/JnTwsrBBcskxHBdMa5S+jDSY
 TK62RJY+9f2N1V+TQ6seQaWfwLHga37nzQJb1vJGSHoViiQlj8dIJXN6FYYcfqcVg+eIeWeF8z/
 6+JH6/+smubDxm5TEEcxF56XB8uQkC77MZONyJkWkWD6ty4hlODhXVGbnHED6UilqOZvrzYZDLx
 GXZ+0X5mzsGaHYKjSvQ==
X-Proofpoint-ORIG-GUID: 4dV9JxhBrbJdF6btgsm0lWDt8DlFr_nm
X-Proofpoint-GUID: 4dV9JxhBrbJdF6btgsm0lWDt8DlFr_nm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfX0LOi/nVaz/dJ
 aNRTyBhMcD6VzxvsTx10kyrstxZURCoY2j0roC+kuIPfjaidfGKgD9ecoPyArlWkh++zUoFkcBq
 IpcnJy7d7P+OsMNwoQjSH4qDFkNvyMk=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad7780c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=8Fys3Dm6xgAeGQ2jRPYA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200056

The RK3588 has three CPU frequency domains, with CPUs grouped into
three cpufreq policies.

Add a DTPM hierarchy for the RK3588 with one CPU node per cpufreq
policy, represented by cpu@0, cpu@400 and cpu@600. Group the three CPU
domains under a virtual package node attached to the RK3588 root node.

Add the RK3588 compatible to the Rockchip DTPM match table to select
the new hierarchy.

Assisted-by: LLM
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
Changes in v3 (since v2):
- Rebase on v7.3-rc7.
- Fix __initdata placement and the RK3588 match-entry indentation.
- Add Assisted-by attribution; no functional changes.

 drivers/soc/rockchip/dtpm.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index 5ae00680602f..664764f4b460 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -62,8 +62,56 @@ static struct powercap_hierarchy rk3399_hierarchy __initdata = {
 	.nr_nodes = ARRAY_SIZE(rk3399_nodes),
 };
 
+static struct dtpm_node rk3588_cpu0 = {
+	.type = DTPM_NODE_DT,
+	.path = "/cpus/cpu@0",
+};
+
+static struct dtpm_node rk3588_cpu4 = {
+	.type = DTPM_NODE_DT,
+	.path = "/cpus/cpu@400",
+};
+
+static struct dtpm_node rk3588_cpu6 = {
+	.type = DTPM_NODE_DT,
+	.path = "/cpus/cpu@600",
+};
+
+static struct powercap_node rk3588_nodes[] __initdata = {
+	[0] = {
+		.name = "rk3588",
+		.data = &rockchip_virtual,
+	},
+	[1] = {
+		.name = "package",
+		.parent = &rk3588_nodes[0],
+		.data = &rockchip_virtual,
+	},
+	[2] = {
+		.name = "cpu0-cpufreq",
+		.parent = &rk3588_nodes[1],
+		.data = &rk3588_cpu0,
+	},
+	[3] = {
+		.name = "cpu4-cpufreq",
+		.parent = &rk3588_nodes[1],
+		.data = &rk3588_cpu4,
+	},
+	[4] = {
+		.name = "cpu6-cpufreq",
+		.parent = &rk3588_nodes[1],
+		.data = &rk3588_cpu6,
+	},
+};
+
+static struct powercap_hierarchy rk3588_hierarchy __initdata = {
+	.nodes = rk3588_nodes,
+	.nr_nodes = ARRAY_SIZE(rk3588_nodes),
+};
+
 static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
 	{ .compatible = "rockchip,rk3399", .data = &rk3399_hierarchy },
+	{ .compatible = "rockchip,rk3588", .data = &rk3588_hierarchy },
 	{},
 };
 
-- 
2.43.0

