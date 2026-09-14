Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B835292A
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398132; cv=none; b=rZ1Hx9bU2H0gOtAYKRtZUiYVKx/oVLe1GVB2/BgNo44MJLs6PMzfB23KzUjei2fRIBOusB87mk8/y2r3dN8WUpN0CVRPgArmI69RjabpZlmgsVcAEieIsUjZEGiaS8xsHPXFURs+MKHaLj3EtdjmEeqyzDETdex7NXq2Gz39dfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398132; c=relaxed/simple;
	bh=eRZchRufhj3t9s/2k/I67ScznlqWKjd4OkHFdD5fxaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m76uOfenRU77B75gCbZONf9fZ0s2GGXZJ58t1ArTdrRZILzVlBYiIo1uWvNfKAa85Fy0H9I8ZcSPl2YqzM24sTxmiLhhMOO85/EDHh8+OXR9EdLQAwIK6imPfyqbwWziZYFsr7RMFAunwZsYvPe+pJu4mBy7WfhSuk5ePktrOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RrEuUu9q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DfXbY3P0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RrEuUu9q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DfXbY3P0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0hkQ1200872
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=w4t3O+boQ/6
	prVdjN4I3fTqFDViq1Qb1L+fZxB5u9Ng=; b=RrEuUu9q5M9qmpGHhQ8s8q7Pzl9
	EpkPm/6FmCnxpjBOSLOGlCC4llT6x5+99fyOX7zFdEhdG2bIE+aelkWW825w49nR
	pY2ITnqj1XjmAVakfbg3jRGMmlwsUjrW3o+h0WEcufPQY+T9240rla/h6/kmxD89
	6psc+Yb+beDmcVwsDS+U6+yl6MbG5AJIxgdHw4XeoTHhab5r/+D46h46fBfWb1G7
	ZzaUmglfFTWoBY9GGm2162yjAoWviXpIxNHlEjEb6oJOKuyVfigZzuJDfi30gCsJ
	BuBv4CBNv/j4DDRtxDL8uXSqP7Oo24bB6r4vrzDoMrlb2Z7K2xy0GcDdGGQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdevsejb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:02:08 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-78fea4e86f5so3522749137.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789398128; x=1790002928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4t3O+boQ/6prVdjN4I3fTqFDViq1Qb1L+fZxB5u9Ng=;
        b=DfXbY3P07jgfy8YPoXX5q7lO7IHMw2IXSygglBsj5o3G6LPeM96NDTst1S0WmpSZtm
         vfCOsM05Sqbnc6En4zjo/YuE+ynNO+GeU4grjnwZQ1ru15AtPEuzrXCocZDbaOkCqRVB
         vooGl9MZXBR2FDdgGMbLEQAkFxL4Ys+v+iqKc3iO31+Xft3qH3fL+QuV1YGdLrurXj4W
         SJYRWfYu22GtmbNT+afgSW3hnIZuaeWS3p/wXUoafnkeBtUC/+UGiODjCDqPx5B6oBel
         /UnpuW+D1li7Jgimjbrx3ZPieggjGF8FfcVedPQCet/pdI+KKbosA+7SFV8vMI7ItUZT
         AQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789398128; x=1790002928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w4t3O+boQ/6prVdjN4I3fTqFDViq1Qb1L+fZxB5u9Ng=;
        b=Q5moGKnxME71t/8guONd08OP0mCEZxbdS94AYk9oNO4Ipw+vFrmoUMTZm6vas7h7zh
         eHPMngBuIX+UkOxKpIiAvsILiGomhfVhQHmj2/NBFuLR6GhcgtQFqaGArO63+AvdXkVc
         A+NDUj2IGm/kBpj7JMoWftEgBWb7/mJT8KOPka/Fpewus8ZQkLyiIiXGt2PdVoopW0aA
         lNGsIDr8Zo+Wpgyh857Xinlkye+fTk/Zti5HCMBBmh3HqpZIIsOHP9UiUWHaSQUHuU0d
         +wo4/yuhc0I1HmO6JNHpnmW6Dv3U8Wq4t01kD4ymrVHTuQfp+7b68RSZxxqZK5n9HItK
         p3GQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBrLSc7xYQO/ynxub6vjb0mHPYNgRABfFRXDOZF1JunDShAoittn25fOJ09V6YXWOMjm06fMPJjg==@vger.kernel.org
X-Gm-Message-State: AFuF++k9+atfqsHhjl6v2X58ZL0LYYN+CQEaIjdNuLN8feRFYCiMfM+/
	XVhPP6V0K032axzlDtkpnmdpdR8qV7n8XeZkTw03p5kHh5vtB/biBG0adMd9+oFxsxoO46RnyzD
	xGl6Z2OoBz3YYwcTOFMBUn7WCI4YTdoLkUVuaesc3hBXWGumyqq1IDO3OxUnzkw==
