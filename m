From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Wed, 12 Mar 2008 15:11:17 -0400
Message-ID: <200803121511.17389.lenb__45705.5792714984$1205349213$gmane$org@kernel.org>
References: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080310100008.GA9520@elf.ucw.cz>
	<20080310134915.45ae7446@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080310134915.45ae7446@mjolnir.drzeus.cx>
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
To: linux-pm@lists.linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Pierre Ossman <drzeus-list@drzeus.cx>, Lee Revell <rlrevell@joe-job.com>
List-Id: linux-pm@vger.kernel.org


> > USB keeps processor out of C3 in many cases.
> 
> I figured that was the case. But I did not see any difference in powertop.

Modern Intel mobile processors have a feature called "C2 popup"
that allows the processor to retire DMA from C3 without
breaking into C0.  Instead the processor pops up to C2
where the cache snoop can allow the DMA to retire --
then it returns to C3, all transparent to software.

That is why powertop does not see it.

> > > 4. Battery and AC
> > > 
> > > The noise increases with the battery present and also when the AC supply is removed.
> > >
> > 
> > On battery, some machines swap C3 for "secret" C4, which is slower but
> > saves power.

ak> Normally such things are not visible in the DSDT, but hidden in SMM traps.

no, this mechanism is totally visible to the OS via a _CST re-evaluation on AC/DC transition.

This is very commmon, as the reference BIOS code does it.
It isn't a secret.  There are two common techniques -- either
re-define C3 to enter hardware C4, or simply add C4 as 4th C-state.

> I guess the only way to find out is to disassemble the DSDT. Exposing myself to such concentrations of ACPI is not an appealing project. :/

the latest cpuidle code actually publishes the details of the C-states being used.
 
$ pwd
/sys/devices/system/cpu/cpu0/cpuidle/state3
$ grep . *
desc:ACPI FFH INTEL MWAIT 0x20
latency:17
name:C3
power:250
time:1862590932
usage:9028970

You'll see "desc" change if ACPI pulls a _CST change on you.

> Disabling the second core makes the noise go away. This might be a subset of 1., as I've been told that a stopped core enters C1.

if you disable it at run-time, Linux puts it in C1.
If you never boot it in the first place (eg. maxcpusp=1), the BIOS leaves it in the deepest available C-sate.

The former will prevent the package from entering a deep package C-state,
as c-states are coordinated in hardware.  The later will allow the package
to enter whatever C-state the running core chooses.
 
> Changing HZ and NO_HZ has no noticeable effect on the problem (except the odd behaviour in 2.).
> This is further supported by the fact that Windows also has the problem (which should behave close to 100 HZ without NO_HZ). 
> 
> 
> So for now, the only viable workaround is processor.max_cstate....

yup, that's why we put it in.  Is it insufficient?

-Len
