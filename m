From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] PM / Hibernate: Modify signature used
	to mark swap
Date: Mon, 4 Oct 2010 19:56:00 +0200
Message-ID: <20101004175600.GE1518__32072.4093392075$1286217295$gmane$org@ucw.cz>
References: <201009292313.23601.rjw@sisk.pl> <4CA3ADED.6090908@tuxonice.net>
	<201009300002.03412.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201009300002.03412.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


> > > Index: linux-2.6/kernel/power/swap.c
> > > ===================================================================
> > > --- linux-2.6.orig/kernel/power/swap.c
> > > +++ linux-2.6/kernel/power/swap.c
> > > @@ -29,7 +29,7 @@
> > >
> > >   #include "power.h"
> > >
> > > -#define SWSUSP_SIG	"S1SUSPEND"
> > > +#define HIBERNATE_SIG	"LINHIB0001"
> > >
> > >   /*
> > >    *	The swap map is a data structure used for keeping track of each page
> > > @@ -195,7 +195,7 @@ static int mark_swapfiles(struct swap_ma
> > >   	if (!memcmp("SWAP-SPACE",swsusp_header->sig, 10) ||
> > >   	    !memcmp("SWAPSPACE2",swsusp_header->sig, 10)) {
> > >   		memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);
> > 
> > if no compression
> > 
> > > -		memcpy(swsusp_header->sig,SWSUSP_SIG, 10);
> > 
> > else
> > 
> > > +		memcpy(swsusp_header->sig, HIBERNATE_SIG, 10);
> > 
> > ??
> 
> I thought about that, but we'll need to drop the old signature when the image
> format changes (I think it will after your patch series) anyway.  And the
> benefit is not really worth it IMO (it only affects people using the in-kernel
> hibernation on x86-64).
> 

ACK. Lets keep this simple.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
