From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [RFC Add in_use attribute] Let the driver know if
	it's in use
Date: Tue, 21 Apr 2009 07:08:44 +0200
Message-ID: <49ED54DC.6040407@gandalf.sssup.it>
References: <20090416131323.GA16752@gandalf.sssup.it>
	<200904202354.04777.rjw@sisk.pl> <20090420224555.GA28697@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090420224555.GA28697@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

Hi,

Greg KH wrote:
> On Mon, Apr 20, 2009 at 11:54:04PM +0200, Rafael J. Wysocki wrote:
>   
>> On Thursday 16 April 2009, Michael Trimarchi wrote:
>>     
>>> Drivers on embedded systems would be smart enough
>>> to know that some of the devices should remain powered up, because
>>> they could still be useful even when the CPU wasn't running.
>>> The patch add the in_use attribute, that it can be used by the
>>> the drivers to avoid power down during suspend.
>>>       
>> OK, so the idea is that in_use will be set by the user space for devices that
>> shouldn't be suspended.  Is this correct?
>>     
>
> If so, why?  Why would you suspend anything then?  Why not just have
> userspace suspend the devices it wants to suspend and leave the ones it
> thinks is "in_use" alone?
>
>   
Because it the previus thread the idea is that the driver should use 
this flag

"[linux-pm] [RFC Disable suspend on a
specific device] This is a little change in linux power scheme".


>> Assuming it is, I'd call the flag 'in_use' rather than 'is_inuse'.  Also, if
>> may_inuse is supposed to mean that we can set in_use for this device, I'd call
>> it 'in_use_valid', I'd make it be unset by default and I'd allow the driver to
>> unset it if it is going to react to 'in_use'.
>>
>>     
>>> Signed-off-by: Michael Trimarchi <trimarchi@gandalf.sssup.it>
>>> Cc: "Alan Stern" <stern@rowland.harvard.edu>
>>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>>> Cc: "Pavel Mackek" <pavel@ucw.cz>
>>> Cc: "Len Brown" <lenb@kernel.org>
>>>
>>> ---
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> index e73c92d..d67043b 100644
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>>> @@ -1124,6 +1124,49 @@ static struct device *next_device(struct klist_iter *i)
>>>  }
>>>  
>>>  /**
>>> + * device_visit_subtree - device subtree iterator.
>>> + * @root: root struct device.
>>> + * @data: data for the callback.
>>> + * @fn: function to be called for each device.
>>> + *
>>> + * Iterate the @parent's subtree devices, and call @fn for each,
>>> + * passing it @data.
>>> + *
>>> + */
>>>       
>> Hmm, I'm not sure ig Greg is going to like it.
>>     
>
> I have the same big question you do:
>
>   
>> Besides, I'm not sure if it's really necessary.  What's wrong with using
>> simply device_for_each_child() instead?
>>     
>
> Exactly, what are you trying to do that differs from
> device_for_each_child()?
>   
Is device for each child use to visist the first level of the tree?
>   
>>> @@ -1207,6 +1250,7 @@ int __init devices_init(void)
>>>  	return -ENOMEM;
>>>  }
>>>  
>>> +EXPORT_SYMBOL_GPL(device_visit_subtree);
>>>       
>
> I see you didn't run your patch through scripts/checkpatch.pl :)
>   
I run the checkpatch but I find that the exported symbol are there so I 
add the new one.
> Please do so in the future.
>
> thanks,
>
> greg k-h
>
>   
Michael
