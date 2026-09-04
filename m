Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78FD3F4822
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511335; cv=none; b=T4HISHguE3xh92gEpOsEtAflMGFDJUXj4OjTQbfjhxQ2mRTYqfuEl3SBQQYdSbASs5iTAj23SfQa9lhgy8LiQKinj83yqa9+sHh1FB43JOj33kmHG5UIj2GXmxypVIw7vC1vCoAEQXXez2MmNxSkPsp9iQGooE8Yh14plprY7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511335; c=relaxed/simple;
	bh=g4xmnLSHh073Plg+hze15SlgOcRK/r//g8ChdV6m8Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmF0eelNtsBywr4C4pB9vi7jaizZZ+4DbPAWG67A7jnitg1UC1n7mFEw0e9NewiZDIe5/j4Gjh5ebYUTMe37fnfspHymRPl3s40UlvTOR56lKsa5KDsLIdU7umqUyaQDHbwJ9hRwXnwsW/EhgBh1Ir18aXq1nEp9lvEm7HaCTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nGnqIZ/x; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nGnqIZ/x"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d71ae3455aso10323735ad.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 01:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511331; x=1789116131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NOL5R0SJrxWsGHji42XgvQwAqz+BPG+L9IvuYCKkAns=;
        b=nGnqIZ/xua2JoISuADjNLEE5oo9ncYX4pl3LvHVhyi1FeZjEqqUH0rY4pzlCmupnyP
         5C+v/b+5oaJUsLeOZ1LHnUe5QkbxSo7/zuchEqXEncFq+ZuD9+mRUDsjPlMYrF42Zjsk
         tWCXn3hJtr1uoZi3NdztG/Zpn3VNvanRIjtbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511331; x=1789116131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOL5R0SJrxWsGHji42XgvQwAqz+BPG+L9IvuYCKkAns=;
        b=Y9MMSNVva48iqhnQ+Vr/ZXIZbci6wfTiJEKE/lUSXOFTOclZBCNJkLChDlVQhFh+G1
         MNJU+545Yf4o3+1u6rKtvTLZ6cyI38Io3xKsIpqfRO8kZNvDGGmcWonsbUQCGY1QxITq
         ooNBqG4d8vSpJbfkjZNmNmJmtTAqmLenqR6FXGzEAufe1Frou/rDJMFS1ZmhAaF3ahn7
         oY57nM6bDK1B9Yq6BPsLYkWDYGXF4aWWGZv5yA1ZCeUi8uoDiK/2fzfROKBuLbGJvOpT
         JxcxhuHpE9E1jihqmTThpjcCfIjzXoEiEXTXrVsA3MN/IwQgHy118NnthCJzwwY+dCr6
         ufig==
X-Forwarded-Encrypted: i=1; AKwUvBwv4ekvseUPmRxEPJxyYAjwPbtlKjIwkGujZgBeCkIlFaVkng10YuD6m76Hkzv12OCKz3sjCX1cHw==@vger.kernel.org
X-Gm-Message-State: AFuF++lVi+rdaD3HTMIoPnnZHxOcNuNpUrYIZWcE1pUMU4mulhIa8Wl7
	uS7aFcBZXhb9GnkwfgoXx5XABf82l/+PYdNCt6HlltuR/YSI5sq06ls9yzqvv6uT7Q==
X-Gm-Gg: AYBFou3cAl478eFoC6bu8pKQfhT1tYqVKBP5WqeDSaTIv0d5BPaxmPdZrAtpYNxiB10
	by+Gag8DItYiCI9ypsDyk8S39Us72di0ouvBrqiCinxuviZEdhtoqqeEd0OToi/lXxQb8lhPOor
	O++9tBgA7q22t09knDZ2UBlS4ffshpqEbMWX+BR2oOvNcyMKnsK1hxAQ0TI69+8mu1vRMiXSzsU
	3JFQGghTFaVjMM+GvRKytjagcGaJ0wCnWHBFyzuJ2Z4iJgZoy10+4tj14C7uQHHomNhS9r0yCpA
	lH5PBhBMopp4J5DiSXop51Gj0mBe6E2sLuUeYMQVN2Sp/HM1KG5f4e+Km3KTbwWFupMWwiu/pN5
	JqsZxyx2GArDvugvOTc9ghpGDUPw+mmAU2CUwqhfLyHdsvvyKCbMsVt5tNFpZ5S9ca9bBPIS4dS
	F2U1mZV9ncJLNzSb7X4upTDv4UWhGsQaCensZQx4DrdOHjDIJ3PNiJgsg1aybVfWI+XnOpy20XC
	G4mo9i2t3LmjsKAzUZb77Vc+gstEhbRnsWowy4k1v4x
