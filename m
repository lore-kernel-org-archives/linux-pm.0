From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [RFC Add in_use attribute] Let the driver know if
	it's in use
Date: Thu, 23 Apr 2009 08:01:53 +0200
Message-ID: <49F00451.7010004@gandalf.sssup.it>
References: <20090416131323.GA16752@gandalf.sssup.it>
	<200904202354.04777.rjw@sisk.pl>
	<49ED530E.5010905@gandalf.sssup.it>
	<200904212046.45671.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904212046.45671.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Rafael J. Wysocki wrote:
> On Tuesday 21 April 2009, Michael Trimarchi wrote:
>   
>> Rafael J. Wysocki wrote:
>>     
>>> On Thursday 16 April 2009, Michael Trimarchi wrote:
>>>   
>>>       
>>>> Drivers on embedded systems would be smart enough
>>>> to know that some of the devices should remain powered up, because
>>>> they could still be useful even when the CPU wasn't running.
>>>> The patch add the in_use attribute, that it can be used by the
>>>> the drivers to avoid power down during suspend.
>>>>     
>>>>         
>>> OK, so the idea is that in_use will be set by the user space for devices that
>>> shouldn't be suspended.  Is this correct?
>>>
>>> Assuming it is, I'd call the flag 'in_use' rather than 'is_inuse'.  Also, if
>>> may_inuse is supposed to mean that we can set in_use for this device, I'd call
>>> it 'in_use_valid', I'd make it be unset by default and I'd allow the driver to
>>> unset it if it is going to react to 'in_use'.
>>>
>>>       
>> is_inuse is set for the device. The may_inuse is automatically setting 
>> for the child
>> device. This is done for automatically propagate the dependency
>>     
>
> I see.  I'd call it differently, then.
>
> Besides, is it really always the case that setting the flag for one device
> implies that the entire subtree below it should have the flag set?  IOW,
> there may be some devices in the subtree that we may want to suspend anyway,
> I think.
>   
There are two possible scenario here:
- propagate to the subtree for each device that its parent is in use
- leave to the user space marking the use/in_use status (i will change 
the name)

I don't see problem to write a function in userspace instead on kernel 
space.
We left the decision to suspend/not suspend to the driver. Is it correct?

So basically, just add the flag and set it in device structure and don't 
skip the
device during the suspend phase. This is can be a simple and clean solution.


Michael
