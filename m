Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE244607E;
	Thu, 17 Sep 2026 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684740; cv=none; b=eNq0NwVEF4OMi17NnnkyeIfsZeE2rNjXUNa1VqdPtUdIxJaQ1DNm6XIDsk07JuhtMFMjWzsDkoZMozpJEinKUPcksbPFjhcivxNzlqej4iBSC0FCS7ef0hPXa1Gu2cDGOSeapKtU6kRQsOFY8dUsRl5bbq01bNzS+91kRScvQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684740; c=relaxed/simple;
	bh=DI13kaWhMR7VVEXysPrSREcpe7Iqfs/kvZYijSu02eA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Eq6+DVAE6CbEWgCWjbTZ8xRzAF+ItPPpN99UEkvPjgqD4TbeF6v/m5sgeExyvokqy6g0AbqQiBAtLLsIiIhssIfnwCS1LadyKiVbqiHZSrE+DPtmNuIZdq5lBThVZ992LObqrIhztQK7lemkTv5a2XOyAS3NyQRHvoAr1sxkFM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzwVsXoX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzwVsXoX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986F41F00893;
	Thu, 17 Sep 2026 22:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684738;
	bh=FYqD+8EuHNbP6ZIkLeQ20YUnJezRRXMcecWfjRiQZw0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DzwVsXoXHLMEaSwh8pkPEtTZNMxKgNsQlbsMxoVgE6nuxkw3wcNDQaK6f+HiIiWIR
	 VuedDSXpyvp/BYW+rDGHCPD7sripNpVxMuH6d63EF1h90INd98Ajq2S3kIt64SZp4C
	 QcjWZpTzIX1/K+PiEnIjwv0K3aZyl7SJy8m+xYkqj1//ac48wqkrz8Y+fOYdwk9G2H
	 mzADuqrUn/xju4AAj9rY1p/FSZ5xZcdq3upVmldTPYTgsehphCm0wthg9NZi1vjNxd
	 ZsqAiD5E+9vIz2H8d5MNFMZ/aejOTey6vbLh48rAn2we7H2OneoLeAcZ0mf5B0kkyD
	 46uX+D4jfGQkQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
 linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/8] driver core: prefer
 platform_device_set_fwnode()
Message-Id: <178968473139.466806.13272492778306156816.b4-ty@kernel.org>
Date: Thu, 17 Sep 2026 23:38:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 20 Jul 2026 11:24:47 +0200, Bartosz Golaszewski wrote:
> With the final platform device and software node rework changes having
> been queued in the driver core tree, Danilo pointed out that
> platform_device_set_fwnode() is no longer used and should be removed. I
> argued that instead we should prefer it over the OF-specific
> platform_device_set_of_node().
> 
> This series converts drivers using platform_device_set_of_node() to
> platform_device_set_fwnode() and does not intend any functional change
> as the semantics of:
> 
> [...]

Applied, thanks!

[8/8] slimbus: qcom-ngd-ctrl: use platform_device_set_fwnode()
      commit: bb74fae19700fd1fa92def9daf49e6fbdea26006

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

