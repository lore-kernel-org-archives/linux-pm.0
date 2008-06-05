From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [QUESTION] How to reset TCP connections when
	resuming system from disk/ram
Date: Fri, 6 Jun 2008 00:44:27 +0300
Message-ID: <200806060044.27310.maximlevitsky@gmail.com>
References: <200806020026.56875.maximlevitsky@gmail.com>
	<20080604145900.GA6762@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080604145900.GA6762@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 4 June 2008 17:59:00 Pavel Machek wrote:
> Hi!
> 
> > Thanks to your effort, the suspend to ram/disk works flawlessly on my
> > desktop system.
> > 
> > But I still have rather small, but annoying problem, that system doesn't
> > understands that a long suspend cycle was done, and still waits for long closed
> > TCP connections.
> > 
> > I remember there was a patch to close all TCP connections on suspend, but it was rejected
> > due to the fact that TCP sessions can live through short suspend/resume cycles.
> 
> Well... tcp sessions can survive even long suspends ... if there's no
> NAT nearby and both sides are quiescent...
Well, nat is close, (in my router....)

> 
> Dig out the patch and lets see if it can be made acceptable?
I will try, but currently I have very little free time, thus
I even haven't researched the suspen/resume problems on this notebook

> 
> > Btw, I recently bought an acer laptop (5720G), and there are few suspend/resume issues,
> > namely:
> > 
> > *attempt to do a second suspend to ram freezes the system hard on resume.
> > for example this works:
> > 
> > suspend to ram
> > suspend to disk
> > suspend to ram
> > suspend to disk
> > 
> > but this doesn't
> > 
> > suspend to ram
> > suspend to ram
> 
> Try it from minimum system, but this looks like acpi problem...
Probably, I will investigate thoughtfully this laptop, when I have free time,
It has several broken features including wireless (which works only with disable_hw_scan=1, and still buggy), leds, sound, some messages about
APIC 40 error, webcam that freezes afrer a minute or so, or in other words lots of fun....

It has also an XD and memstick reader that aren't supported - I will try to reverse engineer 
the windows driver, to add those drivers to linux (shouldn't be that hard).

I don't want to bother anybody with this stuff yet, since I have very little free time now.


Best regards,
	Maxim Levitsky
