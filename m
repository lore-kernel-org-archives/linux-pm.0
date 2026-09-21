Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45E481647;
	Mon, 21 Sep 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009874; cv=none; b=hR6HffKgQLH8osn4HBIoRI+k8fpXbhkMMfRwRozDrJDbzFuY7LPPSFp3jUDujmxqWX6rBW9msnd4kVtJiF5FqxdUagnK0Gw6CIJTcw8Gxsm6n+X0VokfriXdXf6QNOiP1nGnnBhgUdnl+UmcoO8V6gCr7dFsGnl2S1p6/k5TvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009874; c=relaxed/simple;
	bh=X8qD955WHpybwj+yRCtCau0eQllUlA6eMCOWbXmSqzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlhgHeOyusl0wQ2+C3Fir/nPCLdeJ+9Q7OIHIZnBOmLy8mpblRke60UikRpz9cuD/WI2Hi3ZrwFXLXAj0ubh2pzTKNT13mCLeJNItpdYmOy7AdO7EJbn6NVV353G7mf97RdleaLO79HjocyKvI2oQ6H14e9ZNr/qj2B/dSC1gr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SvxAKZH4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SvxAKZH4"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFAq7G1438653;
	Mon, 21 Sep 2026 16:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AdqM27vKJxtZ8aMPD1Fh0zcIEMbIa/m6XRbPgdIQBT8=; b=SvxAKZH4VwTqEkgt
	PTV1/jaQJ5qYckhFY1pyAjCpcDdUoV5bCyY2haYGI5cyGziaiMfRuEXdxsUU/ECy
	NryNxZKeCIuRDfml1ahlEobEFb38SfXzeuMZ1/+0NrOFg9kIhwn/tUcitOi7yi38
	jldQOw+7EcdGT+3LtyXLsvZInBgLyhd3rKj0AyFho4tPH399juIp9mbDSyqf+hEs
	iDZMe0XbYGk0JX2Gj1fvF50IorUF73vRF+VXnndUmQP3l7ERBqJPiQeDB6n1308q
	Y5ICAgMjvxi3U6hwIuSKtMHN3jx2NWjf4vJYqyM1OVd3Q87lRwhfUj+jZX6lXPMo
	AW4BsQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5jyrn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 16:57:28 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LGvPjF1464547;
	Mon, 21 Sep 2026 16:57:25 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 68LGvMaE1464229;
	Mon, 21 Sep 2026 16:57:25 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 22:27:14 +0530
Subject: [PATCH v13 6/6] Documentation: Add sysfs documentation for PSCRR
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <pscrr-v13-6-dfc57fceede5@oss.qualcomm.com>
References: <pscrr-v13-0-dfc57fceede5@oss.qualcomm.com>
In-Reply-To: <pscrr-v13-0-dfc57fceede5@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab161f8 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=eG3WmpGALsbKIvMRAg8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4J01QMKyxk9nl6W3OXR308W9EhIsWBtQ
X-Proofpoint-ORIG-GUID: 4J01QMKyxk9nl6W3OXR308W9EhIsWBtQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI0NyBTYWx0ZWRfX7BVqwjD0A7WX
 NYHCOH7K+UFaOT9ITBV1GoAXynhmymGandC17FKMmM0YM5TWF8uXllpmbXqDo9yjRgMDLS8wZQx
 LGv/Ywi71/IaTeXSHO+ZiPJ2S1vi1WM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI0NyBTYWx0ZWRfX8VXjAVHsYYKU
 3RQszFH2BjFTVsxFLgeEr6WysLtP5PJQjS0MreyLhzpoFEoDt34cvoVnIJiyL4aTnObj65YhcIP
 p9Ti2iVZZphejRCNpfmlHxQQjd2BVL3hVKftRTPD8D/Oqtm2cHQkqN2pq2mDCv1J6rXm0VNxe2n
 MN87YNfvsxLzXL+cxqUo2uhpEmtzLzlX9vVEOVP6EFSBpX+64bxZkwqO+PIbfT+31LIFQRPa+bC
 Xty2vbTKEvqWWB97O2BrsBVWZXrhmDhoo0R9akqDS9ArImZ0BSfPg+zJlITqVYOxJu4ldfjOhx0
 v78E8yBSx3j1xy9LC5lLBBnd2x0YTU9IYUomicNphlu2DqydKGQNKW9XbbL6MJ1rT62Srh0RzFj
 7AfQGJVyrH2yZ+xQ2zMKFX1n4iztreyjB3LxbjQW4r+oIZMQevLqQ7MJiTZZ9wZuijim/PpDZcI
 jvAWPO1A5ZD+7WJyysg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210247

