From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Resume hangs [was: mmotm 2010-12-02-16-34 uploaded]
Date: Mon, 31 Jan 2011 22:40:23 +0100
Message-ID: <4D472C47.7010900__39063.7022945613$1296511473$gmane$org@gmail.com>
References: <201012030107.oB317ZSW019223@imap1.linux-foundation.org>
	<4D25CF4A.9090202@gmail.com> <4D38538E.9070104@gmail.com>
	<201101202202.01089.rjw@suse.com> <4D472B9E.5090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D472B9E.5090000@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@suse.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 01/31/2011 10:37 PM, Jiri Slaby wrote:
> On 01/20/2011 10:02 PM, Rafael J. Wysocki wrote:
>> On Thursday, January 20, 2011, Jiri Slaby wrote:
>>> On 01/06/2011 03:18 PM, Jiri Slaby wrote:
>>>> On 12/14/2010 11:22 PM, Rafael J. Wysocki wrote:
>>>>> On Tuesday, December 14, 2010, Jiri Slaby wrote:
>>>>>> On 12/13/2010 10:10 PM, Rafael J. Wysocki wrote:
>>>>>>> On Monday, December 13, 2010, Jiri Slaby wrote:
>>>>>>>> On 12/05/2010 02:08 PM, Rafael J. Wysocki wrote:
>>>>>>>>> On Sunday, December 05, 2010, Jiri Slaby wrote:
>>>>>>>>>> On 12/03/2010 01:34 AM, akpm@linux-foundation.org wrote:
>>>>>>>>>>> The mm-of-the-moment snapshot 2010-12-02-16-34 has been uploaded to
>>>>>>>>>>
>>>>>>>>>> Hi, this kernel regresses with respect to resume. It doesn't wake up,
>>>>>>>>>> the screen is black with blinking cursor at position [1, 1].
>>>>>>>>>> 2010-11-23-16-12 seemed to be OK. In this one it is 100% reproducible so
>>>>>>>>>> far.
>>>>>>>>>>
>>>>>>>>>> I'm using pm-suspend, any ideas what to test before I start to find the
>>>>>>>>>> reason on my own?
>>>>>>>>>
>>>>>>>>> Please try the pm_test tests for core, processors and devices, eg.:
>>>>>>>>
>>>>>>>> Hmm, I haven't seen the issues since then. So it had to be some kind of
>>>>>>>> coincidence -- I see the issue occasionally for some time already. Now
>>>>>>>> it triggered twice in a row after I updated the kernel.
>>>>>>>
>>>>>>> Hmm.  What hardware is that?
>>>>>>
>>>>>> What exactly do you want to know about it? It's some specific intel
>>>>>> desktop machine, 3 years old, 2 intel cores, 6G of mem, 2 sata disks in
>>>>>> raid, dvb-t usb receiver (af9015), usb keyboard and mouse.
>>>>>
>>>>> I'm seeing pretty much the same symptoms on quite different hardware, except
>>>>> for one thing: USB keyboard and mouse.
>>>>>
>>>>> Have you checked if writing 0 to /sys/power/pm_async helps?
>>>>
>>>> It's very hard to reproduce (it happens once a week or two), so I can't
>>>> say yet. As it happened yesterday again, going to test it from now on.
>>>
>>> Ok, I haven't seen the issue with 0 in /sys/power/pm_async for two weeks
>>> now (I added it to boot.local). I would say it's related to that...
>>
>> In that case the next step would be to build the kernel with
>> CONFIG_PM_ADVANCED_DEBUG set and try to switch the async flag for individual
>> devices (it is located is /sys/devices/.../power/ for each device).
>>
>> For example, I wonder if it is sufficient to unset it for all USB devices.
> 
> It seems to suffice... No hangs still. Should I enable pm_async back
> again to confirm the issue is still present?

BTW. I'm currently writing "disabled" into:
/sys/bus/usb/devices/usb1/power/async
/sys/bus/usb/devices/usb2/power/async
/sys/bus/usb/devices/usb3/power/async
/sys/bus/usb/devices/usb4/power/async
/sys/bus/usb/devices/usb5/power/async
/sys/bus/usb/devices/usb6/power/async
/sys/bus/usb/devices/usb7/power/async
/sys/bus/usb/devices/usb8/power/async
/sys/bus/usb/devices/1-0:1.0/power/async
/sys/bus/usb/devices/2-0:1.0/power/async
/sys/bus/usb/devices/2-6/power/async
/sys/bus/usb/devices/2-6:1.0/power/async
/sys/bus/usb/devices/2-6:1.1/power/async
/sys/bus/usb/devices/3-0:1.0/power/async
/sys/bus/usb/devices/4-0:1.0/power/async
/sys/bus/usb/devices/4-2/power/async
/sys/bus/usb/devices/4-2.1/power/async
/sys/bus/usb/devices/4-2:1.0/power/async
/sys/bus/usb/devices/4-2.1:1.0/power/async
/sys/bus/usb/devices/4-2.1:1.1/power/async
/sys/bus/usb/devices/4-2.2/power/async
/sys/bus/usb/devices/4-2.2:1.0/power/async
/sys/bus/usb/devices/5-0:1.0/power/async
/sys/bus/usb/devices/6-0:1.0/power/async
/sys/bus/usb/devices/7-0:1.0/power/async
/sys/bus/usb/devices/8-0:1.0/power/async


/sys/power/pm_async is 1

lsusb:
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 002: ID 0413:6029 Leadtek Research, Inc. WinFast DTV
Dongle Gold
Bus 004 Device 002: ID 04b4:2050 Cypress Semiconductor Corp. hub
Bus 004 Device 003: ID 0458:004c KYE Systems Corp. (Mouse Systems)
Slimstar Pro Keyboard
Bus 004 Device 004: ID 045e:00f0 Microsoft Corp.


regards,
-- 
js
