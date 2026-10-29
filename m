Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264537;
	b=MGz911vPN8IV2LQlIgIyXEHE4Vfgx7xhCZAFImfHaZ2eMAgDQ7WYTVjsyi07eMW4kDvg
	 uCGdNqPD3+M+D149OFVZm6lXyU5AWp3FBL5Nul4pxB9JSP7lFXLVkerJYtdqvYe57SomH
	 N+ZIXF8bArhufJwA25wVj5ZrioqVVHPv2IQmLWWJKC1hkfruXiqPoIEzDE8aVgEG/o5WO
	 2gW8SixklMGub9oRFtjebO3hRU+zrbaTWgMj1AC+U5GhErd9MVKnQWoxJt9iR2n4rEobu
	 rLjehmVJu9yCfySdMAeSCIRFF1LIDZqM2pW+/ru+ZGfG4tWiGijLucQfQmaHC2t2lnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264537;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=O9tE0VhLdA02J4VPxVQaUCiXLFk5PSSXEe9PuZp3B6Y=;
	b=kEghnCiHI1Tw8SeR9rw5purSUOtcLviFUMcmU9DERra7s9juDwkaJsgX/dv/14o/utof
	 KN123mCR/uVdSl4y2q2LpoUkMe8TvYvVGzh9unURyQ/6W16s99RXOWTvGh9wLldIYE8f9
	 7hR7c083F3ev/9rPBekTGVAH5B2H4Qj/tvgFvH4B6gC1FlD/z0sC3NEFv6qhJ9i+9/rvx
	 i4vNJ2JhEoXc5IVkQps0Y5azq8+Ulq+g1WvWFS59VN89Q1ENqIAy40AEeVwH6B8NEsil+
	 /lhII25IS6Kbb08R43vJLQ1n+TfKwNdLhyFQa/c1Z9u1IHhVu+76FPS/p41sPi9FWGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="BL/ohZZe";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=enCyjhrj;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B63606A331
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64B63606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BL/ohZZe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=enCyjhrj
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vF8G3775301
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O9tE0VhLdA02J4VPxVQaUCiXLFk5PSSXEe9PuZp3B6Y=; b=BL/ohZZeT2Ub1L8i
	Q85twEiv+1skouGeATcwuvx7eQgdv/Xtq8jI1dokM0g45a70s4F+qfhG2j9fldrQ
	JU6ia8H2W0b80zUxArcf4NnA1W1/CLQZP9mfZu7G89CPP3DueE3hDngSF+GJudna
	qTfxxvxvzQolFMXvOxo4Q9GPfwGXRxhci3hvvZU1TtilW+eJ8AOLruxDL1tMWD0F
	EsREAtsxnkDxAQ0wEm2AvI5CVEDgpNCJ7ZQtEupyx2H0PGRjPmMTibG9Uyn2ivsN
	mKtKA/lQzSu8XMx6TON8t1FOwkfBnG+wmaMgvZCKd8eKQgY9Sw6mSOB7qKctK/nv
	3CgOUQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkxshryuc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:02:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad704d4760so1589733a91.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793264535; x=1793869335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O9tE0VhLdA02J4VPxVQaUCiXLFk5PSSXEe9PuZp3B6Y=;
        b=enCyjhrjerBxgDlhfi0wtq2VSkxCIbBct8Xv4dXSAUiMD6WV6+Hh+EAco8rCKnC9f1
         2Yxl8Mc7vh2CEzx/I63CeSZYF16Tcr53f2/n6EKyisvcBWkF0hv5wGdUsM++OAdURMf1
         iN0XZDPcHon2M6MS8VLoMm5VhKUqJKnYDlRBySnV5QC1neV+liIM6AvU6BqVbaA51Gam
         VwIRfumv5CdQoXkPdC9o6w2VGWfZL9U2yogku4zfik+fdP+sywq9zifIxWa0b7/O/lQf
         EayLO+Czu5w+mlR4ck9OBwIcNd8A+jEVaijKvJx9viF/9aBOz41E70y/E6VsML8/4tO8
         mxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264535; x=1793869335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O9tE0VhLdA02J4VPxVQaUCiXLFk5PSSXEe9PuZp3B6Y=;
        b=jOFDk2Uizl5kamSKjnoc0Ee/q8/7MCktI7hCjICSNydAMV0rYkN2TT51YvaPUYWCfd
         SrSNs2KGdUrtiV75AyYuX0ct+2rCM7evWBT5C72/hycwDI19NeFRPdZxb2Q04TkQdl9v
         oDF4UdWPfqQLj+NHTNjswXJyDn09Psal63Jm96SWNzuk/2lsRv+8EB+L+PaEhnv6dpL0
         VaSU3JU3Bg3Ku5K86im7xRSSDGad6INyJ25u7KNFrJfEFIQhIHZ0fx6PE1zHVRm4Nczw
         jfsQMagoU+Ejvfm7T5gIE5nSN+07NDd2BrJ1a7QWlYTmJpD7/yrzIocXYvT3/or2KpFh
         l0iQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1wScDtyvLW4lW33KkIrTiDW2k5cGV9lx5oTCOII88nqTdEqcQAzLrHgM90zWjO8eAJoIBQn9oEA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJjlNswJBduJRZuiMNXzZ6ydrDK7eWwmwnr72RShYoARsdBOL3s
	A8Tcc+ysJ0tdXajXLnc7hdhbwDyWEbdz8+c+s6pzDkSvjX3alQn6tNTlsCmfEkYwrKo63lCGZYq
	IsdSHZ4Q0zbrfmLxwSSWvRC6uG6oDxBRZ76fvlfpJqq/aJnX5B+zZShxUTQWolQ==