X-Received: by 2002:a17:90b:1d84:b0:396:4cbf:45a2 with SMTP id 98e67ed59e1d1-39b261e3b7fmr6052421a91.14.1788511330394;
        Fri, 04 Sep 2026 01:42:10 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:42:09 -0700 (PDT)
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
Cc: Wei Deng <wei.deng@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH v8 00/16] arm64: mediatek: Add M.2 E-key slot on Chromebooks
Date: Fri,  4 Sep 2026 16:41:39 +0800
Message-ID: <20260904084158.1341550-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v8 of my attempt at integrating the power sequencing API into
the USB core to support the USB connection on M.2 E-key slots. M.2
E-key was enabled in v7.1-rc1 with just PCIe and UART supported [1].
Hopefully this is the last revision. The fwnode patches need a reviewed-by
from the fwnode owners.

As for Sashiko's comment about fwnode_get_next_*() not putting the
reference to @prev when @node is NULL, I plan to update the kernel-doc
for all the functions in a separate patch later.

Another one of Sashiko's comments is related to dropping the wakeup-source
property from the PCIe node. AFAIK there is no alternative as there is
no longer a node to put it in.

Last, one comment from Qualcomm folks is that the port numbering
conflicts with what the dwc3 bindings specify. IMHO the dwc3 bindings
should be fixed, as the dwc3 controller embeds a XHCI for host mode,
and XHCI port numbering should follow standard USB host hardware port
numbering. I will send separate RFC patches for this.


Changes since v7:
- Mention in kernel-doc that the function does not return ports that
  have no endpoints (Sakari) (patch 1)
- Adapted to pwrseq_enable/disable() rename
- Link to v7:
  https://lore.kernel.org/all/20260724084328.3943997-1-wenst@chromium.org/

Changes since v6:
- Patch 3 (power: sequencing: Add pwrseq_get_state())
  - Adopted enum for valid return codes (Bartosz)
- Patch 10 (usb hub pwrseq integration)
  - Added braces ("{}") to for loop in hub_is_port_power_switchable() (Andy)
  - Adapted usb_port_is_power_on() to new pwrseq_get_state() function
    return values (Bartosz)
- Link to v6:
  https://lore.kernel.org/all/20260721065413.2306137-1-wenst@chromium.org/

Changes since v5:
- Patch 1 (device property: Add fwnode_graph_get_port_by_id())
  - Dropped left-over declaration in header (Sashiko)
- Patch 3 (power: sequencing: Add pwrseq_power_is_on())
  - Reverted back to returning -EINVAL if descriptor is NULL (Andy /
    Bartosz)
- Patch 6 (usb: hub: Associate port@ fwnode with USB port device)
  - Added extra |struct fwnode_handle *| local variables to shorten lines (Andy)
  - Added comment about passing fwnode_graph_get_port_by_id() return value 
    directly to device_set_node() (Andy)
- Patch 10 (usb hub pwrseq integration)
  - Only assign port_dev->pwrseq if successfully retrieved pwrseq
    descriptor (Andy)
  - Dropped the pwrseq error pointer check in the release function
    (Andy)
  - Added check for port->pwrseq != NULL before calling
    pwrseq_is_power_on() (API change from patch 3)
- Link to v5:
  https://lore.kernel.org/all/20260715085348.3457359-1-wenst@chromium.org/

Changes since v4:
- Added flags parameter to fwnode_graph_get_port_by_id() so users can
  specify whether incomplete ports are returned or not (Sashiko)
