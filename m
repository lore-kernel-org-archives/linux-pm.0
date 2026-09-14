Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C13749F4
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368886; cv=none; b=SGEfp+bgPk/ve4UPoPEsTECW1l2ZroeAiutmI9NlcVf6FhcbTwEtdeHvy5bKPuwE1vcAKbdnOtZP8dmnqyDfrgAEaumTeqbpCnSjhSilp/qpu1XEyc6wHGBUNoTCxW4M8QyeeVChR12bhzW555NhypIEmo2527oGL8qqBfk2s8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368886; c=relaxed/simple;
	bh=xQq8hwX4I7JTKYeeMwejfl+3CQIzYaWEKGcqVIK6CgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g5nUc5tln2FmwuS8czQVZY08VRcFayyMySAYbq9IhHIOBDZ1aJvvOaStCvd/fVTtX5wiSxwI/HFqTJh95n2Grz3BrOSk3f8SpSGDF/qiW+pGh3sPdJ7xOKRbKLviT54/U1b3Cn1jcU5w0Z8vzgRRCDwIxej5Wh7tmG0AVWibjHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FYy+MaCJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C+EUhLXg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FYy+MaCJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C+EUhLXg"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5jZN8237716
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 06:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LQF8a6T9OCyRSQ3DJ2Asg+
	h5w79nawgu7eXhWJOPE8A=; b=FYy+MaCJq2IxmTP/QT0kTZlMu71SiHgq4cKu2u
	c4Z1oUpFPyG8Xzw8inJmXNChqb/84eOxRk5MDgzSjWyJOARqmbFVGX7BKSzs3sSB
	Zg8///bWjcEpDfPEdZQf27z7w+MRbU5N0igBkiAr/5pnwldIA2PyfyStxk7cU38B
	VQSZtsZUd6XIrRs8kxVw/3GaqgsMrJ8bBo8fd22/R/DST/v0VhWo2Rpoo2r13h8l
	8+AJ3KBt6ftq8wFgCBD08HTIYGlT8HhqFQwVxuk7rIL+F9PWBQMCX8JTBNeco8xn
	aVH0PO0a0Le7zk872UM6yXBtN04TosV5EWVOdDDQMOxPFNZg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dne25-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 06:54:42 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc489e7a701so4263690a12.2
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 23:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789368882; x=1789973682; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LQF8a6T9OCyRSQ3DJ2Asg+h5w79nawgu7eXhWJOPE8A=;
        b=C+EUhLXg5yOqx99hEdWKLqu43WiDu1b7mJuDsTWgU9/TqIRtgvmdAZ+9UztWgWAv1P
         bCIkfGUgPuYWfDqwqgMv4Oaj1e+T3Ba0d2oSMoM/+baWP7xC7E2rPE2DLoBPH1rCvY70
         wQXe1GqHpGxNYf9SoI4Yud74WE1+ZcC4lC3t5/t89N5xyqi9T8aLg+vfB3z/RO8HG0SQ
         OnOsgPZtwD143XhQ7MeoILJs41MWNaIFR2VmR7BVy8Cmy6uxoWp3BLr+kskiXOtUjCT6
         9V6VSw6eYp0PWHdixN9yeb9b+SzlybqQ4wDZyLx/IjT7lIIGUgZlVIzz8EATHKjIi4D3
         oJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789368882; x=1789973682;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LQF8a6T9OCyRSQ3DJ2Asg+h5w79nawgu7eXhWJOPE8A=;
        b=YGohJB3OYKe3RqoBNekYANiuAVm0GBkH3RJbKOkA7WtvYS5HT+TkTUFajehN/icmCC
         MxklGaC6YRILfO/6TiA26nNKTqWtFlGY8jXEmWNtRkw3xKOhxB9nFdqx5F7FHBgpkgDp
         h9KTDqMEMdt6+uT8oE/Kho7bBspzd/Pnd0NnYocE7euFQsZzT/fH0GKHgtrerNbg653c
         Rp6Q6v3r702Iyke+xiHiob2GYnJv2Uc9PackpEfwMNDUkMnQ9BEuS2f7OL/coUQX+HXs
         sbQ+ATE85iY/GbWfRL7Yh1PlV5t2bdWhtGcHU4pDftqh8LOWfl7lcJPWEwdcMWiPIJzT
         zB7A==
X-Gm-Message-State: AFuF++mzlT97f51sqc2RrwEz2Qo57zbBjIinym2YzxS+2WoeU9d8IaYj
	GmHpvvDe92arSdI2GRZjkB6IksfnFJTTMRbY9x1Zz3ACbyRz22ja/P4L58OxPnBmIlw8CWKA8PB
	f1hSUo7QJSMWQj2nwTafp61Y31/PsAoQtl/pRBRexuB6EC1R6UE7j4G1v8oDZwQ==
X-Gm-Gg: AYBFou1zzYiY1xLBRVQlC0kUgnufSmujxTrcjdoc1IcjmNrN1UmqJ1mVM0USetR7Z/s
	vMaonNqV3GMjtfrLud3H+CIiOeO7Zl5w3K9+hrZS1Za9wWgZfXnXfYN+aWnnhs2cd1qlymiHx2d
	p9icP19Ei8v7k26Qnnq4j5H1Zj3npFnTSmRLvDZkuHC84cSMH321dGBn6hDelsMD9KAvstRgsn+
	SiA2HgWq2SLQZlSHFFyEGPHF7nuilHS4bNvSbSOxCPZibFFBtbvhqOEar6PqFhZVPQ58unX1wl/
	uq8/l/P2acwfTdf0meCMayX3P9bJGnlhfbS/fPTBGH06FRhjMt42vKX/WFen1yBIgR47Ux/GNmI
	mRjdb/QM/wUNSWdAvig2EKyIM9e0D
