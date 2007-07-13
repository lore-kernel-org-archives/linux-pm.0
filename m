From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Fri, 13 Jul 2007 10:54:42 -0600
Message-ID: <m1fy3sdz1p.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.44L0.0707131146340.2555-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707131146340.2555-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Fri, 13 Jul 2007 11:50:11 -0400 (EDT)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 13 Jul 2007, Rafael J. Wysocki wrote:
>
>> Okay, I have thought it through and I think that, as an initial step, we can
> do
>> something like this:
>> 
>> - preload the image-saving kernel before hibernation
>> - in the hibernation code path replace device_suspend() with the shutting down
> of
>> all devices without unregistering them (not very nice, but should be
> sufficient
>>   for a while)
>> - when we've called device_power_down() and save_processor_state(), jump to
>>   the image-saving kernel and let it run
>> - make the image-saving kernel set up everything, save the image without
>>   starting any user space (we may use the existing image-saving code for this
>> purpose, with some modifications) and power off the system (or make it enter
>>   S4)
>> - use the existing restoration code to load the image and jump to the
>>   hibernated kernel
>> - in the restore code patch replace device_resume() with the reprobing of all
>>   devices.
>> 
>> Comments?
>
> I doubt that re-probing devices will work.  The probe routine won't 
> expect there to be any registered children, so it will try to 
> re-register them.

So really unregister the children.  All we really need to do is disassociate
the drivers from the devices (to reuse the existing code) we don't
need to rescan for the devices.  The associating the device drivers
with devices takes human measurable amount of time.  The only thing
that takes time is waiting on hardware.  Maybe things will suck
and associating the drivers with the device tree with take a whole
second on a bad day, I don't think that is enough time to add
complicated new code paths for the drivers to maintain.

> On the other hand, post_restore methods could be written to expect 
> something like this.

Please Please Plaese do not start with the existing software suspend
to disk code and thinking.  We are not implementing suspend to ram
here or anything like it.  We already have proven code paths that
know how to quiesce hardware.  We already have proven code paths
that know how to take quite hardware and make it run.  Please let's
just use them.  At least until we can see that they are insufficient
to the task.

Eric
