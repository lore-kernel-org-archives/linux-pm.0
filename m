From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: -mm:
 pnp-do-not-stop-start-devices-in-suspend-resume-path.patch
 breaks resuming isapnp cards
Date: Tue, 15 Jan 2008 08:51:35 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801150842480.7446__20550.3994868652$1200411773$gmane$org@tm8103.perex-int.cz>
References: <200801092343.48726.linux@rainbow-software.org>
	<200801122250.44220.bjorn.helgaas@hp.com>
	<4789AC0F.9030007@keyaccess.nl>
	<200801141526.57744.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801141526.57744.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Ondrej Zary <linux@rainbow-software.org>, Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Linux Kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Pierre Ossman <drzeus@drzeus.cx>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Jan 2008, Bjorn Helgaas wrote:

> On Saturday 12 January 2008 11:13:35 pm Rene Herman wrote:
> > ... And, now that I have your attention, while it's 
> > not important to the issue anymore with the tests removed as the submitted 
> > patch did, do you have an opinion on (include/linux/pnp.h):
> > 
> > /* pnp driver flags */
> > #define PNP_DRIVER_RES_DO_NOT_CHANGE    0x0001  /* do not change the state 
> > of the device */
> > #define PNP_DRIVER_RES_DISABLE          0x0003  /* ensure the device is 
> > disabled */
> > 
> > I find DISABLE including DO_NOT_CHANGE rather unexpected...
> 
> I don't know the history of those flags, but I wish they didn't exist.

Ok, something to explain. These flags exists to allow drivers to 
manually configure (override) PnP resources at init time - we know - for 
example in ALSA - that some combinations simply does not work for all 
soundcards.

The DISABLE flags simply tells core PnP layer - driver will handle 
resource allocation itself, don't do anything, just disable hw physically 
and do not change (allocate) any resources. Value 0x03 is valid in this 
semantics.

Unfortunately, suspend / resume complicates things a bit, but PnP core can 
handle DO_NOT_CHANGE flag. But it will just mean - _preserve_ resource 
allocation from last suspend state for this device and enable hw 
physically before calling resume() callback.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
