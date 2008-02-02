From: David Brownell <david-b@pacbell.net>
Subject: Re: sleepy linux self-test
Date: Sat, 2 Feb 2008 09:49:22 -0800
Message-ID: <200802020949.23397.david-b__21744.125619489$1201975048$gmane$org@pacbell.net>
References: <20080130131748.GA3796@elf.ucw.cz>
	<20080202124759.GB25773@elf.ucw.cz> <20080202135037.GC925@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080202135037.GC925@elte.hu>
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
> i'd really love to have a /dev/rtc device compatibility APIs, both 
> inside and outside the kernel.

Unfortunately the /dev/rtc code became a legacy API for good reasons.

Like not recognizing that all the world's not a PC, with a single RTC
that clones a long-obsolete chip from Motorola ... and not having been
specified in a hardware-neutral manner.  Oh, and of course not all
systems actually used the same RTC driver anyway; it's not like there
was just *one* such programming interface to worry about.


> I really dont know why the new RTC code  
> does not do it - why does it put up artificial anti-adoption barriers to 
> make it harder to migrate to the new code?

What "anti-adoption" barriers would those be?  Pavel's immediate
problem was easy to solve, though he didn't know it.

>From the perspective of almost anyone not using a PC, all the
adoption barriers were on the side of the /dev/rtc code.

- Dave
