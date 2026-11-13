Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794545713;
	b=Z87TnWGmkevB3NVcNsj8RAIkq4cVIiUC1KgKDjVwP0sRIeb4wY1Sdus84yFRY4kT7pwI
	 NKa07L5ZXj7MhDdqivT9LZ4101N3xGdMa1FkP6mCbbWmPSbWSDaUo6/lfnHvLnT0xuE2G
	 tkVrRH8pHXrZryZ/vlZTo7ZmWm6LucYEz0maJC1qQ1lWumw66DbXtc0kiJThqih2F9/xr
	 k55Ky8SqoE5wiyrP3Hcow+fXrk8Tbf0Qfn0le8kVQVUMCjJxGHUdV3gznBMIuBQS0t0i2
	 atWFc0rLsQ/r7bBwIhBL2Wm54jR/biLVMTBn8yZGFfsuihoE6CRL7Mrmk4rFrgmIiRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794545713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VTWR5mkpuIgueh87MON9g3ptDUiISJcOv6zs0rvvEGI=;
	b=H8NwXWHhOGC1mK3terfKNDR1CdIFqce79wcx1vRxGMSN5rLrtZkFtllslB8vOvu9yqKV
	 whKgMg052bAfZF+fefulgGvfNlboxlUyLFRiOgSnbYlaFZSUufWChGFQjuNR3vBGkNaja
	 CIQi5Qj6clN2DOo4V/LRFb89x0v+kp1x6eC7bDgtl0F7NiS+eXAlwpk6hITSgJx0GOybl
	 zAudgH2U02NEqP5rsZLBDm4d4mMeUuVA09bJqXRpjje3f30uP6f0qEcsY6hd2EB6vCFyA
	 huViMml5BPKuhr1DNoT4saIJife3O1kLYuaeq14w/zIddXxXxpNnF6WCfZcMFSgibjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o5Dp50SO;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B321606A32D
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B321606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o5Dp50SO
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9995ce866so8633155ad.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 20:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794545711; x=1795150511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VTWR5mkpuIgueh87MON9g3ptDUiISJcOv6zs0rvvEGI=;
        b=o5Dp50SOZkUrzjKbIIU8LlnPQjbFGb16tD2KhJeRlPSr6wee5OnvJ51J9zKJX6C83a
         MG6APBbNkBwKu3WPc4Ygh4ByhnF33znwc5M0bcsbkXnAWe5Lw+XKkpYgAGjJDf/yKqSV
         eUaIYDdSAKsoCDUDEDLnL9wtGr3D/4QdG9FUNQJaW7YnRSRN9gtu1/vpzOBQllMNL2mj
         pxM79K9zH/lil7gcQXc3v4qarmSjXu//xvIJHUg/y+rc31B/pZosOxcBu4DErd6LDGKf
         IM2VatuMQFJdWVBKcVB4RvY0JeTdobbMXFfQu0qqyLXUxPp28zFpNKquw85v+mCDq/8w
         4iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794545711; x=1795150511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTWR5mkpuIgueh87MON9g3ptDUiISJcOv6zs0rvvEGI=;
        b=klQBUC9nPQJLFJuN5lpYOXZUmAEGDx3Z3O2LGCZ2QMz8vFcxGm6V0sEIBQumuWZiR4
         4fN3qaQZAS6+FZC3jclF4M5Vfo74/el5mf9uS42CB3rwMrwYZk3ytGcBJEoT6IjRi4FK
         VEnU868+WBR2YlwB5LuXwaEZ3EZVZDzX3DIpz2Cnv58XPTnJLvkJusCw5nq3OcNZURMU
         bpXUEIMnwhnr5/5IgF9y6mwPbBWg6MYwyKOeDYszZaKLij5hBod2Nh0z7aF4k18+W86l
         4+MxlEi3NZEab+aBOBDf9x2cpUy9f4A2Y50fr7LnIQvGvMTluwjyFS3WLQBiLPdB+Vio
         o4SA==
X-Forwarded-Encrypted: i=1; AL+hErEcbx2MIdoRJ/GvOBjsznb38z00KNJJSsO4BkVnze4pXu+WqShhW9/24JGLDEUpdUaCnHglC3u+gQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9WdIeujsaJgRFwppiWitS73CvA3hbwToGUe3SzMK1OJnk/gzYL
	UFc5L7k6KsScr3wy/cpMDVmuD5lgG6Tx1nN8jH6W3nVMVle9q2y0g/sZ
