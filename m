From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: How to disable async resume for few selected devices
 (does it work?)
Date: Thu, 03 Jun 2010 19:12:54 +0300
Message-ID: <1275581574.2563.2.camel@maxim-laptop>
References: <Pine.LNX.4.44L0.1006031000060.1683-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006031000060.1683-100000@iolanthe.rowland.org>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-06-03 at 10:08 -0400, Alan Stern wrote: 
> On Thu, 3 Jun 2010, Maxim Levitsky wrote:
> 
> > On Wed, 2010-06-02 at 21:51 -0400, Alan Stern wrote: 
> > > On Thu, 3 Jun 2010, Maxim Levitsky wrote:
> > > 
> > > > I have a card reader on which one function implements SDHCI and other
> > > > MMC (to workaround windows bug....)
> > > > 
> > > > There is a way to disable MMC function, but is causes the device
> > > > sometimes to die on resume from disk/ram.
> > > > 
> > > > I today was told that MMC function is in fact _almost_ standard SDHCI
> > > > controller, and in fact now sdhci binds to it and works just fine.
> > > > 
> > > > However since both devices share same hardware they appear to have need
> > > > to be resumed one after another, and definitely not in parallel.
> > > > I tried to use device_disable_async_suspend on both pci devices and
> > > > indeed both power/async turns to false.
> > > > 
> > > > But they are still resumed in parallel:
> > > > (look how well mmc0 and mmc1 interleave...)
> > > > Why?
> > > 
> > > My guess is that you shouldn't have disabled async suspend on the PCI 
> > > devices but on their children instead.  That is, the PCI devices are 
> > > 0000:07:00.1 and 0000:07:00.2, but the devices causing your problem are 
> > > mmc0 and mmc1.  Or maybe you'd prefer to disable async suspend on all 
> > > four devices.
> > Nope, all childeren of both pci device has 'async' disabled.
> > Just checked that.
> 
> The mmc drivers probably do part of their work in a separate thread (a
> workqueue).  
They seems not to do so.


> But I'm not acquainted with those drivers and I don't know
> for certain.  You could get a clearer idea by putting printk statements
> at the beginning and end of the resume routines.  And a dump_stack()  
> would tell you for certain whether the routine was invoked
> asynchronously.
I will do that.

In fact it seems just to work now. I can't reproduce that anymore.
It strange. I double checked that power/async was disabled.
Maybe I am just lucky now and the suspend/resume functions still run in
async mode.

I checked pm code and it seems to be correct.


Best regards,
Maxim Levitsky
