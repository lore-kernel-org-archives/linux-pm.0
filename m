Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADCA35F192
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263522; cv=none; b=HONcMlsvTTnYxCrAlwIKd5MK8bqGoORtr0q/D+colkN1kXi/21l3jye0MO0ym1mfkHrVaxj1FkQ7FgGwiOWGKnknfRV/rS+rguU+swF0K6MXBQ3VIVxmzWMQHFL1QtOuZvXVA+37c0RRQO8R+2c1dbIk3KWJzv+XLLviW2oNpYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263522; c=relaxed/simple;
	bh=zrGzrYkPdY7YMJuo7N4SHYemZtOQAa2dtQkSWaMsWQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaGVyco++bij8FgNhbkYLb4MvI7RGOKqXkLUjBVHg7eBzLWohfJYib53e3Vla/q1Ir1SV02llHr4nDDmhbDySTxJPQ1M+zhUiurX6sRYDkyZBkGn651xsk+MqeRp3sXX70yjuflcSHLYE6mo56WQlJhzGu85SCdfWuyTnIdX9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TSwM5HUP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i1j1HsgQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TSwM5HUP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i1j1HsgQ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648G52lA1116771
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 18:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1hHCHNh9vUV
	dYOKHBom2l0BFmQ2i374kNIpIcv8mpZU=; b=TSwM5HUPDYMwjBpyM7wXFsUvSoI
	0biTfbnRW11KIJfWYRXVvpHyzso9MhJxEo3DE0zC0PGsM6NgiA99XnTUT52S3MRg
	ugdLDjgh5Zdc7TDMU/0Pdmd7aGRy+of/wfx/ZmoJ9s+9R+h6rnafQPbLa1loW689
	GuJ39xfVxDfLBW99TN5BsCcjguMJEUeC2fBvKpV4SlNU08wx1l3p5qm9jHQdwjWw
	iaaIKzLuj8fmIRVT1ProrxZJu+dLVolqYuIPwavlEvkAa/5s2ZcUoqC8jSVR5bUD
	e/YvRkNHjlakoevUUMqH67XWzjV1jFE71o9vFot5i7pxMmC2kpTOPldXyPw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k1pgdj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 18:05:19 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6314a4009f2so231329137.0
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778263519; x=1778868319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hHCHNh9vUVdYOKHBom2l0BFmQ2i374kNIpIcv8mpZU=;
        b=i1j1HsgQOpaoIN4SyP88h5ohjaF3nbleq/6niipLHM+Fqb86oih9o8lxBf9rsN7HUr
         yiVhHCbXTVAfbk5QLOhN/HIJkeRwqrTUcauNU4ZrrpqRsirVxbTqGef291hCY6sHzVEm
         SMT4DGFwDA8BaZ0n7YnX1e0FF7XwqgyiDnPoJ9rQW3wZA8+b8bPjgAGtdidTd/xcTXKL
         B19QfzL2wRDgM369IiK7jNznhTIJZdRvDq1VK/IIjNakw6NUhpEqDzoTDTJAz+crboqR
         cY3pWrtLDHDyg6pDPbnTNZSGUjzggxWgXmwtVqeaDMtb12KGwm0VSVMUvaLi5BqP/5OZ
         eBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778263519; x=1778868319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1hHCHNh9vUVdYOKHBom2l0BFmQ2i374kNIpIcv8mpZU=;
        b=CzO2N7CSci7LQidNSm3jFj3QqEg/oGMU3MNV4RhPAX55fkuamjDWs2oqjqO45iCTlQ
         iiL659sW9leVRhw3MRHG8HU8d6TUaAiZTY4aH2mYkzRaDbDalnSTAX4aif4UJT+GlHpv
         IO+uhvnOtx+qqwnoW0RTc8SctjM4OsLFRMDl8eT3mWCzll73R+jKtACQKDn+XLpdmnwU
         aWnO0cZ5XLevsxl19qDwl+1T05PLW022Hovsk+TlC7Kt0spz0n8jdJZz7gA6v+TQBDu9
         CtC4PYbIOSty9Gst1S0VwkwrVt6Gq6FMr6spJPF70S4opvb8z7wCC1l6RW5Gr1EyrNP6
         jGfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EugqMb7d6Mqgv2ioybq1yCVJQ/w1G2/1SCChtTrnQ7ioFs1fQkfhh0z76fDt8e4nOO9lSZzpBAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOyjfJM0ahNqhEymzuF9ZsTgF9Bhye7UrkLYkiW6BhsuazCuuT
	FteJKpdbMICd6sKUeGPb/dxkYfMKXJUFrLeSOp8fnL0Y2S264EmfM7ISIHmT79207XcejNiPeqI
	80MrY81TuGE0edxdQ0P+a0qjeWbWWIZJFR4IU3BJS7eOkTuVDOpIIZZABdm49zA==
