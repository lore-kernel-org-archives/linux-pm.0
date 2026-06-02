Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988232ABCA;
	Tue,  2 Jun 2026 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440450; cv=none; b=JtZnFFZMdmHs8rvEK5zsK/RGSd3aYGPpUCIZNwcTnHXStKp+4OL4GqKvkSDL1tPyncBbrZNDsoCdKO+fGo8BQC08QR8y25q29FP6AF1Q7abnlbFDv5SoswwYxWuEqxqMEPVaB6i5Y1y5K+7tjQBuA0Jo4U/sATMBO4ISRhx62fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440450; c=relaxed/simple;
	bh=vOXM84v3grTegAbF0vmkOPiyrZBmohrXgKxht5zyHrs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YcQGCW0NmrfHj9+cZ5zJgMCTJM8CdBc79HO/JdfqdPZq5m/auH8ZPviDyvWsqA3/zjI/amVnyMzrgu+q5UPbOCNgC4RS5FzYiYBbZJyHalJKbLQIzEGwBwgmUczpG/tNdHz6Ryc3YOVK0LppxST8s80ZFbgfxgECwTRxyqAKBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0wkN9Vd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0wkN9Vd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9979C2BCB4;
	Tue,  2 Jun 2026 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780440449;
	bh=vOXM84v3grTegAbF0vmkOPiyrZBmohrXgKxht5zyHrs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=C0wkN9VdWHBkg6xaKNIivlBj1FtKQXw/ZWWVXpn6j95UrkXmeML45kJJTigfut2g3
	 jLVb0ExMHFdPqAJwAM4aacak8eVs+UECPChdIrLWCtOzYbbIr9V2xy8KxqNnPn9HnE
	 xsUAv8SZdTR8K/+aevgUDPc/xyNq2/XxOYN8raKh9SaOS2qzRXGSNzNEuWc/qO2x90
	 5AdvKhXNb3dsgBL+mUOOO1dWbjnb8wQmY7DcjuaNsX/aAQauOTr4WT+d+pHWcPIp/4
	 O9o/x/ypTlwvbV66YLFkvRHF/Gl2wRewd0ryyqIWiPds1DwB/k0+7tOP95Xu3v1i0k
	 eWMNGudU/Cy7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC42CD6E57;
	Tue,  2 Jun 2026 22:47:29 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH v3 0/2] Add support for Battery Status AMS
Date: Tue, 02 Jun 2026 22:47:05 +0000
Message-Id: <20260602-batt-status-v3-0-a7c1c271f3b0@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGldH2oC/1XMQQ7CIBRF0a00jMXwqUB15D6MA6C/LYmWBpBom
 u5d2jiww/eSe2YSMTiM5FLNJGB20fmxjPpQETvosUfq2rIJZ1wywYAanRKNSadXpCCNVBIsMwZ
 IKaaAnXtv2u1e9uBi8uGz4RnW9+eA2DkZKKMdttKotrGo1bX3vn/g0fonWaHM/2Ku9jEv8Yk3/
 NwIkKKrd/GyLF9OdbKp5AAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440449; l=4020;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=vOXM84v3grTegAbF0vmkOPiyrZBmohrXgKxht5zyHrs=;
 b=PZRu7Om7DMi96whX862b+T+d3JzZFpYUmLyjxFB8JODQ4hovNaZ218I42QjFnItWT73dzQrvH
 DYGJlZFvWAfARKg8O/CBRIkKRFrM7dUywOVz3/jWh/lfmDVdVWpMyEr
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
[A] "power: supply: Add helpers to get and put arrays of power supply handles"
[B] "usb: typec: tcpm: Add support for Battery Status response message"

Technical dependency of patches:
[B] depends on [A] due to usage of `power_supply_get_battery_all` &
`power_supply_put_battery_all` APIs.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
Changes in v3:
- Suggested by Hans:
  - s/power_supply_put_array/power_supply_put_battery_all.
  - Call kfree in power_supply_put_battery_all().
  - Change the datatype for fixed_batt from an array of pointers to a
    double pointer.
  - Directly store the power supply pointers returned by
    power_supply_get_battery_all() into fixed_batt.
  - As we are directly storing all battery type power supplies returned
    by *_get_battery_all() but as per the USB PD specification, tcpm
    only supports reporting of up to 4 fixed batteries, we add
    additional checks to satisfy the latter condition.
  - It was suggested that fixed_batt_cnt be changed to int to store the
    return value of *_get_battery_all(). However, I am leaving it as is
    because: in case the retval is < 0, we don't care for the error
    value beyond the scope of the function it's called in. It's sufficient
    to just have fixed_batt_cnt to stay 0. Lmk if you still want it to
    be int and I will change it.

- Suggested by Badhri (internal review)
  - It's not necessary from a PD protocol perspective that a Sink Cap
    Extended AMS should always precede the Battery Status AMS.
    Therefore, we should also get battery references during Battery
    Status AMS in case fixed_batteries was unintialized.
- Link to v2: https://lore.kernel.org/r/20260527-batt-status-v2-0-4282985165f3@google.com

Changes in v2:
- Suggested by Hans De Goede:
  - Added helper power_supply_put_array() to release array of psy refs.
  - Modified tcpm implementation to use the above.
  - Drop "power: supply: max17042: add handler for energy_now property"
    commit.
  - Offload energy_now calculation to tcpm.
- Minor changes to description comments of
  power_supply_get_battery_all() to improve brevity.
- Link to v1: https://lore.kernel.org/r/20260515-batt-status-v1-0-fed6b7d8cea7@google.com

---
Amit Sunil Dhamne (2):
      power: supply: Add helpers to get and put arrays of power supply handles
      usb: typec: tcpm: Add support for Battery Status response message

 drivers/power/supply/power_supply_core.c | 133 ++++++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c            | 135 ++++++++++++++++++++++++++++++-
 include/linux/power_supply.h             |  15 ++++
 include/linux/usb/pd.h                   |  29 +++++++
 4 files changed, 309 insertions(+), 3 deletions(-)
---
base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
change-id: 20260501-batt-status-16b6761c0bb1

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>


