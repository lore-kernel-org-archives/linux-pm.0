From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 20:12:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707122008550.25614__15090.6067844064$1184296730$gmane$org@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707121453.49616.rjw@sisk.pl>
	<Pine.LNX.4.64.0707121150460.25614@asgard.lang.hm>
	<200707122134.29991.rjw@sisk.pl> <877ip54cti.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <877ip54cti.fsf@jbms.ath.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Jul 2007, Jeremy Maitin-Shepard wrote:

> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>
> [snip]
>
>> There's more to it, though.  If devices are suspended, the hibernation kernel
>> will have to resume them (using platform, like ACPI, callbacks in the process)
>> instead and that will get complicated.
>
>> It's better if devices are quiesced, or even shut down, before we call the
>> hibernation kernel.
>
> I agree that they definitely should not be put into a low power mode, as
> that has nothing to do with hibernation.
>
> Ideally, the following would be done:
>
> All of the hardware that won't be needed by the "save image" kernel will
> be shut down.  The normal driver shut down calls may not be suitable,
> however, because although the same thing should be done to the hardware,
> the device shouldn't be "unregistered", since unlike in the actual
> shutdown case, the same device will need to brought back up again on
> resume, and it will need to have the same device id and such (and
> userspace probably shouldn't see the device going away).
>
> Any devices that will be needed by the "save image" kernel could also
> safely be shutdown as with the unneeded devices, but it would be more
> efficient to simply quiesce it.  Since this would be an additional
> complication, initially probably all of the hardware should be shut
> down, rather than quiesced.
>
> The reason that I think it is useful to actually shut down the devices,
> rather than merely leaving some unneeded devices quiesced, is that it
> would be useful to be able to build the "save image" kernel without
> support for unneeded devices.  In order to support "suspend to ram"
> instead of shutting down after saving the image to disk, the hibernate
> kernel needs to be able to send devices into a low power state.  My
> impression is that if there are devices it does not know about (i.e. the
> unneeded devices), but which are left quiesced but powered on, this
> would be a problem for suspend to ram, although not knowing much about
> how suspend to ram actually works, I could be mistaken.  (Maybe it is
> possible through ACPI or standard bus interfaces to shut down all of the
> devices without really knowing anything about them.)

I don't think that anyone is talking about useing kexec for 
suspend-to-ram, only for suspend-to-disk (hibernate)

>>>>> 3. Support the in-place kexec? The relocatable kernel is not necessary
>>>>> if this can be implemented.
>>>>> 4. Image writing/reading. (Only user space application is needed).
>>>>
>>>> And a kernel interface for that application.
>>>
>>> I do't understand this statement, this application is just useing the
>>> standard kernel interfaces (block devices to read/write to disk, network
>>> devices to read/write to a server, etc). no new interfaces needed.
>
>> Yes, but it will have to know _what_ to save, no?
>
> I agree that a kernel interface would be important; something like
> /dev/snapshot that can be read by the "save image" kernel, and written
> to by the "restore image" kernel.  Note that similarly, kdump provides a
> kernel interface to an ELF image of the old kernel.

I thought that the idea was to save the entire contents of ram so that 
caches, etc remain populated.

having the system kernel free up ram and then making a sg list of what 
memory needs to be backed up would be a nice enhancement, but let's let 
that remain a future enhancement until everyone agrees that the basic 
approach works.

David Lang
