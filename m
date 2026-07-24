Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88537F31E
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877561; cv=none; b=ed5tL/Fl9RVEIprlerjriaS12gjBEc2Phh6GU/CaG8FUGaH1h4vKe+8xAIQcZioFZeLVe0FPgIkBGd+MmVK2AXxZpJLUXtnREf9x3VBYFMR8klNtRbWVE9NuvHgvZF8I4d8hy4guuqfs9VPmpVNsCyHxfzbwAn2N5b168ZqRKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877561; c=relaxed/simple;
	bh=KCWI3HNx7SBSYRM9H+O74KRL98G1L4v3MvETRdT4fww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crDgkbGka/LvFkW/nh2cpp5XEZt9hLMFmAABlAH9A/IaQUPEpysC9kcbflekyXfkpFV0R4d/OgaCaWGbouneEPATM6V+iAO+FJ4FktATrDwxFVmnfjIpX2y6NwHY8E8N1eCmxvlgznmccu02a3XKgmuxg9DHDQyu3Phc6bKCRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=enChIPtp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d65VfQHv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="enChIPtp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d65VfQHv"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5xSUf1892442
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o+cn3qFiodANuon2nIvIKSnIrm4LrxKQ/PH84MmjCzM=; b=enChIPtp/j5fth2d
	abWNbz0T7ekPNvwODwOVFrhDaNFaD41JtFgod2KyVyo7b6hlyO3z1NZNTNHZHKlS
	OgirzJ+3DgAHA9zlJIW/hYERuJ13aX3d6oB/k8DrvTEoPCn6ehsEvnagnkuDT9l2
	ODtxAIumC12a1U3C7K3b2J9+Lb7x8Y7x7nxus5cAURI3cHdn/RjosXBy1lIUfoIR
	2cAZOmZPFqedKdUDVDXAJYxDmsgOT38XwOl07i1ULtXjUMm7YLR5PuFY4EqK2G0z
	VE+r3D/1GdCrj2sTReZ42dCsfv6J7p3vWo6cL2M2DNoQwcwCflu1SVtDW42VqynH
	OvilAg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm2cx89vs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfc52ddc55so2401065ad.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784877558; x=1785482358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o+cn3qFiodANuon2nIvIKSnIrm4LrxKQ/PH84MmjCzM=;
        b=d65VfQHv9JauQqvMr+k0jANt/8ZhgQmUpICAGvxZpxjxV9GpEe56EFRCIwai+05dlW
         4CMKSzHb16XFaAp3b+6aleSorMIeCGhS9sktzQzwocUbvxFSeGONGIqdxYbjpM0EIU6G
         dDsYGVgiUzzbM5hfCkCUWpip6VcXdGylzeZIk+sthLLCFV1Vgyy21n4ITcPEB0X+cVSq
         Xd5+/X5kZC8+K1Tx4kic6z656YMLh6N5gGQeivQHhARs6RFDQnO25eTJSAGl6cBC2aUq
         rHq30kpBuriCDgL8TUzvV6asyio8UARO7d9MAxouJmAQ4nqqjf0NofVF6RQL1P27XEU5
         5ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877558; x=1785482358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+cn3qFiodANuon2nIvIKSnIrm4LrxKQ/PH84MmjCzM=;
        b=BMzmy7s7HPiy7btAx65UxXxWbeHEtyrZI7X0oi1Ln4sVkWHoW5BWsmXh9XIPZctW6N
         2ICnI5zh9hJShjUItYPZgCU1fJmmNgHSyNGy7AMlCYGyn3Cpp4WmKxIfGjEzAMJbi/N8
         pYCon6qUJ30ZSpJKObTyYhs5v0c+nQReySHgw4nYKzZTKX8uhL6R1lU4UZpftsKR+5HW
         puDOiSxdwpWFPQ53ThVO5qEtiNlyewGyLMco3CHxCJ4KUkRhngtaNClt5XmI6nLFORyO
         D9hu+qysTGzkck9TeKxr9oYUmYkE5nOEbnDKWqMAq3Qz8J2tsjU674Bgm1CwP0YCKG6A
         ppxA==
