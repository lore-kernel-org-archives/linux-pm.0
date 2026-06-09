Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A54370ACC;
	Tue,  9 Jun 2026 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021238; cv=none; b=IqWr9gwUNRNGx/uOkx2+6Aa3dVnvjM+N9UjX/nbXxP2dVMxNPBibJT6C5F+k44+syvsxhg3jIWR12ITu68OHu8+BCXeu//1JHGA7GqrvPxSqf/xDlqletb64n7HrFX5Zw8BslBOYm0uj6MJUxSkhhF5IjGCCd1goyH1ngvGT7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021238; c=relaxed/simple;
	bh=lILjMV2ioCK3BE6Zuhmx0roHbytKoYfUTNpAf/uZxs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDTLeEWiB/UAJyqnKncrYI8vphIek47tqrkc2LiVxpKg5YEhEU3gQWNhJcnEdeFgoaibpZFi0HMGlaoOJw79vinyRl9rmCw+4Q3Qu1x/oyTqPVAB0APgOBMCnf4eeUtyThmcHksLTsFLMJRMtQpS7hxYmuRYiFqT47ilavTFw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfKKUGUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfKKUGUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67ED61F00893;
	Tue,  9 Jun 2026 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781021237;
	bh=TW0j7nNBY1OUh9j2Iu5qeAPCw0cjX+q3/66zGbo1FM8=;
	h=From:To:Cc:Subject:Date;
	b=RfKKUGUnLkhXBbIlD/y2nDE8UTydXQTBWbl1aSN4zycEY1T/y2DjMbASSgWiY/aPk
	 /PQpXPnTo6ymAMPm/gudearRGAB5dH0CxXsjAn2EMS8LW738r+UJf+Lq4xXs7hPlRL
	 2KrvSC6aqpiVciW9tJIm0QLKZPs49pM/Y7UW0PM8ycnXu0OA21EjkXaE7UGzOt5thJ
	 K2qSrxhIl1FjW/AChibbOqENetKt7Rme9Ne+IpLx9e1DqorbilCgm26P3IPjQ20RWz
	 bMUokafBeZxjuSCqMdK3dCtAKhq2v1fqW9SHTJlbraA6Vp2P7qtk1XCIfWnv9d2/uj
	 /fI6vrfdO3cUw==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wWyyx-00000001291-0gqn;
	Tue, 09 Jun 2026 18:07:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] pmdomain: fix early domain registration
Date: Tue,  9 Jun 2026 18:06:34 +0200
Message-ID: <20260609160634.246526-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent change switching to a dynamically allocated root device broke
platforms like rcar-sysc that registers PM domains before the PM domain
bus itself has been registered (cf. commit c5ae5a0c6112 ("pmdomain:
renesas: rcar-sysc: Add genpd OF provider at postcore_initcall")).

Defer the assignment of the parent root device until the domain is
registered with driver core to avoid it being left unset.

Fixes: a96e40f4afdc ("pmdomain: core: switch to dynamic root device")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/CAMuHMdUHabMGJyJ7e7yp7DLC+JJc9k6NK9p4anj2wRKNuwZUng@mail.gmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/pmdomain/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 3f265b57158a..19eaee1819c8 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2323,7 +2323,6 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 	device_initialize(&genpd->dev);
 	genpd->dev.release = genpd_provider_release;
 	genpd->dev.bus = &genpd_provider_bus_type;
-	genpd->dev.parent = genpd_provider_bus;
 
 	if (!genpd_is_dev_name_fw(genpd)) {
 		dev_set_name(&genpd->dev, "%s", genpd->name);
@@ -2688,6 +2687,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	if (!genpd_present(genpd))
 		return -EINVAL;
 
+	genpd->dev.parent = genpd_provider_bus;
 	genpd->dev.of_node = np;
 
 	fwnode = of_fwnode_handle(np);
@@ -2782,6 +2782,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		if (!genpd_present(genpd))
 			goto error;
 
+		genpd->dev.parent = genpd_provider_bus;
 		genpd->dev.of_node = np;
 
 		if (sync_state && !genpd_is_no_sync_state(genpd)) {
-- 
2.53.0

