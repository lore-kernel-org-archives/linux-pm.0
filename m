From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 20:06:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707121953440.25614@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707121453.49616.rjw@sisk.pl>
	<Pine.LNX.4.64.0707121150460.25614@asgard.lang.hm>
	<200707122134.29991.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707122134.29991.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Jul 2007, Rafael J. Wysocki wrote:

> On Thursday, 12 July 2007 20:57, david@lang.hm wrote:
>> On Thu, 12 Jul 2007, Rafael J. Wysocki wrote:
>>
>>>> 2. Do not reserve memory for kexec kernel. That is, backup needed memory
>>>> before kexec and restore them after kexec.
>>>
>>> I don't think this is very important initially.
>>
>> I agree, a stipped down hibernate kernel can be very small, not allocating
>> this memory until it's needed is a step for the final polishing.
>
> I'm not sure if I agree with that.  In any case, having to use two different
> kernels for hibernation would be a big drawback.

I see it as a big advantage to not have to use the main kernel for the 
suspend. please keep it as an option at least.

>>>> 3. Support the in-place kexec? The relocatable kernel is not necessary
>>>> if this can be implemented.
>>>> 4. Image writing/reading. (Only user space application is needed).
>>>
>>> And a kernel interface for that application.
>>
>> I do't understand this statement, this application is just useing the
>> standard kernel interfaces (block devices to read/write to disk, network
>> devices to read/write to a server, etc). no new interfaces needed.
>
> Yes, but it will have to know _what_ to save, no?
>
> Plus we need to figure out how to avoid corrupting filesystems and swap in use
> by the "old" kernel and its processes (hint: a separate "hibernation partition"
> is a no-go).

I thought the existing hibernation wrote to the swap partition as it's 
dedicated space?

I didn't know that anyone was suggesting writing the hibernation image to 
a filesystem that the kernel was activly accessing.

>>>> 5. A smooth resume process. Maybe it is not needed to kexec a new kernel
>>>> for resume. For example, in the first stage of kernel boot, just first
>>>> 16M (or a little more) RAM is used, if the resume image is found, the
>>>> saved kernel image is resumed; if the resume image is not found, turn on
>>>> the remaining RAM. This will depends on 3.
>>>
>>> I think that this is the most difficult part of the whole thing.
>>
>> don't try to get too fancy right now. stick with a simple 'boot hibernate
>> kernel, it's userspace looks for an image to resume, and if it doesn't
>> find one reboot to the normal system'
>>
>> I don't know how to do this with grub, but it would be a trivial shell
>> script with lilo
>
> I think it's most portable to use initrd for that, which already makes things
> complicated.  Then, we'll have to load the image and jump to the hibernated
> kernel in such a way that it would be able to continue from where it stopped
> before.  I don't think that is trivial.

I was talking about the scripts that would be used inside the initrd (or 
boot partition of whatever type)

to start with don't worry about how the kexec kernel gets it's / 
filesystem (for testing just use a real partition on your disk. after you 
get everything working let the people who really understand the initrd and 
consider it trivial switch it to an initrd image)

fo rthe current stage where we are trying to make things work don't worry 
about packaging everything tight with initrd and re-useing partitions or 
kernel images. once everything is working reliably then it's time to look 
at useing the same kernel for multiple functions, writing to a partition 
that's i use for other things, etc

unless you are saying that this is a trivial task, and if someone is 
willing to use seperate partitions and kernels this works well, and 
therefor the only problem left is how to make it look the same to the user 
as the old approach?

>>>> 6. Reduce the boot-up time of kexec kernel. Maybe the kexec kernel can
>>>> be hibernate/resume by the normal kernel too. This way, a real
>>>> kexec/boot-up is only needed for the first time.
>>>
>>> I'm not sure what you mean.
>>
>> he's trying to get fancy again, the best way to speed up the boot of the
>> kexec kernel is make it smaller and avoid probing for devices (hotplug
>> should NOT be used for normal suspend situations)
>
> Still, I believe that we should do our best to use only one kernel (meaning one
> kernel image) here.

later on it may be the right thing, for now get it working with different 
images.

David Lang
