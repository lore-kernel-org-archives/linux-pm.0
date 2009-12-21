From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Async suspend-resume patch w/ completions (was:
	Re:	Async?suspend-resume patch w/ rwsems)
Date: Mon, 21 Dec 2009 12:20:42 +0100
Message-ID: <20091221112042.GA12133__16693.3023058393$1261590067$gmane$org@suse.cz>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0912191557320.3712@localhost.localdomain>
	<20091220024142.GC4073@core.coreip.homeip.net>
	<200912202025.25618.rjw@sisk.pl>
	<20091221073915.GC3234@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091221073915.GC3234@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 20, 2009 at 11:39:15PM -0800, Dmitry Torokhov wrote:

> > On the nx6325 that appears to reduce the suspend time as much so the effect
> > of async is not visible any more.  On the Wind it decreases the total suspend
> > time almost by half!
> > 
> > Please push this patch to Linus. :-)
> > 
> 
> Let's see if I manage to solicit some testers first. FWIW it seems to be
> working on my boxes.
> 
> But if this works then I am not sure we even want to bother with async
> suspend of i8042 and serios. And serio already does resume
> asynchronously through kseriod.

I'm kind of wondering where this will break, but I don't remember why
the RESET_BAT was put in exactly - the point of making sure the BIOS
doesn't get confused by the advanced modes is correct, and is required
at least when a keyboard is set to "Set 3", but RESET_BAT is a too heavy
hammer anyway - we could just make sure to switch the kbd/mouse to
'default' modes instead of doing a full reset.

-- 
Vojtech Pavlik
Director SuSE Labs
