From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Sun, 15 Jul 2007 12:23:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707151218320.25614@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707142306.33783.rjw@sisk.pl>
	<Pine.LNX.4.64.0707141400320.14672@asgard.lang.hm>
	<200707151231.27410.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707151231.27410.rjw@sisk.pl>
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

On Sun, 15 Jul 2007, Rafael J. Wysocki wrote:

>>>> I think this is far more complicated then it needs to be.
>>>>
>>>> it sounds like it should be possible to do the following
>>>>
>>>> 1. figure out what pages should be backed up (creating a data structure to
>>>> hold them)
>>>
>>> That should be done after step 2, because the memory contents can change
>>> in this step.
>>
>> no, this needs to be done by the main kernel, becouse only it knows how to
>> find this info. the kernel that you kexec into could be very different
>> (including different versions) and the ways to identify this data is not
>> part of any existing API
>
> If the memory contents changes in step 2, then the information collected by
> the main kernel will be inaccurate.

why would the memory use change when the new kernel is run? is it becouse 
of whatever it does to the devices for the hand-off?

>>>> 2. kexec into the hibernate kernel (this step handles all device
>>>> transitions today)
>>>>
>>>> 3. have the hibernate userspace find the data structures created in step
>>>> #1
>>>>
>>>> 4. have the hibernate userspace write the pages somewhere in the suspend
>>>> format.
>>>
>>> You don't need to run any hibernate userspace to carry out steps 3 and 4.
>>
>> you should though.
>>
>> by doing this write in usespace you can add in all the eye-candy (aka
>> progress bars), network I/O, etc that you want since it doesn't affect
>> things
>>
>> trying to do this in the kernel makes the kernel have to know/decide too
>> much policy (and many things that people want to do are things that do not
>> belong in the kernel in the first place)
>
> Please don't tell me.  I've written uswsusp on the basis of these arguments,
> but I don't cosider it as an overwhelming success ...

uswsusp has the problem that you are trying to run some userspace, but not 
other userspace as you are doing the hibernate. with this approach you 
don't have that problem since you are running a completely seperate 
userspace.

>>>> 5. have the hibernate kernel power down the box.
>>>>
>>>> the only things here that sounds like they're not available in stock
>>>> kernels are steps #1 and #3.
>>>
>>> Correct, up to the first remark above.
>>>
>>>> now this won't do the fancier suspend-to-ram-and-disk and it won't let you
>>>> go back from the hibernate kernel to the main kernel, but it should be
>>>> enough to let you do the suspend safely and reliably.
>>>>
>>>> for the restore, as I understand it the process is
>>>>
>>>> 1. boot a kernel, any working kernel.
>>>>
>>>> 2. read the suspend formatted data from wherever it was saved and feed it
>>>> to /dev/suspend
>>>
>>> Yes, something like this, but you really should pay more attention to devices.
>>>
>>> There are things that you shouldn't do to them (like unregistering), because
>>> some processes may be using them while we're trying to hibernate (for now
>>> we have the freezer, but I though you'd like to do all that to eliminate it).
>>>
>>> Generally, you need to ensure that the devices are handled in consistent ways
>>> by both the hibernated and image-saving kernels and that's a big piece of the
>>> jigsaw that's missing now.
>>
>> the kexec process should handle the device state for the transition from
>> one kernel to another (it has to do this now, this isn't a new
>> requirement), so this should solve the problem during the hibernate stage.
>
> Well, I don't think so.

Ok, I could easily be misunderstanding something here (and the comments 
with the latest 'kexec back and forth' patch indicate there may still be 
work to do here after all)

>> during the wakeup stage, I thought you said that al that was needed was to
>> feed the suspend image to /dev/suspend and the kernel in the suspend image
>> would re-probe, or otherwise re-initialize all the devices it needs. am I
>> misunderstanding this?
>
> Perhaps.  Currently, the hibernated kernel will run device_resume() after
> the restore, which is not exactly compatible with what kexec does.

but kexec isn't needed during the restore process, is it?

David Lang
