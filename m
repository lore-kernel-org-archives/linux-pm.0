Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505866;
	b=dKtjxyzyZ7rhnSstyduWJ0mgxLS1XBZkza12DlS2OYmqSY5/Rg35ebEZQuEoZ70N5LYh
	 dnQvPygq3EZ6MQRpo+XZnmOzWSnmOR86T3Ku4eTur0q9X7JbuSuPSowJ0CMZLdTHdH+ED
	 RY9q4W8hmx/RX20hWheYHbVripybnXkqmOnoSsWUkwVersN6GA+MLkxJgg0JRMcPgb26x
	 eF74TZre8N7dHo7tvE370/fIdezDFBDI5dK2OCz+bSOwj4879LaZ3Nyy9ZgdDsMIuN6Xe
	 /lswubp2pv1caNyNrB1IeYmiKmvhoozMd8r/3mFmE3qP1qmiFP8rMkKjA5Y5O2cTMyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505866;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uXpc2QWgMGXBiYzG6BvVA2zeICE/TGbAAGJgn9nSWvw=;
	b=NW3WZZ5kFoc1a0b6klJAldwER1gGIWGaERV0lO7Nt9pzyXWUJiegA8txPNWTEDRQqZd/
	 ACQsJeA5T6Xrp+L3LnvCMif1sxduHh8KM/LO33xGEuLu1iAw3Q7GjNlgEh8jjq1XDwaVf
	 i9BT1dnaIaWk4Tz+HqykoqcYaCLAtieGxc/yRg4UeHJTWOrCq+SsazYvj+d7KgZXtykVr
	 9RH9jgEZmSScFf+Z5HvQIoA4BmICPhzDeGn0QGtfwAu/HKkA1KcvOKdvXug9gFsrZ1vMJ
	 aw5SLBKjK28Evw69RaeF7s7/utCVUdR/2HMugkTFNR/f2jP6hJ13yjGsBolbhos5uag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U2eK5zmx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S1I68N5Y;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657B606AA27
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8657B606AA27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U2eK5zmx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S1I68N5Y
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDA376271973
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uXpc2QWgMGX
	BiYzG6BvVA2zeICE/TGbAAGJgn9nSWvw=; b=U2eK5zmxQX3gkfz5ViE8MyntVu/
	GrSSZFnWeIMrCaS3S4TNkmw8V9udeZu2ZINdcXicQRI4p5I+b8jApPKP/kI1N0Wt
	gq0Fwp+6bvT1L7tz8n2cQ8/loJ7m4UBYudoWcyCK+sbYmga8N+y2DqtUdAs1cczu
	MyWN8Vq5G3I/uvesRwwR19+5LvEvXMPrdUTC3B4vyl3IC/oqkc91xmrBaxQWLAKY
	boNvwdCkAqTeHn1JDDDatQ/WFw1/n+1CNP7Q7DAMbEHuAs8MfmWMkUbd2q8k2IJ0
	570lUYY/3oV6qHnGFV9aE2kXqmC8MWyLIIol/1jDn96t16EvY1mn1bxC2og==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hv8hvd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f33438950so854211385a.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792505865; x=1793110665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXpc2QWgMGXBiYzG6BvVA2zeICE/TGbAAGJgn9nSWvw=;
        b=S1I68N5YttxClaGAJfaIDKSu8LpoDfbrTw2Qyc+SXqwYdgawznxCImJYAXdW/zlTRu
         LEB9urQwB2bC6gfLZets46Hf37lV+9JnzLfGJ5NLpuiyapEcjw0HrLxRWD5yoymxV0oR
         moS6OWTbFr2+2JLHhFLCstwuAgsA+5emeHoQCCXF9dhuoAeshpLsK0LypDhgQOazIncu
         jD9kSww7ZIjUcC95tWCpJ0vh7xLFWCFPgHUehEAgIgtn1J6HRPXRQCVDLbVsza2bUo6B
         kSuYgu6Mj6bOnBUylZUS+Id1iZW23SZG1qIRwPpIY52cJxYtGn2npQ2JRZQ6nc/w4LgN
         +mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505865; x=1793110665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uXpc2QWgMGXBiYzG6BvVA2zeICE/TGbAAGJgn9nSWvw=;
        b=1wxZjTwq/D4T+RXva5Gq35DChyKz0+r5p6KBe50UOKasoU1F9kTyFjKI/LHMi5sybx
         65nApqHC6sM4MChaWcsN/aF/gQ/gBH+J4HFyDoWOu4P9nIJgd75j+Vp+t52rxPvGc8ld
         DyoNgBBCuWDi+ypGM75/IDmSlCMbvwQaUQQRgSeOx4VjJePczdWjn+cA2T8ucYw6ZFDN
         AI8Pzka2BRCmgAVlXaNgvJMlzsZcdcZzXrXe8HceO1IQOnkbgnb8zNZbjZPYemI4SV01
         1cJkdPNvRaYRvuBnsaiqEUtMPu2H9vXELXX8kL8UfvCiUsv2kJ6RkOy80NRRcdYKgyEP
         DtXw==
