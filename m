Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266013D5252
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674722; cv=none; b=Ey5EtICAT2mna340tBUFIqo768tSn9FuEyILxPLMD+l4wKAqmGnPFWwaxyPkXymUbZ3lk0aSEZQAaBSb0drEcMzNAmcHGOxI1SGFpVSkc3yYR33WMDwgp4O42xNVxgs10qzBWUgA0r5gao9fKXQ4PnygzuGY7CahjSm0fbvOHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674722; c=relaxed/simple;
	bh=gU6785B7B87zl+NgxxlZ51/MxzzF5o4+0DzA+xXkbpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tWAhXI845CsAJplBW6wuqI7tNjtlHcC5xEp6E2KqnGZWJblQh/mPkToC2oVCfR22EEmnThxwJtd2QqWiGCDcgOLf5OC4Peo8n/+mKu1VMuc6pxiqBt0Anu1p+XZhXZTTRNwTQaApPC/ZyZVNkfbPoWrtJWzm7Do1MbksbD6doIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oDnrTVBf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SgXOau7b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oDnrTVBf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SgXOau7b"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7eE7A190651
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gJOuLm68I+QWFveNJ+tREs
	VIKrp5kqtQFQ7zFcT+w6M=; b=oDnrTVBfykflG4T51FOAdd5JpvzCBBmYEblJvc
	/u4AkG0OBWhn1SQbxJf6tTwdUpV+hANaQNtHUZF1wWcq1aNATu8ixlAm/NAKcinj
	oIvjYfDYElHDdGVc4T6qV7D7z51IcYR9bVaD27MWQeTGACzpWMxGGXzj7Y3vXvgu
	fVAtmrfpErZa9PZThzzQkL2PdHtlckgluoJ62VBLMq6Qv3dIoVOHq0Hvb8iKpPWD
	W7Bjh42IOi/D4TbDZZbgCB6/586I8jSIXlEm5f4dT6cfTNv8jcFLkSZaYKHXMV2c
	0Us7kDYNjtSi7Is3SMCEVHvltJ/yw5mz7TAkQt+52s+iDvVQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n1586-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:11:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-380a638fb5bso941290a91.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 02:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783674719; x=1784279519; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gJOuLm68I+QWFveNJ+tREsVIKrp5kqtQFQ7zFcT+w6M=;
        b=SgXOau7brpokiEewsjzW5RiDJRgIWJtpPKjC8gzfp1JDj0YkRglYZSdMgA6CMCzJZR
         Go4/WYAqcsgUeeCOvF7MuDyW/svHMqewDVCmhoIjcuF7Nrpj0p9vWKnoQFxcAmJA8cmH
         jmGzf1miBgqxOAMcydMRI8B7HfcLNA4NLEmRGr0fm/gU7i1/yDldD0LF7qoPHQN2m757
         XTP3wSBMw52Ua2COjXNtI74ksV6XJulYJV8jNtv8XkXRqRxzh/t0u8lENgkYDfwjYE/U
         9hHsJRP2fOzclHcfMBwqiFh51rCu41q2DHnzLdQV4R3tP+JNkpQAsKH9GppunRWrGbVy
         ivQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674719; x=1784279519;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gJOuLm68I+QWFveNJ+tREsVIKrp5kqtQFQ7zFcT+w6M=;
        b=TqOB9a9dXcj/anoDPylTPuJAdfW24LkbD3/CkaKrfuOXCv7oOLLkcyhePmp56Isilf
         MstG5k19OFUUFvcOfOhQs9G5/z/G0HEEjtidwj8erAB8hrWA+Gacc2E40jkVSlIkFZAE
         3gAq+Bc0NfDNVvBSUv9WW38wkZs4VntchfrD3SMXReW6ND+qY+FzcRWufW/H094gEXLs
         fpeWh4lFr56RUgh7TE4sulSLMBlYY3R3LS3Q9he4BdwX/8cZzFzRtUzxEb3nrKKfjdtm
         ZDYHHSiGarPvRzrhnf/LkDkC7jA7PwN7HNH84uy+HLpjWq7VGWpMzqzwsaMHcsZ1aBF9
         1d6w==