X-Forwarded-Encrypted: i=1; AHgh+RrajZWyrLsJfxtvW+Gz4pCcbActef3X8G4ZxMGqs4jHFlPRpAPia/JVDwDnWjgXBxAE5xi+tuYxig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWasXZXcJbFslTMN1mFwlr2okn0g7VUFZMmIpk+rJHpjANBp0T
	NbOfHvxxmTKIpKoNw+XFPmnDTdeERR9oSzI7A0bmjrPVn2J07EXmKLHtnnzoSjZvJMUUIIRzWVG
	4Z8qE74xIMEDmdAu4MCaqfTndvdzoYnpXQx5ZE8Nh38kn2+fm4+yzVyhXxWnW1Q==
X-Gm-Gg: AR+sD12gXkNE9vdtLtxGDoVpSqHcm0qfTnv9ep0ivUA6J6PpQYmheZlqKxVhtEeYW/z
	/u+vukxy8jbJwXDjwHE8xSYwGUO1EbdsrClR9oSGzCQzSqwH3M3VIkdBXyCJbMkyCvYm9ZNRu1s
	ohhh7VWG/5tcm92LPxS3p3jxquJDYlaH+pT9BRtBASinbvZS8u/V7kencLnUTeww+5cmOR5H7O1
	nbwELvx3AURlHqL1fAPGeFx3vLxAorlL4XX8dxYQXzNqg3hPZ9E96MBlOadL/PYxSrRrFVd9aUK
	oU/YnvtoEVUaRYtzeDqTlCNGdCqk8AZ6EC5hFyvyA0ktZHnXEdN8CdZm4CW4WJWWRJpHERyUe7o
	oxF7qiUiC6LWmM8LgxdUYGziRGuX9hi+hxyVBO1yL/8aIeTXmwNA+2yrAGYQ5wRbtZ1ZIQBIEis
	UDQFcY9ktpz6eeIqhQ+bM5s0Oz5Ik=
X-Received: by 2002:a17:902:e801:b0:2c9:8f4a:90b with SMTP id d9443c01a7336-2cfa6a54e47mr73353945ad.3.1784877553149;
        Fri, 24 Jul 2026 00:19:13 -0700 (PDT)
X-Received: by 2002:a17:902:e801:b0:2c9:8f4a:90b with SMTP id d9443c01a7336-2cfa6a54e47mr73352855ad.3.1784877550917;
        Fri, 24 Jul 2026 00:19:10 -0700 (PDT)
Received: from hu-ppapaniy-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efe3afbsm45993805ad.33.2026.07.24.00.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:19:10 -0700 (PDT)
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 12:48:09 +0530
Subject: [PATCH RFC 04/10] PM / devfreq: Add new target_freq attribute flag
 for governors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-rfc_v8_scmi_memlat-v1-4-cb732bcff1f4@oss.qualcomm.com>
References: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
In-Reply-To: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784877514; l=7716;
 i=pragnesh.papaniya@oss.qualcomm.com; s=20260120; h=from:subject:message-id;
 bh=9zK8epQvNbuVk1OIit8CUMNNYQlt7Ism/my5pJtwFUk=;
 b=nOAw4COlo3kTot+tWkInoVAG4WMWOoJMrZMVGgHNvYlBa1wuSNNnr7Bt15tb0fp2L8/rUxg/o
 dcNHgIULXzuAkC6FA9umZi+IFucLk0uDWz6TFs4cvfmPfaNyoi36lFN
X-Developer-Key: i=pragnesh.papaniya@oss.qualcomm.com; a=ed25519;
 pk=09P9nFmZLXJ9+4Jx10ZK5rIW0Fmk79A/DLErm6aVA0c=
X-Proofpoint-ORIG-GUID: Lf6h2VNkZqrjAPB8kgYtX6eJq_hbOaiH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfX8DezXjKYKDta
 AXNHM3f5RP6rAxrIX7JXEm7zFdpD/s42KXpCvnE+Gi/p+gChky5BxTWQrFWgORMvjCg3dHlXB2j
 i7qogObePrGRkMK6zxRqMAotVekm2MtChT6s9BZTAhz6pJmeFeaKccq9crY+rcNRwdraomwPewS
 5RZyPmLxuQGALG9JjhA3SQhGH6nw8b/EgU43g+nKM9sfjs8oIvAXSHF0tQbbohDz0qsmBGmqmEE
 VBLT/BWcAUG+8fNjeRcayuz5nuWokRXZ7c2GZdxuvqajPVLqHzuMn/vNwiMGXWYZ79F8Kdgbhb3
 tvGc3hDxk4R3+N4z7f3yrBsIzMacRE8HFyM0jcKUAw4C/fiuNtmwuCxdyyhvRKrD6iSFPvHm8JF
 iD7KLpadt5RGW9H16a2XOHCqW+zyN5ah/j8DAU8N7+4UHOJTAufuXvH+YjHrTvGqqLFe/1t77h0
 WPnJLuVr3DgXOpVRWZQ==
