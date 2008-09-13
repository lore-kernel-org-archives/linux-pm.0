From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] e100: Use pci_pme_active to clear PME_Status
 and disable PME#
Date: Sat, 13 Sep 2008 16:15:56 -0400
Message-ID: <48CC1F7C.7050908__18096.3715109558$1221337148$gmane$org@garzik.org>
References: <200808051730.27599.alessandro.guido@gmail.com>
	<200808080000.07156.rjw@sisk.pl> <200808080014.25493.rjw@sisk.pl>
	<200808080018.05887.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808080018.05887.rjw@sisk.pl>
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
Cc: Alessandro Guido <alessandro.guido@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, netdev@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> e100: Use pci_pme_active to clear PME_Status and disable PME#
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ---
>  drivers/net/e100.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Index: linux-2.6/drivers/net/e100.c
> ===================================================================
> --- linux-2.6.orig/drivers/net/e100.c
> +++ linux-2.6/drivers/net/e100.c
> @@ -2738,9 +2738,7 @@ static int __devinit e100_probe(struct p
>  		nic->flags |= wol_magic;
>  
>  	/* ack any pending wake events, disable PME */
> -	err = pci_enable_wake(pdev, 0, 0);
> -	if (err)
> -		DPRINTK(PROBE, ERR, "Error clearing wake event\n");
> +	pci_pme_active(pdev, false);

Since I am rusty on my PCI...  why is this needed?
