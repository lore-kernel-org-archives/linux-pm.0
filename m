Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4591364E9C;
	Fri, 15 May 2026 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824257; cv=none; b=O7wCWbY9M9V+dfnJFVS/FNUKzqSXLuxjihmOgE3CHOxpgSkmfpdEjgbUOWItXkpEEI6xHv1hTNdB2bOALS5ny4TxJBj44dvqCQhIbVQQvrtDT+itlHIyp/zVAgwguGqaEboyE/ZuJ4nk+2EwN7VAkq05SsUwYg08zkM/2w4WSYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824257; c=relaxed/simple;
	bh=6rjMPk1stk8aZ3fMDqacMHJU1ErCel3DsuDHgbgKPm8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MOkaJhcnx+vWErI166rIRHKidHHDX/vgpMT4iaY/zc5q4hItUe8AMcnYfvckDdYyfvuOxcvtzOFBgYM1HXM24GOn4i1dYnh6c58uJryR09ffErfLiOnSHrS0J9sNQLzfL5HUVPKKZRsIOby4owdw3oSVgYg2hpMOD0kVPwuF6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmOe7fpD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmOe7fpD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44709C2BCB0;
	Fri, 15 May 2026 05:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778824257;
	bh=6rjMPk1stk8aZ3fMDqacMHJU1ErCel3DsuDHgbgKPm8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DmOe7fpDZbnrP76BIX0o5cyqShnBzjm4ZWtFCTTomTTqYKL374y8/YrGGVud44g/3
	 0L6+xNgm35uie7V2o1ZqilQshteUsJW4kmrHfbCDgoe7izSlfoS56ONEH7b3QHdVcq
	 y0Uzg1Beva9gd87vRndC4kq/qS1zZNj/7/YsI663CzVetzIGAzYoe8+UPzgr/ZWMTD
	 lMSDr/IhHlTBBtn8Dc2tLZPV7GMywX2y8nQU7xPTx1kPw9Lb9FosXlUgL9oCUGoR1K
	 xVDkWCcMatLWX9fRWrh7bZSV6P5Ng+XYfYPefMwricaU2nfSfMDuYAPg5iMsoqdEDn
	 Mil1tzgfMlwuQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F0CD4F25;
	Fri, 15 May 2026 05:50:57 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH 0/3] Add support for Battery Status AMS
Date: Fri, 15 May 2026 05:48:38 +0000
Message-Id: <20260515-batt-status-v1-0-fed6b7d8cea7@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALazBmoC/x3MQQqAIBBA0avErBMcIYOuEi3UppqNhWMRiHdPW
 r7F/wWEEpPA1BVI9LDwGRuw7yAcLu6keG0Go43Vg0blXc5Kssu3KLTejhaD9h6hFVeijd//Ni+
 1fvGjbN1dAAAA
X-Change-ID: 20260501-batt-status-16b6761c0bb1
To: Sebastian Reichel <sre@kernel.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, RD Babiera <rdbabiera@google.com>, 
 Kyle Tso <kyletso@google.com>, Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778824256; l=2299;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=6rjMPk1stk8aZ3fMDqacMHJU1ErCel3DsuDHgbgKPm8=;
 b=tO+0UgaaM/areUwX3b52bA9j0nJ7mOlUiPQ/fzlUEIz2mEckUae8JpJ8IkOA3lHB/J0K8mcTa
 FvSL4BmlyCsCqlubwfSSV8n+1IyWPf1updfDOOi+aSjSrcL0m3n8xeQ
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

PD 3.1 v1.8 Spec necessitates a response to Get_Battery_Status request
from the port partner (see "6.13.2 Applicability of Data Message").
This patchset adds support to get all the battery type power supplies
and query them to report the telemetry required to build a Battery
Status Message. Right now, this submission assumes all the battery type
power supplies that exist in the system are fixed (meaning cannot be hot
swapped).

Previously, I had sent a patch series [1]. However there were some
concerns. Broadly:
  * No client drivers
  * Duplicating dt properties
To address the above issues, we now have Fuel Gauge and Charger drivers.
Also, I have rectified my approach to fetch information about batteries
from the power supply core.

While, the original patch series [1] added support for Battery Caps as
well, this patch series only adds support for Battery Status. Therefore,
I am sending it as a new series while incorporating relevant feedback.

[1] https://lore.kernel.org/all/20250507-batt_ops-v2-0-8d06130bffe6@google.com/

Patches in series:
[A] "power: supply: core: Add power_supply_get_battery_all()"
[B] "usb: typec: tcpm: Add support for Battery Status response message"
[C] "power: supply: max17042: add handler for energy_now property"

Technical dependency of patches:
[C] is independent and can be applied in any order.
[B] depends on [A] due to `power_supply_get_battery_all` symbol.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
Amit Sunil Dhamne (3):
      power: Add power_supply_get_battery_all() to fetch battery psy handles
      usb: typec: tcpm: Add support for Battery Status response message
      power: supply: max17042: add handler for energy_now property

 drivers/power/supply/max17042_battery.c  |  60 ++++++++++---
 drivers/power/supply/power_supply_core.c | 122 +++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c            | 140 ++++++++++++++++++++++++++++++-
 include/linux/power_supply.h             |   9 ++
 include/linux/usb/pd.h                   |  29 +++++++
 5 files changed, 344 insertions(+), 16 deletions(-)
---
base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
change-id: 20260501-batt-status-16b6761c0bb1

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>


