From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/4] cpuidle: define the enter function in
	the driver structure
Date: Fri, 6 Jul 2012 23:23:07 +0200
Message-ID: <201207062323.07402.rjw@sisk.pl>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>
	<201207052238.44330.rjw@sisk.pl> <4FF6C4C1.7030004@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FF6C4C1.7030004@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, linaro-dev@lists.linaro.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday, July 06, 2012, Daniel Lezcano wrote:
> On 07/05/2012 10:38 PM, Rafael J. Wysocki wrote:
> > On Thursday, July 05, 2012, Daniel Lezcano wrote:
> >> We have the state index passed as parameter to the 'enter' function.
> >> Most of the drivers assign their 'enter' functions several times in
> >> the cpuidle_state structure, as we have the index, we can delegate
> >> to the driver to handle their own callback array.
> >>
> >> That will have the benefit of removing multiple lines of code in the
> >> different drivers.
> > 
> > Hmm. I suppose the cpuidle subsystem was designed the way it was for a reason.
> > Among other things, this was to avoid recurrence in callbacks - please see
> > acpi_idle_enter_bm() for example.
> > 
> > Now, if .enter() is moved to the driver structure, it will have to be an
> > all-purpose complicated routine calling itself recursively at least in
> > some cases.  I'm not quite convinced that would be an improvement.
> > 
> > On the other hand, I don't see anything wrong with setting several callback
> > pointers to the same routine.
> 
> Deepthi sent a few months ago a patch moving the per-cpu cpuidle_state
> to a single structure stored in the driver. The drivers were modified
> and cleanup to take into account this modification.
> 
> We saw some regressions like for example the 'disable' which were not
> per cpu and has been moved to the cpuidle_state_usage (and IMHO it is a
> workaround more than a real fix). And now we have new architectures
> (tegra3, big.LITTLE) with different latencies per cpu. Logically we
> should revert Deepthi's patches but from my POV, going back and forth is
> not a good solution (also we have to undo all modifications done in the
> different drivers).
> 
> The main purpose of all these cleanup patches are to move out all
> non-data information from the cpuidle_state structure in order to add a
> new api which could be 'cpuidle_register_cpu_latency(int cpu, struct
> cpuidle_latencies latencies)'.

Well, my question is: what specifically is wrong with having callback
pointers in struct cpuidle_state in case when that structure is known
to be common for all the CPUs in the system?

Sure, there are systems in which that is not the case, but then why
should we complicate the simplest case in order to address them?

> For this specific patch, the 'enter' function for all the drivers is not
> used [1] and one of the driver is about to use a single function [2]. So
> we have only one driver is a couple of functions for this which can be
> replaced by an array of callbacks in the driver itself as we have the index.
> 
> [1] http://lists.linaro.org/pipermail/linaro-dev/2012-June/012355.html

I agree with Deepthi.

> [2] http://lists.linaro.org/pipermail/linaro-dev/2012-June/012399.html

And that is fine and dandy as long as the OMAP people want that.  Evidently,
that is not wanted by everybody and if it had been, the cpuidle subsystem
would have been designed differently.

I really would like that thing to be reconsidered before we proceed with
these changes.

Thanks,
Rafael
