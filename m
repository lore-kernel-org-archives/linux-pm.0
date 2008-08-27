From: Pavel Machek <pavel@suse.cz>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Wed, 27 Aug 2008 11:10:32 +0200
Message-ID: <20080827091031.GA1688__21281.9501212381$1219833018$gmane$org@elf.ucw.cz>
References: <200808221520.19791.oliver@neukum.org>
	<200808262044.54445.rjw@sisk.pl>
	<200808262153.18240.oliver@neukum.org>
	<200808270128.16052.rjw@sisk.pl>
	<5E249C07-0710-49B2-B352-87DDA85E891D@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5E249C07-0710-49B2-B352-87DDA85E891D@holtmann.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@lists.linux-foundation.org, Stefan Seyfried <seife@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wed 2008-08-27 07:22:58, Marcel Holtmann wrote:
> Hi Rafael,
>
>>>>>>> Good. Can you test what happens if you unplug the device while 
>>>>>>> suspended
>>>>>>> and hibernated?
>>>>>>
>>>>>> It's built-in, I can't unplug it. :-)
>>>>>
>>>>> Maybe you can disable it in the BIOS, but this might change the DSDT / 
>>>>> other
>>>>> system configuration, so it might break resume in other ways :-(
>>>>
>>>> There is a switch that's supposed to disable the radio (rfkill or 
>>>> something).
>>>> I used it to switch the radio off while the box was waking up from 
>>>> hibernation
>>>> and kbluetooth didn't find the adapter after the resume.  After I've 
>>>> pressed
>>>> the "radio off" button again, the bluetooth appears to be functional 
>>>> again.
>>>>
>>>> However, this "radio off" button is shared between bluetooth and 
>>>> wireless
>>>> (b43) and there are some surprising interactions.  Nothing seems to be 
>>>> broken,
>>>> though.
>>>
>>> This doesn't explain the original failure. Can you comment out the 
>>> support
>>> for suspend/resume in the driver and try again?
>>
>> With that commented out, I'm able to reproduce the failure.  With the 
>> original
>> patch, I'm not.
>
> I've never seen any issues with the suspend/resume and btusb, but I must 
> admit that I am using an X61 and in that case pm-utils has a magic hack to 
> disable Bluetooth before suspend and this means a clean disconnect from the 
> USB bus.

I was using x60 _without_ that script, and it was okay for long long
time, but it has problems now. Something regressed somewhere.

Rafael, could you try if 2.6.26 suspends ok if you don't unload
anything?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
