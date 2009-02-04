From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/7] PCI PM: Check if the state has been
 saved before trying to restore it
Date: Wed, 04 Feb 2009 12:54:26 +1100
Message-ID: <1233712466.16867.134.camel__20145.0791130357$1233712813$gmane$org@pasglop>
References: <200902040154.36018.rjw@sisk.pl> <200902040157.23385.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902040157.23385.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2009-02-04 at 01:57 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Check if the standard configuration registers of a PCI device have
> been saved during suspend before trying to restore them during
> resume.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-By: Benjamin Herrenschmidt <benh@kernel.crashing.org>


> ---
>  drivers/pci/pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/pci/pci.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci.c
> +++ linux-2.6/drivers/pci/pci.c
> @@ -1421,7 +1421,7 @@ int pci_restore_standard_config(struct p
>  	dev->current_state = PCI_D0;
>  
>   Restore:
> -	return pci_restore_state(dev);
> +	return dev->state_saved ? pci_restore_state(dev) : 0;
>  }
>  
>  /**
