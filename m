Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44D47532E;
	Sun, 18 Oct 2026 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792326156; cv=none; b=RlmQuZAXj5JMVaMS0gjxwB2MJPx2MfCe4NQBjAgXmRLFyaKa1iCdHj17do9rmPn7T+TzF5Mjq1lmLwxJ7hKIOUZ3n6of76gLYPttELNUQyNSnZb0r2G+djanjbK/wQZVS/tSQbBj+/347Qc8Qz6q89XoE913bCrafzxmm+tLGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792326156; c=relaxed/simple;
	bh=88MdtRV5c1OfblwXIh5USkyoQj5IG6VXjRd0Ceysiaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fsnzwulFXzIMbAuRewK2hng49eg02SqAWarQsgkoi6k/QLOuIjpvxy8KngGyk/uH/zdoZZLDjKLzmRyVwIEEk2NadCk9D2n5T12bcKbWEoVlei9c9YNvGoTPaZHML8LpkYI1U+VTVPsWE4rZjCt+bBL1ZtFGcpjsn6pf1YfoxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=I6XMtjHT; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="I6XMtjHT"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3D43D810E5;
	Sun, 18 Oct 2026 14:22:31 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KMPTO3mHBsKi; Sun, 18 Oct 2026 14:22:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792326150; bh=88MdtRV5c1OfblwXIh5USkyoQj5IG6VXjRd0Ceysiaw=;
	h=From:To:Cc:Subject:Date;
	b=I6XMtjHTKOLL0VYiLG8rfZ5X10zDZyRwfkRBAT/ElCdNyf10aAL+CUV1EDQhnYFkg
	 7CvYWSkkD/q3ZvpM+9infGhG1Tl5jWfFR7V0G6X4YWu1+YaiPV7KIUfmIVu4JTMsGK
	 YO7wTtk8Ex3zgihiZF7wFJYcxUoXOyKZYdsnfMmYTbqsdD0hesiYVWqUx6R4NoplUZ
	 HobKpFe00mJI99rGxpirlJr2JaFppAEKGie4oJf75PMJH1CCYshkH2EFPDy4gJGkmY
	 Bpy2rEQo64dhMn1wn38znjECmHa5zKuvh6EPhRLI6cbknqltH15micq+UnWG4wrJlM
	 NPxviXV6mlGXw==
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
Subject: [PATCH v3 0/4] ACPI: Serialize battery, INT3403 _TMP and ideapad methods
Date: Sun, 18 Oct 2026 15:22:16 +0300
Message-ID: <20261018122220.678822-1-aliamemis@disroot.org>
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

Changes in v3:
- Also evaluate _TMP exclusively where int3403 and processor_thermal
  probe for it

Changes in v2:
- Merge the follow-up series [2] and drop its EC query and UCSI patches
  until they are shown to help
- Add acpi_execute_simple_method_exclusive() for _BTP and ideapad
- Make the helpers wrappers that take the lock around the existing ones
- Join lines up to 100 columns, add a Link: for Suggested-by:
- Drop Hans' Reviewed-by from patch 1 due to the rework

Link: https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/20261014190544.150093-1-aliamemis@disroot.org/ [2]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221065
v2: https://lore.kernel.org/all/20261017130652.318778-1-aliamemis@disroot.org/
v1: https://lore.kernel.org/all/20261014132703.93355-1-aliamemis@disroot.org/

Ali Ahmet Memiş (4):
  ACPI: utils: Add exclusive AML evaluation helpers
  ACPI: battery: Evaluate battery methods exclusively
  thermal: intel: int340x: Evaluate _TMP exclusively
  platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively

 drivers/acpi/battery.c                        | 12 +++---
 drivers/acpi/utils.c                          | 41 +++++++++++++++++++
 drivers/platform/x86/lenovo/ideapad-laptop.c  | 12 ++++--
 .../intel/int340x_thermal/int3403_thermal.c   |  3 +-
 .../int340x_thermal/int340x_thermal_zone.c    |  6 ++-
 .../processor_thermal_device.c                |  2 +-
 include/acpi/acpi_bus.h                       |  7 ++++
 7 files changed, 68 insertions(+), 15 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.55.0

