From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: intermittent suspend problem again
Date: Tue, 1 Dec 2009 13:28:15 +0100
Message-ID: <200912011328.15551.rjw__14421.1079030812$1259670513$gmane$org@sisk.pl>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200911291607.05348.rjw@sisk.pl>
	<87y6ln0yxp.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87y6ln0yxp.fsf@tac.ki.iif.hu>
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
Cc: linux-pm@lists.linux-foundation.org, linux-netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 December 2009, Ferenc Wagner wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Sunday 29 November 2009, Ferenc Wagner wrote:
> >
> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> 
> >>> On Saturday 28 November 2009, Ferenc Wagner wrote:
> >>>
> >>>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >>>> 
> >>>>> Compile with CONFIG_PM_VERBOSE (it does mean exactly that).
> >>>> 
> >>>> The last message now was:
> >>>> 
> >>>> e100: 0000:02:08.0: hibernate, may wakeup
> >>>> 
> >>>> Looks like hibernating the e100 driver is unstable.
> >>>
> >>> Can you verify that by trying to hibernate without the e100 driver?
> >> 
> >> Not really, as I still can't reliable reproduce the issue.  Since I'm
> >> running with suspend loglevel = 8, it's happened only twice (in a row),
> >> with seemingly exact same console output.  Some earlier freezes also
> >> happened in dpm_suspend_start, at least.  However, I can certainly add
> >> e100 to SUSPEND_MODULES under /etc/pm/config.d, and continue running
> >> with that.
> >
> > That's what I'd do.
> 
> That worked out mosty OK (no freeze in quite some hibernation cycles),
> but I'm continuing testing it.

Great, please let me know how it works out.

> On the other hand, I reverted 8fbd962e3, recompiled and replaced the
> module, and got the freeze during hibernation.  And that was the bulk of
> the changes since 2.6.31...  I'll revert the rest and test again, but
> that seems purely cosmetic, so no high hopes.
> 
> > In addition to that, you can run multiple hibernation/resume cycles in
> > a tight loop using the RTC wakealarm.
> 
> I'll do so, as soon as I find a way to automatically supply the dm-crypt
> passphrase... or even better, learn to hibernate to ramdisk from the
> initramfs. :)

Well, you don't need to use swap encryptuon for _testing_. :-)

Thanks,
Rafael
