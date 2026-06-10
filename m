Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C53AFD08
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080881; cv=none; b=injhlSwCGsnqSRHzv5QlY4sqMEvgsScOdKL1O8L0SPI5WIC+IYtQX4v0NN/LpJQqNdG7YsMl3DewN9OOz+Ok/Ko72xtIsyS5/6xXCCCigNBsay/AZUR0/X18xLh3L0/fNeWOecWphxkKsJ7NMKPZvmYVcWeJc4zcmutxl31NdVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080881; c=relaxed/simple;
	bh=ZuOVxM6SCrtrNZ59Qzz16xkLgZG0V6ly6c5cBQo7Q3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGotmUjUhrhxEjq8f08DuEPd/MBjtqcJiD9p7uKH+3/In3T9razpFosU/oTFwLENXQ9pSIwgRfcuUaGP82Z8CceoNXjv3E2N/uOGr+V/mEehP4iT4fFj3LWDGw0uFxj8fBX71w63pf1ctuHIIpJ8MQkO4S0gj6NUskjlEjKfn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JPrvhs+W; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JPrvhs+W"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0c2d792c8so43476585ad.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080879; x=1781685679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t8gJIv7IXV+GGLqttV7BJHv8HtnJej0L7a6gfaEYMf4=;
        b=JPrvhs+WDBmaJ7x/7TbuEcdDiDOj22yLg0O0dBD5qyuIhw5WZmsrJWUUChf06pzpjH
         CPNICFAopld2sYS+9Dgf2rVSXAs5gN72yUWQ21E6BWmUoQjPnadHthKi7bDZOzDPDdp8
         eM39MpbZ1fRRATKGSSt7NlKThB0pugnmLnH/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080879; x=1781685679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8gJIv7IXV+GGLqttV7BJHv8HtnJej0L7a6gfaEYMf4=;
        b=KhHj3nC4vNWMJlI994C6K2SkS2DFQGGL/3NXy3andGiZOv9tsd/5u/b/ldwSsrobXj
         rEc6fiGoKmGrdk0pHg93ZkuurjUYTlrjN3hiyTU+3u4JlVF8etxSQWo1Q6c/5vAIgOtn
         ipwVP+lKY9eggtSGCG82AKFIYFmgU1BT44XoNchhHeSuaB7AStwBY57qg71HyRtFpqFh
         0c96fYllMdlMxspqvVCvPxiCbKldW2ZUe/8KWIu9KliLVnHmvxiPg2Eo7pTLYcfnzof3
         i/6d486DRjVEKKh85cnkKIwSDa4ybjtEjPmdWpSRv7yKLZ+Iz+hRkTJcsf1VU8v+oues
         Kkkw==
X-Forwarded-Encrypted: i=1; AFNElJ9Yu9r5hM95spVo7SmIrHjIqs8wusBU23Yc5IVuJ5aL+1UhZ2kGw92Xn+wroUdFPhuZGfwQUIYZOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFbHf6wTu+wbLKc6BUlcgR9PRKb3oJFK1fzDeeRPXTqtcNtHZ
	7spKSFuLVu1HCS3O6Ba1sWD9cXIAf963t+uWiJNDXEgpkcnTpbS1M2sAcdRVLGFwgQ==
X-Gm-Gg: Acq92OEl3ys9JO819lCIQNkR3dX/Bo4rxaRLE5V1FkDMLG17THB9CVFQEhx9RpJ+o3t
	Myr/EeSr9MM+w3vQGC34rr6HAUEq6lYLe572PxSYe9rXD8U3JQ4UOzo3d7PmX/OytGQUeOhEywg
	clX1ejdwkHUxVJ0BCPHrO1LVL2bxSwZza5L5pD+XSLUOT1ES13eSWFSz4Pwo6KBOG+GJK9vufZ7
	LJHFL7dPKdCKhO5O7Hcn1XHzvqO3YI+ofjScVu13cE7Fhkl1k2v4yAfBu0kXHUUZFRD8d9v6be5
	ATkdCkODQ0xoHxaJQJVeVv+dV33H0izopVPDai5BvpmNty3iQfmcVd/KHhx0sBA4XBHSkFWUpal
	0qu6Na0+fz6UrRY+BmY9H9lk3RFSkmpq7mA2sU2WJiAXEEA7opcpfj0B4JrHyGD12K52cOPuwvk
	8VinKx1AxtNMOV/5fSHEYR+sVCrgBtDa+0kmmchLc+dOUaYssDVBwEaZUP/N7CPNTRkmlq5BYFg
	vJbZDCwDYE7teNiYw==
X-Received: by 2002:a17:903:1b67:b0:2c2:c0db:964a with SMTP id d9443c01a7336-2c2c0db9991mr33186765ad.26.1781080878941;
        Wed, 10 Jun 2026 01:41:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:41:18 -0700 (PDT)
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
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 00/16] arm64: mediatek: Add M.2 E-key slot on Chromebooks
Date: Wed, 10 Jun 2026 16:40:34 +0800
Message-ID: <20260610084053.2059858-1-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v2 of my attempt at integrating the power sequencing API into
the USB core to support the USB connection on M.2 E-key slots. M.2
E-key was enabled in v7.1-rc1 with just PCIe and UART supported [1].

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

