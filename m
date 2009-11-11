From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: intermittent suspend problem again
Date: Wed, 11 Nov 2009 12:38:22 +0100
Message-ID: <200911111238.22696.rjw__13317.2863432721$1257939654$gmane$org@sisk.pl>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200910291936.14082.rjw@sisk.pl>
	<87my2tnvtu.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87my2tnvtu.fsf@tac.ki.iif.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, yakui.zhao@intel.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 11 November 2009, Ferenc Wagner wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Thursday 29 October 2009, Ferenc Wagner wrote:
> >
> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> 
> >>> On Wednesday 28 October 2009, Ferenc Wagner wrote:
> >>> 
> >>>> 2.6.32-rc5 feels particularly bad, with frequent failures to switch
> >>>> off the machine after "S|" or freezes after "Snapshotting system".
> >>>> The former does not cause much trouble in itself, as the machine can
> >>>> be switched off and resumed all right, but the latter is nasty.
> >>>> Suspend to RAM works all the time.  The issue is not reproducible,
> >>>> unfortunately, and the kernel change happened almost together with a
> >>>> BIOS upgrade.  Yesterday I switched back to 2.6.31 to see whether it
> >>>> still works stably with the new BIOS.  I'll report back my findings in
> >>>> a couple of days.
> >>>
> >>> OK, thanks.
> >>>
> >>> Still, I'm really afraid we won't be able to debug it any further without a
> >>> reproducible test case.
> >>
> >> Can't you perhaps suggest a way forward there?  Or some tricks to create a
> >> reproducible test case here?
> >
> > Well, you can test if the problem is reproducible in the "shutdown" mode of
> > hibernation.
> 
> Well, both failure modes happen with "shutdown" mode as well (the S|
> freeze with yesterday's git, too), but still not reproducibly.  When
> s2disk is stuck in "Snapshotting system", the system is not completely
> dead, it echoes line feeds and Ctrl-C at least (as added to #14504).
> 
> I wonder what you did if the issue was reproducible...  Is that totally
> unapplicable if the problem happens with 10% probability only?  Slow,
> sure, but until I manage to set up an automated testing bench...

I would try to identify the commit that made the problem appear using git
bisection.  However, this is really difficult with problems that are not
reliably reproducible.

Failing that, I would add some instrumentation to the code to identify the
exact place where it hangs.

BTW, did you carry out the /sys/power/pm_test "core" test on the box?

Rafael
