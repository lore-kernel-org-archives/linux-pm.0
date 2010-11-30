From: Benjamin Poirier <benjamin.poirier@gmail.com>
Subject: Re: BUG, regression. usb-serial adapter broken by PM?
Date: Tue, 30 Nov 2010 10:11:13 -0500
Message-ID: <4CF51411.2070609__45503.8466876887$1291131802$gmane$org@gmail.com>
References: <4CF458CE.2050603@gmail.com> <20101130032625.GB12851@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101130032625.GB12851@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: Len Brown <len.brown@intel.com>, Johan Hovold <jhovold@gmail.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Mohr <andi@lisas.de>, Daniel Sangorrin <daniel.sangorrin@gmail.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 29/11/10 10:26 PM, Greg KH wrote:
> On Mon, Nov 29, 2010 at 08:52:14PM -0500, Benjamin Poirier wrote:
>> Hello,
>>
>> Recently, my usb-serial converter has become unusable. Attempts to open
>> the device always fail with:
>> open("/dev/ttyUSB0", O_RDONLY)          = -1 EAGAIN (Resource temporarily unavailable)
>>
>> The device is a:
>> ID 0c52:2101 Sealevel Systems, Inc. Serial Converter
>> and uses the ftdi_sio driver.
>>
>> I've bisected this problem to
>> commit 1bfee5bc86fdaecc912e06080583eddab7263df2
>> Author: Alan Stern <stern@rowland.harvard.edu>
>> Date:   Sat Sep 25 23:35:00 2010 +0200
>>
>>     PM / Runtime: Merge synchronous and async runtime routines
>>
>> I have other usb-serial converters that use other drivers and that are
>> unaffected. I have noticed the problem on a x86_64 machine (.config
>> here: http://pastebin.ca/2006414) and can reproduce it in kvm (with usb
>> passthrough, .config here: http://pastebin.ca/2006416).
>>
>> I'll be glad to provide more info or try patches.
> 
> A patch to resolve this was sent to linux-usb@vger.kernel.org yesterday,
> can you try that one out (sorry, can't dig it out at the moment...)

I think that's the one:
http://www.spinics.net/lists/linux-usb/msg39257.html

It indeed fixes the problem. Thanks!

btw. it seems I was late to the game, I should've checked bugzilla too,
https://bugzilla.kernel.org/show_bug.cgi?id=23012

-Ben

> 
> thanks,
> 
> greg k-h
