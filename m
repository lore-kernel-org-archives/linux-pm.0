From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4/7] vga_switcheroo: Deduplicate power state tracking
Date: Sun, 18 Feb 2018 09:38:32 +0100
Message-ID: <9ad7283c32362192a6f3a4d815be24018419394f.1518941073.git.lukas@wunner.de>
References: <cover.1518941072.git.lukas@wunner.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:58377 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeBRIkc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Feb 2018 03:40:32 -0500
In-Reply-To: <cover.1518941072.git.lukas@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: Peter Wu <peter@lekensteyn.nl>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Pierre Moreau <pierre.morrow@free.fr>, Bastien Nocera <hadess@hadess.net>

If DRM drivers use runtime PM, they currently notify vga_switcheroo
whenever they ->runtime_suspend or ->runtime_resume to update
vga_switcheroo's internal power state tracking.

That's essentially a duplication of a functionality performed by the
PM core as it already tracks the GPU's power state and vga_switcheroo
can always query it.

Introduce a new internal helper vga_switcheroo_pwr_state() which does
just that if runtime PM is used, or falls back to vga_switcheroo's
internal power state tracking if manual power control is used.
Drop a redundant power state check in set_audio_state() while at it.

This removes one of the two purposes of the notification mechanism
implemented by vga_switcheroo_set_dynamic_switch().  The other one is
power management of the audio device and we'll remove that next.

Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Peter Wu <peter@lekensteyn.nl>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/gpu/vga/vga_switcheroo.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 09dd40dd1dbe..2488af797020 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -92,7 +92,8 @@
  * struct vga_switcheroo_client - registered client
  * @pdev: client pci device
  * @fb_info: framebuffer to which console is remapped on switching
- * @pwr_state: current power state
+ * @pwr_state: current power state if manual power control is used.
+ *	For driver power control, call vga_switcheroo_pwr_state().
  * @ops: client callbacks
  * @id: client identifier. Determining the id requires the handler,
  *	so gpus are initially assigned VGA_SWITCHEROO_UNKNOWN_ID
@@ -406,6 +407,19 @@ bool vga_switcheroo_client_probe_defer(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(vga_switcheroo_client_probe_defer);
 
+static enum vga_switcheroo_state
+vga_switcheroo_pwr_state(struct vga_switcheroo_client *client)
+{
+	if (client->driver_power_control)
+		if (pm_runtime_enabled(&client->pdev->dev) &&
+		    pm_runtime_active(&client->pdev->dev))
+			return VGA_SWITCHEROO_ON;
+		else
+			return VGA_SWITCHEROO_OFF;
+	else
+		return client->pwr_state;
+}
+
 /**
  * vga_switcheroo_get_client_state() - obtain power state of a given client
  * @pdev: client pci device
@@ -425,7 +439,7 @@ enum vga_switcheroo_state vga_switcheroo_get_client_state(struct pci_dev *pdev)
 	if (!client)
 		ret = VGA_SWITCHEROO_NOT_FOUND;
 	else
-		ret = client->pwr_state;
+		ret = vga_switcheroo_pwr_state(client);
 	mutex_unlock(&vgasr_mutex);
 	return ret;
 }
@@ -598,7 +612,7 @@ static int vga_switcheroo_show(struct seq_file *m, void *v)
 			   client_is_vga(client) ? "" : "-Audio",
 			   client->active ? '+' : ' ',
 			   client->driver_power_control ? "Dyn" : "",
-			   client->pwr_state ? "Pwr" : "Off",
+			   vga_switcheroo_pwr_state(client) ? "Pwr" : "Off",
 			   pci_name(client->pdev));
 		i++;
 	}
@@ -641,7 +655,7 @@ static void set_audio_state(enum vga_switcheroo_client_id id,
 	struct vga_switcheroo_client *client;
 
 	client = find_client_from_id(&vgasr_priv.clients, id | ID_BIT_AUDIO);
-	if (client && client->pwr_state != state) {
+	if (client) {
 		client->ops->set_gpu_state(client->pdev, state);
 		client->pwr_state = state;
 	}
@@ -656,7 +670,7 @@ static int vga_switchto_stage1(struct vga_switcheroo_client *new_client)
 	if (!active)
 		return 0;
 
-	if (new_client->pwr_state == VGA_SWITCHEROO_OFF)
+	if (vga_switcheroo_pwr_state(new_client) == VGA_SWITCHEROO_OFF)
 		vga_switchon(new_client);
 
 	vga_set_default_device(new_client->pdev);
@@ -695,7 +709,7 @@ static int vga_switchto_stage2(struct vga_switcheroo_client *new_client)
 	if (new_client->ops->reprobe)
 		new_client->ops->reprobe(new_client->pdev);
 
-	if (active->pwr_state == VGA_SWITCHEROO_ON)
+	if (vga_switcheroo_pwr_state(active) == VGA_SWITCHEROO_ON)
 		vga_switchoff(active);
 
 	set_audio_state(new_client->id, VGA_SWITCHEROO_ON);
@@ -940,8 +954,7 @@ EXPORT_SYMBOL(vga_switcheroo_process_delayed_switch);
  * command line disables it.
  *
  * When the driver decides to power up or down, it notifies vga_switcheroo
- * thereof so that it can (a) power the audio device on the GPU up or down,
- * and (b) update its internal power state representation for the device.
+ * thereof so that it can power the audio device on the GPU up or down.
  * This is achieved by vga_switcheroo_set_dynamic_switch().
  *
  * After the GPU has been suspended, the handler needs to be called to cut
@@ -985,9 +998,8 @@ static void vga_switcheroo_power_switch(struct pci_dev *pdev,
  *
  * Helper for GPUs whose power state is controlled by the driver's runtime pm.
  * When the driver decides to power up or down, it notifies vga_switcheroo
- * thereof using this helper so that it can (a) power the audio device on
- * the GPU up or down, and (b) update its internal power state representation
- * for the device.
+ * thereof using this helper so that it can power the audio device on the GPU
+ * up or down.
  */
 void vga_switcheroo_set_dynamic_switch(struct pci_dev *pdev,
 				       enum vga_switcheroo_state dynamic)
@@ -1001,7 +1013,6 @@ void vga_switcheroo_set_dynamic_switch(struct pci_dev *pdev,
 		return;
 	}
 
-	client->pwr_state = dynamic;
 	set_audio_state(client->id, dynamic);
 	mutex_unlock(&vgasr_mutex);
 }
-- 
2.15.1
