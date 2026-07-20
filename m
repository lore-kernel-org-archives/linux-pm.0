Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD903AE198
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540518; cv=none; b=NFfsD59uR8kA3BN4r3scz052jBL1ha8wNXTX//aadLNiW0ES+//kvSXfLplJBf1/9X3DLPi2N0KCdy2N2FB3B+DVtRs1X+NyMJpKImokQ8zAY1+U+B2S3jf4jZC1sWWQZuycPVtk74x6CrS+S4oFXmU8RRbzUEuhvAQBodHoOO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540518; c=relaxed/simple;
	bh=lR1RewoAZbIahGA8KBdG5nh8j880NEupATIBBXBivDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf+YSWBKJZVB03CGkL17TTluz0wwga6ctpzFT0z9me1eBNlmamJP9EeUhDNmg8iEAWi+OfB9NuTANXkuQ6VpZKoAzsI7Zku2im4vR19+xCSAS8TAfuiyHxIeUwEBDJeyYosZxvw33eWHvhIpI9JQrrBI8e+wl5LTqVd5AgJS5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=dKgt1tBV; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="dKgt1tBV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=PVbz
	oDnpVKgVDd4gX36wEhQdxOoPAfSCiS1SYLlMuPY=; b=dKgt1tBVRUujW/Or9cUu
	Njja0ewW303cV+XaqwFoCQhB4c92qFLo6R2X6sOWdGkc8aBgR5JQFhIWaEWcAIhT
	ELaWXGkWF4TQf045bOVNttofBiEbrSDZ3+Yqm8D9+bax3qCI5R5C+MS0DeCcijN9
	Fss16LtdQO5O0f9FhrRmDaKyVHMHZp98odmgKivqaj71XmC1opc0ba/4i74Ct9Gi
	DuyHeZ0ZR3DyqPF5BXuurNzEbn5sfPu0hp8WuGPLN9FFs7vr0LkZCnFCvUaW6fvD
	CQK/udY2wPkxN7LbOq1oXh8N0ro3KVlKbavEV+FZHj5TiDVYGPc1jiUWwDFBFFzV
	pQ==
Received: (qmail 2419193 invoked from network); 20 Jul 2026 11:41:39 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jul 2026 11:41:39 +0200
X-UD-Smtp-Session: l3s3148p1@XpiKtgdXCtIujntM
Date: Mon, 20 Jul 2026 11:41:39 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
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
Subject: Re: [PATCH 2/8] i2c: pxa-pci: use platform_device_set_fwnode()
Message-ID: <al3tU6t0LQdWYoNX@ninjato>
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

On Mon, Jul 20, 2026 at 11:24:49AM +0200, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Fine with me.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Note that we still need Andi's ack.

