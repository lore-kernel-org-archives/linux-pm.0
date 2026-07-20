Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FF3BBFA3;
	Mon, 20 Jul 2026 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572154; cv=none; b=ICFez2zcg/5XExLuRs0Uz7320ULKSlFxHaLXAL7smDHTCta/twI84c18zmooLkb947/5MCOeOGEJrHs+kCFXVReG/T03ZNYa69tCWHVaA1LvL/AYoyJTPTKM4Yk+yS86Mtt5lsGsuX1/ugzRdb7RkgKtMGtBvR1S1oR2AisGrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572154; c=relaxed/simple;
	bh=tfVWCL5gWoa3QiT5HZTS6PeE9CWbDfu6g4fGN5mDciM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXY+/Sw+K3XP6ICabAiAnICEoU68sMmsppgZYGp+SCpJBjaxpdVMIQAEUDGRiZ2hgyrb+UxfdD36ZoBnjkBM+8XT7b0xdY3WFDuyW3pOHITxnxaD6fXf7xCz51nLyHrW7EsoF24oFCp+QA6fqL5RANDPAi0wJzM0R26W7uIgiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aXfSe1ax; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aXfSe1ax"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yLMgkHL29YuNPW+/3QaUsRDGEETcaDq11JerkMxi71U=; b=aXfSe1axWn1ivOd2Cu9BO1RFeq
	hWgF1UgIJeW3prZhNqGQBXWrgbuTuwyexLgmgUNYx2N/ldKGruFnJsUHlN1z27mAm6jFGqs2hs9gA
	ahOJFCbMr0Yi7Jx28dCpVd/erX67Wj6OVBy/j8nQ7Y54VjyLQTQQ9WeRLH9Gg27QXLhQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlsjH-00DJ6A-QN; Mon, 20 Jul 2026 20:28:39 +0200
Date: Mon, 20 Jul 2026 20:28:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	Srinivas Kandagatla <srini@kernel.org>, driver-core@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
	netdev@vger.kernel.org, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 7/8] net: mv643xx: use platform_device_set_fwnode()
Message-ID: <3e14e41f-ecd5-432b-9f52-690a05b38a8a@lunn.ch>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-7-2dee93f42c54@oss.qualcomm.com>
 <86b2aba7-b049-47e6-bc94-6cb499b30ce4@lunn.ch>
 <CAMRc=Mduv_KiB42d4AZddTrFSHmKogd2wh6vBDXomW6ssdfq9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mduv_KiB42d4AZddTrFSHmKogd2wh6vBDXomW6ssdfq9A@mail.gmail.com>

On Mon, Jul 20, 2026 at 06:01:37PM +0200, Bartosz Golaszewski wrote:
> On Mon, 20 Jul 2026 16:43:40 +0200, Andrew Lunn <andrew@lunn.ch> said:
> > On Mon, Jul 20, 2026 at 11:24:54AM +0200, Bartosz Golaszewski wrote:
> >> Prefer the higher-level platform_device_set_fwnode() over the
> >> OF-specific platform_device_set_of_node() for dynamically allocated
> >> platform devices.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> >> ---
> >>  drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> >> index 9caa1e47c174c9d7a161b7f2e2ee12a829b813d4..2f2d6cce8d852b9ec3ab42678a04a7915d1f00cc 100644
> >> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> >> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> >> @@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
> >>  		goto put_err;
> >>  	}
> >>  	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> >> -	platform_device_set_of_node(ppdev, pnp);
> >> +	platform_device_set_fwnode(ppdev, of_fwnode_handle(pnp));
> >
> > This is definitely an OF only driver. There are no other calls to
> > fwnode functions in this driver, so this is the wrong thing to do.
> >
> > Sorry, NACK.
> >
> 
> I'm not going to die on this hill but drivers are OF-only until they're not.
> For example, Qualcomm is now working on a hybrid ACPI-OF approach for
> laptops[1] and we may end up needing to start converting drivers to fwnode
> after all.
> 
> There's no real benefit to sticking to OF-specific APIs unless you need to
> iterate over all properties of a node or use some other functionality not
> available in fwnode. The overhead is minimal and it's never a hot path.

There is a lot of benefit to sticking to OF specific APIs, because
within the kernel OF is well maintained, has active maintainers, there
are tools to validate bindings, etc. ACPI is a Wild West, each driver
is a snow flake, there is no review, no binding documentation, no
validation tools etc.

I hope you allow plenty of time to convert any networking drivers,
where Linux is driving the hardware, to ACPI. Your first stop will be
the UEFI forum making a proposal for MDIO busses, because that
currently is not part of ACPI. You will then need to spend time
understanding the DT bindings, and figuring out which properties are
deprecated so need to stay OF only, and which can be converted to dual
OF/ACPI. I've seen too many naive attempts which blindly convert
everything, copying all the past errors in the DT binding into the
brand new ACPI binding. That will get NACKed.

OF != ACPI

	Andrew
