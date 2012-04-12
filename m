From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 12:33:22 -0400
Message-ID: <1334248402.23924.337.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204121017460.1496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204121017460.1496-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jrnieder@gmail.com, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2012-04-12 at 10:28 -0400, Alan Stern wrote:

> Hmmm.  This is a situation where the wakeup setting might matter.  Did 
> the /sys/bus/pci/devices/0000:00:1[ad].0/power/wakeup files both 
> contain "enabled" when you ran the test?

They're both enabled for me too.

> 
> Here's a diagnostic patch that will give us a little more information.  
> Keep the previous change (so that pci_prepare_to_sleep gets called 
> whether ehci-hcd is bound or not) and let's see what it says.  Try 
> doing it both with and without ehci-hcd bound.  Running this with "echo 
> devices >/sys/power/pm_test" ought to be good enough.

Where do I read out the dev info?

-- Steve

> 
> Alan Stern
> 
> 
> 
> Index: usb-3.4/drivers/pci/pci.c
> ===================================================================
> --- usb-3.4.orig/drivers/pci/pci.c
> +++ usb-3.4/drivers/pci/pci.c
> @@ -1720,6 +1720,9 @@ int pci_prepare_to_sleep(struct pci_dev
>  
>  	error = pci_set_power_state(dev, target_state);
>  
> +	dev_info(&dev->dev, "target %d wakeup %d error %d\n",
> +			target_state, device_may_wakeup(&dev->dev), error);
> +
>  	if (error)
>  		pci_enable_wake(dev, target_state, false);
>  
