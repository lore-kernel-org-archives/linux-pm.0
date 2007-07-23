From: david@lang.hm
Subject: Re: Re: Hibernation considerations
Date: Sun, 22 Jul 2007 22:31:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707222230050.6350@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707221116060.15224-100000@netrider.rowland.org>
	<200707230842.22121.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707230842.22121.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 23 Jul 2007, Nigel Cunningham wrote:

> Hi Alan.
>
> On Monday 23 July 2007 01:26:23 Alan Stern wrote:
>> On Sun, 22 Jul 2007, Nigel Cunningham wrote:
>>
>>> Hi.
>>>
>>> On Sunday 22 July 2007 02:13:56 Jeremy Maitin-Shepard wrote:
>>>> It seems that you could still potentially get a failure to freeze if one
>>>> FUSE process depends on another, and the one that is frozen second just
>>>> happens to be waiting on the one that is frozen first when it is frozen.
>>>> I admit that this situation is unlikely, and perhaps acceptable.
>>>>
>>>> A larger concern is that it seems that freezing FUSE processes at all
>>>> _will_ generate deadlocks if a non-synchronous or memory-map-supporting
>>>> filesystem is loopback mounted from a FUSE filesystem.  In that case, if
>>>> you attempt to sync or free memory once FUSE is frozen, you are sure to
>>>> get a deadlock.
>>>
>>> Ok. So then (in response to Alan too), how about keeping a tree of mounts,
>>> akin to the device tree, and working from the deepest nodes up? (In
>>> conjunction with what I already suggested)?
>>
>> Face it, Nigel, this is a losing battle.  You can try to come up with
>> ever-more complex schemes to try and force FUSE into the freezer's
>> framework, but it just won't fit.  Or if it does, the next filesystem
>> to come along will require an even more baroque type of special-case
>> handling.
>
> It does seem to be a losing battle, but I'm wondering whether that's really
> because it's an intractable problem, or because people have given up on it
> before its time. We are talking about a computer system, so things should be
> predictable.
>
>> The general problem is that task A may be in an unfreezable state,
>> waiting for task B to do something, while task B is already frozen.
>> Since there's no reasonable way to determine that A really is waiting
>> for B, you're just stuck.  (To make matters worse, A may not even
>> realize which task it is waiting for; it may know only that it's
>> waiting for somebody to do something!)  A and B could be user tasks,
>> kernel threads, or one of each.
>
> I guess I want to persist because all of these issues aren't utterly
> unsolvable. It's just that we don't have the infrastructure yet to figure out
> the solutions to these issues trivially. Take, for example, the locking
> issue. If we could call some function to say "What process holds this lock?",
> then task A could know that it's waiting on task B and put that information
> somewhere. We could then use the information to freeze task B before task A.
>

this sounds like the standard priority inversion problem taken to 
extremes. Ingo has been working this issue, but IIRC the problem is that 
tracking what owns the lock so that you can get that thing to run ends up 
being enough overhead that it's not acceptable in the general case.

David Lang

>> The only thing to do is what Rafael has been working on: unfreeze
>> things, hope the tasks sort themselves out, and try again.
>
> That's what I'm questioning. Is there a more reliable way and we've just given
> up too quickly?
>
> Regards,
>
> Nigel
>
