From: Michael-Luke Jones <mlj28@cam.ac.uk>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 11:41:01 +0100
Message-ID: <A6BCA565-F147-493B-9DF6-7509F1D60071@cam.ac.uk>
References: <200705272229.21263.rjw@sisk.pl>
	<20070527220412.GC22687@srcf.ucam.org>
	<1180304166.3131.66.camel@lov.localdomain>
	<200705280943.54312.rjw@sisk.pl>
	<9D3FC259-8391-4C2F-9F0F-AEF6CB3030E8@cam.ac.uk>
	<1180343171.4242.15.camel@lov.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1180343171.4242.15.camel@lov.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Rob Landley <rob@landley.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Now a technical rather than emotional response...

On 28 May 2007, at 10:06, Kay Sievers wrote:

>> At device driver load, firmware loading must be asynchronous. This is
>> because device driver init can occur before userspace runs and
>> registers a hotplug/uevent event handler. If device use is attempted
>> before firmware loads, a -ENOFIRMWARE call would be great so that
>> userspace and thus the user can be clearly informed what the  
>> problem is.
>
> Why would a driver create an interface before it has the needed
> firmware loaded?

A valid point. But there should be some kind of error notification if  
firmware loading hasn't happened correctly rather than a permanent  
asynchronous wait in which the interface fails to turn up. Possibly a  
kernel information printk or something, which does not exist at the  
moment.

>> However, at 'first use' firmware loading, the synchronous interface
>> should remain. 'ifconfig up' either works or it doesn't, and as I see
>> it, has to just hang around until firmware turns up.
>
> What kind of network driver does create an interface for a
> non-functioning device? That sounds like a bug on its own.

Unclear. My point was that when ifconfig up exits, the interface  
should be up, not asynchronously waiting for firmware to be loaded,  
then taken up in the background. Thus, firmware loading in this case  
should be kept synchronous, in my opinion.

> If a driver binds to a device, it should just have the firmware  
> already
> loaded, and not wait until its used. What's the reason for such a
> behavior, to let a driver pretend it can handle a device, but it  
> doesn't
> even know if all the needed pieces are available on the system?

  Basically, you have a device which can carry out different  
functions depending on the firmware loaded into it. Driver A is  
specific to this device, and loads the firmware. Driver B uses  
functions exported by Driver A to carry out one particular function  
of the device. Driver C uses the same functions to carry out a  
totally different function on the same device, but with different  
firmware loaded.

Add in multiple devices handled by Driver A, all with different  
functionality, and sometimes with combinations of functionality that  
can coexist, and you see that when Driver A loads it cannot possibly  
know which firmware to load, but must wait for other Drivers to turn  
up and be put into use. Thus it 'pretends' to handle all the devices  
until it's forced to make a choice.

Yes, this is hellishly complicated. Blame Intel :)

> The underlying issue are the driver authors, that's not so easy to
> fix. :)

Addressed in previous email.

> Well, 10 seconds are just to short for userspace to react on some
> setups, from tiny boxes which are busy, to 512 CPU boxes enumerating
> thousands of devices, all had problems here. Any timeout for a
> firmware-request is just a broken concept, the request should wait
> forever, to be fulfilled or canceled from userspace when it's ready.

Absolutely. I said this in an earlier email and suggested rejecting  
this patchset on the grounds that it was another bodge covering over  
a fundamentally broken area of the kernel :)

> Kay

Michael-Luke Jones
