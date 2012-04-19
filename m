From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 19 Apr 2012 14:13:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204191411360.1154-100000@iolanthe.rowland.org>
References: <1334858921.28106.66.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1334858921.28106.66.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jrnieder@gmail.com, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 19 Apr 2012, Steven Rostedt wrote:

> Rebuilt with mrproper, and confirming the patch was added.
> 
> It still locked up. But, I looked at your patch and mine and realized
> that mine applied with some "FUZZ".
> 
> Mine:
> 
> @@ -1723,6 +1723,8 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
>         pci_power_t target_state = pci_target_state(dev);
>         int error;
>  
> +       if (1)
> +               target_state = PCI_D0;
>         if (target_state == PCI_POWER_ERROR)
>                 return -EIO;
> 
> Yours:
> 
> @@ -1713,6 +1713,8 @@ int pci_prepare_to_sleep(struct pci_dev
>         pci_power_t target_state = pci_target_state(dev);
>         int error;
>  
> +       if (1)
> +               target_state = PCI_D0;
>         if (target_state == PCI_POWER_ERROR)
>                 return -EIO;
> 
> Mine applied to pci_finish_runtime_suspend not pci_prepare_to_sleep :-p
> I'm using 3.2.5.

Whoops!  That'll do it.  The names say it all: one routine is used for
runtime PM and the other is used for system sleep.  The two functions
are very similar, so naturally "patch" got confused.

Alan Stern