X-Gm-Gg: AYBFou0O9+ZOibx7GHqjdG3lnuBazi57/f7nzRbq9pT3jfkhiSJU/tc9BXOMD4/PMPZ
	52EbV+8DUQNQ9UWjD4vYOLsXtq7HUEpzAls4dHSRrk/DvjouePIngruEBfVnwZWlF1h4qZknlfi
	YiAHqOlbG5SuI9ARgW4GlgznjZMu3hAI0dF7ImPbiiHSm0Ts/9aCY14bT04B06TbRr4cQmOkahx
	dtNU4BcoA3ej5RwdR5k+4VWbhpWNZubCvGJ0dGGCaUGLs+XDoB5kZ/TKTTaiRj/51rH9gBFhFof
	I5UCtV17a8zS53ZhMfWoNHOggxHNPjRrYNEUyUKen3PvZexA6eG3nqUIdgLfUZjUi5ZPeCP8cFN
	xEgH0ux9lqF8MKcDllpRmeQ5K1NW6Domdkh4QbwBDMQIUrV1E4eHBHqucVpy2BLBqLdPhDBIfPT
	hGLlln5xtb
X-Received: by 2002:a17:90b:4b89:b0:3ac:17c:6e85 with SMTP id 98e67ed59e1d1-3ae581e1959mr3770257a91.47.1793264535058;
        Thu, 29 Oct 2026 02:02:15 -0700 (PDT)
X-Received: by 2002:a17:90b:4b89:b0:3ac:17c:6e85 with SMTP id 98e67ed59e1d1-3ae581e1959mr3770169a91.47.1793264534432;
        Thu, 29 Oct 2026 02:02:14 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7ad710sm3197385a91.3.2026.10.29.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:02:14 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:31:00 +0530
