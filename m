Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4627423EAAD
	for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787399012; cv=none; b=ahSm3V8f0pMX+3L0sM4ZdD4sDwu5JJAl9byvAcgVVt8bLSA4FIVPb7R2TXAHPPimYirnLtWPn3bIJ9Tmy6U3M+zO9ii0uEZ0KYFn8Pn2P5mHMqc6l3N8JAO5+7cm07kYG0vSm6p9jTJ2AVeNiSXqBmXwtvtnulSZRu9wRTlr/mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787399012; c=relaxed/simple;
	bh=CN9bI5JSc4R97kTthHOYaRIf79ONlFCVPEmvKFOn3m4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdWiMUoh2lFbipZ8YMqQApqjk8xLuLBYlt3SrLIxqf2/jEz/IxrAhB0zH/YwP+BusIA87dcgN57nvRRb2S5P/5MWgdup1mwncuO6HKSZum4WHkwGI/qtGwins1L8WpbRprItm89U11KXLsRxg1VHl/aKTVJetcDUXCJFMd1/X7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9UvHy6p; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9UvHy6p"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso14996665ad.3
        for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2026 04:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787399010; x=1788003810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t2malKHbWrEiaEypSgDR5cpQ350oJBSIdozLYtaZr0U=;
        b=E9UvHy6pTEg9aSuc+Or0H2dYeVyWRKeUz4NLVouAJdgyYxGsBnpWpLR30lnKJaqNe5
         v43U/C/mEgsJEk9Wm7DgP5JO/9h7a3+by2YTlvLhUH806TmLLUOgdN1cjlivS1Z0abDZ
         gMxDC3+MwIuYhVnt4tawgYKJJb95yy5wu/42jM6ZWYndKRfA74fMMrs2aXKO9o6J7JbX
         L6pNmy8QH/64dHAzT4LWrYQfjMMH6EPaX0NObuC55wacKuO0jMlBUyZCLmN7wX1Bmiie
         62bt9N8GSWVb2PzFuFTtpJbv7GwmC5WhrnISk4Q9gnsDQGj8rFonkUJtL07CsFwiE5HI
         a0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787399010; x=1788003810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t2malKHbWrEiaEypSgDR5cpQ350oJBSIdozLYtaZr0U=;
        b=sWr6KJxttXSf9CRuvgDp2U+8IMVLmwUE71XdiiG1dOqwoZzRNxbqIa5b/AbkjOXvec
         Kx+JBS+8nOuPk1/CMRM9Nq1RMPkoWJoLCJB7OwIJiOA/wKbvhAH1Q557X7hN6Z1PRH0b
         w2pMX+S9dtLLJxXyJ4P4SWTjnBUmMReBpYz/tiI4Mq6rVWBsSdROm3AkDGwygyxX5dtY
         yp1HuezRps2Fp6cSfxT9Cg5VuLrJkl0Me8+R3qhn7kQDZHrFxp/Q7R0xYgjC/7Qe/vmc
         r5Aqdtu2oUaeJECoBuYH7x+xLAYCVIz+Kk8fxui2h5jeAmFxu+i1s3qdI0SemeTA/a2E
         tUfg==
X-Forwarded-Encrypted: i=1; AHgh+Roce7Eu5ziwSXT+Roi9WYGkKRjwPGV+VeWxBPPYPwgf2T6owM/bs5c5SGNijPVhNSOuHsU03PwRKA==@vger.kernel.org
X-Gm-Message-State: AFuF++k9sl5WcYSRUtAx9YSszfQkkwHFL8b1nr2KtO+YyEKnRBWgHcBW
	3ZXussFFW7bKn63yAw0daDIX5uir0ZmFU0+rEZQXUR6RsbdQM43CmWkw
X-Gm-Gg: AR+sD13n8ZzSnUipHfOEttNSfTN9lXFrj3GU71XDPaaY7BQxrfRtUdd+p4vqj1guPEZ
	b0we7s9a/pPhIUcOVtw9hS7rM39PDY+fJpIWny0EtBDMX5pvjQ1BtEc9pqq/xGjzWGszO+Kfx9a
	FM9kU07fEE2gQufU9FlVGRZLpfy0orDUPUdN0RZyKrUbww0C8bpqPHZ6mQVWV+uSLkovFlKBMjR
	vUMxy1DWQ6zN4/5r6PB4qyPNWWgp6MAnbGvE88cpBNBrgfjaoyHe2R+WXU9W9tG8ceN2A/nCn7K
	Qcw9hb3dHcIErklpVMYBmCpYJooetlvRZWQor0BxbFSkQQWHJF2ZIkGIjnrqzNkHvbVtMzFxoBa
	vrAmbr6ErE/2rKV3HGIErDxSab8VJWFiY63CDnS04EuZT2RTEeddz/hs4FReEPGs89wxTMMhac3
	TzDwxOM7p6TtvqnKljnuXJbz0XTcgXbeb1mOSCQeBv0AXwcAjYXwPNcFP2woY=
X-Received: by 2002:a17:903:1206:b0:2ca:1b97:70c5 with SMTP id d9443c01a7336-2d64adaff50mr208053965ad.4.1787399010397;
        Sat, 22 Aug 2026 04:43:30 -0700 (PDT)
Received: from gmail.com ([58.84.62.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f923f2c0sm9387324eec.30.2026.08.22.04.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 04:43:29 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] thermal: gov_power_allocator: Fix NULL pointer dereference in update_tz()
Date: Sat, 22 Aug 2026 17:12:36 +0530
Message-ID: <20260822114236.15998-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

power_allocator_update_tz() unconditionally derives the trip descriptor of
params->trip_max as below,
  const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
and then walks td->thermal_instances. However, params->trip_max is allowed
to be NULL and in that case the list walk dereferences a bogus pointer
derived from NULL which oops the kernel.

get_governor_trips() picks trip_switch_on and trip_max out of the trip
table of the zone. When the zone has neither a passive nor an active trip
point, last_active is NULL and params->trip_max is left NULL. This is an
explicitly supported configuration, as documented in the function
get_governor_trips() as below,
  If there are no passive or active trip points, then the governor won't
  do anything. In fact, its throttle function won't be called at all.

Return early from power_allocator_update_tz() when params->trip_max is NULL
and only compute the trip descriptor after that check. There is nothing to
update in that case anyway, with no trip_max and there are no thermal
instances for the governor to account for, num_actors stays zero and
total_weight is irrelevant.

Fixes: 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocation out of throttle()")

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/thermal/gov_power_allocator.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 37f2e22a999e..b5c254187628 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -660,10 +660,15 @@ static void power_allocator_update_tz(struct thermal_zone_device *tz,
 				      enum thermal_notify_event reason)
 {
 	struct power_allocator_params *params = tz->governor_data;
-	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
+	const struct thermal_trip_desc *td;
 	struct thermal_instance *instance;
 	int num_actors = 0;
 
+	if (!params->trip_max)
+		return;
+
+	td = trip_to_trip_desc(params->trip_max);
+
 	switch (reason) {
 	case THERMAL_TZ_BIND_CDEV:
 	case THERMAL_TZ_UNBIND_CDEV:
-- 
2.43.0