X-Gm-Message-State: AOJu0Yzp8GTgAdyk/r+Cc0KvP/GzbNA7xAQEPBSglWHknxDN3JeL5pm3
	3al3M31TmMrU16dvZDmH8VuP6U4dajgXvMvl8hb6TUucPc4bLNcNRJrINN3rURtXtyZ71EHaXOq
	BNlRqAS7hcD72wPc8q1VXxaKA0DDilMwsmPPfeCcOFAekBZYz+ZPqlH63PtwQEQ==
X-Gm-Gg: AfdE7cmZYcI3GF+hu43tYUGU7abhU/GPqoFcJeCsLo/F8zJU8wFaNLPdNrJ6UlZIHbb
	zvjFvqV5tawdg3WMmQRSEojBJDRrAJmjj/KrAe5VKgVPYp1pfi4GXYgBGCL18HNmIRBivwwO5ir
	URqqB7sd6JuMTJBqM6Bs9+0ll0QojOzAtsql4iQrTBHetcxStL1ZpopiaGsflq5sP26VbSy05UP
	0oUMAM4hHrc2a0h1Oxd0Iq+bavi2dcQM24M7sF70opd4znv06c43x9uBwOqEg9+NiJt/FfxuRtM
	pGRjdipJREnIUVrEFA0fFnKndqAuUHkCD1Ib8P6uSODS8UPgROjSr3/wHL3aZh11Z2UhO+3PBFh
	k1Gd/NX1vpesqnzxKC6LPH6sQuXyKhQL6gZY0Yyx0
X-Received: by 2002:a17:90b:1d48:b0:37f:9ce1:735a with SMTP id 98e67ed59e1d1-389415eb13fmr11330508a91.27.1783674718634;
        Fri, 10 Jul 2026 02:11:58 -0700 (PDT)
X-Received: by 2002:a17:90b:1d48:b0:37f:9ce1:735a with SMTP id 98e67ed59e1d1-389415eb13fmr11330479a91.27.1783674718150;
        Fri, 10 Jul 2026 02:11:58 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm37097364eec.18.2026.07.10.02.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:11:57 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 14:41:31 +0530
Subject: [PATCH] thermal: core: warn on non-critical trips at or above
 critical temp
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-critical_trip-v1-1-780d0b40bb96@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEK3UGoC/x3MQQqAIBBA0avIrBNGo4SuEhFmUw1EyRgRSHdPW
 r7F/xkSCVOCTmUQujnxeRSYSkHY/LGS5rkYLNoWnUEdhC8Ofh8v4ajdhKaZrUOqWyhNFFr4+X/
 98L4fGh0JsF8AAAA=
