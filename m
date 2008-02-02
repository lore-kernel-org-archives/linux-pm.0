From: David Brownell <david-b@pacbell.net>
Subject: Re: sleepy linux self-test
Date: Sat, 2 Feb 2008 09:31:38 -0800
Message-ID: <200802020931.38689.david-b__34309.0162532919$1201973726$gmane$org@pacbell.net>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200801311755.33899.david-b@pacbell.net>
	<20080202124759.GB25773@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080202124759.GB25773@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 02 February 2008, Pavel Machek wrote:
> Hi!
> 
> > > --- a/drivers/rtc/rtc-cmos.c
> > > +++ b/drivers/rtc/rtc-cmos.c
> > > @@ -78,7 +78,7 @@ static inline int is_intr(u8 rtc_intr)
> > >  
> > >  /*----------------------------------------------------------------*/
> > >  
> > > -static int cmos_read_time(struct device *dev, struct rtc_time *t)
> > > +int cmos_read_time(struct device *dev, struct rtc_time *t)
> > >  {
> > >
> > >	... etc ...
> > 
> > You should be using the standard RTC library calls, exported
> > from drivers/rtc/interface.c ... and making sure this mechanism
> > will work with any wakeup-capable RTC.  Otherwise you'll end
> > being needlessly x86-specific, or reinventing those calls.
> > 
> > Plus, the way you're doing it now is violating the locking
> > protocol used by that driver.
> 
> Yep, you are right, but that is the easy issue to fix.

Which is why I was puzzled that you didn't start out doing it
the "right" way ... even just hard-wiring the dubious assumption
that "rtc0" is the right RTC to use.  :)


> There's hard issue: I need 
> 
> struct rtc_device *rtc
> 
> for the rtc that can be used for system resume,

Well, "rtc which (a) has an alarm, (b) may be used for system wakeup".

Assuming there *is* such an RTC ... fortunately, there will usually be
one on systems that are designed to go to sleep.


> and I'd like to get it 
> without violating too many layers. How to do that?
> 
> Ideally, I need 
> 
> set_alarm(int)
> 
> ...that will magically pick the right rtc device to talk to, and set
> alarm on it. I don't see how to implement it with current code.

Easy enough.  Given an RTC device node, you can tell whether it has
no chance at all to meet those requirements:

	static int has_wakealarm(struct device *dev, void *name_ptr)
	{
		struct rtc_device *rtc = to_rtc_device(dev);

		/* (a) has an alarm */
		if (!rtc->op->set_alarm)
			return 0;

		/* (b) may be used for system wakeup */
		if (device_may_wakeup(dev->parent))
			return 0;
		
		*(char **)name_ptr = rtc->name;
		return 1;
	}

Then there's a new class interface you may not have known about,
since it's been merged barely over a week now.  You can use it
to find the name of the rtc to pass to rtc_open():

	static char *find_wake_rtc(void)
	{
		char *pony = NULL;

		dev = class_find_device(rtc_class, &rtc, has_wakealarm);
		return pony;
	}

On most PCs that will return the name "rtc0" ... and it'll do
the same on most of the other systems I have.  On both of the
two-RTC systems I have that will return "rtc1".   On systems
with no wakealarm-enabled RTC, that will return NULL.

Voila!

- Dave
