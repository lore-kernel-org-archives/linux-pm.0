From: David Brownell <david-b@pacbell.net>
Subject: Re: sleepy linux self-test
Date: Sat, 2 Feb 2008 11:47:44 -0800
Message-ID: <200802021147.45376.david-b__18032.8192924664$1201981798$gmane$org@pacbell.net>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200802020949.23397.david-b@pacbell.net>
	<20080202180604.GC26560@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080202180604.GC26560@elte.hu>
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
> * David Brownell <david-b@pacbell.net> wrote:
> 
> > On Saturday 02 February 2008, Ingo Molnar wrote:
> > > 
> > > i'd really love to have a /dev/rtc device compatibility APIs, both 
> > > inside and outside the kernel.
> > 
> > Unfortunately the /dev/rtc code became a legacy API for good reasons.
> > 
> > Like not recognizing that all the world's not a PC, with a single RTC 
> > that clones a long-obsolete chip from Motorola ... and not having been 
> > specified in a hardware-neutral manner.  Oh, and of course not all 
> > systems actually used the same RTC driver anyway; it's not like there 
> > was just *one* such programming interface to worry about.
> 
> i dont get it - please give me specific technological reasons

In a word:  -ENOPATCH.  ;)


> why on my  
> PC /dev/rtc couldnt be mapped to /dev/rtc0 - without requiring any 
> user-space changes. The APIs seem mostly covered, or at least mappable. 
> Why should the transition to a new driver require user-level changes? 
> (beyond the obvious extensions, but those should show up as extensions.) 

So far as I'm aware, the only issue visible to userspace relate to
the legacy driver's use of "/dev/rtc" not "/dev/rtc0" ... which has
previously been "solved" by symlinking "rtc" -> "rtc0", possibly with
assistance from udev.  (Related:  the major/minor number of /dev/rtc.)
Is that your understanding too?

The "why" is that nobody has been sufficiently bothered by the need
to symlink that they produced a kernel patch to compensate.


> In fact i detest the old RTC code with a vengence, so dont understand 
> this as some invitation to flame or something - i simply want YOUR new 
> code to be utilized more!

Good to know!  :)

But so you're clear ... not "my" code, mostly.  Alessandro Zummo started
this framework, based in part on Russell King's framework for RTCs that
were integrated into ARM based SOCs.  I contributed a bunch, including
rtc-cmos to let the PC side of Linux join the effort.


> I just dont see the specific technological  
> reasons of why there is no .config switch to switch the legacy /dev/rtc 
> over to the new RTC driver and be done with it.

Initially:  because that idea hadn't been suggested.  And because that
sort of code migration on PC hardware needs to be done slowly enough
that the migration issues have a real chance to surface.  Issues like:

 - Change to the ACPI suspend/resume interactions broke RTC wakeup
   for a couple releases in the new RTC framework; now fixed.

 - HPET stuff.  I think the recently merged HPET update may imply
   that rtc-cmos needs an HPET hook, but I've not looked at details.

 - Minor bugfixes, which have been resolved over time.

 - Your desire to keep using old /dev/rtc nodes (no symlink, so new
   kernels and old non-udev fileystems can mix).  New issue, no patch.

Nothing else come to mind.


> I'd enable it in a  
> heartbeat and would encourage distros to do so. Are there missing APIs? 
> Is the ioctl API totally different? It's impossible to wrap it?

See above.  Once the HPET thing is resolved, I think distros can
convert given some resolution of the /dev/rtc issue.


> I'm not really interested in "this isnt a PC" arguments.

Maybe because for you, it *is* a PC.  ;)


> The incompatibility is  
> such an obvious migration barrier to me - do you really not see it?

Let's just say that all my PCs run the new code just fine, and not
all of them have /dev/rtc symlinked to /dev/rtc0 ... but I can very
easily imagine it look bit different from a distro perpective.

- Dave
