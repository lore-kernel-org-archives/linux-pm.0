From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Tue, 26 May 2009 07:50:08 +1000
Message-ID: <1243288208.16743.125.camel__37860.2395220243$1243288240$gmane$org@nigel-laptop>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<1243243666.16743.64.camel@nigel-laptop>
	<20090525123228.GA13446@elf.ucw.cz>
	<200905251522.26852.oliver@neukum.org>
	<20090525132613.GA14096@elf.ucw.cz>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090525132613.GA14096@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

Hi.

On Mon, 2009-05-25 at 15:26 +0200, Pavel Machek wrote:
> On Mon 2009-05-25 15:22:26, Oliver Neukum wrote:
> > Am Montag, 25. Mai 2009 14:32:28 schrieb Pavel Machek:
> > > > I'm going to try to. Unfortunately, they'll require what's basically a
> > > > group-up redesign of the basic algorithm, because to get maximum
> > > > reliability, you need to carefully account for the amount of storage
> > > > you're going to need and the amount of memory you have available, and
> > > > 'prepare' the image prior to doing the atomic copy.
> > >
> > > I don't quite get it; why is that needed?
> > >
> > > If there's not enough swap available, swsusp should freeze, realize
> > > there's no swap, unfreeze and continue. I do not see reliability
> > > problem there.
> > 
> > The software suspend may be a part of your response to an imminent
> > power failure (UPS near empty). The number of retries available is possibly
> > limited.
> 
> If there's no swap (and no hibernation partition), s2disk just will
> not work.

Yeah - an argument for not being swap centric in storing the image.

But there's more: if there's swap but it's not in the partition pointed
to by resume=, swsusp and uswsusp won't work either, will they? That's
another reliability issue.

> > I'd feel safer if hibernation by default wrote to a dedicated partition,
> > especially as modern practice is to make swap space smaller than RAM.
> 
> It would be easy to have dedicated partition. But why waste space on
> it?

Because it gives you increased reliability. But it doesn't need to be a
dedicated partition - you can just have a file on a partition.

> Anyway, this debate here is "in what order should we do the swsusp
> actions". Dedicated partition/etc is for separate thread (please).

Yeah; if we keep this discussion up, we'll get to that issue too.

Regards,

Nigel
