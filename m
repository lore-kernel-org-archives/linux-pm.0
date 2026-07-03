Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332293B6BF9
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076620; cv=none; b=b8j7ASTdWcJgieuqW9HxTNW3kNcHbfaOE7vICSrH+Iky158T+M6OnripMvvbdLzV2X+FIuh73AjzM1bTP9HhDO2BnGUxsylpL/t+ieZBaYs310KPP3dVMuGxyuSk1dzptFbWtV+26RVbLRj3K3eg/VCyv/IPoYTh+AUVJZEiDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076620; c=relaxed/simple;
	bh=ogikdSS5fM83wdUgSIeNaSuxlx1astWtdx5wvQV6XaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPOffi2jg0IY/G5Rhco5RVzBzxe1Hm92ek5abfqHWRToY3/DbG6/8haCKBv4R8UOLwk68LKSsgGmgQ9u7+aiT2xKyfrxeoFgWdbIiDa+EumH6O6nKRIpzueVpd527wX+L9a7DuXORjuNfwYbNkpZbW5k71lWdd7pq5nrda7Zjcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lj4Fc1UX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lj4Fc1UX"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cace91f112so3603595ad.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783076617; x=1783681417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sqs/izjUXlQxLzNznfrFoz35GSBVfbHOxBq9DzMVAxY=;
        b=Lj4Fc1UXcZsNnouZKNz4bKaDbqFcV0qn6QPXZMZBUhOoK8fe/TjN4OH83yvYkFYKqM
         lLZrxRUtvhPl1pN151CDGuLpWonXJz/Ux8uFw8K2A28rYNPDyKDOFqmkl6XyU+Z9sEQb
         qvxvxr4A+/1WjNpOsEPgd1gwVE64bZnNE6cG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076617; x=1783681417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqs/izjUXlQxLzNznfrFoz35GSBVfbHOxBq9DzMVAxY=;
        b=SdcnjMh3BpjswzdPlCaNYrtCVg5he1teoobBnqqoPavhVdRWzk5joaLeMDYFKX/EmR
         PB0DTMLByMUaNgq8JZHIk74MTeKx+xfStAqNXr6+V1RvRBAJuSd6YuV6WPsl4vKQ+LRX
         TwJeJJsKRCzNO/4bvRPth0ysTOjJ5Z/4eFW910wOXHSmZudSpf5OG0RD/EfLIYyzIcWa
         H3azLr965Aw2xnvAPEhRBbaU+dsSE4fYNWYM1R90PJkBVu+7Xfz5uLn64teV6kIJwA2D
         vT3uuw/gQp6TC4mytY8zdD7sCIS9HoRC3maWeY2hDNPfqisLgSBBL1HsVM2fbPVgYkJj
         WtVA==
X-Forwarded-Encrypted: i=1; AHgh+RpKftnRwcj8BEY1hSk/YdSW6h86bEh6Y0SqdLzc37PidpHvlbr1lx4wZco6S7p3f4zNrTYNzIeQ+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9X5BsOrdG7H8dM1TrRqoXtW77ew0LktzmxtB4LezcGZ7xBA1t
	CT/8EQkNT6/GJU4+bCVNziS75+24pMzi2yZML9gvRfNBrR2yGalWlXODISSId9HrxA==
X-Gm-Gg: AfdE7cneEh/2BHs73sq78uPZJldY7KJjlvEqkilyoiz0wVc9ce0ZUamB6bd6edEyFHQ
	Vum/KrxAvj4ITXoL5KoFNO2noUUAoKvAclFEMBNc/Cz2vhqnImgo98cadQ7NwTcXVbRjBwmO8u6
	twG+gWAJu7bUxQFwOBZRFQanctnC30ZkaSZNyy4V/uCyYZIC9q1t9jnuzysXBe93RR+EY2+Idzl
	SGm7saWrlSoBgUEMhB1igi0UJTcNim4ixkv5d2ACfh/PozcKfwsyv3g/j4dNdQA5vL5Tb8L3l/N
	Lmh8SSL2zvVTy2sLyhzDLl4BsnOTgfJtkPO5Lp7NFHigyFmfoiJA/YYxBVxSoMcYb5yl2OXsPM4
	ze7aOiduW5ddXDlfT6AI3xm+AaaMOMS/QX6OmhLjDqVajNVuJKzfUn/9cglpIx4Bc8D8wZtdQ0D
	N9kneZdPlhcSkzZBr1al2Ny8w/XLpca2QCcuywYAW0YOyqBkbq87XIe/sCpc0g1Gz8CB/Tvg==
X-Received: by 2002:a17:902:e54c:b0:2ca:d818:61e5 with SMTP id d9443c01a7336-2cad818638cmr21373785ad.26.1783076617402;
        Fri, 03 Jul 2026 04:03:37 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e15sm7785315ad.13.2026.07.03.04.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:03:35 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v3 00/13] arm64: mediatek: Add M.2 E-key slot on Chromebooks
Date: Fri,  3 Jul 2026 19:03:01 +0800
Message-ID: <20260703110317.1283411-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v3 of my attempt at integrating the power sequencing API into
the USB core to support the USB connection on M.2 E-key slots. M.2
E-key was enabled in v7.1-rc1 with just PCIe and UART supported [1].

Major changes since v2:
- Removed changes for MT8192 Asurada family: one of the device is
  shipped with RTL8822CE-VR, which is PCIe + UART and needs more work.
- Removed changes for USB A ports: VBUS one the type A ports on
  Chromebooks are not directly controllable from the OS and VBUS is
  modeled as always on. As such the changes I made don't actually
  change how the system works.
- Added new pwrseq_power_is_on() function
- Make new pwrseq integration effectively OF only by not assigning the
  port fwnode if the hub's fwnode is an ACPI node
