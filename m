From: Anshuman Gupta <anshuman.gupta@intel.com>
Subject: [PATCH v2 1/1] hdac-codec runtime suspended at PM:Suspend.
Date: Sat, 18 Aug 2018 23:42:03 +0530
Message-ID: <1534615923-8541-2-git-send-email-anshuman.gupta@intel.com>
References: <CAJZ5v0hyk=jto8Wt0er==YmKEsgvfvZhO2wDbGOhxZaWWCNgBg@mail.gmail.com>
 <1534615923-8541-1-git-send-email-anshuman.gupta@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534615923-8541-1-git-send-email-anshuman.gupta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: puneethx.prabhu@intel.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, rafael@kernel.org
Cc: alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, anshuman.gupta@intel.com
List-Id: linux-pm@vger.kernel.org

Keep hdac hdmi codec to be in runtime suspended while entering to
system wide suspend. Currently hdac hdmi codec driver using its
suspend and resume operation in prepare and complete PM callbacks,
and it resumes the hd audio controller (parent of self) from runtime
suspend and blocks the direct complete for hd audio controller.

If hdac-codec is already in runtime suspend state skip its power down
sequence in prepare, power up sequence in complete phase. It enables
direct complete path for hdac-codec and hd audio controller
PCI device.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
Changes in v2
- Changed the commit message.
- Using pm_runtime_suspended instead of pm_runtime_status_suspended
  in order to handle any race condition. 
 
sound/soc/codecs/hdac_hdmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 84f7a7a..e965338 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1859,6 +1859,9 @@ static int hdmi_codec_prepare(struct device *dev)
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdev = &edev->hdev;
 
+	if (pm_runtime_suspended(dev))
+		return 1;
+
 	pm_runtime_get_sync(&edev->hdev.dev);
 
 	/*
@@ -1880,6 +1883,9 @@ static void hdmi_codec_complete(struct device *dev)
 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
 	struct hdac_device *hdev = &edev->hdev;
 
+	if (pm_runtime_suspended(dev))
+		return;
+
 	/* Power up afg */
 	snd_hdac_codec_read(hdev, hdev->afg, 0,	AC_VERB_SET_POWER_STATE,
 							AC_PWRST_D0);
-- 
2.7.4
