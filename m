From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [RFC Add no_suspend attribute V2] Let the
 driver	know if it's in use
Date: Sat, 25 Apr 2009 10:21:30 +0200
Message-ID: <49F2C80A.7070500@gandalf.sssup.it>
References: <20090424172435.GA18448@gandalf.sssup.it>
	<49F1FD2B.5020906@gandalf.sssup.it>
	<20090424225501.GC3343@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090424225501.GC3343@kroah.com>
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
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi
Greg KH wrote:
> On Fri, Apr 24, 2009 at 07:55:55PM +0200, Michael Trimarchi wrote:
>   
>>>  /**
>>> + *	device_set_no_suspend_enable - Mark the device as used by userspace
>>> + *	application
>>> + */
>>>       
>
> This is not proper kernel-doc, please fix this up.
>
> And "no_suspend_enable" is ackward, drop the "enable" part?
>
>   
Ok
>   
>>> +void device_set_no_suspend_enable(struct device *dev, bool enable)
>>> +{
>>> +	struct device *next;
>>> +
>>> +	mutex_lock(&dpm_list_mtx);
>>> +
>>> +	/* the new status is equal the old one */
>>> +	if (dev->power.no_suspend == !!enable)
>>> +		goto out;
>>> +
>>> +	/* change the device status */
>>> +	dev->power.no_suspend = !!enable;
>>> +	if (dev->power.no_suspend)
>>> +		dev->power.subtree_no_suspend = 0;
>>>   
>>>       
>> I find a bug here, i will fix.
>> It can be ok the rest of the code?
>>     
>>> +
>>> +	list_for_each_entry_reverse(next, &dev->power.entry, power.entry) {
>>> +		/* 
>>> +		 * exit if we find a node with the same parent of the start
>>> +		 * device
>>> +		 */
>>> +		if (dev->parent && next->parent == dev->parent)
>>> +			break;
>>> +
>>> +		if (next->parent) {
>>> +			/* Propagate the status */
>>> +			next->power.subtree_no_suspend =
>>> +				device_no_suspend_enable(next->parent);
>>> +		}
>>> +	}
>>> +out:
>>> +	mutex_unlock(&dpm_list_mtx);
>>> +	return;
>>> +}
>>> +EXPORT_SYMBOL_GPL(device_set_no_suspend_enable);
>>> +
>>> +/**
>>>   *	device_pm_add - add a device to the list of active devices
>>>   *	@dev:	Device to be added to the list
>>>   */
>>> @@ -78,6 +117,11 @@ void device_pm_add(struct device *dev)
>>>  		if (dev->parent->power.status >= DPM_SUSPENDING)
>>>  			dev_warn(dev, "parent %s should not be sleeping\n",
>>>  				 dev_name(dev->parent));
>>> +		if (device_no_suspend_enable(dev->parent)) {
>>> +			/* if the parent has suspend disable, propagate it
>>> +			 * to the new child */
>>> +			dev->power.subtree_no_suspend = 1;
>>> +		}
>>>  	} else if (transition_started) {
>>>  		/*
>>>  		 * We refuse to register parentless devices while a PM
>>> @@ -87,7 +131,15 @@ void device_pm_add(struct device *dev)
>>>  		dev_WARN(dev, "Parentless device registered during a PM transaction\n");
>>>  	}
>>>  
>>> -	list_add_tail(&dev->power.entry, &dpm_list);
>>> +	if (dev->parent) {
>>> +		/*
>>> +		 * if the device has a parent insert just before it.
>>> +		 */
>>> +		list_add_tail(&dev->power.entry, &(dev->parent)->power.entry);
>>> +	}
>>> +	else
>>> +		list_add_tail(&dev->power.entry, &dpm_list);
>>> +
>>>       
>
> Why are you changing the ordering for when we add devices to the list?
> This seems like you are adding stuff now in backwards order, why make
> this change?
>   
The import thing is that a child is before the parent. This is put all 
the child before the
parent and just next to it. So

A3A2A1AB3B3B2B1

It is correct? This give the possiblity to dump the graph better and it 
doesn't change anything
in the correctness of the list
Michael
> confused,
>
> greg k-h
>
>   
