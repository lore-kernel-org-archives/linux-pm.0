From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.25-rc2 regression - hang on suspend
Date: Fri, 22 Feb 2008 16:56:28 +0100
Message-ID: <200802221656.28546.rjw__29506.0974582613$1203696010$gmane$org@sisk.pl>
References: <1203422386.10992.2.camel@localhost>
	<200802220006.39130.rjw@sisk.pl>
	<1203663628.8422.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1203663628.8422.2.camel@localhost>
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
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 22 of February 2008, Soeren Sonnenburg wrote:
> On Fri, 2008-02-22 at 00:06 +0100, Rafael J. Wysocki wrote: 
> > On Thursday, 21 of February 2008, Soeren Sonnenburg wrote:
> > > On Thu, 2008-02-21 at 01:31 +0100, Rafael J. Wysocki wrote:
> > > > On Wednesday, 20 of February 2008, Soeren Sonnenburg wrote:
> > > > > On Wed, 2008-02-20 at 00:50 +0100, Rafael J. Wysocki wrote:
> [...] 
> > > Using echo none >/sys/power/pm_test and then
> > > echo mem >/sys/power/state I see it hang on ata1 errors again. Waiting
> > > about 10-30 seconds it progresses further and finally arrives at 
> > > 
> > > CPU0 attaching NULL sched-domain
> > > CPU1 attaching NULL sched-domain
> > > 
> > > then hangs.
> > 
> > Please see if compiling the kernel with CONFIG_SMP unset makes suspend
> > work.
> 
> *Argh*, this bug is not behaving nicely :( Whatever happened,
> git-current now suspends correctly with and without CONFIG_SMP  and all
> may CONFIG_PREEMPT_RCU=y and CONFIG_CLASSIC_RCU=y attempts. Also no sata
> errors anymore.
> 
> However it is not reliably waking up (at least when all of the above
> except CLASSIC_RCU is on). Sometimes the display remains black on the
> console, but X still works and sometimes it hangs completely on resume.

I have created the Bugzilla entry at http://bugzilla.kernel.org/show_bug.cgi?id=10065
for this issue.  Please add yourself to the CC list in there and update it with
any new findings.

> Also when compiling these many kernels via make -j4 I noted that I could
> hardly move the mouse / use the keyboard, but saw random jumps and
> key-repetitions...

This last bit is most likely a scheduler issue.  Do you have CONFIG_GROUP_SCHED
set by chance?  If you do, please try to unset it and see if that helps.

Thanks,
Rafael