Subject: [PATCH v27 06/10] power: reset: Add psci-reboot-mode driver
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
Message-Id: <20261029-arm-psci-system_reset2-vendor-reboots-v27-6-fa4b3ff1359b@oss.qualcomm.com>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793264458; l=7058;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=zAebzMok6MKL21880n9O4CoUq9888Knlr3p3nNPuBa0=;
 b=A+v7i4iLM+vZC5KFPyNk4BIQswY5X5kvCg4cn7yWdhSuFVWy4Xdy5OybTMAUZne9NeTpJGB/C
 szcw2tYRimCDkGLYvzdoiYvqPrlrwqy0FlZrdLVVkNqV/q0ranqRKAx
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-GUID: 85sSkBkJaEhcur8XbCv3dPtc9DT5nDIq
X-Authority-Analysis: v=2.4 cv=H6BOUOYi c=1 sm=1 tr=0 ts=6ae30b98 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=OTBdipT0aglEIzt2I9sA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzNCBTYWx0ZWRfX4IYdB0J2Nn7a
 N4JswOFOH2QEDEGvg156qWNCF8tsdVHfXc89Bbrh9mjfn7iKo7rHY3eWPNB6HEw9RRSKB3+ziIm
 3Hr0wWyZ2baXEFpLHIuzmY72ZAmi75Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzNCBTYWx0ZWRfXzJcsKK+YjJbU
 JxHJ8tCBIi9yIt+sHHoC0bPeEHAvdJUfmMFOIj5F3+lSXKEnJPuJ8mknmCWM70K0aX6o1jeHpBO
 DA1PxJarDiqSRDOaZ4dK17Lg/gn+MssSrkZdoSoRoWsqDNgxF/TqIQQ8OaabFMFBV9Tl+9JW021
 VCNFVZyboE9FlHcXxPI17HubKeY5MFjWi2Qro1sWfXSvkcI//y13O42gOx7FsHBqqLkHaoMGFCT
 /PdhUliJhWOMpW40Qx5M2da1tEOsCx1I6zqRtbNjYIgHB/8OGnM5ylx1IvHULEqkiRAPDe0SquU
 WFoXTLcgDViUnf07SHXIzUbV3HOm7ho4fhuPSuXivlyfUl4GC5DLEp6AMfLuGdy5HqyBFot/9eR
 FvUTzZaPFJS6US7PAlCR5K4ydww8hifn9AidL+JfD3IT6fRrjaQkhmtG7j4wSPAZh6x9aAj3Sk/
 IVIDdxZG+c9qgyNNUYA==
X-Proofpoint-ORIG-GUID: 85sSkBkJaEhcur8XbCv3dPtc9DT5nDIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290034

PSCI supports different types of resets like SYSTEM_RESET, SYSTEM_RESET2
ARCH WARM reset and SYSTEM_RESET2 vendor-specific resets. Currently
there is no common driver that handles all supported psci resets at one
place. Additionally, there is no common mechanism to issue the supported
psci resets from userspace.

Add psci-reboot-mode as an auxiliary device created by the psci-devices
driver. Define two types of PSCI resets, predefined-resets and
vendor-specific resets. Predefined-resets are defined by psci driver
and vendor-specific resets are defined by SoC vendors, under the
psci:reboot-mode node of SoC device tree.

Register the driver with the reboot-mode framework to interface these
resets to userspace. When userspace initiates a supported command, pass
the reset arguments to the PSCI driver to enable command-based reset.

This change allows userspace to issue supported PSCI reset commands
using the standard reboot system calls while enabling SoC vendors to
define their specific resets for PSCI.

Suggested-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Suggested-by: Lee Jones <lee@kernel.org>
Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 MAINTAINERS                            |   1 +
 drivers/firmware/psci/psci-devices.c   |   4 ++
 drivers/power/reset/Kconfig            |  11 ++++
 drivers/power/reset/Makefile           |   1 +
 drivers/power/reset/psci-reboot-mode.c | 101 +++++++++++++++++++++++++++++++++
 5 files changed, 118 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4ca41cdd872..0e03826eec48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22292,6 +22292,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/psci.yaml
 F:	drivers/firmware/psci/
+F:	drivers/power/reset/psci-reboot-mode.c
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
diff --git a/drivers/firmware/psci/psci-devices.c b/drivers/firmware/psci/psci-devices.c
index d23befc490ed..04f24b8d9943 100644
--- a/drivers/firmware/psci/psci-devices.c
+++ b/drivers/firmware/psci/psci-devices.c
@@ -20,6 +20,10 @@ static const struct arm_psci_device_info arm_psci_devices[] = {
 	{
 		.name = "psci-cpuidle-domain",
 	},
+	{
+		.name = "psci-reboot-mode",
+		.of_node_name = "reboot-mode",
+	},
 };
 
 static void arm_psci_auxiliary_device_release(struct device *dev)
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index bce996bbef28..f165a41d40ed 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -360,6 +360,17 @@ config NVMEM_REBOOT_MODE
 	  then the bootloader can read it and take different
 	  action according to the mode.
 
