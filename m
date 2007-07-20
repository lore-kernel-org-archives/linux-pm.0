From: Milton Miller <miltonm@bga.com>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 12:32:25 -0500
Message-ID: <09666fe245b0fb34a5a09464250e003d@bga.com>
References: <Pine.LNX.4.44L0.0707201216460.3811-100000@iolanthe.rowland.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707201216460.3811-100000@iolanthe.rowland.org>
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
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Jul 20, 2007, at 11:20 AM, Alan Stern wrote:
> On Fri, 20 Jul 2007, Milton Miller wrote:
>>> We can't do this unless we have frozen tasks (this way, or another)
>>> before
>>> carrying out the entire operation.
>>
>> What can't we do?   We've already worked with the drivers to quesce 
>> the
>> hardware and put any information to resume the device in ram.  Now we
>> ask them to put their device in low power mode so we can go to sleep.
>> Even if we schedule, the only thing userspace could touch is memory.
>
> Userspace can submit I/O requests.  Someone will have to audit every
> driver to make sure that such I/O requests don't cause a quiesced
> device to become active.  If the device is active, it will make the
> memory snapshot inconsistent with the on-device data.

If a driver is waking a device between the time it was told by 
hibernation "suspend all operations and save your device state to ram" 
and "resume your device" then it is a buggy driver.

I argue the process can make the io request after we write to disk, we 
just can't service it.  If we are suspended it will go to the request 
queue, and eventually the process will wait for normal throttling 
mechanisms until the driver is woken up.

It may mean the driver has to set a flag so that it knows it had an 
iorequest arrive while it was suspended and needs to wake the queue 
during its resume function.


Actually, my point was more "what kernel services do the drivers need 
to transition from quiesced to low power for acpi S4 or 
suspend-to-ram"?  We can't give them allocate-memory (but we give them 
a call "we are going to suspend" when they can), but does "run this 
tasklet" help?  What timer facilities are needed?

Do we need to differentate init (por by bios) and resume from quiesced 
(for reboot, kexec start/resume)?  I hope not.

milton
