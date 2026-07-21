Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034FC43711D
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620682; cv=none; b=fXraxEvkvD6aq/VCaMR7t9qfwA5j/MThLPskDKjZJRnNfI+UDZRV9irPzM67IgoqvYIaNaJXYWV/Wrz+jDmJFNRzQ73j76KCg9BPbSEeYxNWoMG2P1I12E9XK67wxYTiEcPSAaEQb4DWbNL1NVha5m8EZivhw1PMCkaE0iq3Q6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620682; c=relaxed/simple;
	bh=Qu6V/jFa3L0ra7v1UlZyzgbe/1V/e5d4AsjK/MKCp8c=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYCOMmquSTdwc0EGdEDYFi5PO/nTKFBCJaNw90wGs1eMvPtE5RZjB6paxJbm9GSUoXQpmE4Czm+ujIFFxt1M4IKG950LolGdZnXAmFr9n4QH49d3/gv/wMTN8UPnCjTojGxePVt4c1ymNjn/opB5HnS9GkMilCrdn4v5J4RaVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVmvwJVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVmvwJVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CD01F00ACA
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620679;
	bh=y8ZQiTN586DKOzGjE0xQTVjSc0oG6CWcbCqpe2Jy2M4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=YVmvwJVT9Qyay4HbMhb49B9CjDlZz7ft+lQj9lbS0gACumnC1Iv2/dsdm1MV9mu4c
	 zAFU0hI7Xau7B4/YM37CP9pXGedF5Cl9Ux1RfADSqooiQWl5++I9UPNLx9bYcxW1m8
	 dWwOXXbyLjJgKyY5IIabDL3n7y2Qbv9FbuP/aoVu6GwF4dZ4uDwHKNeaHY0jS2eqLz
	 RXoTf9r6Ejv9blA7uC5ei4TYzAeV966wu8kwI6AZd0WBupxsdSKzxFL2wT4iB1WSxL
	 qBk3K/JlKeou8FmssItan6rHnzpwi6jaVlRe/TmBqMy6lmtyvBR91Q78CeI2qT2hly
	 ZQt1jND0CNHjw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so860352e87.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 00:57:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqViporeuxTXMX28kp6RNgYOTcK9tVvHp+N34PNFKR9v7Onh+lS+M8GP2ykJy61HBJMWC3IBVM+TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfRqGnam3HW86NgWFVhTCL407/wUOSbnomv7wyeN/WvUuyhxuG
	0+JM+bY0GLpQruVeiYU3XZlayhdUrutMVRCPCRT7dPZJ/JbbkA5JsQnH+sIyVKfCDIbdwcdfhki
	4PMV/g4RprOHCTtVkP6do6WbiXINq5WaTxapiJNe0oA==
X-Received: by 2002:ac2:554c:0:b0:5ae:bcf8:e7d0 with SMTP id
 2adb3069b0e04-5b28f9bd551mr2209166e87.55.1784620678478; Tue, 21 Jul 2026
 00:57:58 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 00:57:57 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 00:57:56 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <3e14e41f-ecd5-432b-9f52-690a05b38a8a@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-7-2dee93f42c54@oss.qualcomm.com>
 <86b2aba7-b049-47e6-bc94-6cb499b30ce4@lunn.ch> <CAMRc=Mduv_KiB42d4AZddTrFSHmKogd2wh6vBDXomW6ssdfq9A@mail.gmail.com>
 <3e14e41f-ecd5-432b-9f52-690a05b38a8a@lunn.ch>
Date: Tue, 21 Jul 2026 00:57:56 -0700
X-Gmail-Original-Message-ID: <CAMRc=Md_zUwYW5KL+p=BRixSaf3Rrc5jnBA3x8Ze+fK+fAOctQ@mail.gmail.com>
X-Gm-Features: AUfX_mxrzWF5f1w8uOBbvKVmYCYI9DGFBZVEBrX2uI1sc7agH6iCfKo0CQST8Mw
Message-ID: <CAMRc=Md_zUwYW5KL+p=BRixSaf3Rrc5jnBA3x8Ze+fK+fAOctQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] net: mv643xx: use platform_device_set_fwnode()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Srinivas Kandagatla <srini@kernel.org>, 
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 20:28:39 +0200, Andrew Lunn <andrew@lunn.ch> said:
> On Mon, Jul 20, 2026 at 06:01:37PM +0200, Bartosz Golaszewski wrote:
>> On Mon, 20 Jul 2026 16:43:40 +0200, Andrew Lunn <andrew@lunn.ch> said:
>> > On Mon, Jul 20, 2026 at 11:24:54AM +0200, Bartosz Golaszewski wrote:
>> >> Prefer the higher-level platform_device_set_fwnode() over the
>> >> OF-specific platform_device_set_of_node() for dynamically allocated
>> >> platform devices.
>> >>
>> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> >> ---
>> >>  drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
>> >> index 9caa1e47c174c9d7a161b7f2e2ee12a829b813d4..2f2d6cce8d852b9ec3ab42678a04a7915d1f00cc 100644
>> >> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
>> >> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
>> >> @@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
>> >>  		goto put_err;
>> >>  	}
>> >>  	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> >> -	platform_device_set_of_node(ppdev, pnp);
>> >> +	platform_device_set_fwnode(ppdev, of_fwnode_handle(pnp));
>> >
>> > This is definitely an OF only driver. There are no other calls to
>> > fwnode functions in this driver, so this is the wrong thing to do.
>> >
>> > Sorry, NACK.
>> >
>>
>> I'm not going to die on this hill but drivers are OF-only until they're not.
>> For example, Qualcomm is now working on a hybrid ACPI-OF approach for
>> laptops[1] and we may end up needing to start converting drivers to fwnode
>> after all.
>>
>> There's no real benefit to sticking to OF-specific APIs unless you need to
>> iterate over all properties of a node or use some other functionality not
>> available in fwnode. The overhead is minimal and it's never a hot path.
>
> There is a lot of benefit to sticking to OF specific APIs, because
> within the kernel OF is well maintained, has active maintainers, there
> are tools to validate bindings, etc. ACPI is a Wild West, each driver
> is a snow flake, there is no review, no binding documentation, no
> validation tools etc.
>
> I hope you allow plenty of time to convert any networking drivers,
> where Linux is driving the hardware, to ACPI. Your first stop will be
> the UEFI forum making a proposal for MDIO busses, because that
> currently is not part of ACPI. You will then need to spend time
> understanding the DT bindings, and figuring out which properties are
> deprecated so need to stay OF only, and which can be converted to dual
> OF/ACPI. I've seen too many naive attempts which blindly convert
> everything, copying all the past errors in the DT binding into the
> brand new ACPI binding. That will get NACKed.
>
> OF != ACPI
>

I've never said that and ACPI is actually irrelevant to this discussion. Fwnode
is the abstraction layer and OF happens to implement it. Unless you need
fine-grained control (only exposed by the lower-level abstraction) or
performance - neither of which is the case here - you should use the top-level
API. As I said: there's no good reason to stick to OF-specific interfaces for
drivers that don't really require it - and even then, we should strive to fill
the gaps in the fwnode API instead.

Bart
