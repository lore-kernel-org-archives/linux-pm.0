From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks
Date: Thu, 20 Mar 2008 14:33:28 +1100
Message-ID: <1205984008.26869.408.camel__28489.7138983526$1205984281$gmane$org@pasglop>
References: <Pine.LNX.4.44L0.0803191101050.4958-100000@netrider.rowland.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803191101050.4958-100000@netrider.rowland.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org


> That was in fact the original plan, before Rafael changed over to
> calling prepare() just prior to suspend().

Heh, ok :-)

> Your analysis is right.  Removal isn't a problem; we don't care if 
> drivers are prohibited from registering new children when they are 
> unbound.  In general we want to make it possible to unregister devices 
> at any time during the suspend-resume procedure (except of course that 
> a device can't be unregistered while one of its methods is running).
> 
> An important point I tried to make in the earlier email is that drivers
> will want a simple way to know when it is illegal for them to register
> new children.  For example, suppose the registration is done by a
> workqueue routine.  The most reliable way for the driver to insure that
> the routine won't try to register new children improperly is to have
> the routine check a flag which gets set _before_ prepare() is called.

I don't totally agree here. Drivers could have their own flag set
internally with appropriate locking. The problem with your approach is
locking. Just setting a flag is mostly useless, -unless- there
appropriate locking between setter and testers. 

For example, the flags we talked about previously, the one set _after_
prepare that causes device_add() to fail, this one must have its setting
done within the same mutex/lock as device_add() internally uses to
protect the list. Or something along those lines.

Now, your idea of having the core set some other flag to tell drivers to
stop doing addition wouldn't work here because the driver would -not-
hold the core device list mutex between testing it and performing the
addition.

As a general matter, the driver would need to internally, using it's own
locking mechanisms, ensure that it will not do any further device_add,
and that's not something the core can help with. In our case, that could
be acheived by flushing the work queues and ensuring we don't queue
another one, or using some driver internal semaphore to set a "stop
adding" flag whatever... 

However, I think this is mostly a non-issue, because the core _does_
provide something here that is useful for drivers who don't want to
bother with the above: The failure return from device_add. If drivers
don't want to do something akin to what I described, they can just be
made to deal gracefully with the failure from device_add that would
happen due to the core internal flag being set after the return from
prepare().

So I don't think we need anything else.

Cheers,
Ben.
