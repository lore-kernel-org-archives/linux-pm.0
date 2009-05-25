From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Mon, 25 May 2009 15:26:13 +0200
Message-ID: <20090525132613.GA14096__42543.7072561637$1243258135$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<1243243666.16743.64.camel@nigel-laptop>
	<20090525123228.GA13446@elf.ucw.cz>
	<200905251522.26852.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905251522.26852.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

On Mon 2009-05-25 15:22:26, Oliver Neukum wrote:
> Am Montag, 25. Mai 2009 14:32:28 schrieb Pavel Machek:
> > > I'm going to try to. Unfortunately, they'll require what's basically a
> > > group-up redesign of the basic algorithm, because to get maximum
> > > reliability, you need to carefully account for the amount of storage
> > > you're going to need and the amount of memory you have available, and
> > > 'prepare' the image prior to doing the atomic copy.
> >
> > I don't quite get it; why is that needed?
> >
> > If there's not enough swap available, swsusp should freeze, realize
> > there's no swap, unfreeze and continue. I do not see reliability
> > problem there.
> 
> The software suspend may be a part of your response to an imminent
> power failure (UPS near empty). The number of retries available is possibly
> limited.

If there's no swap (and no hibernation partition), s2disk just will
not work.

> I'd feel safer if hibernation by default wrote to a dedicated partition,
> especially as modern practice is to make swap space smaller than RAM.

It would be easy to have dedicated partition. But why waste space on
it?

Anyway, this debate here is "in what order should we do the swsusp
actions". Dedicated partition/etc is for separate thread (please).
 

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
