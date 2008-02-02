From: Ingo Molnar <mingo@elte.hu>
Subject: Re: sleepy linux self-test
Date: Sat, 2 Feb 2008 14:50:37 +0100
Message-ID: <20080202135037.GC925__23374.7354629033$1201960359$gmane$org@elte.hu>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200801311755.33899.david-b@pacbell.net>
	<20080202124759.GB25773@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080202124759.GB25773@elf.ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> > Plus, the way you're doing it now is violating the locking protocol 
> > used by that driver.
> 
> Yep, you are right, but that is the easy issue to fix. There's hard 
> issue: I need
> 
> struct rtc_device *rtc
> 
> for the rtc that can be used for system resume, and I'd like to get it 
> without violating too many layers. How to do that?
> 
> Ideally, I need 
> 
> set_alarm(int)
> 
> ...that will magically pick the right rtc device to talk to, and set 
> alarm on it. I don't see how to implement it with current code.

i'd really love to have a /dev/rtc device compatibility APIs, both 
inside and outside the kernel. I really dont know why the new RTC code 
does not do it - why does it put up artificial anti-adoption barriers to 
make it harder to migrate to the new code?

	Ingo
