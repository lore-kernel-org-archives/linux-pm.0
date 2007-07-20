From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 18:48:24 -0400
Message-ID: <87zm1qofnr.fsf@jbms.ath.cx>
References: <Pine.LNX.4.44L0.0707201830470.5241-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707201830470.5241-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Fri\, 20 Jul 2007 18\:35\:16 -0400 \(EDT\)")
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

> On Fri, 20 Jul 2007, Jeremy Maitin-Shepard wrote:
>> >> when doing a suspend-to-ram you get to a point where you just don't use 
>> >> any userspace.
>> 
>> > What do you mean?  How can you prevent user tasks from running?  That's 
>> > basically what the freezer does, and the whole point of this approach 
>> > is to eliminate the freezer.  Right?
>> 
>> Presumably no tasks at all would be scheduled.

> How would you prevent tasks from being scheduled?  How would you
> prevent drivers from deadlocking because in order to put their device
> in a low-power state they need to acquire a lock which is held by a
> user task?

Perhaps this isn't an issue once the device is already quiesced.  I'm
just conjecturing.

[snip]

-- 
Jeremy Maitin-Shepard
