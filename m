Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681358;
	b=RLdESAjNBk+Gepdwe+CbosxvWQQhKrTzc4bYWBucl/PfA7W3C3ZBrDPw0A85l2ScVRGF
	 xQQwsAtJKXx7HTHBt88phFT4JyJnPOS5QHoHw3loDKx3MUUCbMYJDWXwfWH7WG8XFCxGU
	 WYtYwY+tzfQ3VYGm5TL4WdmPodMZj0eDXmHFB37dOzda4Q1yG3prGtRljy2g3jNnz7LGA
	 AiMHHVRwoc+YZFk2Jd0A9iO6pQJu+nN8EfnPo6YYmTAZpNgPZrXKgv2TUs9OlC1UCGtse
	 a4JQmnCYMRDFLvipslVwJPvuMdzorisElgk9Swv6FBsiK6lKrEdUVfD2UBmYtI0Y3JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681358;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aLQirFytpFjaE6BC34p8KJJHy2Uy3xoA/cAaFgViJ0I=;
	b=uO2MH04W9zWk9e13zbTqZH2V9gkB7yB0vwHjHGUXTVwjl20AVDt2MOcm7JCzmUWyEd00
	 dFF1GgpbHU6JOwbjONZi5Lr498jMXSR5nkC7MD+GlHeSa0LW84QYFvRMTofUENvYO894T
	 sUJSoPgrv2hTZ8EdE1GGHNXQgKInLUXln4+o/sXjrALDcG203pNMFfoLVWaSCNJa8u+BB
	 MZHzqATowwj4fRRqeSWfIQYsKJtWH58xe7G9k+as8tP+SKqA2PRxo3TUJhckn3Rf6nm/H
	 HmB//QAUyPsF3krC5volpOc1iNiQRe7zxqf0tt7i71GoUspY3YXYgdH475zyjPw3eBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="HW/gtEYO";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bwhgqKQE;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EACD606D803
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 04:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EACD606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HW/gtEYO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bwhgqKQE
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A34h9lx750949
	for <linux-pm@vger.kernel.org>; Tue, 3 Nov 2026 04:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aLQirFytpFj
	aE6BC34p8KJJHy2Uy3xoA/cAaFgViJ0I=; b=HW/gtEYOYq7qPFBq0/gQqd/3Np+
	RcWkro5MXkDQIBNCR1TXtNRsGdHdCsQiKw66Sx/kGOr08qK1PaXIYeiYJ/wry6uM
	IU7tQM6geAV3UkQw7gLioBgYAttptD8T/JeAJmiwFCc9gFObLAjDR+kgZ4ePka+/
	DIwNKCEntBWFyADddc8uBtmmvwNeqL0lke39UycuBFBUqhVai/E8ChTizHlMoEZF
	SliM+VOWEWpM+qr655TBkIyu0lnOX/Q+j1HrAaXJXhi1af8JH+sJorsELhWbkyMN
	uYU/CWsrEhRLd3ffRmnO+FLwWOy4ETQslXaj0tuelDfhTGhWCPmWUNlgDVQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq8u5g0m1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 04:49:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb93c874bso60534285a.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 20:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793681352; x=1794286152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLQirFytpFjaE6BC34p8KJJHy2Uy3xoA/cAaFgViJ0I=;
        b=bwhgqKQE3kqUkT43/q6GQsFlxYJYpo21rnOUzLdklDETojqytxgxZjjAzqiIij1vf9
         pa0fhw1OWb9qIj/AKA3KYn470F/shF1VZSv4WL2wCeYw/ScG0ZsPhCVujS6Q0hM17kwC
         rriubc9/124mYHa88yloTUCdb864CQ2ZbXkCeBgBitPdaem+zlAWV47OCVm7+x+prbG/
         ZMly6bOZVeePcEDKz66zsnFITEBj4vY0tiHkopI2TheFTsX+QrFs2Dez443/SaI3Eiw/
         mmsq0NVYGQeDC/o6LGhubWOnJOuMhlAFwD90C56DH1x7SYo32h4+GwZLRCwFQSrmn8nj
         RkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793681352; x=1794286152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLQirFytpFjaE6BC34p8KJJHy2Uy3xoA/cAaFgViJ0I=;
        b=yefl74nLBbnfuu5ZPbVUJoTbEgHQOxxg8eISYigcK3Jh2PoBM6/tX8KtVzB4nh2+Fg
         XOkioT6a1gZdndr8Mg4/iiplhfFvIBTqMccThNbveU3WE2a8gZ9IGV+HFySBrlcwWiaI
         F5Wmj25ScTyM5oDPC30OGd/iQywtnxWgo+ebNpBRnIAtE8GinBCQRcEg8IP8v8wRhaqJ
         /0DD1C4zyTPekmKZdqCuiR2giW73WGo6FRKHkGTpJT11d7JgRzDhAkQwCa+dNNB5+Cnj
         h9+c81vrDihIAhls57whhsrP2pgSK0we7j8sVVwDRbcGKZJRgDM8rqh5n9XXu7eqG/9r
         21tw==
