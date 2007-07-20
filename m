From: david@lang.hm
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 15:43:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707201540260.5166__40523.0487733663$1184971885$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707201830470.5241-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707201830470.5241-100000@iolanthe.rowland.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 20 Jul 2007, Alan Stern wrote:

> On Fri, 20 Jul 2007, Jeremy Maitin-Shepard wrote:
>
>>>> when doing a suspend-to-ram you get to a point where you just don't use
>>>> any userspace.
>>
>>> What do you mean?  How can you prevent user tasks from running?  That's
>>> basically what the freezer does, and the whole point of this approach
>>> is to eliminate the freezer.  Right?
>>
>> Presumably no tasks at all would be scheduled.
>
> How would you prevent tasks from being scheduled?  How would you
> prevent drivers from deadlocking because in order to put their device
> in a low-power state they need to acquire a lock which is held by a
> user task?

you give up on the suspend becouse you have no way of getting the user 
task to give up the lock.

however, kernel locks should not be held by user tasks, user tasks are not 
expected to behave in rational ways, allowing them to compete with kernel 
tasks for locks is a sure way to get a deadlock or indefinate stall.

what locks are accessed this way?

>>>> from that point on you are just walking the device tree
>>>> putting things into low-power mode. This is the point where we are talking
>>>> about jumping to.
>>
>>> Yes.  And putting things into low-power mode requires the ability to
>>> run the scheduler, which means that user tasks can be scheduled, which
>>> means that they can run.
>>
>> Does it really (fundamentally) require scheduling tasks, particularly in
>> the case that the devices have already been put in the "quiesced" state?
>
> I can't say for sure.  That's the way we have been doing it.  It
> wouldn't be easy to change, because the driver would have to busy-wait
> during delays -- which would mean it would need to use different code
> for system-wide suspend and runtime suspend.

please define terms so that we are all on the same page

what do you mean by
system-wide suspend
runtime suspend

David Lang
