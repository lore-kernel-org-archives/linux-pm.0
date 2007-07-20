From: david@lang.hm
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 14:34:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707201428080.5166__46325.4764014438$1184967954$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707201722060.5241-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707201722060.5241-100000@iolanthe.rowland.org>
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

> On Fri, 20 Jul 2007 david@lang.hm wrote:
>
>>> Userspace can submit I/O requests.  Someone will have to audit every
>>> driver to make sure that such I/O requests don't cause a quiesced
>>> device to become active.  If the device is active, it will make the
>>> memory snapshot inconsistent with the on-device data.
>>
>> assuming this is the suspend-from-ram after a kexec back from the
>> write-to-disk kernel I don't think you are correct.
>>
>> when doing a suspend-to-ram you get to a point where you just don't use
>> any userspace.
>
> What do you mean?  How can you prevent user tasks from running?  That's
> basically what the freezer does, and the whole point of this approach
> is to eliminate the freezer.  Right?
>
>> from that point on you are just walking the device tree
>> putting things into low-power mode. This is the point where we are talking
>> about jumping to.
>
> Yes.  And putting things into low-power mode requires the ability to
> run the scheduler, which means that user tasks can be scheduled, which
> means that they can run.

I did not know that getting into low-power mode required scheduling.

does it require userspace?

if so this is a problem and I say punt on suspend-to-disk-and-ram until 
suspend-to-ram is working independantly ;-)

if not, then can you schedule but not consider non-kernel tasks runnable?

freezing all of userspace is easy (see above)

freezing all of kernelspace is easy (unplug all non-boot CPU's and don't 
schedule)

where freezing gets hard is when you need to partially freeze either one 
of these.

David Lang
