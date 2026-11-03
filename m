Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697863;
	b=Xwoger5/H+abrOTZ3Z4qM390lxGfYWEgbl7oWgJQzkoNilXXagwRR0BD/TBgMCA5W3Ya
	 U0W1s8f73mp3rBwaAAuOjnN6OGnLpRplL77b3Df/V+ZEiKUifxPMPsBs9kt72hxJ0Xqc+
	 OQU2EpqZ5rO5XQrvKTIJKsMsyDRD6d2pIkRws+9TCwDoLjpx+LKQl+drdv1qu7M2PVwQ9
	 Tft4jBhz0r3hrXoRSlU0PE0TIJGqmuUrenUF0qOdoBRnKUSOCUgyxBK48AQuSFKSKAmjC
	 BXsO+13Z2IL2c8qGwi5KseI0wn4Cj6P4nszH/ZFuNr/rWgmrAmK53Czjj5hgr92lJNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697863;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=My5g1/hWyVtaqeuolzLXvupHyj8u+fkqRULATYn+MrE=;
	b=rzWtJcqRox8+ppLm5o1wFeASZuDfVjnkvmGpdWl8fWtfEy0cq7k7SxVLaOP4TczK4r6J
	 sVAaGUVdii+iOvbWrhRgTsudB2w1S2n5gpdB2KJctCJqEvaKxMqUehlEa80iJ4vVIIK3X
	 H905ZUMBvR7OaUoXlaGQk2VuwxzkwS+T0/DoEU3wHMcZV63pqK1bEBPm8LnvA341uMfvl
	 LXlhVusyo/XQRBaKo66hcC4HCUy/AYORozcWs5+zbKO9kElEStLX/2Du/U+p4SwMI9Mk/
	 Cfb+u0BlX2AgvPFPa+Q/g+660hs/HY31t34Dgi0fg/WONJIn6xIsOHon4RGj//i3hSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJYe8WqC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1179606A327
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJYe8WqC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD25C1F00919;
	Tue,  3 Nov 2026 09:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697862;
	bh=My5g1/hWyVtaqeuolzLXvupHyj8u+fkqRULATYn+MrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FJYe8WqCtSr8oQHf9X68ndEXwg6FcOpCaXeFHLKH5ED3M6xW2ukecnW62dR5UVK15
	 C3ohnjh1E0IIr26thRh4mqpFvZj58WhTs6wsXu/9VGDxG/zNKzGv3d39fDtYfHVXj1
	 eojoPUc9z3TOEEWUFTEZ0gCFZKOfQrNvz5gqRYlEYDfTf4I9IitwXCNzSs33pI00e/
	 XY2yx+fBNy4Oe2fYzCCDGUhUUqYdRemRq+u0am4NZsFEWi3Mjr9lRXhg7ZYL7eQXsK
	 KXQPNwyZTgKo3nsIUlvWomMYeajy9wJSosHlOOxsKl9+W203wM659T4FAyjtxXdIkG
	 4Jy1FzHxTJsmA==
Date: Tue, 3 Nov 2026 09:24:17 +0000
From: Lee Jones <lee@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com, heiko@sntech.de, sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 0/4] Fix Incorrect State of Charge for RK817
Message-ID: <20261103092417.GG13023@google.com>
References: <20261102143942.305293-1-macroalpha82@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102143942.305293-1-macroalpha82@gmail.com>

On Mon, 02 Nov 2026, Chris Morgan wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Users of the popular firmware RockNIX had identified a few bugs with
> accurately displaying the correct state of charge for RK817 battery
> devices. With the help of one user analyzing the code with Claude
> they were able to identify a few potential bugs along with potential
> solutions which I was then able to verify. These bugs are as follows:
> 
> 1) Incorrectly clamping a value with a max of 10000 instead of 100000.
> This bug caused the state of charge to sometimes read as 10% instead
> of 100% as it should have.
> 
> 2) Using the boot_voltage value to calibrate the battery in scenarios
> where it could not be trusted. The boot_voltage register populates
> immediately at power-on, and the driver would check if this value
> was older than 30 minutes before using it. Unfortunately when combined
> with the default behavior of the bootloader to turn the device off
> when plugged in (requiring a user to explicitly power the device on)
> the boot_voltage and boot_timer values were wrong. The boot voltage
> would not account for any voltage added while the device was off,
> and the boot_counter that tracks the time the device was off would
> be reset. To fix this we changed the behavior to (outside of first-boot
> scenarios) use a value saved to NVRAM, the value from the coulomb
> counter directly, and an OCV lookup from the live battery voltage,
> and then using those values provide an initial "guess" of the state
> of charge and recalibrate with the OCV voltage once it is available.
> 
> Included in this series is another fix that would cause the battery
> to drain while the system was shut down. This patch replicates the
> Rockchip BSP driver to clear a shutdown register. Unlike the BSP there
> is no behavior to bypass this since no boards have yet been observed
> using the SYS_CAN_SD bypass on the BSP kernel.
> 
> Changes Since V1:
>  - Dropped the sleep fixes, as I would like to test them a bit more
>    extensively first.
>  - Dropped the devicetree parameter, as since no boards have *yet*
>    needed to alter the default behavior there's no need for it.
>  - Changed the behavior of how we select the initial SOC and made
>    it its own function to ease in code readibility. This new method
>    was tested with various boot scenarios. The average error was less
>    than 5%, and in a worst case scenario where the device was
>    discharged to 0%, then left to charge at the bootloader the device
>    over-reported its state of charge by about 10%. When this occurred
>    the device reported its SOC as 100% but that it was charging, which
>    was corrected by the new OCV logic that kicked in once charging
>    completed.
>  - Scrapped the more complicated sleep fix in favor of simply telling
>    the battery to recalibrate at full after suspend, in case of a 
>    counting anomaly. 
> 
> Chris Morgan (4):
>   power: supply: rk817-charger: Fix NVRAM SoC Value
>   power: supply: rk817-charger: Resolve boot state of charge from the
>     coulomb counter
>   power: supply: rk817-charger: Clear SYS_CAN_SD register by default
>   power: supply: rk817-charger: Clear full charge cal on resume
> 
>  drivers/power/supply/rk817_charger.c | 313 ++++++++++++++++++++-------

>  include/linux/mfd/rk808.h            |   3 +

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 239 insertions(+), 77 deletions(-)

-- 
Lee Jones
