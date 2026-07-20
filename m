Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C042DFE6;
	Mon, 20 Jul 2026 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558354; cv=none; b=fZfp+IgMEhUogiwpnOvrfwSgDk4B5NwRcOLw6GzOcxP2wX7tJ5aHmHRmeh3BbxEl+hFZCXZCixITEAuFNAs3/Ckr8f23FH8hbx/j4bHfCCACwoTQ78GAX6lBdKe8e/gPgANnGvPn+R+5xhQaeUqgNBpde0U1i6bGO3KiMhTRmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558354; c=relaxed/simple;
	bh=ddFtt++l0cIrQRJwpibRCXO1NHpBQQmpdZB/oy/A9IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We97/hX6ZF7x4MRICxm5BAQWpBYoqnsOebncBBGmAt04SAzst6UVeVhuq0twYUxaQWRq15CxmLH5vJMMN2Vcz/QqwJtwO4RNPsuScR0B6uYfQsEStLx5VD9MdW2+ZlUDSdhyy857Jvp6HPOBIqtQJG+WP3SetvMkghvwpCSYzPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jlS/QNzG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jlS/QNzG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RMjWEzu38tseHoFo/YUCFGtCdWHHOcvPUTf8wfVO9l4=; b=jlS/QNzG8jL6ztl+koDV7jIKGy
	hJ8MoU4EgaQgOE1qzjLmdtFbbmi/0fgZfb4iTHwPI1fG+fHHula2om3ezgCqqfeAdRQe4ZBDMr05+
	gPG4MNS98XzezJlKLfyz2QX0gg43IJlG3DiKv4snsRh78RHhZP5X+0/L4MTdSThyYxYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlp8g-00DH7Y-1A; Mon, 20 Jul 2026 16:38:38 +0200
Date: Mon, 20 Jul 2026 16:38:38 +0200
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
Subject: Re: [PATCH 4/8] net: bcmgenet: use platform_device_set_fwnode()
Message-ID: <ae9da5dd-3528-4270-ada0-d17ed14478e0@lunn.ch>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-4-2dee93f42c54@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-4-2dee93f42c54@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 11:24:51AM +0200, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.

Why?

This driver is OF only. It does not support ACPI, and probably never
will. In general, networking and ACPI don't go together, ACPI is not
sufficiently advanced.

What is you use case here?

	Andrew