X-Gm-Gg: AYBFou3GoxVu7uf3gN4IZ7EshLNitOaskO4t9t1uFYUu0YobQwg3vnAYv47mYKCRl2d
	7YjuOknMfHLOJ7u7g2rB6tAFly9EEGx8oxASvSsMaWAPBsrvt+kWAZnI9+BvXH6YJSyQu773+2f
	0DlKD9ndZWS/nW1VJfYats4ckPuZxZGakValmIf18zGX4od/0KMB+OT7hrd/1mMzVYWgbQOJEif
	8zi6MJ96uug/weRO8tidebhv/ymiKT4omOFYWJlkVQMsHC0yv+VjcOQc2xyoJ9ZmGbqqza0HQeb
	sFawzZJTfhCX7gZczCIXjJE//X6hi8dqwMtNt8bs09OxHagnCNeHs8fjpWvPEPh4AXgfmfNTjgC
	aUVVF4Zzx7CBQxcMH6isp0b2yXxTqDXb2qZRqL+QsUBh+dYR3aE0sWGBd1SYnxOfQfgtoemQvpQ
	jDU+3J9jVeJpd3/64m+rZYpiJxTFYwSyVoxqNViE/aWDhAmrHJvh1k7WFSyW4VZzlF1aXq7gSUv
	fyCkoNHluEMvB9bKCPEOzCHSvWMvHuGKldbfQk7LilNq9MS322apat4E7pgu0mMXp/19GcxmGGg
	EBYP9JvaUKEoaJC+9zAtfhEJVH0hpgO8DNJZhKJzrhn3uDeU/Kol3A5qvbdhCUvBXaPr5YJpWAj
	SdnV7JXVcUibE14eTTCkSYocvEA1aV/7JlEfLngNOU1Z7l8gR+We/V0/+vYcybXJ/d6OgIuEwEC
	8N
X-Received: by 2002:a17:902:f688:b0:2ed:379:158d with SMTP id d9443c01a7336-2ee0da98d27mr14360145ad.9.1794545711133;
        Thu, 12 Nov 2026 20:55:11 -0800 (PST)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee10bdd1a4sm3805145ad.11.2026.11.12.20.55.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 20:55:10 -0800 (PST)
From: Yu Zhang <yuz08559@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] thermal: sysfs: take the zone lock in the tzp attribute handlers
Date: Fri, 13 Nov 2026 14:55:02 +1000
Message-ID: <20261113045502.68053-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The thermal zone parameter (tz->tzp) sysfs attributes - sustainable_power,
k_po, k_pu, k_i, k_d, integral_cutoff, slope and offset - dereference
tz->tzp without holding the zone lock:

	if (!tz->tzp)
		return -EIO;
	...
	tz->tzp->name = value;

For a zone registered without thermal zone parameters (tzp == NULL at
registration - the thermal testing zones, ACPI thermal and every driver
using thermal_zone_device_register_with_trips(..., NULL, ...)),
power_allocator_bind() allocates tz->tzp and power_allocator_unbind()
frees it and sets it back to NULL, both under the zone lock:

	tz->tzp = kzalloc(sizeof(*tz->tzp), GFP_KERNEL);
	...
	params->allocated_tzp = true;
	/* unbind */
	if (params->allocated_tzp) {
		kfree(tz->tzp);
		tz->tzp = NULL;
	}

bind/unbind run from policy_store() -> thermal_zone_device_set_policy()
under the zone lock when the governor is switched to or away from
power_allocator.  The tzp attribute handlers take no lock, so a read or
write of one of these files racing a governor switch dereferences a
freed tz->tzp or a NULL pointer.  The read side (0644) is reachable by
an unprivileged user.

KASAN, one test thermal zone, one loop switching the policy between
power_allocator and step_wise and one loop writing k_pu, panics in
seconds:

  BUG: KASAN: slab-use-after-free in k_pu_store+0xd7/0x130
  Write of size 4 at addr ffff8880064e5c94 by task init
   k_pu_store+0xd7/0x130
   dev_attr_store+0x46/0x70
   sysfs_kf_write+0xed/0x110
   kernfs_fop_write_iter+0x29f/0x380
   vfs_write+0x5df/0x950
   ksys_write+0xfd/0x1e0
  Allocated by task:
   power_allocator_bind+0x51a/0x600
   thermal_set_governor+0x86/0x170
   thermal_zone_device_set_policy+0x58/0xb0
  Freed by task:
   power_allocator_unbind+0xad/0xd0
   thermal_set_governor+0x57/0x170
   thermal_zone_device_set_policy+0x58/0xb0

Take the zone lock in the tzp attribute handlers, as mode_show() and
weight_store() already do ("Don't race with governors using the
'weight' value").  The governor already reads these fields under the
zone lock, so this also serialises the PID constant updates against a
running power_allocator.

Fixes: f5cbb182586e ("thermal: power_allocator: don't require tzp to be present for the thermal zone")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -258,6 +258,8 @@ sustainable_power_show(struct device *de
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 
+	guard(thermal_zone)(tz);
+
 	if (tz->tzp)
 		return sysfs_emit(buf, "%u\n", tz->tzp->sustainable_power);
 	else
@@ -271,6 +273,8 @@ sustainable_power_store(struct device *d
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	u32 sustainable_power;
 
+	guard(thermal_zone)(tz);
+
 	if (!tz->tzp)
 		return -EIO;
 
@@ -289,6 +293,8 @@ sustainable_power_store(struct device *d
 	{								\
 		struct thermal_zone_device *tz = to_thermal_zone(dev);	\
 									\
+		guard(thermal_zone)(tz);				\
+									\
 		if (!tz->tzp)						\
 			return -EIO;					\
 									\
@@ -302,6 +308,8 @@ sustainable_power_store(struct device *d
 		struct thermal_zone_device *tz = to_thermal_zone(dev);	\
 		s32 value;						\
 									\
+		guard(thermal_zone)(tz);				\
+									\
 		if (!tz->tzp)						\
 			return -EIO;					\
 									\