X-Change-ID: 20260710-critical_trip-7b015d270e36
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783674715; l=2692;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=gU6785B7B87zl+NgxxlZ51/MxzzF5o4+0DzA+xXkbpI=;
 b=/EqudalGe5Ottc/o9RVUWDTNEKyHYLtklVnkGtSlLun1ymt/2Fl/T4Dul7xGn5kM1EYLx+2NQ
 rOADNCTPM6BBonDuAlaI3o/N73Zf2QNQMfR720wgZZmkWpqr4MvZ6hV
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4OSBTYWx0ZWRfXwNb19w9Gf6P9
 LM5saa2soTIhD1oZLy0MxQhrmOO1g60mmKdU8LcIe047aRdA6AYl2wipDbj50jbVHQqbMwWtwXW
 pVazq8kontK7F5Hloy34pF+C8oiQQb8=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a50b75f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=4zQjrgj9hB3qBnJOrRkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: IT9mX2u2F3FZS7cwDbg0EEtXT72Wa0pd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4OSBTYWx0ZWRfX2NYKA7kXZEGw
 I2F+r2DiWAljJlyX95xoWrIsXf8WG5VCSDweZ2mLji8NUlyU512KUzDYoGCLJNA0bfr6BT94hs8
 HFCsk1lx0WuUOohklsSRK9NtsaVs5WoN6RDGPNgNYWoupWjAaFzGQS7AwDvIDhk28xdoh48hagd
 vFocrOpykAhWWlrV+6UM1tkC6sSZlImTMC9rj6TWX11Wz6/QsqIYcWcb2NqhplBj2RUFrAGSpHI
 wlpJn0XNa+9E/sN26gbE1UhzvjADRiPkUstp3XjKq8Q1JFwBaUPr6gIoEIrD84ATxsAq4qD+mUL
 tiKmOaP56d5Ibyvwnc/EDEsiRm5gPwoSkjyqP9LJt2zn/BL0OhR/ziIH8blJlftFpMaV6X3D03L
 W81XOZMFOx+JwtsLqTsxVtzoMGIp1nA0PuEFcGjkv6c6c9Y6LkK1HCczpBJTMuFfQLE0MFjzNGI
 j9WZ7aky/gKf1y6JsHw==
X-Proofpoint-GUID: IT9mX2u2F3FZS7cwDbg0EEtXT72Wa0pd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100089

Thermal zones can be registered or updated with non-critical trips at or
above the critical trip temperature. Such trips cannot provide useful
mitigation before critical trip handling runs, and a HOT trip at that
temperature can coincide with shutdown.

Warn at registration time and on trip temperature changes to surface
misconfigured platform data and incorrect dynamic updates early. When
multiple critical trips exist, warn against the lowest one.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 28a20d4b475c..0e37e3787565 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -434,6 +434,38 @@ static void thermal_trip_crossed(struct thermal_zone_device *tz,
 	thermal_governor_trip_crossed(governor, tz, trip, upward);
 }
 
+static void thermal_zone_check_trip_ordering(struct thermal_zone_device *tz)
+{
+	const struct thermal_trip_desc *td;
+	int crit_temp = INT_MAX;
+
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip = &td->trip;
+
+		if (trip->type == THERMAL_TRIP_CRITICAL &&
+		    trip->temperature != THERMAL_TEMP_INVALID &&
+		    trip->temperature < crit_temp)
+			crit_temp = trip->temperature;
+	}
+
+	if (crit_temp == INT_MAX)
+		return;
+
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip = &td->trip;
+
+		if (trip->type == THERMAL_TRIP_CRITICAL ||
+		    trip->temperature == THERMAL_TEMP_INVALID)
+			continue;
+
+		if (trip->temperature >= crit_temp)
+			dev_warn(&tz->device,
+				 "%s trip temperature %d is not below critical trip temperature %d\n",
+				 thermal_trip_type_name(trip->type),
+				 trip->temperature, crit_temp);
+	}
+}
+
 void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
 				struct thermal_trip *trip, int hyst)
 {
@@ -462,6 +494,7 @@ void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
 
 	WRITE_ONCE(trip->temperature, temp);
 	thermal_notify_tz_trip_change(tz, trip);
+	thermal_zone_check_trip_ordering(tz);
 
 	if (old_temp == THERMAL_TEMP_INVALID) {
 		/*
@@ -1509,6 +1542,8 @@ thermal_zone_device_register_with_trips(const char *type,
 	if (result)
 		goto remove_id;
 
+	thermal_zone_check_trip_ordering(tz);
+
 	thermal_zone_device_init(tz);
 
 	result = thermal_zone_init_governor(tz);

---
base-commit: 4f441960e691d37c880d2cc004de06bb5b6bd5e4
change-id: 20260710-critical_trip-7b015d270e36

Best regards,
-- 
Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

