From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: -mm:
	pnp-do-not-stop-start-devices-in-suspend-resume-path.patch
	breaks resuming isapnp cards
Date: Mon, 14 Jan 2008 15:26:56 -0700
Message-ID: <200801141526.57744.bjorn.helgaas__22234.0918648571$1200349694$gmane$org@hp.com>
References: <200801092343.48726.linux@rainbow-software.org>
	<200801122250.44220.bjorn.helgaas@hp.com>
	<4789AC0F.9030007@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4789AC0F.9030007@keyaccess.nl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Ondrej Zary <linux@rainbow-software.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Pavel Machek <pavel@suse.cz>, Pierre Ossman <drzeus@drzeus.cx>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 12 January 2008 11:13:35 pm Rene Herman wrote:
> ... And, now that I have your attention, while it's 
> not important to the issue anymore with the tests removed as the submitted 
> patch did, do you have an opinion on (include/linux/pnp.h):
> 
> /* pnp driver flags */
> #define PNP_DRIVER_RES_DO_NOT_CHANGE    0x0001  /* do not change the state 
> of the device */
> #define PNP_DRIVER_RES_DISABLE          0x0003  /* ensure the device is 
> disabled */
> 
> I find DISABLE including DO_NOT_CHANGE rather unexpected...

I don't know the history of those flags, but I wish they didn't exist.
They really look like warts in the PNP core code.  They're used so
infrequently and without obvious rationale, that it seems like it'd
be better if there were a way to deal with them inside the driver.

But to answer your question, I don't know enough to have an opinion
on whether DISABLE should include DO_NOT_CHANGE.

> By the way, I also still have this next one outstanding for you... :-/
> 
> http://lkml.org/lkml/2008/1/9/168

This had to do with the excessive warnings about exceeding the maximum
number of resources for a PNP device.  This should be resolved by Len's
patch here:

  http://bugzilla.kernel.org/show_bug.cgi?id=9535#c10

We all agree this is a stop-gap, and for 2.6.25, we need the real
solution of making PNP resources fully dynamic.

Bjorn
