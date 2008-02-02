From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sleepy linux self-test
Date: Sat, 2 Feb 2008 13:47:59 +0100
Message-ID: <20080202124759.GB25773__26696.7456941076$1201956580$gmane$org@elf.ucw.cz>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200801311755.33899.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200801311755.33899.david-b@pacbell.net>
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
Cc: linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > --- a/drivers/rtc/rtc-cmos.c
> > +++ b/drivers/rtc/rtc-cmos.c
> > @@ -78,7 +78,7 @@ static inline int is_intr(u8 rtc_intr)
> >  
> >  /*----------------------------------------------------------------*/
> >  
> > -static int cmos_read_time(struct device *dev, struct rtc_time *t)
> > +int cmos_read_time(struct device *dev, struct rtc_time *t)
> >  {
> >
> >	... etc ...
> 
> You should be using the standard RTC library calls, exported
> from drivers/rtc/interface.c ... and making sure this mechanism
> will work with any wakeup-capable RTC.  Otherwise you'll end
> being needlessly x86-specific, or reinventing those calls.
> 
> Plus, the way you're doing it now is violating the locking
> protocol used by that driver.

Yep, you are right, but that is the easy issue to fix. There's hard
issue: I need 

struct rtc_device *rtc

for the rtc that can be used for system resume, and I'd like to get it
without violating too many layers. How to do that?

Ideally, I need 

set_alarm(int)

...that will magically pick the right rtc device to talk to, and set
alarm on it. I don't see how to implement it with current code.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
