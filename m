From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Sun, 15 Jul 2007 16:22:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707151549200.25614__41416.3998364986$1184542226$gmane$org@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707151231.27410.rjw@sisk.pl>
	<Pine.LNX.4.64.0707151218320.25614@asgard.lang.hm>
	<200707160059.08277.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707160059.08277.rjw@sisk.pl>
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

On Mon, 16 Jul 2007, Rafael J. Wysocki wrote:

> On Sunday, 15 July 2007 21:23, david@lang.hm wrote:
>> On Sun, 15 Jul 2007, Rafael J. Wysocki wrote:
>>
>>>>>> I think this is far more complicated then it needs to be.
>>>>>>
>>>>>> it sounds like it should be possible to do the following
>>>>>>
>>>>>> 1. figure out what pages should be backed up (creating a data structure to
>>>>>> hold them)
>>>>>
>>>>> That should be done after step 2, because the memory contents can change
>>>>> in this step.
>>>>
>>>> no, this needs to be done by the main kernel, becouse only it knows how to
>>>> find this info. the kernel that you kexec into could be very different
>>>> (including different versions) and the ways to identify this data is not
>>>> part of any existing API
>>>
>>> If the memory contents changes in step 2, then the information collected by
>>> the main kernel will be inaccurate.
>>
>> why would the memory use change when the new kernel is run? is it becouse
>> of whatever it does to the devices for the hand-off?
>
> Yes, I think so, although I'm not sure, because I don't know what happens to
> devices during a "normal" kexec.

is this  a matter of running some test to find out, or is this a question 
for the kexec implemantors?

>>>> during the wakeup stage, I thought you said that al that was needed was to
>>>> feed the suspend image to /dev/suspend and the kernel in the suspend image
>>>> would re-probe, or otherwise re-initialize all the devices it needs. am I
>>>> misunderstanding this?
>>>
>>> Perhaps.  Currently, the hibernated kernel will run device_resume() after
>>> the restore, which is not exactly compatible with what kexec does.
>>
>> but kexec isn't needed during the restore process, is it?
>
> Generally, it's not needed.  _However_, the current handling of devices is
> such that:
> (a) hibernated kernel uses device_suspend() to put them into low power states
>    and creates the image
> (b) hibernated kernel uses device_resume() to get devices back to work and
>    saves the image
> (c) during the restore the boot kernel loads the image and uses
>    device_suspend() to prepare devices for the "old" kernel
> (d) hibernated kernel gets control and uses device_resume() to get devices back
>    to work.
> Now, if you use kexec instead of (a) and (b), then whatever it does to devices
> is generally incompatible with the device_resume() in (d) (because, for
> instance, some device driver's .resume() routine may expect some data to be
> saved by the corresponding .suspend() at specific locations).

ok, this means that the resume operation is not a solved problem (at least 
for the kexec process)

now, one possible approach to this (and this may be what Ying Huang it 
thinking of) would be to have the restore process be

1. boot the normal kernel with a dummy userspace, initializeing all 
devices

2. kexec to the hibernate kernel

3. the hibernate kernel's userspace overwrites all memory from the 
origional system that was saved

4. kexec from the hibernate kernel back to the origional kernel

the ugly part here is the need for the dummy userspace in step #1 so that 
it doesn't try to access the wrong things.

now, it may be that the kernel boot in step 1 doesn't need to be able to 
initialize all drivers for things to work in step 4, in which case things 
are much simpler (but you still may need the three kernel hop so that the 
final kernel is running in the same addresses that it started in.

David Lang
