From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [RFC Disable suspend on a specific device] This is a
 little change in linux power scheme
Date: Wed, 08 Apr 2009 10:45:54 +0200
Message-ID: <49DC6442.3040506@gandalf.sssup.it>
References: <200904072257.23756.rjw@sisk.pl> <200904081013.25301.rjw@sisk.pl>
	<49DC5F58.7070705@gandalf.sssup.it>
	<200904081034.56624.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904081034.56624.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Wednesday 08 April 2009, Michael Trimarchi wrote:
>   
>> Rafael J. Wysocki wrote:
>>     
>>> On Wednesday 08 April 2009, Michael Trimarchi wrote:
>>>   
>>>       
>>>> Hi,
>>>>
>>>> Nigel Cunningham wrote:
>>>>     
>>>>         
>>>>> Hi.
>>>>>
>>>>> On Tue, 2009-04-07 at 23:38 +0200, Pavel Machek wrote:
>>>>>       
>>>>>           
>>>>>> Well.... userspace should not have to decide this. If userspace tells
>>>>>> kernel not to suspend video card (on PC/ACPI), then we either honour
>>>>>> the request, or violate ACPI spec (and probably break suspend).
>>>>>>         
>>>>>>             
>>>>> What about the cases where the ACPI spec is irrelevant? (As I understand
>>>>> it, not all embedded boards use ACPI). Would this be a good approach in
>>>>> those cases? If so, perhaps the trick would be to make the functionality
>>>>> depend on !CONFIG_ACPI?
>>>>>       
>>>>>           
>>>> It can be an option, or just add only in embedded configuration where is 
>>>> not ACPI configured.
>>>> The dependences is allready provided by the kernel. The default is to 
>>>> have suspend enabled.
>>>> The user level access it's needed because the kernel does't exacly know 
>>>> when the device must remain on/off during suspend.
>>>>     
>>>>         
>>> So, who exactly is going to have that information?  Does it depend on a user
>>> decision on something else?  If something else, then what?
>>>   
>>>       
>> An example:
>>
>> - a user has a blootooth handset and make a call so the application 
>> framework
>> know that that device are reserverd or blocked and are usefull for maintains
>> the call on. but linux can suspend without problem. So the user level
>> echo "disabled" for exaple to the 
>> /sys/devices/platform/soc-audio/power/disabled
>> and avoid suspending of audio devices and subdevice like aplifier, 
>> switch , etc. This
>> increase life battery of system, because permits a partial suspend.
>>     
>>>   
>>>       
>>>> This api change can't cover any possible scenario but
>>>> introduce a flexbility scheame in suspend process. Avoid suspend in some 
>>>> device can be obtain
>>>> looking at dependece too? I don't know exacly if the acpi capapiblity 
>>>> can be seen throw the
>>>> link to a bus or a specific class, but we can limit it to the platform 
>>>> device instead all device.
>>>>     
>>>>         
>>> If I understand it correctly, the behavior you'd like to obtain is quite
>>> similar to the one of wake-up devices that usually also need to remain
>>> powered (at least to some extent) during suspend.  This, however, is handled
>>> by the drivers of that devices, in their suspend callbacks.
>>>
>>> How is your device different from the other wake-up devices?
>>>   
>>>       
>> The difference from the wakeup device it's if I remember that they are 
>> suspendend
>> but ready to wakeup on external input. I want that device remain on, so 
>> I think that is
>> a little different beahvior. It's like to have a PM_DEVICE configuration 
>> dynamic instead of static.
>>     
>
> OK, thanks.
>
> I think this is a rather fundamental issue and it requires some more thought.
>
> What platform is your device based on, BTW?
>
> Rafael
>
>   
I'm working on an openmoko freerunner gta02 and do some work on android 
framework.
It's a smartphone
http://wiki.openmoko.org/wiki/Main_Page

The bluetooth device for example in the Freerunner has a direct I2S connection to
the WM8753.  Audio from a bluetooth headset is decoded by and sent digitially 
to the WM8753 which does the digital to analogue conversion and 
routes it out via the appropriate outputs.
Analogue problem has the ti-caplyso when the audio is routed for a phone call.

Is the correct answer to you question?

Michael
