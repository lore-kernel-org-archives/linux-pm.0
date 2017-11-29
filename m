From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 8/9] PCI: tegra: Broadcast PME_turn_Off message before
 link goes to L2
Date: Wed, 29 Nov 2017 10:51:47 -0600
Message-ID: <20171129165147.GB6469@bhelgaas-glaptop.roam.corp.google.com>
References: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
 <1511638333-22951-9-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1511638333-22951-9-git-send-email-mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 26, 2017 at 01:02:12AM +0530, Manikanta Maddireddy wrote:
> Per PCIe r3.0, sec 5.3.3.2.1, PCIe root port shoould broadcast PME_turn_Off
> message before PCIe link goes to L2. PME_turn_Off broadcast mechanism is
> implemented in AFI module. Each Tegra PCIe root port has its own
> PME_turn_Off and PME_TO_Ack bitmap in AFI_PME register, program this
> register to broadcast PME_turn_Off message.

s/PME_turn_Off/PME_Turn_Off/ above to match spec.

I thought PME_TO_Ack was also mis-capitalized, but it's not.  Guess
that "TO" stands for "Turn Off".

> Signed-off-by: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> V2:
> * no change in this patch
> 
>  drivers/pci/host/pci-tegra.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index bbc2807bcd4a..b380958a3deb 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -155,6 +155,8 @@
>  #define  AFI_INTR_EN_FPCI_TIMEOUT	(1 << 7)
>  #define  AFI_INTR_EN_PRSNT_SENSE	(1 << 8)
>  
> +#define AFI_PCIE_PME		0xf0
> +
>  #define AFI_PCIE_CONFIG					0x0f8
>  #define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		(1 << ((x) + 1))
>  #define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		0xe
> @@ -315,6 +317,7 @@
>  #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
>  
>  #define LINK_RETRAIN_TIMEOUT 100000
> +#define PME_ACK_TIMEOUT 10000
>  
>  struct tegra_msi {
>  	struct msi_controller chip;
> @@ -1503,6 +1506,76 @@ static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
>  	return 0;
>  }
>  
> +static inline u32 get_pme_turnoff_bitmap(struct tegra_pcie_port *port)
> +{
> +	struct device *dev = port->pcie->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret = 0;

Unnecessary initialization.  In fact, the variable is unnecessary; you
can just return the value directly as soon as you know it.

> +
> +	switch (port->index) {
> +	case 0:
> +		ret = 0;
> +	case 1:
> +		ret = 8;
> +	case 2:
> +		if (of_device_is_compatible(np, "nvidia,tegra30-pcie"))
> +			ret = 16;
> +		else
> +			ret = 12;
> +	}
> +	return ret;
> +}
> +
> +static inline u32 get_pme_ack_bitmap(struct tegra_pcie_port *port)
> +{
> +	struct device *dev = port->pcie->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret = 0;

Similar.

> +
> +	switch (port->index) {
> +	case 0:
> +		ret = 5;
> +	case 1:
> +		ret = 10;
> +	case 2:
> +		if (of_device_is_compatible(np, "nvidia,tegra30-pcie"))
> +			ret = 18;
> +		else
> +			ret = 14;
> +	}
> +	return ret;
> +}
> +
> +static void tegra_pcie_pme_turnoff(struct tegra_pcie_port *port)
> +{
> +	struct tegra_pcie *pcie = port->pcie;
> +	ktime_t deadline;
> +	unsigned int data;
> +
> +	data = afi_readl(pcie, AFI_PCIE_PME);
> +	data |= (0x1 << get_pme_turnoff_bitmap(port));
> +	afi_writel(pcie, data, AFI_PCIE_PME);
> +
> +	deadline = ktime_add_us(ktime_get(), PME_ACK_TIMEOUT);
> +	do {
> +		data = afi_readl(pcie, AFI_PCIE_PME);
> +		data &= (0x1 << get_pme_ack_bitmap(port));
> +		udelay(1);
> +		if (ktime_after(ktime_get(), deadline))
> +			break;
> +	} while (!data);
> +
> +	if (data)
> +		dev_err(pcie->dev, "PME Ack is not receieved on port: %d\n",

s/receieved/received/

> +			port->index);
> +
> +	usleep_range(10000, 11000);
> +
> +	data = afi_readl(pcie, AFI_PCIE_PME);
> +	data &= ~(0x1 << get_pme_turnoff_bitmap(port));
> +	afi_writel(pcie, data, AFI_PCIE_PME);
> +}
> +
>  static int tegra_msi_alloc(struct tegra_msi *chip)
>  {
>  	int msi;
> @@ -2828,6 +2901,7 @@ static int tegra_pcie_remove(struct platform_device *pdev)
>  {
>  	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
>  	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +	struct tegra_pcie_port *port, *tmp;
>  
>  	if (IS_ENABLED(CONFIG_DEBUG_FS))
>  		tegra_pcie_debugfs_exit(pcie);
> @@ -2835,6 +2909,8 @@ static int tegra_pcie_remove(struct platform_device *pdev)
>  	pci_remove_root_bus(host->bus);
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		tegra_pcie_disable_msi(pcie);
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +		tegra_pcie_pme_turnoff(port);
>  	tegra_pcie_disable_ports(pcie);
>  	tegra_pcie_free_resources(pcie);
>  	tegra_pcie_disable_controller(pcie);
> -- 
> 2.1.4
> 
