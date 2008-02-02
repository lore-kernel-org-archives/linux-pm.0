From: David Brownell <david-b@pacbell.net>
Subject: Re: sleepy linux self-test
Date: Sat, 2 Feb 2008 11:13:21 -0800
Message-ID: <200802021113.22130.david-b__36237.5157456428$1201979740$gmane$org@pacbell.net>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200802020931.38689.david-b@pacbell.net>
	<20080202180002.GB26560@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080202180002.GB26560@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 02 February 2008, Ingo Molnar wrote:
>
> > > Yep, you are right, but that is the easy issue to fix.
> > 
> > Which is why I was puzzled that you didn't start out doing it the 
> > "right" way ... even just hard-wiring the dubious assumption that 
> > "rtc0" is the right RTC to use.  :)
> 
> because this was mostly about an quick & easy hack to see whether it 
> makes sense at all to automate the testing of suspend/resume.

I think you should have written "quick and dirty".  ;)

It would have been easier to just use the public interface
and hard-wire "rtc0".  But going directly to the hardware
was dirtier, and more in the spirit of "hack that obviously
shouldn't go upstream until it gets done properly".

- Dave
