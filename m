From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/7] PCI PM: Fix handling of devices without
	drivers
Date: Wed, 04 Feb 2009 12:53:53 +1100
Message-ID: <1233712433.16867.133.camel__12876.9119656228$1233712692$gmane$org@pasglop>
References: <200902040154.36018.rjw@sisk.pl> <200902040156.15200.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902040156.15200.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Sesterhenn <snakebyte@gmx.de>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> -static void pci_pm_default_suspend(struct pci_dev *pci_dev)
> +static void pci_pm_default_suspend(struct pci_dev *pci_dev, bool prepare)
>  {
>  	pci_pm_default_suspend_generic(pci_dev);
>  
> -	if (!pci_is_bridge(pci_dev))
> +	if (prepare && !pci_is_bridge(pci_dev))
>  		pci_prepare_to_sleep(pci_dev);

Minor nit: It took me a while to understand the patch because of the use
of the word "prepare" which we easily confuse with the prepare suspend
phase.

Might be worth using a different terminology...

Cheers,
Ben.
