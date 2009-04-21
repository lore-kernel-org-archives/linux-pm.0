From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [RFC Add in_use attribute] Let the driver know if
	it's in use
Date: Tue, 21 Apr 2009 08:43:28 +0200
Message-ID: <49ED6B10.9060005@gandalf.sssup.it>
References: <20090416131323.GA16752@gandalf.sssup.it>
	<200904202354.04777.rjw@sisk.pl> <20090420224555.GA28697@kroah.com>
	<49ED54DC.6040407@gandalf.sssup.it>
	<20090421061754.GA20726@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090421061754.GA20726@kroah.com>
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

Hi

Greg KH wrote:
> On Tue, Apr 21, 2009 at 07:08:44AM +0200, Michael Trimarchi wrote:
>   
>> Hi,
>>
>> Greg KH wrote:
>>     
>>> On Mon, Apr 20, 2009 at 11:54:04PM +0200, Rafael J. Wysocki wrote:
>>>   
>>>       
>>>> On Thursday 16 April 2009, Michael Trimarchi wrote:
>>>>     
>>>>         
>>>>> Drivers on embedded systems would be smart enough
>>>>> to know that some of the devices should remain powered up, because
>>>>> they could still be useful even when the CPU wasn't running.
>>>>> The patch add the in_use attribute, that it can be used by the
>>>>> the drivers to avoid power down during suspend.
>>>>>       
>>>>>           
>>>> OK, so the idea is that in_use will be set by the user space for devices that
>>>> shouldn't be suspended.  Is this correct?
>>>>     
>>>>         
>>> If so, why?  Why would you suspend anything then?  Why not just have
>>> userspace suspend the devices it wants to suspend and leave the ones it
>>> thinks is "in_use" alone?
>>>
>>>   
>>>       
>> Because it the previus thread the idea is that the driver should use 
>> this flag
>>
>> "[linux-pm] [RFC Disable suspend on a
>> specific device] This is a little change in linux power scheme".
>>     
>
> I wasn't involved in that thread, and am not on linux-pm, care to
> summarize why this change is now recommended?
>   
Sorry, I try to summurize:

There are embededd system that has some devices used by the cpu and other
unit. So in linux suspend the cpu, call the suspend to all the devices
and can power-off devices that are used by other subsystem. The first
patch that I send add an attribute and avoid suspend on devices that are flagged
and use the pm subsystem do skip suspend on that device. 
This second patch let to device this possibility.


>   
>>> Exactly, what are you trying to do that differs from
>>> device_for_each_child()?
>>>   
>>>       
>> Is device for each child use to visist the first level of the tree?
>>     
>
> Have you tried it?
>   
No, I take a look at the code.

int device_for_each_child(struct device *parent, void *data,
                          int (*fn)(struct device *dev, void *data))
{
        struct klist_iter i;
        struct device *child;
        int error = 0;

        klist_iter_init(&parent->p->klist_children, &i);

I was thinking that the klist_children is the fist_level one children, 
so each time
a device is registerd it add the link to the parent.

        while ((child = next_device(&i)) && !error)
                error = fn(child, data);
        klist_iter_exit(&i);

So if I want to walk the tree I must visit the children of the any 
child. Sorry,
maybe I miss somenthing.
> thanks,
>
> greg k-h
>
>   
Michael
