Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681352;
	b=GMi7s5bPXz4pNXn+Kf70Q/iuYcVS0/rK5ghAruJe+VXSWZBGhq6WsaByE68ukqKQMqGE
	 MQkZRZMCJ8PeSKRfBqMfw20zeuSto56sJqb+Pr4Cf+KW6VhQ2gzDqUHjOnnRz1cr7Iy0u
	 DVWdYBnZb7lsePukYs+JCO3216t8kg6KHrrIW7mLH3js47Pq496u5XMQZ0qHciBzb66Zp
	 N9s9ftVj9mPCZhqHSeXDNpZKLN744FBVOvN4kADZrl8W2DxNuu57QbzmsoUKqkB9XCvDl
	 jfGTBtKeEkDj9KzHDC9Uw3ioMFS7TgusUraRNzxAR79uVt+d05dsmZWgKP3OvpApU0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681352;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JCqczoWRKss8snbeoW1OQA5p86RlP9skpTKlIpuQAs8=;
	b=h6bmFdMZP6Zu8VmRFtkSnKQXJD99mXgI0eR69c1QFZ/MWTFFl62XfeMtj9jrDZmZjPna
	 b9iSNdxcrcVLkcYaKAobqGVP31NRNwGguHFjFHcXo36GJTkq0dQxGWBhWJwzWAvoDU93E
	 yRlOiMqkhESafAB3zLs7eVpBKicRBDsS8OgBCCW3ggcBHI/n/+rFhUMErrDIEA5P1WQ0s
	 gTR+8REomjB32rfvUi/qunM3LebOz73iS629jfi8cGEbBHzRTVjm7nd/PAtZf8Cs1JOIa
	 v7GZDNKM5to/yFrKJ8Xpalq71d2MNBmLwQFsvR/CAlZEIEG0PUvM26kgR7/gcZhlt8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IiyEcu+O;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UE5wSs7A;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EDF606D809
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 04:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70EDF606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IiyEcu+O;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UE5wSs7A
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31egDh2012336
	for <linux-pm@vger.kernel.org>; Tue, 3 Nov 2026 04:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JCqczoWRKss
	8snbeoW1OQA5p86RlP9skpTKlIpuQAs8=; b=IiyEcu+OqwEx+AHLh6dxF0HFLuN
	v98LajLChhJP5gTSB9kX9r74mVC9QrqEke9Qvoy3ed90rvutsx8p665rpcGY3QOz
	rObsNdhMw1wXKKCjJUQ54Jj0L7YJh9XG+rnrM0M1/DKI7T/c5BeO+1H9l43OcQAg
	muCb0jxv7fkOZPu79mX/YzDBC3jOm0pCTidi4z6wxi7uB+L4uhNGm5wjXWuw31ls
	O2titeVUNp71mrAKHObPSZ45Fk3C92LDopi6SiW4n8zmMgsBtJWAHsvgoIETBbHB
	J/N6Om7Sj6P2Q+ea2kI8eUsyr0f5QOeLtwtmQcB6WG8EawbK7aY01JWjOrA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsa6uupv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 04:49:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb71b1443so776675885a.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 20:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793681351; x=1794286151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JCqczoWRKss8snbeoW1OQA5p86RlP9skpTKlIpuQAs8=;
        b=UE5wSs7AFOw0I1PckcxU4kGrwxV9y2mCXFTwGvYYb1HYm213G43qte1NEfv4c7/JJS
         IzRKWR09blbCBI6bXDkete9bQVpx6abL1GWS3/pvCXXV62iGIM43HBkXS4ksnvXKcn4P
         OWJSSb+Y7cy8aygnmypYerV2/LN8J05tkxnc/1RY8J7L8TzAH/azECW26E/Be/QJMd37
         /FHQGy9IHzl197jFRfg02aWTXl0wHj2ZHtAZTgg6quA55DjDaqKjuLT1hUJ0Fo+TIyzw
         BgcYi76u5r3P0macgKBNxxyY1cqQ9fV7EqdpBhZ+dyyKHJJBwbjFKmhVPsqYEXw/hsOz
         dcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793681351; x=1794286151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JCqczoWRKss8snbeoW1OQA5p86RlP9skpTKlIpuQAs8=;
        b=q0fjDPPFfBx9j81J6CkUCbvdRwApt9zrYz+kZr3VgjhgNK0nTsWfb+8CIbWqZj8yGy
         pMyhGnlZQY9GQoPMW8Ycfl+PGFJ+g9cceNN/g0V+sEfQpjSgD4aLaZ6Uc4cHrchsimgT
         CKcUOMds3v4WGYJAweXef1jU/Xwb+U0Dv3Ax7LN1ThmeYi82Lu65V04yn2J4yHyZF05Q
         vt8S37oeIPVon6Nj8Mm4gNPux+xGp7j8efT48liaI1MN970Igjq1ngrb8zvhr8BiLpvg
         M2U44z8UVm37KWp/F0d3ozOI57v3d7sV7CIfTKOR6kmd5wc27ma+T8H+k+vnTCwOjSjJ
         h3mQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgfB+jMXxrTk7rWXOPoe6NNLoD8kdjxlAK0cPPzR+HVksEPV3BOebhuNBdv6Ko2pzK359ggVPjbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8O0K83LNrsgPZPE7EHEApGJJn19f4GImRMow5n3teMHDBWamAe
	uE0zYmAgXHu9sWue3uZeB9i6r6IiY67n34I0VxSWHQCISmo0qIsjy53fGsHbalLff0+vSbqaa9y
	NkWIy6aLiAe1Tt0ZK9VwFIqTOUDWXaY1OcxYp5z33ZJr8z6KYThqA1qrboUsBNw==