X-Received: by 2002:a05:6a21:b93:b0:3d3:aec2:4dcc with SMTP id adf61e73a8af0-3db40611b7dmr2766871637.24.1789368881773;
        Sun, 13 Sep 2026 23:54:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:b93:b0:3d3:aec2:4dcc with SMTP id adf61e73a8af0-3db40611b7dmr2766823637.24.1789368881332;
        Sun, 13 Sep 2026 23:54:41 -0700 (PDT)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm25924720eec.24.2026.09.13.23.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 23:54:40 -0700 (PDT)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:24:25 +0530
Subject: [PATCH] pmdomain: core: Fall back to node name for idle states
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-pmdomain-idle-state-name-fallback-v1-1-e4242c409a0b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACCap2oC/yXNQQrCMBCF4auUWTuQplbQq4iLSTLV0SQtmShC6
 d2Nuvze4n8rKBdhhVO3QuGXqMy5od914G+Ur4wSmsEaezDHfo9LCnMiyW2PjFqpMmZKjBPF6Mg
 /cHBuDG60hgYDrbMUnuT9+zhf/tanu7Ov3zBs2wc3tCFDhQAAAA==
X-Change-ID: 20260914-pmdomain-idle-state-name-fallback-3bb5db520a30
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789368879; l=1596;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=xQq8hwX4I7JTKYeeMwejfl+3CQIzYaWEKGcqVIK6CgM=;
 b=rlyiMCXvAMF56w7WTSZ8W3wD6nkU55XUyOrQ7XQIYXofe0n4LBkkDMuPTfj4ZNQqcm0ZUwEx8
 X8+6dC2RJL3Bf/agapF5SkdrL9atcXZ08jHATEsi9NYw76/G4xuiT8c
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-GUID: Mc-QD6PAtrdirNYHUMIgUjZKx5NKmXqB
X-Proofpoint-ORIG-GUID: Mc-QD6PAtrdirNYHUMIgUjZKx5NKmXqB
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa79a32 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=XBISo84U3woaGXxjM1MA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA5NiBTYWx0ZWRfXxQmiIKGpWnwU
 5zMjQN90r49SOrMKb9ISlMYx6xpM36U+kHv7nRoX4CuSC6znB2fhCd+ajz6g0zT7iHKER6eK3Df
 YznTaV+L6HSx2g+SV/PwUV2zDYsfnQY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA5NiBTYWx0ZWRfX3UzCg465viXV
 8EESrCMJEpzYOed/s6wfkEXq8fjnPzZw78fN6JGft0Uxmv6C8cIB+ggMof5x5vSGBimgKL3BzOA
 sdGva8wPLqlV7LYShA46+YRczbksmqWkmAc6Nv4qAhOnN7tvl3UIW6/K/fDyvVDutCUIQjgTrVz
 Br5bdTIWy6FEDXtDPhnax5MWUB54KxEp2rvym/I0NXPEzpXaiCuAIBBsNEoTMgzZIavN6mrGKh+
 fYsy4sTM3O5clYUrkFR4gXEejaf/oJkR6Q/wB73tY/pb4lFhNYh5uoCLZ1ebdXWQi956xGPp+Ke
 93RB79Z8hsMtY9R9F7NZ+twH+vKCP1z5Rw8KvNlLrARXFFOUH4kw4bquCqFvqV0qji0VWf1ZEJd
 7+Mf7OX3wWUd79q/11D331m+65ZmlaRsl9D7kJK/yME5B/rwNQjGB6Wq6sRrc9LCneZiSsR6h4K
 6ceYVpq0pACT/UUX4xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140096

The dt_idle_states uses idle-state-name when available and when missing
falls back to the node name. Do the same for domain-idle-states.

This lets pmdomain idle_states_desc debugfs show a name even when
idle-state-name is omitted.

Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 drivers/pmdomain/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 052ec478dfcc..d0bcb4897477 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3583,7 +3583,10 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 	if (!err)
 		genpd_state->residency_ns = 1000LL * residency;
 
-	of_property_read_string(state_node, "idle-state-name", &genpd_state->name);
+	err = of_property_read_string(state_node, "idle-state-name",
+				      &genpd_state->name);
+	if (err)
+		genpd_state->name = state_node->name;
 
 	genpd_state->power_on_latency_ns = 1000LL * exit_latency;
 	genpd_state->power_off_latency_ns = 1000LL * entry_latency;
@@ -4006,7 +4009,7 @@ static int idle_states_desc_show(struct seq_file *s, void *data)
 		snprintf(state_name, ARRAY_SIZE(state_name), "S%-5d", i);
 		seq_printf(s, "%-6s %-12llu %-14llu %s\n",
 			   state_name, latency, residency,
-			   state->name ?: "N/A");
+			   state->name);
 	}
 
 	genpd_unlock(genpd);

---
base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
change-id: 20260914-pmdomain-idle-state-name-fallback-3bb5db520a30

Best regards,
--  
Maulik Shah <maulik.shah@oss.qualcomm.com>

