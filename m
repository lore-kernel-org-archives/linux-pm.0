Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903DC3EC2CB;
	Wed,  1 Apr 2026 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042374; cv=none; b=VyVxAw35eN9xn/guNPIlQ9IT315dxdrQbMW/cSsZYro+1s4UF2kthh/VW16KMAzgKYaE7qGmfuBZkZ3c49kEhz0vub5OFBoXgY54dH5ZPlQVHGErYdcfRQQOfWg4H//D9SRVldKKWBfEveqpRXN7ZuX8JLZaSFb6doYJ/b8mflk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042374; c=relaxed/simple;
	bh=MUw9F7L0J9ORxUWBcBPbTTFGPGevrUNSWpXB+OHXCuM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag1WoA3UgJSSLV+lmhBtGlXwnpa2kZr6Rhqp42eyk9uVVnl4AFMEuy2VrzQPb5vpRghliQ7ZFvuTv8cC0EStRD6bOfdxZpRqmHdPAn3g8LuLbw9aUFhxHU3+ff5L4/Nx+IFGKCmibjVaea2vSU76MTJsuyL/+TwZrj3mWhj5HaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeatE6Bh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeatE6Bh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C80C4CEF7;
	Wed,  1 Apr 2026 11:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775042374;
	bh=MUw9F7L0J9ORxUWBcBPbTTFGPGevrUNSWpXB+OHXCuM=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=IeatE6BhXvOPtlR5BL/B3g8KiwutSpzA+lAIq3i1KJqMCnl6KvqFrrGyqV5TrxFDF
	 HG+F+fp3brjvWi820RtywzsDd6aSNnke0I6q0jEKO67YveDW/w7Zi8crY7j9X+wotL
	 USZylAZr7JE2xB5OE+TKhRyMEL1Ofx+q/Jx20RTkvfWNb1UwmGDm0pYQjH1CdA3XSk
	 SQhrjwH5npoOnGhC4ysABRL1geNFGj5PwDTmBazE41gZLotuYLlKa5wPLrIc2tdySq
	 YL12VJCl9xalT/uGJOFT+kldw3ZcBMOTAR2cs8mShAmpuV58kSERWSsQn35NJkO01u
	 QCwjic5jSh1CA==
Date: Wed, 1 Apr 2026 12:19:28 +0100
From: Lee Jones <lee@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/2] driver: reset: spacemit-p1: add driver
 for poweroff/reboot
Message-ID: <20260401111928.GM3795166@google.com>
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
 <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>
 <20251105093347.GD8064@google.com>
 <E205F88FB1EE06C5+aQscI0Uy7pgiMzEt@kernel.org>
 <20251105100856.GG8064@google.com>
 <20251105101149.GH8064@google.com>
 <acxInP3_rU9H8Q5V@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acxInP3_rU9H8Q5V@aurel32.net>

On Wed, 01 Apr 2026, Aurelien Jarno wrote:

> Hi Lee,
> 
> On 2025-11-05 10:11, Lee Jones wrote:
> > On Wed, 05 Nov 2025, Lee Jones wrote:
> > 
> > > On Wed, 05 Nov 2025, Troy Mitchell wrote:
> > > 
> > > > On Wed, Nov 05, 2025 at 09:34:21AM +0000, Lee Jones wrote:
> > > > > On Tue, 04 Nov 2025, Troy Mitchell wrote:
> > > > > 
> > > > > > On Mon, Nov 03, 2025 at 01:48:33AM +0100, Sebastian Reichel wrote:
> > > > > > > 
> > > > > > > On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
> > > > > > > > This adds poweroff/reboot support for the SpacemiT P1 PMIC chip, which is
> > > > > > > > commonly paired with the SpacemiT K1 SoC.
> > > > > > > > 
> > > > > > > > Note: For reliable operation, this driver depends on a this patch that adds
> > > > > > > > atomic transfer support to the SpacemiT I2C controller driver:
> > > > > > > >   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-1-a89367870286@linux.spacemit.com/
> > > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > dependency is here.
> > > > > > > > 
> > > > > > > > [...]
> > > > > > > 
> > > > > > > Applied, thanks!
> > > > > > > 
> > > > > > > [1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
> > > > > > >       commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58
> > > > > > Should we apply it now? The dependency patch hasn’t been merged yet...
> > > > > 
> > > > > What is the dependency?
> > > > I point it out above.
> > > > Without this patch, reboot and shutdown would end up calling the non-atomic i2c_transfer.
> > > 
> > > Okay, thanks.  I was mostly checking that you weren't referring to the
> > > MFD patch, which doesn't represent a true dependency.
> > 
> > To save Sebastian some trouble, let's keep the reboot patch applied.
> > 
> > I'll hold off on the MFD one, which will ensure that reboot isn't probed.
> > 
> > Let me know when the dep is merged and I'll hoover up the rest of the set.
> 
> The dependency is still not yet merged, although it has been ready for 
> weeks, and I am just crossing fingers that it will get picked-up for
> for 7.1.
> 
> That said it's not a hard dependency, in most cases reboot will work, 
> which is an improvement over no reboot driver. The missing I2C PIO 
> patches are just there to make it reliable.
> 
> Therefore given the 7.1 merge window approaching, I believe it's better 
> to merge this simple MFD patch and to not wait more.

It's too late for v7.1 now.

I think this set has been well and truly forgotten.

Please rebase and submit a [RESEND] with the info in the cover letter.

-- 
Lee Jones [李琼斯]