The series is based on next-20260608.


Patch 1 and 2 add new fwnode graph helpers. These are used by the patch
5 and 7, respectively.

Patch 3 changes the power sequencing framework's Kconfig symbol from
tristate to bool. This is needed as the USB core is bool. And since a
later patch introduces power sequencing API usage to the USB core, the
power sequencing framework cannot be built as a module anymore. This
patch needs to go in with "usb: hub: Power on connected M.2 E-key
connectors", or we will get allmodconfig build failures.

Patch 4 reworks the USB hub driver to return the actual error code from
hub_configure() in hub_probe(). This is needed in the next patch to
correctly return -EPROBE_DEFER returned by pwrseq_get() in patch 7.

Patch 5 makes the USB port device associated with a "port@" fwnode if
available. This depends on patch 1.

Patch 6 changes usb_port_is_power_on() so that |struct usb_port*| is
passed in instead of |struct usb_hub*|. This patch does not change any
functionality.

Patch 7 lets the USB hub driver look for power sequencers for each port.
Currently this only works for M.2 E-key connections, but it could be
extended to cover other cases. It should also make port reset via turning
off the port VBUS work, even when VBUS is not directly controlled by the
hub. This depends on patch 2 (for the new helper) and patch 3 (to avoid
allmodconfig link failures).

Patch 8 reverts an incorrectly modeled OF graph connection for the
MediaTek XHCI controller.

Patch 9 then adds a proper representation.

Patch 10 adds matching pwrseq consumer by "port@" node to the M.2 slot
driver. This is only used for the USB target, but there is no attempt
to differentiate the connection type. The driver simply tries matching
the "port@" node first, then falling back to the port parent or device's
node.

Patch 11 reworks the power sequencing targets for the E-key connector in
the pcie-m2 driver to add targets for USB and SDIO. The former is used
later on in this series.

Patches 12 through 16 enable the M.2 E-key slots (used for WiFi/BT) and
USB type-A connectors found on MediaTek-based Chromebooks. These are
provided in this series for reference. The USB type-A connector changes,
while not directly related, have overlapping context, and was easier to
include. They were also used to test some extra local changes I tried
to convert the USB A connector from an onboard USB device to a power
sequencing provider.


This series unfortunately spans multiple trees. The way I see it:

  - Patch 1 and 2 go through the driver core, and an immutable tag is
    provided to be merged together with the USB patches.

  - Patch 3 gets an ack from Bartosz, and goes through the USB tree.

  - Patch 4 through 9 (all the USB related ones) go through the USB
    tree, along with the dependencies above.

  - Patch 10 and 11 go through the power sequencing tree.

  - Patch 12 through 16 (device tree only) go through the soc tree via
    the mediatek tree.

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

Chen-Yu Tsai (16):
  device property: Add fwnode_graph_get_port_by_id()
  device property: Add fwnode_graph_get_next_port_endpoint()
  power: sequencing: Change CONFIG_POWER_SEQUENCING to bool
  usb: hub: Return actual error from hub_configure() in hub_probe()
  usb: hub: Associate port@ fwnode with USB port device
  usb: hub: Pass |struct usb_port*| to usb_port_is_power_on()
  usb: hub: Power on connected M.2 E-key connectors
  Revert "dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed
    EP"
  dt-bindings: usb: mediatek,mtk-xhci: Allow ports for USB connections
  power: sequencing: pcie-m2: support matching on remote "port" node
  power: sequencing: pcie-m2: Add usb and sdio targets for E-key
    connector
  arm64: dts: mediatek: mt8192-asurada: Add USB type-A connector
  arm64: dts: mediatek: mt8192-asurada: Add M.2 E-key slot
  arm64: dts: mediatek: mt8195-cherry: Add M.2 E-key slot
  arm64: dts: mediatek: mt8195-cherry: Add USB type-A connector
  arm64: dts: mediatek: mt8188-geralt: Add WiFi/BT as M.2 E-key slot

 .../bindings/usb/mediatek,mtk-xhci.yaml       |  17 +-
 .../boot/dts/mediatek/mt8188-geralt.dtsi      |  93 ++++++++++-
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 139 +++++++++++++++--
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 147 +++++++++++++++++-
 drivers/base/property.c                       |  55 +++++++
 drivers/power/sequencing/Kconfig              |   2 +-
 drivers/power/sequencing/pwrseq-pcie-m2.c     |  50 ++++--
 drivers/usb/core/hub.c                        |  55 +++++--
 drivers/usb/core/hub.h                        |   6 +-
 drivers/usb/core/port.c                       |  72 ++++++++-
 include/linux/property.h                      |   3 +
 11 files changed, 583 insertions(+), 56 deletions(-)

-- 
2.54.0.1099.g489fc7bff1-goog