X-Gm-Gg: AYBFou1siXtNauseAhTvLpMijayO+JJ0ddFUylRkXh4jEVCJm9WPO3EQxxTk0XBBVFw
	QCng0tCRGZwPPSrcmEP0ydqpJjC4SKh9uxccAowDMGEqkqYRwWCIx21uYVEWGh0KGRoB34477P8
	1TrEzYaqt9LBaZgojJ4lQKZG89pO/afs9hfyodf+kzqqXFD7c+Qsrk/pH39tqF45Z1gY2QbKnRz
	73W4cDvov4oBPIkKk9dtJuL5V1+wKQTtaFhmzY+E0yJgWnnBbZwcu3Y42UPdSe6vbdKG4LB5czB
	OwqNLktlYJzj/VXnHVinU/lVHyfSeVgYfTXSakVYXsO7g32I2wIMwLb0i2K1R4qgPHRnLNGdtcw
	6aSy8E8o9NuKEHN/pt+erHsw1J1Q9NkWumSV4R74MjcDqBzCN88ZBjlAC+nGfsje1bPKigL1CEB
	di
X-Received: by 2002:a05:620a:a89b:20b0:945:51c1:c17 with SMTP id af79cd13be357-94551c11060mr930801285a.42.1793681345861;
        Mon, 02 Nov 2026 20:49:05 -0800 (PST)
X-Received: by 2002:a05:620a:a89b:20b0:945:51c1:c17 with SMTP id af79cd13be357-94551c11060mr930800185a.42.1793681345400;
        Mon, 02 Nov 2026 20:49:05 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8b9e:7797:dd05:11cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a879fb29sm25685445e9.4.2026.11.02.20.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:49:04 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v5 3/6] powercap: dtpm: Remove duplicate RK3399 CPU hierarchy nodes
