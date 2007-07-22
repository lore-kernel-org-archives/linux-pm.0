From: david@lang.hm
Subject: Re: Re: Hibernation considerations
Date: Sun, 22 Jul 2007 14:54:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707221451550.6350@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707221608140.16031-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707221608140.16031-100000@netrider.rowland.org>
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
Cc: Miklos Szeredi <miklos@szeredi.hu>, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

On Sun, 22 Jul 2007, Alan Stern wrote:

> On Sun, 22 Jul 2007, Miklos Szeredi wrote:
>
>>> The only thing to do is what Rafael has been working on: unfreeze
>>> things, hope the tasks sort themselves out, and try again.
>>
>> Have we some proof, that this will untangle the freezing tasks in a
>> limited time?  Or will it just make the problem harder to trigger?
>
> Of course there's no proof.  Just the opposite -- if things get hung up
> the first time, they might get hung up the second time.  And the
> third...
>
> But it ought to make the problem harder to trigger.  For the present
> that's a worthwhile improvement.

it gives the system more tries to find a spot in time where the deadlock 
doesn't happen, if you find one you can continue.

but even if things keep getting hung up, at least you are backing out of 
each try safely and can eventually tell the user "I give up, try shutting 
some things down and suspending again"

David Lang
