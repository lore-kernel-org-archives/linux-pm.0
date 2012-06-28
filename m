From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Cpuidle drivers,
	Suspend : Fix suspend/resume hang with intel_idle driver
Date: Thu, 28 Jun 2012 21:11:03 +0200
Message-ID: <201206282111.03992.rjw@sisk.pl>
References: <4FEC20D2.2070501@linux.vnet.ibm.com>
	<201206281153.25310.rjw@sisk.pl>
	<4FEC84A4.1000605@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FEC84A4.1000605@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: preeti <preeti@linux.vnet.ibm.com>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, "Srivatsa.S.Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, June 28, 2012, preeti wrote:
> On 06/28/2012 03:23 PM, Rafael J. Wysocki wrote:
> > On Thursday, June 28, 2012, preeti wrote:
> >>
> >> From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
[...]
> cpuidle is an architecture independent part of the kernel  code.Since 
> this patch aims at x86 architecture in specific,I considered it
> inappropriate.
> 
> In addition to this,suspend happens on x86 only if ACPI is configured.

But that is not required for intel_idle, so if it hangs with intel_idle,
then it is not dependent on ACPI after all.

> Therefore it seemed right to put the callback in ACPI specific code
> which deals with ACPI sleep support.

I wonder if we can address this issue correctly.  That is, in a non-racy
way and in a better place.

First, I really don't think it is necessary to "suspend" cpuidle (be it
ACPI or any other) when device drivers' suspend routines are being
executed (which also is racy, because the cpuidle "suspend" may be running
concurrently with cpuidle on another CPU) or earlier.  We really may want
to disable the deeper C-states when we're about to execute
suspend_ops->prepare_late(), or hibernation_ops->prepare(), i.e. after
we've run dpm_suspend_end() successfully.

So, it seems, it might be a good idea to place a cpuidle driver suspend
(and/or hibernation) hook at the end of dpm_suspend_end() and make ACPI
and intel_idle drivers implement that hook.

That would be much more deterministic than your patch I think.

Thanks,
Rafael
