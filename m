From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Wed, 11 Jul 2007 22:48:06 -0700
Message-ID: <4695C096.5080400__41919.4571594291$1184219398$gmane$org@goop.org>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<20070711172243.ab44c4d4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070711172243.ab44c4d4.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Andrew Morton wrote:
> On Wed, 11 Jul 2007 15:30:31 +0000
> "Huang, Ying" <ying.huang@intel.com> wrote:
>   
>> 1. Boot a kernel A
>> 2. Work under kernel A
>> 3. Kexec another kernel B in kernel A
>> 4. Work under kernel B
>> 5. Jump from kernel B to kernel A
>> 6. Continue work under kernel A
>>
>> This is the first step to implement kexec based hibernation. If the
>> memory image of kernel A is written to or read from a permanent media
>> in step 4, a preliminary version of kexec based hibernation can be
>> implemented.
>>
>> The kernel B is run as a crashdump kernel in reserved memory
>> region. This is the biggest constrains of the patch. It is planed to
>> be eliminated in the next version. That is, instead of reserving memory
>> region previously, the needed memory region is backuped before kexec
>> and restored after jumping back.
>>
>> Another constrains of the patch is that the CONFIG_ACPI must be turned
>> off to make kexec jump work. Because ACPI will put devices into low
>> power state, the kexeced kernel can not be booted properly under
>> it. This constrains can be eliminated by separating the suspend method
>> and hibernation method of the devices as proposed earlier in the LKML.
>>
>> The kexec jump is implemented in the framework of software suspend. In
>> fact, the kexec based hibernation can be seen as just implementing the
>> image writing and reading method of software suspend with a kexeced
>> Linux kernel.
>>     

I guess I'm (still) confused by the terminology here.  Do you mean that 
it fits into suspend-to-disk as a disk-writing mechanism, or in 
suspend-to-ram as a way of going to sleep?

>> Now, only the i386 architecture is supported. The patch is based on
>> Linux kernel 2.6.22, and has been tested on my IBM T42.
>>     
>
> This sounds awesome.  Am I correct in expecting that ultimately the
> existing hibernation implementation just goes away and we reuse (and hence
> strengthen) the existing kexec (and kdump?) infrastructure?
>
> And that we get hibernation support almost for free on all kexec (and
> relocatable-kernel?) capable architectures?
>
> And that all the management of hibernation and resume happens in userspace?
>
> I didn't understand the ACPI problem.  Does this mean that CONFIG_ACPI must
> be disabled in the to-be-hibernated kernel, or in the little transient
> kexec kernel?
>   

I think the point is that if kernel A says "I'm suspending" and calls 
the suspend method on all its devices, then kernel B finds that it has 
no powered on devices to work with.  But then couldn't it turn on the 
ones it wants anyway?  And don't you want to suspend them, to make sure 
they're not still DMAing memory while B is trying to shuffle everything 
off to disk?

It does sound pretty cool.

    J
