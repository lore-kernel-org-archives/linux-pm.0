Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573088;
	b=oNQ84aWlEssJ9SZMKrJgrBtmNuLw9MFMGBs3OejJqJ9ofvtn/lWIHuGbSAMtFJjAd+y+
	 XrpeyNLxD7lz44gDeNL6uHw4MN1ytoLgwdGFm0TmxJomRTz6MgspeN9pMNfdmFsydu3Fy
	 EXVbyAs0g3HJmIwDOrqV+ry/FYVCtHMzRM6HudqnnqYgJSfDWO7ORKEZkltMlanWn0Tv5
	 4clY4fe5tDLf35WWhlw+5f9ZriI+WFYlbcdUGdeN2qivymbg2NJWGUAKGIGApPQURuLco
	 GqBYyab9qg075VQRV34STaD9pDQ25AAqElKtsIJhUIPEYBO2UvEI0l7hJ2Vfkk3dFbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573088;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2AfyFc0ogUfdrYyNRX9G1+SJ+Gxo1o57TnNd9vgut88=;
	b=TWQQcZYeKEgdG24XPKm0av35CVSgjev0xcr7NiqugfVCrZ9UVmWxY/Pm36qd0boPYzp5
	 nsipv743/uyypO7kGuYPSRNAnMPt29eMM5QQAwXygOJmGFqQk7m6wqYFEB3/iHIjyCDD0
	 W1njn6tQ+HDAAg3VbHIzOpQvhjTfUbPWH+HwYqHutRVcv4tzDQxWVy8ZYhlhU5UaBo2uD
	 cW+JgK0z/b+JPmbJl073dYiUJG8niVW1RTNDwSDiubfd0Drq/fgL0qz9NJmMKyQZKpwUT
	 9HuTTkzYLiCfNsH2ojscQnrlonSNovRmZuteLuFxoQTeLuF+EX15cwQLAt9DyqNrrtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gbmHNU7k;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PhKd0apH;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D197606A33F
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D197606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gbmHNU7k;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PhKd0apH
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L8VRuk2795036
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2AfyFc0ogUf
	drYyNRX9G1+SJ+Gxo1o57TnNd9vgut88=; b=gbmHNU7kQbdNXFPXrzA8QJJo2CZ
	a42GcmLkNAmhRgxA0rgy/vM6nUJiUDYRiryxZRkTPDO7AdSiBeh7CvexixDNA/6c
	ISGYKWNKm9ObxCFzqHhhYuAePZLPaLpKUvBVtSu3bgzT630fa7PfYyw0fLPvYj6S
	2TUyUCfEVL5hcvYyLZTS++vaNYLPEHKDgrtIo8C7tJwoVmBSAgjcXNP8MiOisesC
	vcdnQJoKnJkvGE3BKvTKriPn2dQyynSbHrL/cIIksjF7AnhpaWQsmwcKAbfdi1dh
	Jq6C8Rk5dRN2VewIjop8Ty4eJkqf5za68/ekn2P9HwvOKLIqro1xsyK5/cg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy788by-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:58:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934956beec8so108045885a.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 01:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792573086; x=1793177886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2AfyFc0ogUfdrYyNRX9G1+SJ+Gxo1o57TnNd9vgut88=;
        b=PhKd0apHDcO7HGXlquY/vh68RAcWKK0YnTRc6B2RfUSS/A127TaLP+PfnrR9/pTo/f
         ZPybIELJvJvWDmovFf+2/vibMHED2U0dPVytowVfXDDfMYEgFXi8a9zbDRTT06/Nukxz
         50MLg92kyIFYazLZkPRh+O4nSYwjo65ma4K6KDK+yuVTNPRrsFMVWS3IBvFWtmUgJK+j
         FbxVaTQSVPdmA9JVuTIRsvbomkTipdG90ouysK8Bj7NfQKDQ2F5DEFPuR+QY7N3WXzVR
         asR3ZJHDwpeav6vda0ykOtv9Jalm6vc91xgku7PY0rWz113YkWAgopwqxdauaCgyXV3E
         KmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792573086; x=1793177886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2AfyFc0ogUfdrYyNRX9G1+SJ+Gxo1o57TnNd9vgut88=;
        b=hTWGm0MsEoVs4qVjOrpgCmUGQ3RlaAN0GSndlvOsdOzOoJQAofCEl+hhQsfzGAoozR
         VvGA5dFAa5NnhK9F9IpHLxox+GZTsWkIJWxW42tQ0DJ3G2YQ+29oq50xCF/UDESyOB/Z
         lJXN4g8R4YYuT0XZk56/Y3c6B+UMhxtFrShbpy3lJOuHf8Ilr8cJLosjWHio8J53BsRt
         z2uKi65RH2ULxXHGwpQnj3i9T0lc78QRoGvB4AmaNwSj8/keI4jUHkAW/ljZHxOZBgat
         GYoL/uO9EAxLXvFltY2W0FFptj1WA6h01azUDFG7zoyV9L6Asb2YPWC/lb3tbgtUl15H
         sn/w==
X-Forwarded-Encrypted: i=1; AKwUvBzf0xrZIeATBw3N5YC0wATcDBJx5Jl0HfjjQSy1S51jUEsLKiJN0bhdXY5iBdd3XPLBUXzY+1ytjw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLGUN0yKmUx9clIbCz4L7KwDGbmunugG0ut/PLKZYeMHsaBGJ2e
	KATSOyi2pc7LinI4g26dlFY0L6qd9bMRVWdFKr/5fAF9Il+gxOeHCbnwhYFB+Rstelv8wtkp7qW
	WG31BuMSK2nzA/An+39QC5Q8XDdeywN2dvAlHKXHadYbVKx5Ppu6PAh6gq54fbw==
