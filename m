From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/2] PM / sleep: ensure deferred probe workqueue is
 finished in wait_for_device_probe
Date: Fri, 9 Oct 2015 09:38:13 -0500
Message-ID: <5617D155.60700@ti.com>
References: <Pine.LNX.4.44L0.1510081637570.1284-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46744 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755891AbbJIOiV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 9 Oct 2015 10:38:21 -0400
In-Reply-To: <Pine.LNX.4.44L0.1510081637570.1284-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On 10/08/2015 03:53 PM, Alan Stern wrote:
> On Thu, 8 Oct 2015, Rafael J. Wysocki wrote:
> 
>>> @@ -391,6 +391,10 @@ int driver_probe_done(void)
>>>    */
>>>   void wait_for_device_probe(void)
>>>   {
>>> +	/* wait for the deferred probe workqueue to finish */
>>> +	if (driver_deferred_probe_enable)
>>> +		flush_workqueue(deferred_wq);
>>> +
>>>   	/* wait for the known devices to complete their probing */
>>>   	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
>>>   	async_synchronize_full();
>>
>> I'm not sure if this is sufficient.
>>
>> Something may be added to the workqueue right after you've flushed it and
>> then be reporobed after the wait_event() in theory.  Or am I missing anything?
> 
> Maybe I'm missing part of this, but I think the point is to make sure
> that every probe which began or was queued before this function got
> called, has finished before the function returns.
> 
> Thus, in the case at hand we want to defer all probes starting from
> some point in the system sleep transition.  Grygorii sets his
> defer_all_probes variable and then calls this function.  It waits for
> any probes that were initiated before the function call.  Any probe
> that was initiated after the function call (for example, the ones
> you're concerned about between the flush_workqueue and wait_event) will
> see that defer_all_probes is set and so will defer itself.

Yes. It will work as expected with the next patch.
For all other case, where this API is used alone -
it will make things more safe, but there is no way to completely block
scheduling of new probes.

> 
> Now, I'm not sure what happens when a probe that was deferred tries to
> defer itself again.  Do we end up in an infinite probing loop?

No. handling of defered probes will be re triggered only if
some probe was finished successfully.
> Is  the deferred_wq workqueue freezable?

seems WQ_FREEZABLE is not set for this WQ.


-- 
regards,
-grygorii
