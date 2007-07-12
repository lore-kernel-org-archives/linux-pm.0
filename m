From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec
	base	hibernation
Date: Thu, 12 Jul 2007 00:03:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707112345250.28090__34992.7113893957$1184224224$gmane$org@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<20070711172243.ab44c4d4.akpm@linux-foundation.org>
	<1184251423.9346.55.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1184251423.9346.55.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Jul 2007, Huang, Ying wrote:

> On Wed, 2007-07-11 at 17:22 -0700, Andrew Morton wrote:
>> This sounds awesome.  Am I correct in expecting that ultimately the
>> existing hibernation implementation just goes away and we reuse (and hence
>> strengthen) the existing kexec (and kdump?) infrastructure?
>> And that we get hibernation support almost for free on all kexec (and
>> relocatable-kernel?) capable architectures?
>> And that all the management of hibernation and resume happens in userspace?
>
> Yes. Ultimately, most of the hibernation code such as process freezer,
> memory shrinking, memory snapshot (atomic copy), image reading/writing
> can go away, because kexec based hibernation doesn't depend on them.
> Just the device/CPU state quiescent/save/restore is necessary to remain.

and the device/CPU quiesent/save/restore/sleep/wakeup functions are needed 
for suspend-to-ram and low-power mode.

> And, the management of hibernation and resume will happen in userspace.
>
>>
>> I didn't understand the ACPI problem.  Does this mean that CONFIG_ACPI must
>> be disabled in the to-be-hibernated kernel, or in the little transient
>> kexec kernel?
>
> Under current implementation of device state quiescent/save/restore, the
> CONFIG_ACPI must be turned off both in to-be-hibernated kernel and
> transient kexec kernel.
>
> But the hibernation people are going to separate the device suspend from
> device hibernate. The device hibernate will put device in quiescent
> state but not in low power state. When this is done, it is not necessary
> to disable CONFIG_ACPI at all. It is just a workaround for current
> implementation that disabling CONFIG_ACPI.
>
>> How close do you think all this is to being a viable thing?
>
> The kexec jump is the first step, maybe the simplest step. There are
> many other issues to be resolved, at least the following ones.
>
> 1. Separate device suspend from device hibernate.

you shouldn't need a device hibernate, hibernate will be a system 
shutdown.

> 2. Do not reserve memory for kexec kernel. That is, backup needed memory
> before kexec and restore them after kexec.
> 3. Support the in-place kexec? The relocatable kernel is not necessary
> if this can be implemented.
> 4. Image writing/reading. (Only user space application is needed).
> 5. A smooth resume process. Maybe it is not needed to kexec a new kernel
> for resume. For example, in the first stage of kernel boot, just first
> 16M (or a little more) RAM is used, if the resume image is found, the
> saved kernel image is resumed; if the resume image is not found, turn on
> the remaining RAM. This will depends on 3.
> 6. Reduce the boot-up time of kexec kernel. Maybe the kexec kernel can
> be hibernate/resume by the normal kernel too. This way, a real
> kexec/boot-up is only needed for the first time.

the hibernate kernel shouldn't need a lot of the features of the standard 
kerneel (does it really need sound for example), and if tailored even 
tighter could be configured to only have the drivers actually used for the 
save and restore, makeing a _very_ minimal kernel (no USB, no network, 
only simple video drivers, etc) greatly speeding up the boot

David Lang