X-Authority-Analysis: v=2.4 cv=X51i7mTe c=1 sm=1 tr=0 ts=6a6311f6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=hD80L64hAAAA:8 a=WcTcrbn6WVXM4q_icv8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Lf6h2VNkZqrjAPB8kgYtX6eJq_hbOaiH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfXyzhpEcD0zE4m
 t1FETv8SPWRkRQLmo/hNZPie6MeqhNIQs5/p+U/QltKPwsyOQOK3qcaX+gx6xCZKuchF8nWML6c
 E5rvTyzAk5wWVEyvCgODRZjDIz/U/qM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240065

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

The target_freq sysfs attribute exposes a governor's predicted next
target frequency. Not every devfreq governor has a meaningful value
to report there; some merely observe an externally-driven device.

Add a DEVFREQ_GOV_ATTR_TARGET_FREQ attribute flag that governors with
a meaningful target frequency must opt in to. Gate the existing
target_freq sysfs read on the flag and return -EINVAL when the active
governor does not advertise it.

Tag all in-tree governors so visible behaviour stays unchanged for
in-tree users. Out-of-tree governors that drive frequency updates
and want to keep target_freq readable need to set the new flag.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Co-developed-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
---
 Documentation/ABI/testing/sysfs-class-devfreq | 8 ++++++++
 drivers/devfreq/devfreq.c                     | 6 ++++++
 drivers/devfreq/governor_passive.c            | 1 +
 drivers/devfreq/governor_performance.c        | 1 +
 drivers/devfreq/governor_powersave.c          | 1 +
 drivers/devfreq/governor_simpleondemand.c     | 1 +
 drivers/devfreq/governor_userspace.c          | 1 +
 drivers/devfreq/hisi_uncore_freq.c            | 1 +
 drivers/devfreq/tegra30-devfreq.c             | 3 ++-
 include/linux/devfreq-governor.h              | 3 +++
 10 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index df8ba88b9f6a..5be9940a5853 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -37,6 +37,14 @@ Description:
 		The /sys/class/devfreq/.../target_freq shows the next governor
 		predicted target frequency of the corresponding devfreq object.
 
