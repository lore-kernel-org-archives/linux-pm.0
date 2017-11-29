From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 4/9] PCI: Export pci_find_host_bridge()
Date: Wed, 29 Nov 2017 09:35:53 -0800
Message-ID: <20171129173553.GA27742@infradead.org>
References: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
 <1511638333-22951-5-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511638333-22951-5-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org, frowand.list@gmail.com, bhelgaas@google.com, rjw@rjwysocki.net, tglx@linutronix.de, vidyas@nvidia.com, kthota@nvidia.com, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 26, 2017 at 01:02:08AM +0530, Manikanta Maddireddy wrote:
> PCI subsystem pass pci_bus pointer to pci_ops callback functions, Tegra
> host driver use pci_find_host_bridge() to get pci_host_bridge from pci_bus.
> Export pci_find_host_bridge() to allow Tegra PCIe driver to be compiled as
> loadable kernel module.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2:
> * commit message update
> 
>  drivers/pci/host-bridge.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index add66236215c..e0942fc086ad 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -22,6 +22,7 @@ struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
>  
>  	return to_pci_host_bridge(root_bus->bridge);
>  }
> +EXPORT_SYMBOL(pci_find_host_bridge);

All PCI internals should be exported using EXPORT_SYMBOL_GPL.
