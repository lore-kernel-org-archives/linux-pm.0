Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA16175A72;
	Wed,  1 Jul 2026 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782866075; cv=none; b=mcOYm7UFU5+Ad2/lGN5vxFM/RUY8e6gjVjnvsodWutQiG5zpk+45TS3Lc73fJ7GDetWHp56E8QgvktGSHlpa0wMqSsQAQFJ1EEKu9ZeJhrapinMgu3v6RR1Ejg0b2T5Ie//t2w8uq3dHjH7bT4BeTJ/ILePZM5yCypc4HJw3X4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782866075; c=relaxed/simple;
	bh=I4vg6DHHr5+EusWxauGftveS+8tdCcuVGW8aXCIpIUg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ffw2zOeetjBIpPw6yj3HQfgt7LAm6onl7KPHs44ifwC/4gpPxyTtPhZPNFRBSJ3O8GYCUHdf/M4LpyBO/Dl751SAjkgWaDSD6KzYPoVZehkCzx6UyFf/96BLMqwiI5yirM6Fyw8/TpyZ9WlhMZtjJzD7pAK0CnHWAW5L6loOqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7rwfEcB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7rwfEcB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC6D2C2BCB9;
	Wed,  1 Jul 2026 00:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782866075;
	bh=I4vg6DHHr5+EusWxauGftveS+8tdCcuVGW8aXCIpIUg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=i7rwfEcBRychZ4ftgkmL2TRoCFHAN/j3lrT2AbzqaJtZM6scovcXpeolddo5D5FXk
	 9xJOQ7eLH2cdfxFWXzl3yH5nK+jqCcqSbYZ5tgQf5aft4d5oiFDccVdRvrVT08jNXu
	 B+lD5P/HLAtKISmcpeSOdEVZmT3Uem6IkDNYfWtu0mGSygRgvlQtKzIn88/28Nw3Li
	 QLW7wEib6BHdncpm2iip47wzCHSi4uvgRrDTSJ6jkU2cZjvtbehPNoEWnlW8EYBEYm
	 Jo0+eijiBQZRcBqnvxh9go+r0w2T01n8pIZ4U3koVWmQC26Ksgy2Xj3fxQy1SvDHlx
	 Tznw3g900RdbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD521C43458;
	Wed,  1 Jul 2026 00:34:34 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH v4 0/2] Add support for Battery Status AMS
Date: Wed, 01 Jul 2026 00:34:17 +0000
Message-Id: <20260701-batt-status-v4-0-a31d97b1ae57@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIlgRGoC/2XM0Q6CIBiG4VtxHEfj/1WwjrqP1gEgKFtJE2I15
 72Hrq1ch9+3Pe9EghmdCeRYTGQ0yQXnhzyqXUF0L4fOUNfmTZAhZzUDqmSMNEQZH4ECV1xw0Ew
 pIFncR2Pdc62dL3n3LkQ/vtZ4guX9dKDedBJQRq1puRJto40Up8777mr22t/IEkr4g1FsMWZcY
 YOHpgZe2/IPl1/MGW5xmbEUGjQKsKViGzzP8xv9eXt7IQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782866074; l=4318;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=I4vg6DHHr5+EusWxauGftveS+8tdCcuVGW8aXCIpIUg=;
 b=zIZTUkZ4++xujArdDEEYsTgx53+ayCTfNkK8ZYjL8gozj23582K/mYC9ln4kdEG8XzHUtGCEo
 gVxrV1+SwqTD5HHZGW/erHGisaWpHuljgmqLTgQReXjnoGhGOiae14C
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
[B] depends on [A] due to usage of `power_supply_get_system_batteries` &
`power_supply_put_system_batteries` APIs.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
Changes in v4:
- Filter battery retrieval based on POWER_SUPPLY_SCOPE_SYSTEM
  (suggested by Sebastian Reichel)
- For the rest of the comments, I have replied in thread in previous
  submission.
- Link to v3: https://lore.kernel.org/r/20260602-batt-status-v3-0-a7c1c271f3b0@google.com

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

 drivers/power/supply/power_supply_core.c | 153 +++++++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c            | 135 ++++++++++++++++++++++++++-
 include/linux/power_supply.h             |  15 +++
 include/linux/usb/pd.h                   |  29 ++++++
 4 files changed, 329 insertions(+), 3 deletions(-)
---
base-commit: 4708cac0e22cfd217f48f7cec3c35e5922efcccd
change-id: 20260501-batt-status-16b6761c0bb1

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>