+config PSCI_REBOOT_MODE
+	bool "PSCI reboot mode driver"
+	depends on ARM_PSCI_DEVICES
+	select AUXILIARY_BUS
+	select REBOOT_MODE
+	help
+	  Say y here to enable the PSCI reboot mode driver. The driver
+	  registers with the reboot-mode framework to configure PSCI
+	  reset commands, which are executed by the PSCI driver during
+	  psci_sys_reset().
+
 config POWER_MLXBF
 	tristate "Mellanox BlueField power handling driver"
 	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index e31cab4ba78e..45d8aaaffaa1 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -41,5 +41,6 @@ obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
+obj-$(CONFIG_PSCI_REBOOT_MODE) += psci-reboot-mode.o
 obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
 obj-$(CONFIG_POWER_RESET_QEMU_VIRT_CTRL) += qemu-virt-ctrl.o
diff --git a/drivers/power/reset/psci-reboot-mode.c b/drivers/power/reset/psci-reboot-mode.c
new file mode 100644
index 000000000000..c5dcfc40392a
--- /dev/null
+++ b/drivers/power/reset/psci-reboot-mode.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/psci.h>
+#include <linux/reboot-mode.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+/*
+ * Predefined modes use two arguments. arg1/magic[0] is always zero and
+ * arg2/magic[1] is one of the values defined by enum psci_standard_resets.
+ */
+static const struct reboot_mode_entry psci_resets[] = {
+	{
+		.name  = "psci-system-reset",
+		.magic = { 0, PSCI_SYSTEM_RESET_COLD_RESET },
+		.count = 2,
+	},
+	{
+		.name  = "psci-system-reset2-arch-warm-reset",
+		.magic = { 0, PSCI_SYSTEM_RESET2_ARCH_WARM_RESET },
+		.count = 2,
+	},
+};
+
+static u64 psci_reboot_mode_get_cookie(const u32 *magic, int count)
+{
+	u64 cookie = 0;
+	int i;
+
+	/*
+	 * For a 3-cell magic, arg2 is the high 32 bits and arg3 is the low 32 bits.
+	 * For a 2-cell magic, arg2 is the low 32 bits.
+	 */
+	for (i = 1; i < count; i++)
+		cookie = (cookie << 32) | magic[i];
+
+	return cookie;
+}
+
+static int psci_reboot_mode_write(struct reboot_mode_driver *reboot,
+				  const u32 *magic, u32 count)
+{
+	if (count < 2 || count > 3)
+		return -EINVAL;
+
+	/* Unexpected value at magic[1]/arg2 on a 32-bit system. */
+	if (!IS_ENABLED(CONFIG_64BIT) && count == 3 && magic[1])
+		return -EINVAL;
+
+	return psci_set_reset_cmd(magic[0],
+				  psci_reboot_mode_get_cookie(magic, count));
+}
+
+static int psci_reboot_mode_probe(struct auxiliary_device *auxdev,
+				  const struct auxiliary_device_id *id)
+{
+	struct reboot_mode_driver *reboot;
+	struct device *dev = &auxdev->dev;
+	size_t count;
+	int ret;
+
+	reboot = devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
+	if (!reboot)
+		return -ENOMEM;
+
+	/* Skip PSCI SYSTEM_RESET2 modes if unsupported. */
+	count = psci_has_system_reset2_support() ? ARRAY_SIZE(psci_resets) : 1;
+
+	ret = reboot_mode_driver_init(reboot, dev, NULL,
+				      psci_reboot_mode_write, psci_resets,
+				      count);
+	if (ret)
+		return ret;
+
+	return devm_reboot_mode_register(dev, reboot);
+}
+
+static const struct auxiliary_device_id psci_reboot_mode_id_table[] = {
+	{ .name = "arm-psci.psci-reboot-mode" },
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, psci_reboot_mode_id_table);
+
+static struct auxiliary_driver psci_reboot_mode_driver = {
+	.probe = psci_reboot_mode_probe,
+	.id_table = psci_reboot_mode_id_table,
+};
+
+static int __init psci_reboot_mode_init(void)
+{
+	return __auxiliary_driver_register(&psci_reboot_mode_driver, THIS_MODULE,
+					   "psci-reboot-mode");
+}
+subsys_initcall(psci_reboot_mode_init);

-- 
2.34.1