+		Reading this attribute returns -EINVAL when the active
+		governor does not advertise DEVFREQ_GOV_ATTR_TARGET_FREQ.
+		All in-tree governors that drive frequency transitions tag
+		this attribute, so existing in-tree behaviour is unchanged.
+		Out-of-tree governors that previously relied on the
+		unconditional read of df->previous_freq must opt in by
+		setting DEVFREQ_GOV_ATTR_TARGET_FREQ in their attrs field.
+
 What:		/sys/class/devfreq/.../trans_stat
 Date:		October 2012
 Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index f08fc6966eae..2f27a239e34a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1530,6 +1530,12 @@ static ssize_t target_freq_show(struct device *dev,
 {
 	struct devfreq *df = to_devfreq(dev);
 
+	guard(mutex)(&devfreq_list_lock);
+
+	if (!df->profile || !df->governor ||
+	    !IS_SUPPORTED_ATTR(df->governor->attrs, TARGET_FREQ))
+		return -EINVAL;
+
 	return sprintf(buf, "%lu\n", df->previous_freq);
 }
 static DEVICE_ATTR_RO(target_freq);
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index d7feecd900f1..b75e4bbee4b1 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -448,6 +448,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_passive = {
 	.name = DEVFREQ_GOV_PASSIVE,
+	.attrs = DEVFREQ_GOV_ATTR_TARGET_FREQ,
 	.flags = DEVFREQ_GOV_FLAG_IMMUTABLE,
 	.get_target_freq = devfreq_passive_get_target_freq,
 	.event_handler = devfreq_passive_event_handler,
diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
index fdb22bf512cf..b9ec587f582c 100644
--- a/drivers/devfreq/governor_performance.c
+++ b/drivers/devfreq/governor_performance.c
@@ -37,6 +37,7 @@ static int devfreq_performance_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_performance = {
 	.name = DEVFREQ_GOV_PERFORMANCE,
+	.attrs = DEVFREQ_GOV_ATTR_TARGET_FREQ,
 	.get_target_freq = devfreq_performance_func,
 	.event_handler = devfreq_performance_handler,
 };
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
index ee2d6ec8a512..69eab1d0a7fc 100644
--- a/drivers/devfreq/governor_powersave.c
+++ b/drivers/devfreq/governor_powersave.c
@@ -37,6 +37,7 @@ static int devfreq_powersave_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_powersave = {
 	.name = DEVFREQ_GOV_POWERSAVE,
+	.attrs = DEVFREQ_GOV_ATTR_TARGET_FREQ,
 	.get_target_freq = devfreq_powersave_func,
 	.event_handler = devfreq_powersave_handler,
 };
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index ac9c5e9e51a4..65ff9d912ef9 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -118,6 +118,7 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 static struct devfreq_governor devfreq_simple_ondemand = {
 	.name = DEVFREQ_GOV_SIMPLE_ONDEMAND,
 	.attrs = DEVFREQ_GOV_ATTR_POLLING_INTERVAL
+		| DEVFREQ_GOV_ATTR_TARGET_FREQ
 		| DEVFREQ_GOV_ATTR_TIMER,
 	.get_target_freq = devfreq_simple_ondemand_func,
 	.event_handler = devfreq_simple_ondemand_handler,
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 3906ebedbae8..d1b765a7b8e5 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -135,6 +135,7 @@ static int devfreq_userspace_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_userspace = {
 	.name = DEVFREQ_GOV_USERSPACE,
+	.attrs = DEVFREQ_GOV_ATTR_TARGET_FREQ,
 	.get_target_freq = devfreq_userspace_func,
 	.event_handler = devfreq_userspace_handler,
 };
diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
index e1f64b723082..5a2d7e011ad1 100644
--- a/drivers/devfreq/hisi_uncore_freq.c
+++ b/drivers/devfreq/hisi_uncore_freq.c
@@ -398,6 +398,7 @@ static struct devfreq_governor hisi_platform_governor = {
 	 * Set interrupt_driven to skip the devfreq monitor mechanism, though
 	 * this governor is not interrupt-driven.
 	 */
+	.attrs = DEVFREQ_GOV_ATTR_TARGET_FREQ,
 	.flags = DEVFREQ_GOV_FLAG_IRQ_DRIVEN,
 	.get_target_freq = hisi_platform_gov_func,
 	.event_handler = hisi_platform_gov_handler,
diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 401aac6a9f07..fcb278c4a74c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -776,7 +776,8 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor tegra_devfreq_governor = {
 	.name = "tegra_actmon",
-	.attrs = DEVFREQ_GOV_ATTR_POLLING_INTERVAL,
+	.attrs = DEVFREQ_GOV_ATTR_POLLING_INTERVAL
+		| DEVFREQ_GOV_ATTR_TARGET_FREQ,
 	.flags = DEVFREQ_GOV_FLAG_IMMUTABLE
 		| DEVFREQ_GOV_FLAG_IRQ_DRIVEN,
 	.get_target_freq = tegra_governor_get_target,
diff --git a/include/linux/devfreq-governor.h b/include/linux/devfreq-governor.h
index dfdd0160a29f..2853f571dfdf 100644
--- a/include/linux/devfreq-governor.h
+++ b/include/linux/devfreq-governor.h
@@ -43,9 +43,12 @@
  *   : Indicate polling_interval sysfs attribute
  * - DEVFREQ_GOV_ATTR_TIMER
  *   : Indicate timer sysfs attribute
+ * - DEVFREQ_GOV_ATTR_TARGET_FREQ
+ *   : Indicate the target freq sysfs attribute
  */
 #define DEVFREQ_GOV_ATTR_POLLING_INTERVAL		BIT(0)
 #define DEVFREQ_GOV_ATTR_TIMER				BIT(1)
+#define DEVFREQ_GOV_ATTR_TARGET_FREQ			BIT(2)
 
 /**
  * struct devfreq_governor - Devfreq policy governor

-- 
2.34.1

