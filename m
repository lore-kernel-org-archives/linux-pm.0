From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [alsa-devel] PNP_DRIVER_RES_DISABLE breaks swsusp at
	least with snd_cs4236
Date: Sat, 12 Jan 2008 20:01:58 +0100
Message-ID: <200801122001.59174.rjw__18637.766413349$1200164485$gmane$org@sisk.pl>
References: <200801092343.48726.linux@rainbow-software.org>
	<20080112121256.0f2e96ad@poseidon.drzeus.cx>
	<4788C323.6090206@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4788C323.6090206@keyaccess.nl>
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
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Ondrej Zary <linux@rainbow-software.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Pavel Machek <pavel@suse.cz>, Pierre Ossman <drzeus@drzeus.cx>, linux-pm@lists.linux-foundation.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, 12 of January 2008, Rene Herman wrote:
> On 12-01-08 12:12, Pierre Ossman wrote:
> 
> > On Sat, 12 Jan 2008 02:23:27 +0100
> > Rene Herman <rene.herman@keyaccess.nl> wrote:
> > 
> >> Pavel, Rafael -- the attached fixes snd-cs4236 not coming back to life for 
> >> Ondrej after hibernation due to the PNP_DRIVER_RES_DO_NOT_CHANGE test 
> >> triggering in pnp_bus_resume() and keeping the card in a suspended state.
> >>
> > 
> > I'm a bit confused here. Bjorn Helgaas wanted to remove the pnp_start/stop_dev() calls completely, and you want them called all the time. :)
> 
> Wanted where? Haven't seen a coment from Bjorn? But -- while removing them 
> both looks (as) sensible from a mirror-image viewpoint, this wouldn't fix 
> the problem.
> 
> As fas as I understand things, "hibernation" is basically "save state, shut 
> down machine" where the latter step is going to disable the card inevitably.

Not exactly.  In the ACPI (aka platform) mode it's:
- pretend we're suspending and put everything into low power states
- snapshot memory
- power everything up
- save image
- suspend (ie. enter S4, suspending devices before).
 
> On resume, you're going to need to restore the resources (that were saved in 
> pnp_dev->res) that it was using to the card, which is what pnp_start_dev() 
> does -- it not being called is the current problem of the card not coming 
> back to life.

First of all, the card need not be initialized at all before .resume() is called.

> pnp_stop_dev() could go in this specific situation. Not much point in first 
> disabling the thing it seems if a subsequent shutdown is going to take care 
> of that anyway. However, suspend/resume isn't just called in the case of 
> complete hibernation I guess and I know nothing about it all -- hence my 
> request to the hiberhation people for how this is designed to be.

.suspend()/.resume() are used during suspend to RAM too.  As far as hibernation
is concerned, .resume() is used for two different purposes:
(a) to bring the device up after it's been put into a low power state for
    snapshotting memory
(b) to bring the device up (or reconfigure it if brought up already) after the
    hibernation image has been loaded and we're restoring the previous
    system state.

> But we certainly need the pnp_start_dev() in the current flow of things. It 
> not being called is the problem this fixes...

Yes, pnp_start_dev() is generally needed in .resume().

Thanks,
Rafael
