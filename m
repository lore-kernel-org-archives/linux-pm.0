From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH] APM: delete APM in Linux-2.6.40
Date: Fri, 25 Mar 2011 09:07:16 +0100
Message-ID: <201103250907.16337.linux__11795.2552777298$1301040499$gmane$org@rainbow-software.org>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<201103241315.34722.linux@rainbow-software.org>
	<alpine.LFD.2.02.1103241905250.16085@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1103241905250.16085@x980>
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
To: Len Brown <lenb@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 25 March 2011, Len Brown wrote:
> > Please don't turn Linux into second Windows.
>
> No worry there.
>
> I mention Microsoft not to advocate that Linux be Windows,
> but to point out that this (hardware/firmware) ship sank 5 years
> ago and Linux is still on the boat.  MS was able to delete
> APM support in 2006 from their source tree, yet we still carry it.

And we also support ISA cards (network/sound/whatever). That's why many people 
(including me) like and use Linux. Take any old machine that has enough power 
to do the job you want and install Linux - e.g. get a Pentium box, install 
Debian and you have a mail server (and if you need to power it down, you need 
APM too). It's not possible with any other OS (well, maybe *BSD but Linux has 
more drivers).

If we remove support for older HW, Linux will never get a decent desktop 
market share. The common use case is "new Windows will not run (or run slow) 
on that (old) box, let's try Linux".

> > If you don't want APM in the
> > kernel, just don't compile it. There are many people using older systems
> > with APM - and most of them wouldn't oppose to this removal as they don't
> > even know about it.
>
> They can still run old Linux on an old APM-only laptop --
> just like they can still run Windows 3.1 or Windows XP if they want to.
>
> What we'd be taking away is their ability to run the latest
> Linux kernel on that laptop.

And that's bad. With Linux philosophy, you need new kernel to get new HW 
support. So if you have an APM-only laptop and would want to use a new USB 
device, you're out of luck. What to do then? Delete Linux and install Windows 
XP?

> The issue at hand is people (like me) who have to maintain
> the latest Linux source code.  In sort, I don't want to
> write, debug, and test a cpuidle driver for an apm-only laptop
> when I could be spending effort on code that people will
> actually run.

So don't do it then. If APM works now, keep it as is. Just like hgafb (HGA 
hardware is from 1984).

-- 
Ondrej Zary
