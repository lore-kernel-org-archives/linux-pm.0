Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB03382F2;
	Mon, 26 Jan 2026 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442005; cv=none; b=PR1nkEbzKekpLUHU+ePKilmVFoJa9FEpiKki/F9pvF1wZHsIXHBkwC5v9aKzQfgPUuubDtFI4oovcODnwNVbodKsL2Nhmf+uWeUKSbKY+WiXVJX5tt+11dvpuvgONPRS7lTqF0QbWAZt1n3SJOzuxbygKu3QFiDVuBCNykG/xCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442005; c=relaxed/simple;
	bh=d8VuOEfG0f/9HpsNiEmEqegXE6O8LKlNn7wru/cUYdM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d5ayyHqMZmsdLXM532CDd7p/sQwpvW/KrzUvFCaXGhfEeYrEhryrtuIrJOkYIQxd8XA4BMBZzlm9kL87r7e1+MK0iwOxWbeZ9O25uMPNksdI4txWWCDXywUQrgbjUi53rp39GKRZtRGOVLN1+Lh77xZZNnEHcJvXt032r/iE2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cPi0QWY+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cPi0QWY+"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2F0E6277E4;
	Mon, 26 Jan 2026 16:40:01 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q1cFH0pjmZE2; Mon, 26 Jan 2026 16:40:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769442000; bh=d8VuOEfG0f/9HpsNiEmEqegXE6O8LKlNn7wru/cUYdM=;
	h=From:Subject:Date:To:Cc;
	b=cPi0QWY+oOdLeOJ1ShOMwdbsizwgmJl+oPuLpgJt8XDfw4bCGhnPny3PPplMzZ1kL
	 9i+y6YFWExbuAMfXxzMnTO/irM+nwJlIpmuiFr1rJFTOsq0UjFCyrpgT015kdlft5j
	 4uS9yvlVaTsEHSbwQ9iNf6BgWdfb/OJtyDQ0REMvO/nk9HqhMVRs1pYZtGZl30UZTm
	 M8yZE1YV8uONkd7BTgFsNRX9P5+SmsXPRDo0AWx+gEiD/m39TtExPohkH5wazxOaHz
	 KFbgeTCJVYWFs10LjwV65XydVzZhxNg3n9n/kGMjeMjCmCiGtx87OWW2YIZ2OAlIrN
	 2f5VwM82a6iPQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/2] Add support for Samsung S2MU005 battery fuel gauge
 device
Date: Mon, 26 Jan 2026 21:09:47 +0530
Message-Id: <20260126-s2mu005-fuelgauge-v1-0-68a146ed0819@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMOKd2kC/x2MQQqAIBAAvxJ7Ttg2FOwr0aFyq4WyUIxA+nvSc
 WBmMkQOwhG6KkPgW6KcvkBTVzBvo19ZiSsMhGSwIaMiHQlRqyXxvo6pCKTZOqu5xclA6a7Aizz
 /sx/e9wMXynTiYwAAAA==
X-Change-ID: 20260126-s2mu005-fuelgauge-25e9d95e30b6
To: Yassine Oudjana <y.oudjana@protonmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>

This patch series adds supports for the battery fuel gauge device for
Samsung S2MU005 PMIC battery chargers. It reports various metrics,
including incoming voltage, current, battery capacity, etc.

Although this device is independent of the actual PMIC which it
accompanies in functionality, it is used in conjunction with the PMIC's
charger sub-device to provide complete battery status.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (1):
      dt-bindings: power: supply: document Samsung S2MU005 battery fuel gauge

Yassine Oudjana (1):
      power: supply: add support for S2MU005 battery fuel gauge device

 .../power/supply/samsung,s2mu005-fuel-gauge.yaml   |  49 +++++
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/s2mu005-battery.c             | 234 +++++++++++++++++++++
 4 files changed, 293 insertions(+)
---
base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
change-id: 20260126-s2mu005-fuelgauge-25e9d95e30b6

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

