From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Power on bridges before scanning new devices
Date: Tue, 24 May 2016 17:06:51 +0200
Message-ID: <20160524150651.GA5605@wunner.de>
References: <20160519231234.GB1785@al>
 <1463991648-85051-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160523200042.GB24375@localhost>
 <20160523215015.GA31479@localhost>
 <20160524122357.GA20453@localhost>
 <20160524125323.GE1789@lahna.fi.intel.com>
 <20160524142744.GA1553@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:43096 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621AbcEXPD3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 11:03:29 -0400
Content-Disposition: inline
In-Reply-To: <20160524142744.GA1553@al>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>, Dave Airlie <airlied@gmail.com>

Hi Peter,

On Tue, May 24, 2016 at 04:27:44PM +0200, Peter Wu wrote:
> @@ -246,6 +247,28 @@ static int nouveau_dsm_pci_probe(struct pci_dev *pdev)
>  	return retval;
>  }
>  
> +/* Windows 8/8.1/10 do not use DSM to put the device in D3cold state,
> + * instead it disables power resources on the parent PCIe port device. */
> +static bool nouveau_check_pr3(struct pci_dev *dis_dev)
> +{
> +	acpi_handle parent_handle;
> +	struct acpi_device *ad = NULL;
> +
> +	if (ACPI_FAILURE(acpi_get_parent(nouveau_dsm_priv.dhandle,
> +					 &parent_handle))) {
> +		pr_warn("Failed to obtain the parent device\n");
> +		return false;
> +	}
> +
> +	acpi_bus_get_device(parent_handle, &ad);
> +	if (!ad) {
> +		pr_warn("Failed to obtain an ACPI device for handle\n");
> +		return false;
> +	}
> +
> +	return ad->power.flags.power_resources;
> +}
> +

This can be shortened significantly by using pci_upstream_bridge()
and ACPI_HANDLE().

Best regards,

Lukas
