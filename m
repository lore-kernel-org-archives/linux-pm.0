From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI PM: Restore the 2.6.24 suspend ordering
Date: Wed, 2 Apr 2008 15:00:20 +0200
Message-ID: <20080402130020.GB5295__42623.133902862$1207141381$gmane$org@ucw.cz>
References: <200803300319.08398.rjw@sisk.pl> <200803301515.33922.rjw@sisk.pl>
	<20080401084523.GA25278@atrey.karlin.mff.cuni.cz>
	<200804012155.52547.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200804012155.52547.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, LKML <linux-kernel@vger.kernel.org>, Arthur Erhardt <erhardt@pit.physik.uni-tuebingen.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Felix M?ller <fm@opensuse.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > We could simply blacklist them, no?
> > > 
> > > Yes, but for this purpose we'll have to redesign the core so that everything
> > > (including debugging and the error paths) works if _PTS is executed before
> > > suspending devices.  _That_, however, is not a 2.6.25 thing.
> > 
> > So we have solution that fixes 2.6.24 systems, makes system that
> > worked in 2.6.25-rc5 work with command line option, but gets error
> > handling wrong.
> > 
> > I guess we could use that?
> 
> IMO we should not use that, because it's broken.  That's why I posted the
> patch.

I understand that. World will not fall down one way or another, but
I'd slightly prefer the 'only change default' version. That's why I
objected to your patch :-).
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