Document the Power State Change Reasons Recording (PSCRR) sysfs interface
under /sys/kernel/pscrr/: the per-provider directories and their name,
device, reason, caps, supported_reasons and record_policy attributes,
including the stable reason token values.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

changes v12:
- rewrite for the per-provider interface (providerN/ directories with
  caps, supported_reasons and record_policy)
- rename the file to sysfs-kernel-pscrr to match the sysfs path
- refresh KernelVersion/Date
- drop Reviewed-by: Matti Vaittinen; the documentation was rewritten
changes v8:
- simplify and clarify example sysfs value comments
- add note that not all values are meaningful on every system
changes v7:
- document expected values
---
 Documentation/ABI/testing/sysfs-kernel-pscrr | 108 +++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-pscrr b/Documentation/ABI/testing/sysfs-kernel-pscrr
new file mode 100644
index 000000000000..63aa411b7362
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-pscrr
@@ -0,0 +1,108 @@
+What:		/sys/kernel/pscrr/
+Date:		July 2026
+KernelVersion:	7.2
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		Root directory of the Power State Change Reason Recording
+		(PSCRR) framework. It contains one subdirectory per registered
+		reason provider, named providerN (N is an arbitrary, stable
+		index assigned at registration).
+
+		A provider is either a hardware reason source (a PMIC, SoC
+		reset controller or watchdog exposing a reset cause) or a
+		recorder that persists the current reason across a power cycle
+		(e.g. an NVMEM or RTC scratch cell). The set of reasons is
+		deliberately not collapsed to a single "winning" cause, since
+		resets are often multi-causal.
+
+What:		/sys/kernel/pscrr/providerN/name
+Date:		July 2026
+KernelVersion:	7.2
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		(RO) Human-readable label identifying the provider, e.g.
+		"pca9450" or "nvmem".
+
+What:		/sys/kernel/pscrr/providerN/device
+Date:		July 2026
+KernelVersion:	7.2
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		Symbolic link to the backing struct device of the provider.
+		Present only for providers that are bound to a device.
+
+What:		/sys/kernel/pscrr/providerN/reason
+Date:		July 2026
+KernelVersion:	7.2
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		The set of power state change reasons observed by this
+		provider, as a space-separated list of reason tokens (an
+		empty line means no reason is recorded).
+
+		The attribute is writable only for providers that can record
+		a reason; for a pure hardware source it is read-only. A write
+		records one reason and accepts either a reason token or its
+		decimal index. The tokens and their stable numeric values are:
+
+		==  =================  ============================================
+		0   unknown            Unknown or unspecified reason
+		1   under-voltage      Supply voltage dropped below a safe level
+		2   over-current       Excessive current draw / possible short
+		3   regulator-failure  Voltage regulator failure
+		4   over-temperature   Unsafe temperature detected
+		5   ec-panic           Embedded controller (EC) panic
+		6   power-on           Regular cold power-on
+		7   watchdog           Watchdog timeout
+		8   software           Software-initiated reset or reboot
+		9   external           External reset input asserted
+		10  rtc                RTC-triggered wake-up or power-on
+		11  reset-button       User reset button
+		12  cpu-clock-failure  CPU clock failure
+		13  crystal-failure    Crystal oscillator failure
+		==  =================  ============================================
+
+		The numeric order is stable ABI: new reasons are only ever
+		appended. A provider may support only a subset of these; see
+		"supported_reasons".
+
+What:		/sys/kernel/pscrr/providerN/caps
+Date:		July 2026
+KernelVersion:	7.2
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		(RO) Space-separated list of the provider's non-default
+		capabilities. Being readable and storing a single reason are
+		the defaults and are not listed. Currently defined:
+
+		========  ==============================================
+		writable  the provider can record a reason (see "reason"
+		          and "record_policy")
+		========  ==============================================
+
+		An empty line therefore denotes a read-only, single-slot
+		provider.
+
+What:		/sys/kernel/pscrr/providerN/supported_reasons
+Date:		July 2026
+KernelVersion:	7.2
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		(RO) Space-separated list of the reason tokens (see "reason")
+		this provider is able to report or record. A provider that
+		supports every reason lists them all.
+
+What:		/sys/kernel/pscrr/providerN/record_policy
+Date:		July 2026
+KernelVersion:	7.2
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		(RW) Policy used when more than one reason is recorded during a
+		single power cycle. Present only for providers that can record
+		(see "caps"). Valid values are:
+
+		=====  =================================================
+		first  keep the first reason recorded this cycle (the
+		       root cause); this is the default
+		last   overwrite with the most recently recorded reason
+		=====  =================================================

-- 
2.34.1

