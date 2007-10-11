From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [QUESTION] I need advice for writing
	.suspend/.resume functions
Date: Fri, 12 Oct 2007 00:15:29 +0200
Message-ID: <200710120015.30607.rjw__43946.7979864732$1192140109$gmane$org@sisk.pl>
References: <200710110513.10753.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710110513.10753.maximlevitsky@gmail.com>
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
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

Well, unfortunately I have only a little experience with writing device
drivers, so please take my comments below with a grain of salt.

Also, I think it's better to discuss this on linux-pm to which some more
experienced people are subscribed.

On Thursday, 11 October 2007 05:13, Maxim Levitsky wrote:
> Hi,
> 
> I have few questions about .suspend()/.resume() driver functions and how best to write them.
> 
> I have written a support for suspend/resume for saa7134 v4l driver.
> Now looking at code again and again, I found few problems, and I am seeking your advice how to fix them.
> 
> First of all the .suspend() function:
> 
> Looking at various drivers (including v4l ones) it seems that in general the function:
> 
> 1) tells upper layers that it is suspended
> 2) saves the state of device
> (generally there is nothing to save, since the driver maintains a copy of device state in memory)
> 
> 3) disables the device (including DMA)
> 4) does usual pci_save_state+pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state))
> (I am talking about pci devices of course)
> 
> But there is one problem that my .suspend() function have together with quite a lot of drivers:
> It can race with IRQ handler. Suppose the handler is called just before .suspend(), and thus .suspend() literally 
> pulls the hadware from that handler.
>
> I was told that I should use synchronize_irq(), and it looks exactly like the solution.

Yes, that seems to be the right solution.

> But I was surprised to see that very few drivers use it in their .suspend() routines.

Frankly, I'm not sure why that is so.

> Another issue, even bigger happens during the resume:
> Suppose the IRQ line is shared with some other device and it gets resumed first.
> And my IRQ handler is called because of the other device.
> Now my IRQ handler can't determine whenever the IRQ for the device, since the hardware is still powered off.
> 
> Probably I can fix the following issues doing this:
> 
> 1) do free_irq() in .suspend(), and request_irq() in .resume
> this solves both problems since free_irq()  calls synchronize_irq()
> Few drivers do that this way. I would like to know if this is the right way.

AFAICS, it is not and these drivers should probably be modified not to do so.

The problem, as I see it, is that we don't know what state the device will be
in during the resume (this may be a resume from disk and the device may have
been initialized by the BIOS and we get it actually generating interrupts).
 
> 2) Disable the card's IRQ register , then call synchronize_irq(), at that
> point I can be sure that no IRQ handler is running and will run then set some
> per device flag say dev->insuspend 
> 
> let IRQ handler check this flag, and bail out if set, so false interrupts are caught on resume
> Probably not a good idea, since I didn't find such implementation in kernel

I'm not sure of that.  Sounds better than freeing the IRQs in .suspend() to me.

Greetings,
Rafael
