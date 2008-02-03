From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sleepy linux self-test
Date: Sun, 3 Feb 2008 23:48:31 +0100
Message-ID: <20080203224831.GE2799__18446.7108957053$1202078990$gmane$org@elf.ucw.cz>
References: <20080130131748.GA3796@elf.ucw.cz> <200802031321.27828.rjw@sisk.pl>
	<20080203131636.4100828D3E1@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200802032229.30576.rjw@sisk.pl>
	<20080203224206.8FD40166811@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080203224206.8FD40166811@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: mingo@elte.hu, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > The changes look good to me.
> 
> They feel unfinished to me though.  :)
> 
> Like using "jiffies" instead of a clocksource, which makes trouble
> since the timing covers periods with IRQs disabled.  And the test
> mode parameter needs work.

Well, I'd say that timing has bigger problem, right?

It is

set alarm
	suspend system
| poweroff
alarm expires
	system resumes

... so you are measuring resume time + sleep time, no? 

> > Well, it would be nice to have this feature in as soon as reasonably possible,
> > so that people can include suspend tests in the automated testing.
> 
> Except ... "rtcwake" (from util-linux-ng) already supports such
> testing, albeit from userspace.   But not the timing tests.
> 
> What was the rationale for wanting this done in-kernel?  (Other
> than to know it can work portably.)

Ingo has to answer this one...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
