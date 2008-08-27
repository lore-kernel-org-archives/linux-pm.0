From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Wed, 27 Aug 2008 07:22:58 +0200
Message-ID: <5E249C07-0710-49B2-B352-87DDA85E891D@holtmann.org>
References: <200808221520.19791.oliver@neukum.org>
	<200808262044.54445.rjw@sisk.pl>
	<200808262153.18240.oliver@neukum.org>
	<200808270128.16052.rjw@sisk.pl>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808270128.16052.rjw@sisk.pl>
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
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, Stefan Seyfried <seife@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

>>>>>> Good. Can you test what happens if you unplug the device while  
>>>>>> suspended
>>>>>> and hibernated?
>>>>>
>>>>> It's built-in, I can't unplug it. :-)
>>>>
>>>> Maybe you can disable it in the BIOS, but this might change the  
>>>> DSDT / other
>>>> system configuration, so it might break resume in other ways :-(
>>>
>>> There is a switch that's supposed to disable the radio (rfkill or  
>>> something).
>>> I used it to switch the radio off while the box was waking up from  
>>> hibernation
>>> and kbluetooth didn't find the adapter after the resume.  After  
>>> I've pressed
>>> the "radio off" button again, the bluetooth appears to be  
>>> functional again.
>>>
>>> However, this "radio off" button is shared between bluetooth and  
>>> wireless
>>> (b43) and there are some surprising interactions.  Nothing seems  
>>> to be broken,
>>> though.
>>
>> This doesn't explain the original failure. Can you comment out the  
>> support
>> for suspend/resume in the driver and try again?
>
> With that commented out, I'm able to reproduce the failure.  With  
> the original
> patch, I'm not.

I've never seen any issues with the suspend/resume and btusb, but I  
must admit that I am using an X61 and in that case pm-utils has a  
magic hack to disable Bluetooth before suspend and this means a clean  
disconnect from the USB bus.

Anyway, killing all URBs in-fly on suspend and bringing up the  
interrupt one on resume should do the right thing. However we have to  
check if we not just better resume all URBs and let the Bluetooth core  
handle lost connection during the suspended time.

Regards

Marcel
