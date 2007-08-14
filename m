From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC][PATCH] uli526x: Add suspend and resume
	routines (updated)
Date: Tue, 14 Aug 2007 01:58:17 -0400
Message-ID: <46C14479.1080206__7631.93726675144$1187071258$gmane$org@garzik.org>
References: <200708052114.01790.rjw@sisk.pl> <200708080024.28692.rjw@sisk.pl>
	<46B8F19D.6060406@garzik.org> <200708080056.41651.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708080056.41651.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kyle McMartin <kyle@mcmartin.ca>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Grant Grundler <grundler@parisc-linux.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Wednesday, 8 August 2007 00:26, Jeff Garzik wrote:
>> Rafael J. Wysocki wrote:
>>> On Tuesday, 7 August 2007 23:40, Jeff Garzik wrote:
>>>> I'll let our new tulip maintainer see what he thinks about the 
>>>> implementation.  Seems fairly sane to me, but should at least get an "it 
>>>> works" test.
>>> It has been tested, as stated in the changelog, and works (on my test system).
>>
>> Apologies, I missed this.  I'll look to our new tulip maintainer to 
>> queue your resent patch, or at least ACK it...
> 
> OK
> 
> Below is the updated version.  It's functionally equivalent to the previous one.
> 
> Greetings,
> Rafael
> 
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Add suspend/resume support to the uli526x network driver (tested on x86_64,
> with 'Ethernet controller: ALi Corporation M5263 Ethernet Controller, rev 40').
> 
> This patch is based on the suspend/resume code in the tg3 driver.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/net/tulip/uli526x.c |  109 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 103 insertions(+), 6 deletions(-)
> 
> Index: linux-2.6.23-rc2/drivers/net/tulip/uli526x.c
> ===================================================================
> --- linux-2.6.23-rc2.orig/drivers/net/tulip/uli526x.c
> +++ linux-2.6.23-rc2/drivers/net/tulip/uli526x.c
> @@ -1110,19 +1110,15 @@ static void uli526x_timer(unsigned long 
>  
>  
>  /*
> - *	Dynamic reset the ULI526X board
>   *	Stop ULI526X board
>   *	Free Tx/Rx allocated memory
> - *	Reset ULI526X board
> - *	Re-initialize ULI526X board
> + *	Init system variable
>   */
>  
> -static void uli526x_dynamic_reset(struct net_device *dev)
> +static void uli526x_reset_prepare(struct net_device *dev)
>  {
>  	struct uli526x_board_info *db = netdev_priv(dev);
>  
> -	ULI526X_DBUG(0, "uli526x_dynamic_reset()", 0);
> -
>  	/* Sopt MAC controller */
>  	db->cr6_data &= ~(CR6_RXSC | CR6_TXSC);	/* Disable Tx/Rx */
>  	update_cr6(db->cr6_data, dev->base_addr);
> @@ -1141,6 +1137,22 @@ static void uli526x_dynamic_reset(struct
>  	db->link_failed = 1;
>  	db->init=1;
>  	db->wait_reset = 0;
> +}
> +
> +
> +/*
> + *	Dynamic reset the ULI526X board
> + *	Stop ULI526X board
> + *	Free Tx/Rx allocated memory
> + *	Reset ULI526X board
> + *	Re-initialize ULI526X board
> + */
> +
> +static void uli526x_dynamic_reset(struct net_device *dev)
> +{
> +	ULI526X_DBUG(0, "uli526x_dynamic_reset()", 0);
> +
> +	uli526x_reset_prepare(dev);
>  
>  	/* Re-initialize ULI526X board */
>  	uli526x_init(dev);
> @@ -1150,6 +1162,89 @@ static void uli526x_dynamic_reset(struct
>  }
>  
>  
> +#ifdef CONFIG_PM_SLEEP
> +
> +/*
> + *	Suspend the interface.
> + */
> +
> +static int uli526x_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	pci_power_t power_state;
> +	int err;
> +
> +	ULI526X_DBUG(0, "uli526x_suspend", 0);
> +
> +	if (!(dev && netdev_priv(dev)))
> +		return 0;

> +static int uli526x_resume(struct pci_dev *pdev)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct uli526x_board_info *db = netdev_priv(dev);
> +	int err;
> +
> +	ULI526X_DBUG(0, "uli526x_resume", 0);
> +
> +	if (!(dev && db))
> +		return 0;


Two comments:

1) Like akpm, the CONFIG_PM_SLEEP is out of place.  All other drivers 
use CONFIG_PM

2) just remove the !dev checks, that is an impossible condition
