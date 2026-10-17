Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C79296BD2;
	Sat, 17 Oct 2026 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792242438; cv=none; b=JPtMlIZVoiGvPa9gnFcLcZ5rhxv6sRBlfxi7/B+v1aCZoc6l1PLpNkYI65cWwMBznYZQytTzF9NBu/yrx2ArvgGJ9s8dHLTn79VJlVVNlmuht55ZWp/55pOY2/GEiygeVxF69pDxPhxQVJo6GSah+2+J7XeDU4khmxps13Jo/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792242438; c=relaxed/simple;
	bh=wHaKnXk5dvgTuwSxeYuX3VMmbmmXSlzEXrIjK9mY2zY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BGRLHxObpp3xHcxg6Z6+RTVLBgZNiuJ4IYFP+tlh8G4RH//ttqaZOz2RqtBYLn0QbTal/z18DxC+87KBvU0KoY0fwOeW9hA90gkTrQfPbtv1kdE/QcabUSurZ6qY9XWAm3BubLOq1tAT600kGN1vJVuhobbMRR2+MQI/sZUH4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=A2DvF9JC; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="A2DvF9JC"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 40EEC82C23;
	Sat, 17 Oct 2026 15:07:08 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DnvE_HUi_Gul; Sat, 17 Oct 2026 15:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792242427; bh=wHaKnXk5dvgTuwSxeYuX3VMmbmmXSlzEXrIjK9mY2zY=;
	h=From:To:Cc:Subject:Date;
	b=A2DvF9JCal/FBlUICLtwz77n9zvowQnZ11u+0QB79EIYLf17317AyTKXac3d6Nqbz
	 lfFqtLplYNaRxpXTZaq6oFKNUvOpNAwU7e3FYzpjedKoUhx1m8kQ+hCUpqtHZlPDvH
	 eUCph3XMim3Sb9HaV8W7dL9EYDbhMyqxkzckkWQe6HIY8uhazuJNouiIKgP0gOc+27
	 nHXATJM/2Nd/uV+Mrz0heTdPhYVl3o/IW5MfDldHmVdtEbOoQuEfwlv5XI2rNt8nEh
	 oxtqi1xY4D2U8OTxZw6MFhdTrcwSHJL1AVAT0seaS9E0mkziKOIpIH1B/a8n7CI2p6
	 iqw51HdmA5u3g==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Rong Zhang <i@rong.moe>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ike Panhc <ikepanhc@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Charis Stratakis <c.stratakis@proton.me>,
	Avraham Hollander <anhollander516@gmail.com>,
	=?UTF-8?q?Jeffrey=20W=C3=A4lti?= <jeffrey@waelti.dev>,
	Rick <rickk1166@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] ACPI: Serialize battery, INT3403 _TMP and ideapad methods
Date: Sat, 17 Oct 2026 16:06:33 +0300
Message-ID: <20261017130652.318778-1-aliamemis@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
without taking the mutex the battery methods use.  On some Lenovo
IdeaPad and Yoga models, the battery _BIX and the ideapad GBMD take the
EC mutex and a serialized method in opposite order and deadlock until
an AML mutex times out.

As discussed in [1], add exclusive variants of the AML evaluation
helpers and use them for the battery, INT3403 _TMP and ideapad methods.
Patches 2-4 depend on patch 1.

Changes in v2:
- Merge the follow-up series [2] and drop its EC query and UCSI patches
  until they are shown to help
- Add acpi_execute_simple_method_exclusive() for _BTP and ideapad
- Make the helpers wrappers that take the lock around the existing ones
- Join lines up to 100 columns, add a Link: for Suggested-by:

Link: https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/20261014190544.150093-1-aliamemis@disroot.org/ [2]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221065
v1: https://lore.kernel.org/all/20261014132703.93355-1-aliamemis@disroot.org/

Ali Ahmet Memiş (4):
  ACPI: utils: Add exclusive AML evaluation helpers
  ACPI: battery: Evaluate battery methods exclusively
  thermal: intel: int340x: Evaluate _TMP exclusively
  platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively

 drivers/acpi/battery.c                        | 12 +++---
 drivers/acpi/utils.c                          | 41 +++++++++++++++++++
 drivers/platform/x86/lenovo/ideapad-laptop.c  | 12 ++++--
 .../int340x_thermal/int340x_thermal_zone.c    |  6 ++-
 include/acpi/acpi_bus.h                       |  7 ++++
 5 files changed, 66 insertions(+), 12 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.55.0

