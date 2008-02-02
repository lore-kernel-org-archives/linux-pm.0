From: Ingo Molnar <mingo@elte.hu>
Subject: Re: sleepy linux self-test
Date: Sat, 2 Feb 2008 19:06:04 +0100
Message-ID: <20080202180604.GC26560__49303.321602247$1201976029$gmane$org@elte.hu>
References: <20080130131748.GA3796@elf.ucw.cz>
	<20080202124759.GB25773@elf.ucw.cz> <20080202135037.GC925@elte.hu>
	<200802020949.23397.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802020949.23397.david-b@pacbell.net>
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
Cc: linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


* David Brownell <david-b@pacbell.net> wrote:

> On Saturday 02 February 2008, Ingo Molnar wrote:
> > 
> > i'd really love to have a /dev/rtc device compatibility APIs, both 
> > inside and outside the kernel.
> 
> Unfortunately the /dev/rtc code became a legacy API for good reasons.
> 
> Like not recognizing that all the world's not a PC, with a single RTC 
> that clones a long-obsolete chip from Motorola ... and not having been 
> specified in a hardware-neutral manner.  Oh, and of course not all 
> systems actually used the same RTC driver anyway; it's not like there 
> was just *one* such programming interface to worry about.

i dont get it - please give me specific technological reasons why on my 
PC /dev/rtc couldnt be mapped to /dev/rtc0 - without requiring any 
user-space changes. The APIs seem mostly covered, or at least mappable. 
Why should the transition to a new driver require user-level changes? 
(beyond the obvious extensions, but those should show up as extensions.) 

In fact i detest the old RTC code with a vengence, so dont understand 
this as some invitation to flame or something - i simply want YOUR new 
code to be utilized more! I just dont see the specific technological 
reasons of why there is no .config switch to switch the legacy /dev/rtc 
over to the new RTC driver and be done with it. I'd enable it in a 
heartbeat and would encourage distros to do so. Are there missing APIs? 
Is the ioctl API totally different? It's impossible to wrap it? I'm not 
really interested in "this isnt a PC" arguments. The incompatibility is 
such an obvious migration barrier to me - do you really not see it?

	Ingo
