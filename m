From: Anshuman Gupta <anshuman.gupta@intel.com>
Subject: [PATCH v2 0/1] cover-letter hdac-codec runtime suspended at PM:Suspend.
Date: Sat, 18 Aug 2018 23:42:02 +0530
Message-ID: <1534615923-8541-1-git-send-email-anshuman.gupta@intel.com>
References: <CAJZ5v0hyk=jto8Wt0er==YmKEsgvfvZhO2wDbGOhxZaWWCNgBg@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hyk=jto8Wt0er==YmKEsgvfvZhO2wDbGOhxZaWWCNgBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: puneethx.prabhu@intel.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, rafael@kernel.org
Cc: alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, anshuman.gupta@intel.com
List-Id: linux-pm@vger.kernel.org

Current implementation of hdac hdmi codec driver uses its
suspend/resume operation callback in its prepare/complete callback
which has issues with hdac direct-complete, it has been reviewed earlier
that hdac hdmi codec driver requires a rework
(https://patchwork.kernel.org/patch/10276021/),
but as there is no rework with driver, it require to fix hdac direct complete
issue to leverage hdac direct complete in order to optimize its resume latency
while resuming from system wide suspend.

Anshuman Gupta (1):
  hdac-codec runtime suspended at PM:Suspend.

 sound/soc/codecs/hdac_hdmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.7.4