X-Forwarded-Encrypted: i=1; AKwUvBwE4qZmrPo36HLMlO2F3nmYpQdCmrZSCyVOT5B+8vg10Q5zthWBC4QpM2H7E9UO/HQ6wiu0rDvfCA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKKxIm1KU+SLoS450dvhwgf6LZ6NiCiLhqsiAO4TyUAiww4Av8C
	bgB14CuWrNMk9yCimqgOrbBWBPZWRhgGV70L9KAVueGS8TTzPnIG/vF/6uLGsNi4CBh3IqLGcZp
	Q8V2qTz/Fgvn5TWIfxm7W7QgxL7V64F1A1QewJQLkOC5PFa0QhgDYmI0E4VUyVA==
X-Gm-Gg: AYBFou2gGAWyes2V62A2mQkNIkxHYaVCm0POJtaK4CpGy4ZV3Ph9mH8UawSVUCSe/E/
	efEIgTW6gj13OoSPb+sULPvnYB0mMG6VfxVDvSJgv55Utkg/IYlXSUEFeN8r0Uxc8CSe4z7kSrN
	OuvaVe5imvpzPw9kM+Xdalsacuhkwqz53lim8QWqYqhHteRvT1IQNM0IaA8R11ChI50wXyWih/d
	RPHw3qUYAXM0ndBiVHEc3p+Hq53ar2jO+VIct+SLKv4O1FCOFES/1pLhVPhYo2tknYirRS+JM+Q
	05n+NdoqKbeqcyLVP5IGNuqh46DcElTEtp2syfcyQ2tNCRJhtaY49JuwiKZYaW1IungVLq2NG7J
	0jWLu76ZKhTu7AiACXm5Byoz4EVM=
X-Received: by 2002:a05:620a:8812:b0:939:6dfa:48fd with SMTP id af79cd13be357-93f29d8358bmr1660653785a.51.1792505864763;
        Tue, 20 Oct 2026 07:17:44 -0700 (PDT)
X-Received: by 2002:a05:620a:8812:b0:939:6dfa:48fd with SMTP id af79cd13be357-93f29d8358bmr1660644185a.51.1792505864113;
        Tue, 20 Oct 2026 07:17:44 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:4884:6e9a:d9ff:9fa6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d810043sm6642276f8f.16.2026.10.20.07.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:17:43 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/6] powercap: dtpm: Rename Rockchip virtual node descriptor
Date: Tue, 20 Oct 2026 16:16:55 +0200
Message-ID: <5ff8e721e9b2191439dc8f5342fec6f4c07b4fe8.1792504834.git.daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfX5jTv9iywcfCy
 J4411qWEjoSZDdtaYqNm0zH++v0bxrD63P5B3RhlPh2S5KoseVKyKcfsZF2I7V8i9FsuevsI4KG
 2anHQdQzgaXsRY6fZYEhquO9D5dyRZEXyRSF5qFI6pn5NVY4PNnorVIMOaCaSa9NcVL+K2TOLsI
 CFQRLoOF674FvvqUZ1C+P09mecQve2VIlls+05ov647rOpmg7ywRpLumXXHu1T+vLhGf8xhEXjO
 SBbXgulboSSaxrBW9NM45htVECrp2VnagOEnPPQP9bKPdmojotnGyxv/dbzE9RIC5j/kGKpBrDI
 MXnSw6Cvx8gxqFgIHM+E8RKVwxEW3Upm5Lsoc8FZrIEwGTMHjrxw5sIJwrHewLy4iGwHcSI7IMv
 0TB/N/GIZ1rEiG0LHvTRFKboL9jeW8GS5cQSDaglBYrwddXguPx8QCBol2i929Mhnw2nphcRLI5
 WaKjKv2K1bEastf0NMg==
X-Proofpoint-ORIG-GUID: m8rBE_cT71PaVlvQ0d3l4AamjWgF9Eio
X-Proofpoint-GUID: m8rBE_cT71PaVlvQ0d3l4AamjWgF9Eio
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfXzXSwxaknQvkO
 2wNF/9H6JIOlGjdPvkDZvjIBkCAkf2zytb9yrx4zptoy6X9AlF3iuo5kY6d8GddJOW+oUMRNhWj
 7EEFBBwQZrsOqCcEr9+2MrZo5Py/sXo=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad77809 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=_NZqlvP9bvTAGtRSC3sA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200056

The virtual DTPM node descriptor is named after the RK3399 even though
it does not contain any SoC-specific information.

Rename it to rockchip_virtual so it can be reused by other Rockchip SoC
hierarchies.

No functional change intended.

Assisted-by: LLM
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
Changes in v3 (since v2):
- Rebase on v7.3-rc7 and refresh context after patch 4 style cleanup.
- Add Assisted-by attribution; no functional changes.

 drivers/soc/rockchip/dtpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index 222d9098cc98..5ae00680602f 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -11,7 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
-static struct dtpm_node rk3399_virtual = {
+static struct dtpm_node rockchip_virtual = {
 	.type = DTPM_NODE_VIRTUAL,
 };
 
@@ -33,12 +33,12 @@ static struct dtpm_node rk3399_gpu = {
 static struct powercap_node rk3399_nodes[] __initdata = {
 	[0] = {
 		.name = "rk3399",
-		.data = &rk3399_virtual,
+		.data = &rockchip_virtual,
 	},
 	[1] = {
 		.name = "package",
 		.parent = &rk3399_nodes[0],
-		.data = &rk3399_virtual,
+		.data = &rockchip_virtual,
 	},
 	[2] = {
 		.name = "cpu0-cpufreq",
-- 
2.43.0

