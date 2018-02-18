From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 3/7] vga_switcheroo: Update PCI current_state on power change
Date: Sun, 18 Feb 2018 09:38:32 +0100
Message-ID: <847bcea7d76adfe74abb32fc3da66f5c3cfe8203.1518941073.git.lukas@wunner.de>
References: <cover.1518941072.git.lukas@wunner.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:36325 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeBRIkF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Feb 2018 03:40:05 -0500
In-Reply-To: <cover.1518941072.git.lukas@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: Peter Wu <peter@lekensteyn.nl>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Pierre Moreau <pierre.morrow@free.fr>, Bastien Nocera <hadess@hadess.net>

When cutting power to a GPU and its integrated HDA controller, their
cached current_state should be updated to D3cold to reflect reality.

We currently rely on the DRM and HDA drivers to do that, however:

- The HDA driver updates the current_state in azx_vs_set_state(), which
  will no longer be called with driver power control once we migrate to
  device links.  (It will still be called with manual power control.)

- If the HDA device is not bound, its current_state remains at D0 even
  though the GPU driver may decide to go to D3cold.

- The DRM drivers update the current_state using pci_set_power_state()
  which can't put the device into a deeper power state than D3hot if the
  GPU is not deemed power-manageable by the platform (even though it
  *is* power-manageable by some nonstandard means, such as a _DSM).

Centralize updating the current_state of the GPU and HDA controller in
vga_switcheroo's ->runtime_suspend hook to overcome these deficiencies.

The GPU and HDA controller are two functions of the same PCI device
(VGA class device on function 0 and audio device on function 1) and
no other PCI devices reside on the same bus since this is a PCIe
point-to-point link, so we can just walk the bus and update the
current_state of all devices.

On ->runtime_resume, the HDA controller is in D0uninitialized state.
Resume to D0active and then let it autosuspend as it sees fit.

Note that vga_switcheroo_init_domain_pm_ops() is not supposed to be
called by hybrid graphics laptops which power down the GPU via its root
port's _PR3 resources and consequently vga_switcheroo_runtime_suspend()
is not used.  On those laptops, the root port is power-manageable by the
platform (instead of by a nonstandard means) and the current_state is
therefore updated by the PCI core through the following call chain:

  pci_set_power_state()
    __pci_complete_power_transition()
      pci_bus_set_current_state()

Resuming to D0active happens through:

  pci_set_power_state()
    __pci_start_power_transition()
      pci_wakeup_bus()

Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Peter Wu <peter@lekensteyn.nl>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/gpu/vga/vga_switcheroo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 3cd153c6d271..09dd40dd1dbe 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -1022,6 +1022,7 @@ static int vga_switcheroo_runtime_suspend(struct device *dev)
 		vgasr_priv.handler->switchto(VGA_SWITCHEROO_IGD);
 		mutex_unlock(&vgasr_priv.mux_hw_lock);
 	}
+	pci_bus_set_current_state(pdev->bus, PCI_D3cold);
 	vga_switcheroo_power_switch(pdev, VGA_SWITCHEROO_OFF);
 	mutex_unlock(&vgasr_mutex);
 	return 0;
@@ -1035,6 +1036,7 @@ static int vga_switcheroo_runtime_resume(struct device *dev)
 	mutex_lock(&vgasr_mutex);
 	vga_switcheroo_power_switch(pdev, VGA_SWITCHEROO_ON);
 	mutex_unlock(&vgasr_mutex);
+	pci_wakeup_bus(pdev->bus);
 	ret = dev->bus->pm->runtime_resume(dev);
 	if (ret)
 		return ret;
-- 
2.15.1