X-Gm-Gg: AYBFou2KGoPg1Eqn9v+M7QkEYKScqQXAtMw6ApHu9f2jv1iqIuRjau6rOdHuGxAJqb+
	HLe2DY169+n67P/WrZWdPLNKRHn6ooTxX50gvAUragQxXLnqeKW1dvN3adzg1qNwtpqWTJl9QvD
	ZAMbaOIM0m6qkzjFLNZHhHZpGTiNUUF+gpvm6hm+zo9nixduDr7qbZu5lwrYZNmNt8ULJT29U7Y
	TqoxrYNpRd/CPPXe5BirDfLV7pFuOvC7p8xM8aYGB0JncJbALFtbmI7iquDaS1tUyhxW6fo8bFB
	ON4mM6zXZFlu2E6WD6gv3uVeLuRNK/S4gMgrCivmpB1ANP/R04UiZuo4Jd0f91n8At6LljZLB4I
	GGXgeQPLpYwHF7CHL+li1p/MAag==
X-Received: by 2002:a05:620a:1b95:b0:93c:c162:125b with SMTP id af79cd13be357-93f57f233admr308223685a.39.1792573086426;
        Wed, 21 Oct 2026 01:58:06 -0700 (PDT)
X-Received: by 2002:a05:620a:1b95:b0:93c:c162:125b with SMTP id af79cd13be357-93f57f233admr308220085a.39.1792573085975;
        Wed, 21 Oct 2026 01:58:05 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8d9e:b00d:491:1503])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258424bcsm4058401f8f.55.2026.10.21.01.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:58:04 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com
Cc: andersson@kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
        linux-pm@vger.kernel.org (open list:QUALCOMM TSENS THERMAL DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] thermal/drivers/qcom/tsens: Validate the sensor count before initialization
Date: Wed, 21 Oct 2026 10:57:47 +0200
Message-ID: <20261021085749.3786101-2-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021085749.3786101-1-daniel.lezcano@oss.qualcomm.com>
References: <20261021085749.3786101-1-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-GUID: vGdqOmEtN8V8_FMQswZ3VMXM80t3nN-o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNSBTYWx0ZWRfX868/pzw4+NJH
 R9a0WF0q6JbEaP5UKa3HhfhZ2G/pse2uVWQ+XeazQUbJHTrb26ub1ETa5D9PXuddKBi7pItU5sr
 McQ9jMtglaZFH+ONTj36Sdd6EBHoKibcpjMiJ+tJUWy5kklfSnKEfUgTNSxzz/nOakZSbmEjWX5
 KdesUjxGvCoSuPiDQWiuaB7mUmJ81fF0K/TJzp1jfTOJzvJymLJsi9s82RqSujLQEg3apdiEV+W
 aM8sAlZTdftTvgfPz/Cqjjk9DH9SHby0QcXiTqAno2uggvcj3yIb2kGbjkav76KbFCsepKfhyYF
 yW1Jj2UudKU818YsttYHtCbrWcz0JH1jOetR74IcowiyAorCARn1a6EHy23pGQbuHAkKOUFlmEY
 wnCsT40N/VzPJ4vmTntIQ+Wxdi8byLBJDjc51fIzuuRnsm0aFxSHB8+NZZfnwQ5BBXdA8UVK6Ob
 Db04OjR7qnRP23adxzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNSBTYWx0ZWRfX5d7G4e2jWOC2
 R5jQQVLNvThxhVMXuKMFJL/mzZmFDFsHDxBZ+AZ8YesVZP+l16IIFJICuJNJx7UbQn0O7bGNeRm
 Wm79RsR34v+xB7bP5/K7VyGxAmfenxM=
X-Proofpoint-ORIG-GUID: vGdqOmEtN8V8_FMQswZ3VMXM80t3nN-o
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad87e9f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=Kcfep0Es--GOdI1On_cA:9 a=NFOGd7dJGGMPyQGDc5-O:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210035

The #qcom,sensors property can override the platform sensor count without
an upper-bound check. A count exceeding the IP's maximum causes the
driver to access uninitialized regmap fields when handling interrupts.
Platforms with an explicit hardware-ID table can also read beyond that
table, even when the count remains within the IP's hardware limit.

Reject zero counts and counts exceeding the hardware maximum or, when
present, the hardware-ID table length before allocating the private
structure and assigning sensor IDs. Preserve the existing fallback to
the platform default when the property cannot be read, and document
both the fallback and the sensor-count limits.

Fixes: 6d7c70d1cd65 ("thermal: qcom: tsens: Allow number of sensors to come from DT")
Closes: https://sashiko.dev/#/bug/linux-d0867095-c131-491e-a6aa-a81debfd0df5
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>
---
 drivers/thermal/qcom/tsens.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4f69ce4976d9..9134637a3458 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1399,10 +1399,20 @@ static int tsens_probe_common(struct platform_device *pdev)
 
 	num_sensors = data->num_sensors;
 
+	/*
+	 * DT may override the platform sensor count. A missing, empty or too
+	 * short property leaves num_sensors unchanged, retaining the default.
+	 */
 	if (np)
 		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
 
-	if (num_sensors <= 0) {
+	/*
+	 * Require at least one sensor and stay within the IP's hardware limit.
+	 * Platforms with an explicit hardware-ID table also limit the count to
+	 * its number of entries, which may be smaller than the hardware limit.
+	 */
+	if (!num_sensors || num_sensors > data->feat->max_sensors ||
+	    (data->hw_ids && num_sensors > data->num_sensors)) {
 		dev_err(dev, "%s: invalid number of sensors\n", __func__);
 		return -EINVAL;
 	}
-- 
2.43.0

