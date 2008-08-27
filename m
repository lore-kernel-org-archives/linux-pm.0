From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.27-rc2 USB suspend regression
Date: Wed, 27 Aug 2008 14:36:30 -0700
Message-ID: <48B5C8DE.9050304__31602.1677725532$1219873230$gmane$org@goop.org>
References: <Pine.LNX.4.44L0.0808271729380.2137-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0808271729380.2137-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern wrote:
> On Wed, 20 Aug 2008, Jeremy Fitzhardinge wrote:
>
>   
>> Alan Stern wrote:
>>     
>>> On Wed, 20 Aug 2008, Jeremy Fitzhardinge wrote:
>>>
>>>   
>>>       
>>>> Using the Fedora Rawhide kernel RPM "2.6.27-0.238.rc2.fc10.i686"
>>>> (kernel-2.6.27-0.238.rc2.fc10.i686), I'm seeing suspend to ram
>>>> failures.  The suspend seems to go OK, but then I just get endless:
>>>>
>>>> usb 5-1: uhci_result_common: failed with status 440000
>>>>
>>>> messages, with occasional flickers of something else being printed
>>>> (perhaps).  The machine is otherwise unresponsive.
>>>>     
>>>>         
>>> You could comment out that error message in order to see what else is 
>>> in the log.  It is located in drivers/usb/host/uhci-q.c in the 
>>> uhci_result_common() function.
>>>
>>> You could try running -rc3 instead of -rc2, although that probably 
>>> won't make much difference.
>>>
>>> What USB devices do you have on the failing system?  In particular,
>>> what is 5-1?  If you unplug it before suspending, does the problem go
>>> away?  (It certainly should!)
>>>
>>>   
>>>       
>> No external usb devices.  There are three internal USB devices:
>> Bluetooth, a Sierra CDMA modem thingy and a fingerprint reader.
>>
>> $ lsusb
>> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> Bus 005 Device 003: ID 0483:2016 SGS Thomson Microelectronics
>> Fingerprint Reader
>> Bus 005 Device 002: ID 0a5c:2110 Broadcom Corp. Bluetooth Controller
>> Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> Bus 003 Device 003: ID 1199:0218 Sierra Wireless, Inc. MC5720 Wireless Modem
>> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>>
>> The rfkill switch "unplugs" the two wireless devices, so I'll try that
>> before suspending next time (if I remember).
>>     
>
> Is this still a problem?
>   

I haven't seen it lately, but it was fairly erratic anyway.  It happened
a few times in quick succession, and then it all worked fine.  The
rawhide kernels are getting fairly old (I guess RH is still trying to
pull its infrastructure together), so I'm running a fairly recent
self-compiled kernel.  Will report anything I see.

> Is this related to other Bluetooth suspend/resume regressions in 
> 2.6.27?
>   

I'm not sure if its BT or Sierra wireless related.

    J