X-Gm-Gg: AYBFou38DaqQTYyQyOdWYDWTVbeM/4SU2IpZqPtjN9KJy5PwTr1OsQNarqo5uapGKls
	NguUdvHTroM9rTYW6NvlvYYkp/TwN5wl4/B3sidhk3hJLKLJafmMX7eH72fDi9YGXtNlBZVmYo8
	lsdzAjxpQQUCOODkYFqOZAez2ywXn2XzS+KOyxK+JYsNK8vvxn//zl2eb+L98OqV41m11e9d7WS
	28aS2vsnS+CeJ/JwRbwwHw622jt25POJEFoP2IXi4McmYQG7gc0yyeAuLbFzd9Q9LkFI2Ybx3Fk
	R78TNxnJjK9CYILLq8vsV81HSYVIDhoxYAQcNfPyTLvyiTcLomwOK3JI32ZFPP5A/JjsCMMdZRh
	UJTkZhLLg3gJaGKrKPBMXPhZ18x07BSVRiX2/o558V2kRR3qGGmPU864W0Q==
X-Received: by 2002:a05:6102:22d4:b0:791:740b:7ce6 with SMTP id ada2fe7eead31-798930aa611mr2058731137.11.1789398127706;
        Mon, 14 Sep 2026 08:02:07 -0700 (PDT)
X-Received: by 2002:a05:6102:22d4:b0:791:740b:7ce6 with SMTP id ada2fe7eead31-798930aa611mr2058562137.11.1789398127096;
        Mon, 14 Sep 2026 08:02:07 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296608480esm468632666b.36.2026.09.14.08.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:02:05 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Dhruva Gole <goledhruva@gmail.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] cpuidle: psci: Move initialization a bit earlier in the boot sequence
Date: Mon, 14 Sep 2026 17:01:41 +0200
Message-ID: <20260914150146.187622-6-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914150146.187622-1-ulf.hansson@oss.qualcomm.com>
References: <20260914150146.187622-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9Jzzs6QrLN2urX7DSeKFYcpeowPTKX6b
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIxNSBTYWx0ZWRfX7pDssFNu1YH+
 ex326y9oQv88vbMSzfR7Ezr6I36AwDoaatuUL8kqNrhqUKrwXwM4mSuSZV03ifLGu0kybEr/kqE
 672ZIcHlSDwZwyxMztovPIwMm0BMvVc=
X-Proofpoint-GUID: 9Jzzs6QrLN2urX7DSeKFYcpeowPTKX6b
X-Authority-Analysis: v=2.4 cv=ftpJ914f c=1 sm=1 tr=0 ts=6aa80c70 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=lJEbMRRrfWY45v_ev9wA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIxNSBTYWx0ZWRfX02FGJvuMXD9Z
 6stf3TjGoQb1+DdCINxJRfIqGS+PrLasQnET0hn7lTR44Lihhqvh5hR5Ef/A50bhfJNZX/WS9lI
 t2ZQjFRVqJu2xFikRQDQaFG2nyhuaZNJa+MaP1xNkJWMiJhPTCeHYMdU+xXfAQ/tkGsEclNJeo2
 Egd71bE1SSnGJPiDFJqOWhd808RxSVPjN6f6lIZF/xCmse7eRhdPl8fwIoE4liW8kbKmhnCDlT8
 xs2yzHmOJP6uU5uGHcJVQAr4/YF1gP9Gvfx6TkS0uNXwZDgplhEFxCLBqZ6cS8s6ES6YK4tyujT
 QcTTH0E8WrhfAyuH0JaYLhNiOKuqWyG1FKm5nPhomHMqxisVvp9/4kwX+eJVYUX6FmnQk1X73GC
 3qNLcEov1zuLwpbCD0AVO4jOpPMuVzZ3O6xcou42Qz4luicExy6lW8wY37rVPPBfR2LVdMJxfDN
 5Pm7ivi+FPYza4v3jug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140215

When using PSCI OS-initiated mode along with the cpuidle-psci-domain driver
it's of great benefit to attach the CPU devices to their CPU PM domains as
soon as possible, as other non-CPU devices sharing the same PM domains
depends on it to allow their devices to be probed.

Let's therefore move to a subsys_initcall, which should be soon enough
after the cpuidle-psci-domain have initialized the PM domain topology.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Tested-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---

Changes in v4:
	- None.
Changes in v3:
	- None.
Changes in v2:
	- New patch.

---
 drivers/cpuidle/cpuidle-psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index b250d0dde760..0187d6a9096a 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -479,4 +479,4 @@ static int __init psci_idle_init(void)
 
 	return 0;
 }
-device_initcall(psci_idle_init);
+subsys_initcall(psci_idle_init);
-- 
2.43.0