- Added patch to convert remaining instances of directly setting/clearing
  USB_PORT_FEAT_POWER to usb_hub_set_port_power()
- Power sequencing state removed again in favor of state tracking by
  pwrseq subsystem
- Power sequencing descriptor again separately requested for HS and SS
  ports
- Dropped pwrseq_power_off() call before pwrseq_put(); the latter calls
  the former implicitly if the power state was left on
- Squashed DT binding revert and addition into one patch

- Link to v2:
  https://lore.kernel.org/all/20260610084053.2059858-1-wenst@chromium.org/


Major changes since v1:
- No longer adding the "index" parameter the power sequencing API
- Switched from OF graph to fwnode graph APIs
- Tie "port@" node to usb_port device, and use this device as consumer
  to acquire power sequencing descriptor
- Power sequencing descriptor now only tied to USB 2.0 port to avoid
  double reference
- Power sequencing state tracking added
- Link to v1
  https://lore.kernel.org/all/20260515090149.3169406-1-wenst@chromium.org/

The series is based on next-20260702.


Patch 1 and 2 add new fwnode graph helpers. These are used by the patch
5 and 8, respectively.

Patch 3 adds a new pwrseq_power_is_on() for a power sequencer consumer
to query the current request state. Note that this is not the _actual_
state.

Patch 4 reworks the USB hub driver to return the actual error code from
hub_configure() in hub_probe(). This is needed in the next patch to
correctly return -EPROBE_DEFER returned by pwrseq_get() in patch 9.

Patch 5 makes the USB port device associated with a "port@" fwnode if
available. This depends on patch 1.

Patch 6 changes usb_port_is_power_on() so that |struct usb_port*| is
passed in instead of |struct usb_hub*|. This patch does not change any
functionality.

Patch 8 lets the USB hub driver look for power sequencers for each port.
Currently this only works for M.2 E-key connections, but it could be
extended to cover other cases. It should also make port reset via turning
off the port VBUS work, even when VBUS is not directly controlled by the
hub. This depends on patch 2 and 3 for the new helpers.

Patch 9 reverts an incorrectly modeled OF graph connection for the
MediaTek XHCI controller and adds a proper representation.

Patch 10 adds matching pwrseq consumer by "port@" node to the M.2 slot
driver. This is only used for the USB target, but there is no attempt
to differentiate the connection type. The driver simply tries matching
the "port@" node first, then falling back to the port parent or device's
node.

Patch 11 reworks the power sequencing targets for the E-key connector in
the pcie-m2 driver to add targets for USB and SDIO. The former is used
later on in this series.

Patches 12 and 13 enable the M.2 E-key slots (or slot-like integration)
found on MT8195 and MT8188 MediaTek-based Chromebooks. 


This series unfortunately spans multiple trees. The way I see it:

  - Patch 1 and 2 go through the driver core, and an immutable tag is
    provided to be merged together with the USB patches.

  - Patch 3 gets an ack from Bartosz, and goes through the USB tree.

  - Patch 4 through 9 (all the USB related ones) go through the USB
    tree, along with the dependencies above.

  - Patch 10 and 11 go through the power sequencing tree.

  - Patch 12 and 13 (device tree only) go through the soc tree via the
    mediatek tree.

Some of us discussed v1 at Embedded Recipes, and I believe Bartosz, Mani
and I agree on this approach. The debate is likely going to be on
whether this should be integrated into the USB core or not. I believe it
should, so that the power sequencing timing is tied to the USB port
being brought up. I do have a fallback option of just enabling the USB
power sequencing target inside the M.2 slot driver if a valid OF graph
connection is seen. But this is less desired for the reason given above.

Please have a look and share your thoughts.


Thanks
ChenYu


[1] https://lore.kernel.org/all/20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com/

Chen-Yu Tsai (13):
  device property: Add fwnode_graph_get_port_by_id()
  device property: Add fwnode_graph_get_next_port_endpoint()
  power: sequencing: Add pwrseq_power_is_on()
  usb: hub: Return actual error from hub_configure() in hub_probe()
  usb: hub: Associate port@ fwnode with USB port device
  usb: hub: Pass |struct usb_port*| to usb_port_is_power_on()
  usb: hub: Use usb_hub_set_port_power() to control port power
    everywhere
  usb: hub: Power on connected M.2 E-key connectors with power
    sequencing API
  dt-bindings: usb: mediatek,mtk-xhci: Switch to ports for USB
    connections
  power: sequencing: pcie-m2: support matching on remote "port" node
  power: sequencing: pcie-m2: Add usb and sdio targets for E-key
    connector
  arm64: dts: mediatek: mt8195-cherry: Add M.2 E-key slot
  arm64: dts: mediatek: mt8188-geralt: Add WiFi/BT as M.2 E-key slot

 .../bindings/usb/mediatek,mtk-xhci.yaml       | 17 +++-
 .../boot/dts/mediatek/mt8188-geralt.dtsi      | 92 ++++++++++++++++++-
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 73 ++++++++++++++-
 drivers/base/property.c                       | 47 ++++++++++
 drivers/power/sequencing/core.c               | 18 ++++
 drivers/power/sequencing/pwrseq-pcie-m2.c     | 52 ++++++++---
 drivers/usb/Kconfig                           |  1 +
 drivers/usb/core/hub.c                        | 78 +++++++++++-----
 drivers/usb/core/hub.h                        | 12 ++-
 drivers/usb/core/port.c                       | 62 ++++++++++++-
 include/linux/property.h                      |  3 +
 include/linux/pwrseq/consumer.h               |  1 +
 12 files changed, 401 insertions(+), 55 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

