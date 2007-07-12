From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 12 Jul 2007 15:13:08 +0000
Message-ID: <20070712151308.GA5139__2233.42513568259$1184270147$gmane$org@ucw.cz>
References: <20070703211227.GA28758@srcf.ucam.org>
	<E1I666o-0006wu-00@dorka.pomaz.szeredi.hu>
	<200707041703.21808.oliver@neukum.org>
	<200707041717.05149.rjw@sisk.pl>
	<18060.15209.274437.471074@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <18060.15209.274437.471074@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mackerras <paulus@samba.org>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > They will not trigger 100% of the time, but sporadically and generally at
> > random.
> > 
> > At least the freezer problems are reproducible. ;-)
> 
> Our experience with powermacs has been that it isn't actually all that
> hard to get it right for the drivers you care about.

So... will you fix input and usb? Their maintainers seem to prefer
simplicity of frozen system.

Also, can you write down rules for drivers to follow?

Like... 'if you get a request after system suspend started, you may
not kmalloc(GFP_KERNEL)'

 - because disk driver may be already suspended

- hmm, what happens if disk driver _is_ suspended? Let's say I'm v4l
driver on cpu1. Someone may talk to me _while_ disk driver is being
suspended... and if I'm after disk driver in pci order, I may only
learn about suspend _after_ I do the wrong kmalloc.

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
