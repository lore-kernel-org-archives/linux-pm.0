Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B3C1F4C96;
	Wed, 27 May 2026 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840154; cv=none; b=L6uNydixq5SLwCqwcKGV3oWBMloJcJ4Um2qt+roBjbVxod4lETUN/QSir233RZBcJH9pRyc6vCMW8mTRyYrF7nNFw65b9veXv+LL2TpBFxrSpwbtMi3IXQ8wzka4bbyXMSDZ/GHLyTzsupqAyyvvfkpOPDEMQAjcT1j/PA7kQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840154; c=relaxed/simple;
	bh=zYq5viXWuFtL7JTfONviNW5I5CCbJQgwj//PCyr8jKU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=INx7fHTTnTt3pSB0bVHKIbKSjyqkZOXmfueLZ44ToXssed4whRg0SzjKukOhmHzMLSlDMYIOs3ij9RrYS4G//ocCuPDMgRv1SrBeA4jZ52Qw9mKzTKGH0312kXXwAnVnUGsV5bDtOqByJQZ10iNoawMQeDbaAbbcvKcooLcIsJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4n6G6kN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4n6G6kN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2028EC2BCB3;
	Wed, 27 May 2026 00:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779840152;
	bh=zYq5viXWuFtL7JTfONviNW5I5CCbJQgwj//PCyr8jKU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=R4n6G6kN59IquPr/Pducy9YNSjpeKliKfFeprlHJDQWBgtaatNpzteCG/ve+i6hQz
	 zTiz2bGjIV60xhsE0SyX/kkrRRU34zfuhLcUZ1/J1C/VGKuVuxx0b9TVh+YQWXi9Sr
	 IFIWnUjgheYHXL9urn8OJeiFYvSCNhd6QIzpsmAjw8Ljjkcn7Ktf0VpGyykT412a3l
	 shXLHdrlD7iK5gOd8LuKH9XEt2vpRwzV1MFRL3jZ5tTdGxBeI2CAE7zjaJex5FbwrJ
	 7AOh6LUJJx9+wKxx+GOEgLAZrMluIHxLQ/dAYL9UmQ0F+FV7J2iKcRr4tY2giQ3HAl
	 Hh4RIScD2JoRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EA1CD5BD2;
	Wed, 27 May 2026 00:02:32 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH v2 0/2] Add support for Battery Status AMS
Date: Wed, 27 May 2026 00:02:24 +0000
Message-Id: <20260527-batt-status-v2-0-4282985165f3@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJA0FmoC/1XMzQoCIRSG4VsZzjrDI4xGq+4jZuHPGUeoMdSkG
 Lz3bGjT8v3gezbIlAJlOA8bJKohh7j2EIcB7KJXTyy43iC4kHzkyIwuheWiyzMzlEYqiZYbg9A
 fj0RzeO3adeq9hFxieu94xe/6c3D8cyoyzmZy0ih3sqTVxcfob3S08Q5Ta+0DRcCT+KcAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779840151; l=2600;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=zYq5viXWuFtL7JTfONviNW5I5CCbJQgwj//PCyr8jKU=;
 b=+18rHuPiKFZzSZnrlbF4Jcp41LqoYoGnEi6GxtiNZQT9/9hP7T374XKoyiYL0Lt/G0s7BJYMc
 75PqWlTm5q4CxwGIZ9M3/dGWJrieqY3ZIPDPd171XRHvBSDsf5C57pf
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
`power_supply_put_array` APIs.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
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

 drivers/power/supply/power_supply_core.c | 137 ++++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c            | 151 ++++++++++++++++++++++++++++++-
 include/linux/power_supply.h             |  12 +++
 include/linux/usb/pd.h                   |  29 ++++++
 4 files changed, 326 insertions(+), 3 deletions(-)
---
base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
change-id: 20260501-batt-status-16b6761c0bb1

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>


