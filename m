Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B142D752;
	Mon, 20 Jul 2026 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558642; cv=none; b=GWnqllMV7JunNieHCvxzqU2Gs9/BaSOTW/PXLwRgq8A1t5MZ6YrLv3vvFhv1VpvD5zFIutIFL/mKEaoNjkdrkNoVpi9G74ezMUyjRDkifm2XeZvpKSEg7kGYQXNEboxCD8xJsMY/+4Kup5zebdg+oa4AjWLTK+vIr0mDBPweXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558642; c=relaxed/simple;
	bh=CQJGspfiB/NAwgT88jIh/m4ZZrG8ah3eLPy3cB4vUOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDORlzVpDyKVc5H/Ie68JyauIXkFdy4BRRJwf/R2BfajYk4ahwvNMXu9RlIxROZViPDytNqVMPfYFcDO6p2fHh7I4ZGw+nuj79KVR7RQjMiUiaN/8my8RhNlEr1E7pobcTv2wy7ZZuURphmzXN6xmPBo4tzg6EoqPy03Xyalzmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u87EBpi0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u87EBpi0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BXhfFoqflgF82KRwFNK0K4F+WC7W4X52vQ4MqWkibHk=; b=u87EBpi0W7PcezV9DBKXdXN4/P
	p9UYaLCZFtgUyOGYdytHLutMvSSNyvUcIgRfwGDopHvUqq9ZIlniLUGgYPwPRrDPsFmM1fCmmLkzn
	A985PR89vvPMIsZsJvQqT/OtMNtLd8+M4EQYIuLAiGvk2F3QoNojNtnckKSJnLpXICWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlpDY-00DHCs-Cz; Mon, 20 Jul 2026 16:43:40 +0200
Date: Mon, 20 Jul 2026 16:43:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org,
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 7/8] net: mv643xx: use platform_device_set_fwnode()
Message-ID: <86b2aba7-b049-47e6-bc94-6cb499b30ce4@lunn.ch>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-7-2dee93f42c54@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-7-2dee93f42c54@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 11:24:54AM +0200, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index 9caa1e47c174c9d7a161b7f2e2ee12a829b813d4..2f2d6cce8d852b9ec3ab42678a04a7915d1f00cc 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
>  		goto put_err;
>  	}
>  	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> -	platform_device_set_of_node(ppdev, pnp);
> +	platform_device_set_fwnode(ppdev, of_fwnode_handle(pnp));

This is definitely an OF only driver. There are no other calls to
fwnode functions in this driver, so this is the wrong thing to do.

Sorry, NACK.

       Andrew
