From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 14730] sky2 won't work after suspend/resume
	cycle
Date: Mon, 7 Dec 2009 21:23:32 +0100
Message-ID: <200912072123.32354.rjw__41863.7458737523$1260217488$gmane$org@sisk.pl>
References: <bug-14730-10028@http.bugzilla.kernel.org/>
	<200912071951.nB7JpW10003364@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912071951.nB7JpW10003364@demeter.kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 07 December 2009, bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=14730
> 
> 
> 
> 
> 
> --- Comment #7 from Andrew Morton <akpm@linux-foundation.org>  2009-12-07 19:51:32 ---
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Fri, 4 Dec 2009 09:02:21 GMT
> bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=14730
> > 
> >            Summary: sky2 won't work after suspend/resume cycle
> >            Product: Power Management
> >            Version: 2.5
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: high
> >           Priority: P1
> >          Component: Hibernation/Suspend
> >         AssignedTo: power-management_other@kernel-bugs.osdl.org
> >         ReportedBy: mat@esi.com.pl
> >         Regression: Yes
> > 
> > 
> > I use sky2 network adapter in my Fujitsu Siemens Esprimo Mobile U9200. It
> > worked fine up until 2.6.31-rc3 (or at least that's the last one I tried it
> > works for me) and in all versions after that I tried it stops working after
> > suspend/resume cycle (I use powersave daemon, but I also tried without it -
> > effect is the same). 
> > 
> > After resume what I see in dmesg is this:
> > 
> > sky2 driver version 1.23
> > sky2 0000:04:00.0: enabling device (0000 -> 0003)
> > sky2 0000:04:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
> > sky2 0000:04:00.0: setting latency timer to 64
> > sky2 0000:04:00.0: unsupported chip type 0xff
> 
> It looks like reads from the device are returning all-ones.  
> 
> > sky2 0000:04:00.0: PCI INT A disabled
> > sky2: probe of 0000:04:00.0 failed with error -95
> > 
> > So it looks like something is probably not restored correctly after resume or
> > some initializations are not executed.
> > 
> > I use Gentoo sources, but I also tried it on vanilla kernels - 2.6.31 and
> > 2.6.32-rc8 and it doesn't work in any version past 2.6.31-rc3.
> > 
> 
> Help.  Do we think this regression is likely to be a sky2 thing, an
> ACPI thing, an x86 arch thing or...?

Quite frankly, I have no idea.

In principle that may be a result of a PCI PM core change, but nothing
comes to mind immediately.

It may be worth trying to revert 

commit 4b77b0a2ba27d64f58f16d8d4d48d8319dda36ff
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Wed Sep 9 23:49:59 2009 +0200

    PCI: Clear saved_state after the state has been restored

and retesting.