X-Gm-Gg: Acq92OGOJ5wMKu6CV48vmgUhAoCOAHpj24cMiNLm2HWhsyLm9ssWMv7y4ZRr2WUTlN+
	6QxXCBn6H+i99XJUMgYL/gJT2LLDyzL3zVwNT2E/37Ir8aSqQ1EcDE3/fiYvAWyXRVId8aCW5hJ
	1Y8L3TDX9KuapLq/5bWaqu5+lvU1lEba+GaLE1xF8mmwNv9zqkRF2vMUdPTi/MJBE2gpJ2wWKbI
	cnqefNNN2ibyHMHkgoS5hdsSeHKCMrupfruqKfRtCeMAVUjWI3jsuONoiwXVFFP0a6LrAu4xOox
	ui9DOxko8S3eNSZG3M7EuAFzlM9aZz66v2B6bpdBAJIvv/BVJ1oJ1EthXDGr6j84T4Ou9PeLtH2
	aV5TOCjHw475R5/II2DUz/C0zvUtVRG9VRSy1rmS80wC9EzZXQw==
X-Received: by 2002:a05:6102:5813:b0:62f:357a:329a with SMTP id ada2fe7eead31-630f8c3229bmr7109950137.0.1778263518593;
        Fri, 08 May 2026 11:05:18 -0700 (PDT)
X-Received: by 2002:a05:6102:5813:b0:62f:357a:329a with SMTP id ada2fe7eead31-630f8c3229bmr7109898137.0.1778263518134;
        Fri, 08 May 2026 11:05:18 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:cda6:5a1c:b564:d3ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd32afasm11654825e9.5.2026.05.08.11.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:05:17 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, lukasz.luba@arm.com, rafael@kernel.org
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] thermal/core: Add dedicated release callback for thermal zones
Date: Fri,  8 May 2026 20:05:09 +0200
Message-ID: <20260508180511.1306659-3-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: k12WufN-a7oXqiVuOuKXPae75kF0UPHE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE4MCBTYWx0ZWRfX/cDU+OX3xu1v
 OCdPVSHNFZOTNXpqAwGbL9vxEaXVZ3FDsnJWq6tiQ1+p/Ah4HDdtR3wOBYZs6vTbjMlYeAwH++6
 AxyUmOCw5A5Cw1duSCGimecLVNriWI+4W4J2HMLeOeI5O3dD+sQ5f+eIOn8d1ltyeEiokJwRHqg
 KbH3AQse+MJxG4lGNux0CGFZsoHoegiTiw8VM3xim6HPMmvA8RpU0fJ843E6f9kNjbH/9ruezyv
 VWw9ofqSm9292T28grAwWsq+QaMm4BP1iDJSw0wNMkE68yZnVXu8Rx46HWC1Gsw3Ni1Ag2iqwXb
 ztTPLi6zAIZdu2PwfPnYnegmWR+1heCxTYu/4C+x9OYOyPuW7kTp2K+XNIFsQXboTpbGTYfh02E
 8Scfiu4QLkftu6QIj53g1jUVk/McnDhWyAAgYOSH7CJHvC1CwGKoMgNEHWaWYT06X4zgoBn4vG6
 8Yt9peBdWikcQVAxtyg==
X-Authority-Analysis: v=2.4 cv=COwamxrD c=1 sm=1 tr=0 ts=69fe25e0 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=fxX41ZqujnG29gMSCLkA:9
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: k12WufN-a7oXqiVuOuKXPae75kF0UPHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080180

The thermal class release callback currently handles thermal zone
cleanup by checking the device name prefix.

Move the thermal zone cleanup to a dedicated struct device release
callback.  This avoids relying on device names to select the release
path and keeps the thermal zone lifetime handling local to the thermal
zone object.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cf5d4a9c11fe..a79fc4cdb078 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -949,24 +949,8 @@ static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
 	kfree(pos);
 }
 
-static void thermal_release(struct device *dev)
-{
-	struct thermal_zone_device *tz;
-
-	if (!strncmp(dev_name(dev), "thermal_zone",
-		     sizeof("thermal_zone") - 1)) {
-		tz = to_thermal_zone(dev);
-		thermal_zone_destroy_device_groups(tz);
-		thermal_set_governor(tz, NULL);
-		ida_destroy(&tz->ida);
-		mutex_destroy(&tz->lock);
-		complete(&tz->removal);
-	}
-}
-
 static const struct class thermal_class = {
 	.name = "thermal",
-	.dev_release = thermal_release,
 };
 static bool thermal_class_unavailable __ro_after_init = true;
 
@@ -1473,6 +1457,17 @@ static void thermal_zone_init_complete(struct thermal_zone_device *tz)
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 }
 
+static void thermal_zone_device_release(struct device *dev)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+
+	thermal_zone_destroy_device_groups(tz);
+	thermal_set_governor(tz, NULL);
+	ida_destroy(&tz->ida);
+	mutex_destroy(&tz->lock);
+	complete(&tz->removal);
+}
+
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
@@ -1580,6 +1575,7 @@ thermal_zone_device_register_with_trips(const char *type,
 		tz->ops.critical = thermal_zone_device_critical;
 
 	tz->device.class = &thermal_class;
+	tz->device.release = thermal_zone_device_release;
 	tz->devdata = devdata;
 	tz->num_trips = num_trips;
 	for_each_trip_desc(tz, td) {
-- 
2.43.0