X-Forwarded-Encrypted: i=1; AKwUvBzly1WKb74a44Y24X0PHfSQJwZOYHtVT3a2jAVW/P38B4J+Ze0Wb/J9aNJAju6w26E3yMVPJkMwFg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+X1DWw0sUmOc8CmEnop5n/g60gk+OB2odHKRWoShcIV1JH5WcH
	BddbYd5TBc8HCBOE1iO0kHvsoPDcRf6Ovs3gD2VtPJ0N52RKKhyc6gHt5yhD9yA5TNSfM0i/Dep
	N9x69Fwb/vj0+3pXEu4PByskTCkW72/5QPHVbOiTONcaugm6HJUYlo12lJGJjpg==
X-Gm-Gg: AYBFou2oTB/wDk/+0YkohP/Qud4YRaCnx+3dfMBkifaYJeiVP+Np6Km9DkKiDyqsaHl
	t9jxXR7NLZjpkWsfc19sdzfHOdskAsu1bAatOj8RSwkMY8+m2biznufG0AiZLC8ziBkcM9/mAcc
	PWjI8nPu3iPVnr4Tnr6wHPqifRuw4WG9+QtV0VXhLE4UsMwWX8kivbCuEhHP6oKYjiMQv0eJYxT
	kTklpr6mwbAUTXYnYf7f7hCosBX+ZGPVLfsQL/zTygByccZB6vRYrGo40bTT7S2u9bMm5W8UpSC
	TVeYKJtbF6Ih5d5MR+U56xxeCEBUS+YBONa3ojDzMkXUCT3hyfZG9fC4uinvAJ22cpR9pCIrH3p
	l0oE1LAMI3WHgAmv2gIOtR0Avp6XOuFKGZOyP1JIvpxrveYYBvAJXpHiXxQBvQBZ8uaxSJ+AYtF
	MN
X-Received: by 2002:a05:620a:4052:b0:93c:290e:9e9c with SMTP id af79cd13be357-9441337e6c2mr2383284085a.16.1793681351787;
        Mon, 02 Nov 2026 20:49:11 -0800 (PST)
X-Received: by 2002:a05:620a:4052:b0:93c:290e:9e9c with SMTP id af79cd13be357-9441337e6c2mr2383281885a.16.1793681351285;
        Mon, 02 Nov 2026 20:49:11 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8b9e:7797:dd05:11cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a879fb29sm25685445e9.4.2026.11.02.20.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:49:10 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v5 6/6] powercap: dtpm: Add RK3588 hierarchy
Date: Tue,  3 Nov 2026 05:48:20 +0100
Message-ID: <973998404b628e5a995a06fbd0febce0802f79bd.1793666444.git.daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
References: <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-GUID: fF4650S-edTMXHqAhGjBcYde_nfDnICr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAxOCBTYWx0ZWRfX0oc5R896AdzY
 wES0mmu0ykAn8u8eT9mU6/vokkfD7XFhcoRlINm1wEmHbNLJHs00AnrMwydAEaTLlg4IqLZ9gh3
 3P7GQzGSL4trwBa3HErGNRV/f2JUMBA=
X-Authority-Analysis: v=2.4 cv=RZ0FmFtv c=1 sm=1 tr=0 ts=6ae967c8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=8Fys3Dm6xgAeGQ2jRPYA:9 a=PEH46H7Ffwr30OY-TuGO:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: fF4650S-edTMXHqAhGjBcYde_nfDnICr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAxOCBTYWx0ZWRfX8epWYU0Mlvef
 nme/B2nEW2Rz4g79PRnnH6qofg4SlkRT1pgiutYhtfsW0EzGwO0xvqqlc3Ifs+CeuA3sDAnnjlM
 z4BQ55YxCUkzYIX9FNQkHEhpGLipotjP5m5mWSCbwstCuo2e/bRJXReF2lLLDk6atHRA1O/gwGb
 32+gbKgUpgcGDEOiIlPVjX9QVVAi1eI0ATpwiNPKuymMmtjiGWLVeztovXZGHX+kOJQbinpUvI0
 qHxBPJqBIWIIdlk1PTpwIXImWzlmClceuLy0WA7CQzrhsm1Z52C6VWUtMUtDAxTNCoC/0AP45rR
 gm1oun5/PLvxLVboCGJS1OOClN9OzRTxb72m7fgjgzX2HAktINvM6652IIYQSBxtzJjYLpABgQ7
 qxA49GseoJxne4JsfSwOI2hfZZwZTZSIz/MXIkhChAhgAeXHW/k4pjDuHt7vo7es/aqeAPAZ3sW
 aKv3dInMPNQd5Vi/wAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030018

The RK3588 has three CPU frequency domains, with CPUs grouped into
three cpufreq policies.

Add a DTPM hierarchy for the RK3588 with one CPU node per cpufreq
policy, represented by cpu@0, cpu@400 and cpu@600. Group the three CPU
domains under a virtual package node attached to the RK3588 root node.

Add the RK3588 compatible to the Rockchip DTPM match table to select
the new hierarchy.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
Changes in v5 (since v4):
- Add Reviewed-by from Lukasz Luba; no code changes.

Changes in v4 (since v3):
- Rebase on v7.3; no code or commit-description changes.

Changes in v3 (since v2):
- Rebase on v7.3-rc7.
- Fix __initdata placement and the RK3588 match-entry indentation.
- No functional changes.

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

