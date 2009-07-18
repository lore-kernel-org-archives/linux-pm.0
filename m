From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Sat, 18 Jul 2009 13:49:48 +0200
Message-ID: <20090718114947.GG1433__3376.80507586828$1247917895$gmane$org@ucw.cz>
References: <Pine.LNX.4.44L0.0906020954110.3074-100000@iolanthe.rowland.org>
	<200906041830.54897.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906041830.54897.rjw@sisk.pl>
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
Cc: paul@pwsan.com, gregkh@suse.de, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Sure, conditions may have changed while the system was asleep.  They might
> > also change while the system is awake.  In general, whether or not the system
> > was asleep shouldn't make any difference -- to as great an extent as possible
> > we should strive to pretend that the entire sleep took no time at all (or
> > simply didn't happen).
> > 
> > So: Suppose the system had been awake when the access point
> > disappeared.  What would the wireless adapter driver do then?  It
> > should try to do exactly the same thing if the access point disappears
> > while the system is asleep.
> 
> Not really.  Namely, when the access point _vanishes_ at run time, this is an
> error condition from which we have to recover, while if it's _not_ _present_
> after a resume, it's a normal situation and we shouldn't be recovering from
> that (the user might have changed the physical location while
> suspended).

I disagree here. User can just walk away with powered notebook.


> > You see?  The sleep should be transparent.
> 
> In some cases it won't be, because the hardware state changes while sleeping.
> For example, a laptop battery may be depleted while suspended, so that after
> resume it's in the 'low' condition, while it was in the 'good' condition before
> the preceding suspend.  Arguably, you can't drain a battery from 90% to 10%,
> for example, momentarily.  Also, a CPU fan might be 100% on before
> suspend,

Actually... going 90%->10% immediately is common behaviour of old
li-ion batteries.

> because the CPU was hot at that time, but that doesn't mean the fan should be
> 100% on after the subsequent resume, because it's likely that the CPU will be
> cold (on some systems trying to make the fan spin too fast may lead to
> general problems with thermal management afterwards).

100% is indeed sane default for fan. Yes you should slow the fan down
when you read the real temperature. And yes some systems play it safe
and do 100% fan during boot.

(Otherwise you may have heat problems if you suspend and immediately
resume).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
