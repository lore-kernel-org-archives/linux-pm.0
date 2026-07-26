Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D96D3346A8;
	Sun, 26 Jul 2026 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785099032; cv=none; b=VaipwrZBOoriD4NrfannjLYDE4yu2Ey6XIeWTEqTJV/FMFDY/aeR5SpQh1kHaij2PCoHtTERz9pC7+TAsXGl5gJTYbD/YzWsflDQtEFmNDH3Xu0d205h5mGZskD2RJqLNYXcw6/YjXdVAddhd4C7lPdTs11WGv6LT8slt4+LeHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785099032; c=relaxed/simple;
	bh=3e8ybFzMuH/HJ0Ve+oX3AxqYvVPeb4SH0GjJoz5fi2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvriZur0IMHLZKbI0CRXHyBGMG9a3pxWZdM1xyKMG7xgI9mzsrUJJ3t8Sc0l4MvmYxdFGdUORUuNDJFfqwk7Oj2q1eLDxuBKSyb8bD5jE3ChWKckrgPJPRzD7z87umdl6BxkXBBwCpCLRsQb/OUfmD+Y2QfW5jbeKQ42JoMv3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=In5V3KSS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In5V3KSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4611F000E9;
	Sun, 26 Jul 2026 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785099031;
	bh=HLpZYMENBNgPXFarYmWwn7VwAhRa9SmUHkcGWYZHpG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=In5V3KSSLdWN4HHPW+I8bvUb7SeetiUPoS+vwnKYBb2rUiZOW6WdSPgD7lUHb2ay2
	 aEV8ESrjf0zFLfFex/SkOqNEB0Vj752OA8tBNny/jl1XwEuHlMuT1eq1+pgtxqUNRV
	 4RB4LYce8X4AXHS91Jl3DeTxLBsFytz0qCX4/dsHqKyDntQdurR5j7n9uLgpGXcu8/
	 1nuAFjFRygNUHsQa9d64ooc+nT4MptG5vbo9oXzn3nbgFG/J8JsoyceViKUD7QG5kl
	 K3FdMqec0+WZ5CNDX4q3SMVfQHRxBwc6CQKsoAX6wh7LYKIXkBrEyf5BnVloSBt/y5
	 iBhv21g14JvFA==
Date: Sun, 26 Jul 2026 22:50:26 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org, 
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 2/8] i2c: pxa-pci: use platform_device_set_fwnode()
Message-ID: <amZzAGnHvXxS8CM8@zenone.zhora.eu>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-2-2dee93f42c54@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-2-2dee93f42c54@oss.qualcomm.com>

Hi Bartosz,

On Mon, Jul 20, 2026 at 11:24:49AM +0200, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