Date: Tue,  3 Nov 2026 05:48:17 +0100
Message-ID: <f9b6ff8250f27e117facd372735b6c1f46e74926.1793666444.git.daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAxOCBTYWx0ZWRfX/03h6MVznd0T
 dT/useaeAcUxmmk1IT8/EDRHyTFduuSLSXMGOz1J8x0cWwE6d7l5pXsP4VI8u/n1dFg4OO7EqbX
 LzcFXN7MoS6uDmAGHzkZhZdIWSdxZB0wpsccZC26018iSfqHCx7C0AhxCJO9qL5JukhkG4/Y7H+
 3btKJ1SnrkfmIKXbtNT1dM0Ru+KYaRcTs4PF1aB+gYXhaZyz5ef1E9f4HfwsQYWgsF7C3d57Qwr
 V8IuZZhkuIWgJG5spyKEXZeWhaOWWRJ886XvkuYVvhQosLDYOpOmMyTO6lcjky98zGtpKmfGy0t
 vEDB/syhvzDtDQzZtWrON/j2NOIiGiPOh6k+8u9uBRUHvsSE+g/6x6LmmF+oZTjjeN3Rx1+CCAx
 N06XFXioM/MWzSxZ7p5CXK8ibY/rRJ0OmKIIFwA/Bivwx//ZulsH8wsLHhb9PZghxaQ8eihmK6G
 dhT5GqKtesTZo5uk0+w==
X-Proofpoint-GUID: CMbOztWg0W7UX5cgj2k9drNOczaAhJ8S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAxOCBTYWx0ZWRfX+agln/+ZS50C
 tQop5W3tR/SjM1HLaYeDiqq0vkD5qED8dq4Nu2Cj8jkfEJfmG4swmtPj45Bo4s/B3Ta/miM6Zwn
 QCSzTUk3u8EEGlKA2be7vdQ9f4os66E=
X-Proofpoint-ORIG-GUID: CMbOztWg0W7UX5cgj2k9drNOczaAhJ8S
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6ae967c7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=EpzjDTW3ywHV2UopgxgA:9 a=PEH46H7Ffwr30OY-TuGO:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030018

The DTPM CPU backend registers one powercap zone per cpufreq policy,
not per CPU. On RK3399, CPUs sharing the same cpufreq policy therefore
map to the same DTPM zone.

Remove the redundant CPU nodes from the RK3399 hierarchy and keep only
one CPU node per cpufreq policy. The backend already suppresses duplicate
registration through its per-CPU state, so the removed entries are
redundant descriptions of the same zones. Keep both CPU policy domains
and the GPU in the hierarchy, preparing for one created zone per generic
hierarchy node.

Also fix indentation in the Rockchip device match table.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
Changes in v5 (since v4):
- Add Reviewed-by from Lukasz Luba; no code changes.

Changes in v4 (since v3):
- Rebase on v7.3; no code or commit-description changes.

Changes in v3 (since v2):
- Rebase on v7.3-rc7.
- Fix Rockchip match-table indentation here rather than in patch 1.
- Clarify that the existing backend suppresses duplicate registration.

 drivers/soc/rockchip/dtpm.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index b36d4f752c30..e71f315fbb6b 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -20,30 +20,18 @@ static struct dtpm_node __initdata rk3399_hierarchy[] = {
 	[2] = { .name = "/cpus/cpu@0",
 		.type = DTPM_NODE_DT,
 		.parent = &rk3399_hierarchy[1] },
-	[3] = { .name = "/cpus/cpu@1",
+	[3] = { .name = "/cpus/cpu@100",
 		.type = DTPM_NODE_DT,
 		.parent = &rk3399_hierarchy[1] },
-	[4] = { .name = "/cpus/cpu@2",
+	[4] = { .name = "/gpu@ff9a0000",
 		.type = DTPM_NODE_DT,
 		.parent = &rk3399_hierarchy[1] },
-	[5] = { .name = "/cpus/cpu@3",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[6] = { .name = "/cpus/cpu@100",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[7] = { .name = "/cpus/cpu@101",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[8] = { .name = "/gpu@ff9a0000",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[9] = { /* sentinel */ }
+	[5] = { /* sentinel */ }
 };
 
 static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
-        { .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
-        {},
+	{ .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
+	{},
 };
 
 static int __init rockchip_dtpm_init(void)
-- 
2.43.0

