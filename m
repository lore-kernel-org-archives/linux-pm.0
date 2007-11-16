From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] snd hda suspend latency: shorten codec read
Date: Fri, 16 Nov 2007 13:58:24 +0100
Message-ID: <20071116125824.GA28082__33186.9576163173$1195218015$gmane$org@elte.hu>
References: <20071115181418.GA6603@ucw.cz> <473C825E.3030307@rtr.ca>
	<20071115193424.GA31691@elte.hu> <20071115193612.GA751@elte.hu>
	<473CC6D4.2010909@rtr.ca> <20071116055531.GA16273@elte.hu>
	<20071116071522.GA1453@elte.hu> <20071116082146.GA14685@elte.hu>
	<20071116112317.GA12724@elte.hu> <20071116124319.GA21978@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071116124319.GA21978@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Lord <lkml@rtr.ca>, perex@perex.cz, Takashi Iwai <tiwai@suse.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


snd hda suspend latency goes down a second via the patch below.

	Ingo

------------->
Subject: snd hda suspend latency: shorten codec read
From: Ingo Molnar <mingo@elte.hu>

not sleeping for every codec read/write but doing a short udelay and
a conditional reschedule has cut suspend+resume latency by about 1
second on my T60.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 sound/pci/hda/hda_intel.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux/sound/pci/hda/hda_intel.c
===================================================================
--- linux.orig/sound/pci/hda/hda_intel.c
+++ linux/sound/pci/hda/hda_intel.c
@@ -555,7 +555,8 @@ static unsigned int azx_rirb_get_respons
 		}
 		if (!chip->rirb.cmds)
 			return chip->rirb.res; /* the last value */
-		schedule_timeout_uninterruptible(1);
+		udelay(10);
+		cond_resched();
 	} while (time_after_eq(timeout, jiffies));
 
 	if (chip->msi) {
