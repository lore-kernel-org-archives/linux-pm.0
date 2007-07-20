From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 17:37:35 -0400
Message-ID: <877ioupxi8.fsf__18969.3086933859$1184967947$gmane$org@jbms.ath.cx>
References: <Pine.LNX.4.44L0.0707201722060.5241-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707201722060.5241-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Fri\, 20 Jul 2007 17\:24\:30 -0400 \(EDT\)")
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
Cc: david@lang.hm, LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 20 Jul 2007 david@lang.hm wrote:
>> > Userspace can submit I/O requests.  Someone will have to audit every
>> > driver to make sure that such I/O requests don't cause a quiesced
>> > device to become active.  If the device is active, it will make the
>> > memory snapshot inconsistent with the on-device data.
>> 
>> assuming this is the suspend-from-ram after a kexec back from the 
>> write-to-disk kernel I don't think you are correct.
>> 
>> when doing a suspend-to-ram you get to a point where you just don't use 
>> any userspace.

> What do you mean?  How can you prevent user tasks from running?  That's 
> basically what the freezer does, and the whole point of this approach 
> is to eliminate the freezer.  Right?

Presumably no tasks at all would be scheduled.

>> from that point on you are just walking the device tree 
>> putting things into low-power mode. This is the point where we are talking 
>> about jumping to.

> Yes.  And putting things into low-power mode requires the ability to 
> run the scheduler, which means that user tasks can be scheduled, which 
> means that they can run.

Does it really (fundamentally) require scheduling tasks, particularly in
the case that the devices have already been put in the "quiesced" state?

-- 
Jeremy Maitin-Shepard
