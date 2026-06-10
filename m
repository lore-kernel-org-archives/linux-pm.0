Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC8313277;
	Wed, 10 Jun 2026 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083840; cv=none; b=ib7FXtBDyliGtOpE2XjZa096xC/iAvYgbQilwnpIow6R9cmQlxHrjwdhMCOnypiBd8vT3y8XeCXUJE7AVdZeJ/dgnHDGpJonMoXxcUvTWXwMQqG56alj77tG0qQ+a7ocH+9K4wpX5X0pODje3Jd6vENO5w0MQHZRUt+9Ih4jIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083840; c=relaxed/simple;
	bh=9lh9jfbzDHp6Bfxoru7I1PEcPES9+e4YcN1LJU7C+NA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gbVrTofrVTYWBxbfbXZAx0PoXgqEA/fbyC4bCO4B3yjheV8JFmI/5/I0PseASj+1k3VoCUZmj+B7A8e1SCep1lvtmsE//R16kctjM5duIoR5vJbQolPUtHxiXIhyfPfqFd/KAWNBVrI2hOOU023g7/lCa85AXjPcUMnANBDPaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PbQeycmH; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PbQeycmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781083828; x=1781688628; i=markus.elfring@web.de;
	bh=IHwRnwz+2ZxPfmcFi+GtcYmPKcJBhRsFIvBtK0jkZas=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PbQeycmHO9+tExS8SjjD524R9UBZgBPHOgPMKGjcV4CCw6ok6Bc+qqjXI9G0FIsB
	 JWDPktXcQJDi+3pbKCoWmiIqtygGqGkVMIISx7zAla86u+yk0HPFOmF5omUkx3sy3
	 TasA2bwhO1OvTe+CFP55qL9pCo3M3LHG+WJPGeojBk4F8+UFykaCHGIzfaHdCxl7I
	 DyDpBTDiTfBTEx18xovzKKwRDH/WK0SyKqXYOs96bHza+SsF4ovtTBWG/DMM0tEpE
	 imo31B8WybrS4u7LFzPGSA10JbffP9+7kAGD+ddq04Bl0xCALYvfQNzHk8WDeRk4/
	 yN6iiAuD8FxmLidCMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxpiU-1xS6F024Fy-016G0F; Wed, 10
 Jun 2026 11:30:28 +0200
Message-ID: <a3dc82f0-7333-465d-85b4-8034b1591442@web.de>
Date: Wed, 10 Jun 2026 11:30:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] thermal: gov_power_allocator: Use common error handling code
 in power_allocator_bind()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4OcGAkCkkaX6XYfxth1I6Iu5uwdsx6GtW95RPTAqZeYOKcAGLdl
 Icu5F+L1epf+YaGMRZxZmAVkEYiWCXdP3JFe8+JkSvO85zpvYyDOu0iggBeitbX2QezWlzI
 ev/aZ5uF9SBbWbRfsBeIhx+XfQbEWdHvGeY8Un1MZWp1EvWUFhTgfckE9EV5PpdmeMcWVvu
 jvhkwDs38sWqjhniyghEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+QkAVzmuius=;xPDsvjkyJ0Hkhpa8VkK6vBPbdHd
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 10 Jun 2026 11:20:37 +0200

Adjust labels so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/thermal/gov_power_allocator.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_p=
ower_allocator.c
index 37f2e22a999e..6b9450ffd5de 100644
=2D-- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -707,22 +707,20 @@ static int power_allocator_bind(struct thermal_zone_=
device *tz)
 	ret =3D check_power_actors(tz, params);
 	if (ret < 0) {
 		dev_warn(&tz->device, "power_allocator: binding failed\n");
-		kfree(params);
-		return ret;
+		goto free_params;
 	}
=20
 	ret =3D allocate_actors_buffer(params, ret);
 	if (ret) {
 		dev_warn(&tz->device, "power_allocator: allocation failed\n");
-		kfree(params);
-		return ret;
+		goto free_params;
 	}
=20
 	if (!tz->tzp) {
 		tz->tzp =3D kzalloc_obj(*tz->tzp);
 		if (!tz->tzp) {
 			ret =3D -ENOMEM;
-			goto free_params;
+			goto free_power;
 		}
=20
 		params->allocated_tzp =3D true;
@@ -746,8 +744,9 @@ static int power_allocator_bind(struct thermal_zone_de=
vice *tz)
=20
 	return 0;
=20
-free_params:
+free_power:
 	kfree(params->power);
+free_params:
 	kfree(params);
=20
 	return ret;
=2D-=20
2.54.0

