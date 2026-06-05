Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F33B1B3;
	Fri,  5 Jun 2026 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661781; cv=none; b=oaOhERVROKpLO615hMFqSjGXcrHTlJ4uTTWWpVk+VuK2N7gdFRHev6j72MABOPBeyAApwakSZPDj3xQNIcK12nxQpPwB2Oq0H5eeVlKYU61Yo3ALiDcE81tGdmt3wFCNc5zWGdGNTB65yJOfyrl3I+sgKtlTFMjZWnTxHCzW9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661781; c=relaxed/simple;
	bh=Gv/jv50W6HYzvFdtLIOw9FUx1JL4zlTD930XAxEzdgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SW1SFcqkM0C0sh8U71VW3R88hA+DYWJ95erutUF3oyj8fG/qGc9gaP9YQI79TPLPtInsBiwo5ueCZ5I1ErO1urzcPFiNIF2AqitZ2BOcf9x2M02mxgUswobRCNOMFCCxVIIFT8Jmbix4RqcvAC+5YaepfT7n3x3APNSmV0Wnc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOFT+2Ov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOFT+2Ov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CFA1F00893;
	Fri,  5 Jun 2026 12:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661780;
	bh=N6eF1GWUd29h7zy7BTjjZPmBC+K5GJ6gDgFk0aS492o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VOFT+2OvlBtpNuDhZERoNGbVhpyXK6pZJaP6rLVUG6qpUcQs6j+Omao1sssQRncQY
	 1m9NFiMYSj7IQbmefSmJytF0dsrP5YNKZatB6uNwDtchw3h+govcw9EbPZmh3kcHF6
	 0oPamZY3TdW+5YHiyKa9spHJ423FECL3kGkLDkWSGouMiQgdlI0n6DLVv4mRJtjmth
	 lo5m/tghSaeN6MiAweXSHu5BOAT0zLd9n+spOEroR9P+r/gYh4RPjWwNlfvbQ/+cga
	 JCtQ7c+84t3He6vUTed8SdwPpe+dWk28+7O7g4XOlwkdOG88pDfVyTVdJtZr12BUg+
	 Ff43G7q8d2huw==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wVTTF-00000000DVf-0HM4;
	Fri, 05 Jun 2026 14:16:17 +0200
Date: Fri, 5 Jun 2026 14:16:17 +0200
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Lee Jones <lee@kernel.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Peter Chen <peter.chen@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	driver-core@lists.linux.dev, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 08/23] driver core: platform: provide
 platform_device_set_of_node_from_dev()
Message-ID: <aiK-EXwp_xhcbty9@hovoldconsulting.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com>
 <ah9O15bMlAYgSlHx@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah9O15bMlAYgSlHx@ashevche-desk.local>

On Wed, Jun 03, 2026 at 12:44:55AM +0300, Andy Shevchenko wrote:
> On Thu, May 21, 2026 at 10:36:31AM +0200, Bartosz Golaszewski wrote:
> > Provide a platform-specific variant of device_set_of_node_from_dev(). In
> > addition to bumping the reference count of the OF node being assigned,
> > it also assigns the fwnode of the platform device.
> 
> Can we rather investigate the way how to make that of node reuse thingy
> (which is used solely by pin control) differently and then drop this confusing
> device_set_of_node_from_dev() call altogether?

No, that call is needed. See commit 4e75e1d7dac9 ("driver core: add
helper to reuse a device-tree node") for details.

Johan