- Made pwrseq_power_is_on() return 1 if descriptor is NULL, i.e. if
  the descriptor is optional, matching the other pwrseq consumer APIs
- Added patch to swap out conditional set_bit()/clear_bit() with
  assign_bit() (split out from "usb: hub: Power on connected M.2 E-key
  connectors with power sequencing API") (Andy)
- Call fwnode_graph_get_port_by_id() with FWNODE_GRAPH_DEVICE_DISABLED
  so that even incomplete ports can be connected (Sashiko)
- Dropped unused |hdev| variable from usb_hub_remove_port_device()
  (Greg / Sashiko)
- Dropped 'extern' from usb_port_is_power_on() header declaration (Andy)

- Patch 10 (usb hub pwrseq integration)
  - Rewrote usb_port_is_power_on() to better express intent and
    restrictions of pwrseq API (Andy)
  - Switched to dev_fwnode() in port_pwrseq_is_supported() (Andy)
  - Added blank line separating normal variable declarations and __free()
    type declarations (Andy)
  - Split out assign_bit() rewrite (Andy)
  - Moved pwrseq_put() to release function to avoid UAF (Sashiko)
  - Added back pwrseq_power_off() call in usb_hub_remove_port_device();
    otherwise power off could be delayed to object release
  - Don't clear hub->ports[port1 - 1] in main error path;
    by that time the port device is registered and sysfs attributes are
    available to userspace (Sashiko)

- Dropped blank line between __free() variable declaration and
  subsequent use of the variable in conditional (Andy)
- Added patch to split Bluetooth pwrseq units (Wei)
- Link to v4:
  https://lore.kernel.org/all/20260709095726.704448-1-wenst@chromium.org/

Changes since v3:
- Added missing stub function for !POWER_SEQUENCING (patch 3) (Sashiko)
- Added missing fwnode_handle_put() (patch 5) (Sashiko)
- Added new patch to move |struct usb_port| related declarations to
  separate header (patch 6) (Andy)
- Patch 9 (usb hub pwrseq integration)
  - Adapted to move of usb_port_is_power_on() to port.c and port.h
  - Simplified usb_hub_set_port_pwrseq() (Andy)
  - Renamed usb_hub_set_port_pwrseq()'s "set" parameter to "on"
  - Dropped usb_hub_restore_port_pwrseq() (use usb_hub_set_port_pwrseq()
    with inverted argument)
  - Fixed off-by-one access in hub_is_port_power_switchable() (Sashiko)
  - Assign retval from dev_err_probe() instead of the other way around (Andy)
  - Clear hub->ports[port1 - 1] in USB port error and remove paths to
    avoid other threads from accidental UAF while the USB hub device is
    being unwound (Sashiko)
  - Short-circuit out of helpers if !IS_ENABLED(CONFIG_POWER_SEQUENCING)
    to avoid errors from stub functions (Sashiko)
- Drop redundant device node validity check; device_match_of_node()
  does it internally (patch 11) (Andy)
- Link to v3:
  https://lore.kernel.org/all/20260703110317.1283411-1-wenst@chromium.org/

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

The series is based on next-20260901.


Patch 1 and 2 add new fwnode graph helpers. These are used by the patch
5 and 8, respectively.

Patch 3 adds a new pwrseq_get_state() for power sequencer consumers
to query the current request state. Note that this is not the _actual_
state.

Patch 4 swaps out the existing conditional set_bit()/clear_bit() with
assign_bit(), which does the same thing.

Patch 5 reworks the USB hub driver to return the actual error code from
hub_configure() in hub_probe(). This is needed in the next patch to
correctly return -EPROBE_DEFER returned by pwrseq_get() in patch 9.

Patch 6 makes the USB port device associated with a "port@" fwnode if
available. This depends on patch 1.

Patch 7 moves some |struct usb_port| related stuff from hub.c and hub.h
to port.c and port.h. No actual code or functionality is changed.

Patch 8 changes usb_port_is_power_on() so that |struct usb_port*| is
passed in instead of |struct usb_hub*|. This patch does not change any
functionality.

Patch 9 changes some USB hub port power control code that directly
toggles USB_PORT_FEAT_POWER to use usb_hub_set_port_power().

Patch 10 lets the USB hub driver look for power sequencers for each port.
Currently this only works for M.2 E-key connections, but it could be
extended to cover other cases. It should also make port reset via turning
off the port VBUS work, even when VBUS is not directly controlled by the
hub. This depends on patch 2 and 3 for the new helpers.

Patch 11 reverts an incorrectly modeled OF graph connection for the
MediaTek XHCI controller and adds a proper representation.

Patch 12 adds matching pwrseq consumer by "port@" node to the M.2 slot
driver. This is only used for the USB target, but there is no attempt
to differentiate the connection type. The driver simply tries matching
the "port@" node first, then falling back to the port parent or device's
node.

Patch 13 reworks the power sequencing targets for the E-key connector in
the pcie-m2 driver to add targets for USB and SDIO. The former is used
later on in this series.

Patch 14 splits the Bluetooth power sequencing unit so that the USB and
serdev consumers can separately toggle the actual state of W_DISABLE#2.
This patch is purposefully not squashed into the previous one to provide
a clear target for discussions.

Patches 15 and 16 enable the M.2 E-key slots (or slot-like integration)
found on MT8195 and MT8188 MediaTek-based Chromebooks. 


This series unfortunately spans multiple trees. The way I see it:

  - Patches 1 and 2 go through the driver core, and an immutable tag is
    provided to be merged together with the USB patches.

  - Patch 3 has an ack from Bartosz, and goes through the USB tree. But
    Bartosz also wants an immutable branch/tag to have a copy in the
    pwrseq tree.

  - Patches 4 through 11 (all the USB related ones) go through the USB
    tree, along with the dependencies above.

  - Patches 12 through 14 go through the power sequencing tree.

  - Patches 15 and 16 (device tree only) go through the soc tree via the
    mediatek tree.

Some of us discussed v1 at Embedded Recipes, and I believe Bartosz, Mani
and I agree on this approach. The debate is likely going to be on
whether this should be integrated into the USB core or not. I believe it
should, so that the power sequencing timing is tied to the USB port
being brought up. I do have a fallback option of just enabling the USB
power sequencing target inside the M.2 slot driver if a valid OF graph
connection is seen. But this is less desired for the reason given above.

I hope we can get this merged in this cycle for v7.4.


Thanks
ChenYu


[1] https://lore.kernel.org/all/20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com/

Chen-Yu Tsai (16):
  device property: Add fwnode_graph_get_port_by_id()
  device property: Add fwnode_graph_get_next_port_endpoint()
  power: sequencing: Add pwrseq_get_state()
  usb: hub: Use assign_bit() in usb_hub_set_port_power()
  usb: hub: Return actual error from hub_configure() in hub_probe()
  usb: hub: Associate port@ fwnode with USB port device
  usb: core: Move struct usb_port and related APIs to port.h
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
  power: sequencing: pcie-m2: Split Bluetooth unit based on interface
  arm64: dts: mediatek: mt8195-cherry: Add M.2 E-key slot
  arm64: dts: mediatek: mt8188-geralt: Add WiFi/BT as M.2 E-key slot

 .../bindings/usb/mediatek,mtk-xhci.yaml       |  17 ++-
 .../boot/dts/mediatek/mt8188-geralt.dtsi      |  92 +++++++++++++++-
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |  73 ++++++++++++-
 drivers/base/property.c                       |  56 ++++++++++
 drivers/power/sequencing/core.c               |  19 ++++
 drivers/power/sequencing/pwrseq-pcie-m2.c     |  64 ++++++++---
 drivers/usb/Kconfig                           |   1 +
 drivers/usb/core/hub.c                        |  72 ++++++------
 drivers/usb/core/hub.h                        |  58 ++--------
 drivers/usb/core/port.c                       | 103 +++++++++++++++++-
 drivers/usb/core/port.h                       |  68 ++++++++++++
 include/linux/property.h                      |   4 +
 include/linux/pwrseq/consumer.h               |  12 ++
 13 files changed, 527 insertions(+), 112 deletions(-)
 create mode 100644 drivers/usb/core/port.h

-- 
2.55.0.979.g7e5102b832-goog

