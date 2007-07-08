From: david@lang.hm
Subject: Re: hibernation/snapshot design [was Re: [PATCH] Remove
 process freezer from suspend to RAM pathway]
Date: Sun, 8 Jul 2007 16:45:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707081630370.25614@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707072224270.10912-100000@netrider.rowland.org>
	<200707082115.27363.rjw@sisk.pl>
	<1183928612.3388.289.camel@localhost.localdomain>
	<200707082345.27859.rjw@sisk.pl>
	<1183931688.3388.316.camel@localhost.localdomain>
	<20070708221315.GF5401@elf.ucw.cz>
	<Pine.LNX.4.64.0707081519210.25614@asgard.lang.hm>
	<20070708230042.GH5401@elf.ucw.cz>
	<Pine.LNX.4.64.0707081614211.25614@asgard.lang.hm>
	<20070708232819.GJ5401@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070708232819.GJ5401@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 9 Jul 2007, Pavel Machek wrote:

> On Sun 2007-07-08 16:20:46, david@lang.hm wrote:
>> On Mon, 9 Jul 2007, Pavel Machek wrote:
>>
>>>>>>> Actaully, I'm perfectly fine with that, as long as each task blocked by
>>>>>>> the
>>>>>>> driver due to suspend has PF_FROZEN (or something similar) set.  Then,
>>>>>>> at
>>>>>>> least theoretically, we'll be able to drop the freezer from the suspend
>>>>>>> code
>>>>>>> path and move it after device_suspend() (or the hibernation-specific
>>>>>>> equivalent) for hibernation (in that case there shouldn't be a problem
>>>>>>> with
>>>>>>> any task waiting on I/O while the freezer is running ;-)).
>>>>>>
>>>>>> I don't see the need for a freezer for snapshot but that's a different
>>>>>> issue. (stop_machine looks good enough to me).
>>>>>
>>>>> Freezer is not needed for snapshot -- it is needed so that we can
>>>>> write out the snapshot to disk without the need for special
>>>>> drivers/block/simple-ide-for-suspend.c. (We are doing snapshot, then
>>>>> write to disk from userland code in uswsusp).
>>>>
>>>> instead of trying to freeze most of the system, could you do something
>>>> like start a virtual machine sandbox to write the data out, and not let
>>>> any userspace other then the sandbox operate?
>>>>
>>>> you would need to throw away disk buffers so that you don't mix current
>>>> pending I/O with I/O from the sandbox, and this would be a visable change
>>>> for how suspend is setup, but wouldn't this work?
>>>
>>> It feels kind of expensive, but yes, we could use another kernel for
>>> doing the dump. Kdump people are using that. We could use hypervisor
>>> for doing the dump. Xen people are doing that. (But I do not think any
>>> of those solutions is suitable for "lets hibernate my notebook" case).
>>
>> expensive and reliable beats efficiant and unrelaible.
>>
>> why do you say that neither would work for the "lets hibernate my
>> notebook" case?
>
> Both would work. One would eat 8-64MB of your RAM, permanently; second
> would eat 5-15% of your cpu, permanently. Not very suitable.

how much overlap is there between the two approaches? are they close 
enough to be able to give the user the choice of which to use depending on 
their machine (new machines with the hardware virtualization support may 
want the hypervisor, other hardware may want to sacrafice 8M of ram)

> Who says current solution is unreliable?

users report problems, suspend* developers repeatedly state that the 
problems are that the rest of the kernel needs to be fixed to work 
properly with the existing approach.

I think it's safe to say that it doesn't work in the general case, even 
though it does work in some specific cases.

David Lang
