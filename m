From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sleepy linux self-test
Date: Sat, 2 Feb 2008 20:32:02 +0100
Message-ID: <20080202193202.GB31621__44307.8734133907$1201980820$gmane$org@elf.ucw.cz>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200802020931.38689.david-b@pacbell.net>
	<20080202180002.GB26560@elte.hu>
	<200802021113.22130.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802021113.22130.david-b@pacbell.net>
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
Cc: Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat 2008-02-02 11:13:21, David Brownell wrote:
> On Saturday 02 February 2008, Ingo Molnar wrote:
> >
> > > > Yep, you are right, but that is the easy issue to fix.
> > > 
> > > Which is why I was puzzled that you didn't start out doing it the 
> > > "right" way ... even just hard-wiring the dubious assumption that 
> > > "rtc0" is the right RTC to use.  :)
> > 
> > because this was mostly about an quick & easy hack to see whether it 
> > makes sense at all to automate the testing of suspend/resume.
> 
> I think you should have written "quick and dirty".  ;)
> 
> It would have been easier to just use the public interface
> and hard-wire "rtc0".  But going directly to the hardware
> was dirtier, and more in the spirit of "hack that obviously
> shouldn't go upstream until it gets done properly".

Yes, it was "quick and dirty". And I do not think it is going
upstream in this form...?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
