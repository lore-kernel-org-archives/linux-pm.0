Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55E318BA9;
	Thu, 22 Jan 2026 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088368; cv=none; b=QVRlGUbLCOBp7+THRaDdhw+dlSnJemLmR9H/Bx3/cVGCb/FXxfUEWlL3fHGj++7J2Mg4eCn58CwFaZ9sO9D7JFDCaQc7gweLbPI/QRkbmfe/lY+KD/p9s8aKq/lo9+VT41lbEZegiZeGNuhlomAcVEQwuQBZrvYd5KToO/TTc24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088368; c=relaxed/simple;
	bh=2LXnu/brmZUI3V1EmnLhPNh9+A6esk4EpC94Vjt+P3M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lkjXqcu6ueYMKmE9JobUz+POGtLvVm+hDDdsYr281shTf6RHodmCNusMQEWE8WeTYnrcMXSKz+v2kzyPw+5tJvfNDL1oqKfShhJgJTn+CAhg5VxiPcAIM3m2gXpxphZi5uvFH+2LddLb0jF5g4c6e6HSSrubTnmHnHWasUrDHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrq//dD2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrq//dD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C108C116D0;
	Thu, 22 Jan 2026 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769088368;
	bh=2LXnu/brmZUI3V1EmnLhPNh9+A6esk4EpC94Vjt+P3M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nrq//dD2l7B13W6g/AX4Nt0SoK1+0ixzvkZ/RUo50OIVJztTicwARgXkbhLSl/aDF
	 vUaHVmUq+Uug9FphUqlb633hnZnZAuqdEKNoBIfndlQvNtlCfRIs8a3Ezamw+uHIR8
	 u34Znbn5FbKJBjIAJQ7AkQepc2Euoupf5cGSL68Mqp4iaU+PWBAtbio46/2FUR4err
	 X/KV1gpXP0PC67vNpDGAQ0HQyChKjKXLIRxSNfO4R8Km0qDNb8DkxQ05aU5PurWLgk
	 +SSvH4kfGx4AxbloEuzvoaa37V7U+MQla74ongRUrGN5R11fbPgtB7v1l418Hn6Z/+
	 J1v95ixCYpDNQ==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, rafael@kernel.org, linux-pm@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20260115131727.373738-1-ckeepax@opensource.cirrus.com>
References: <20260115131727.373738-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: SDCA: Add NO_DIRECT_COMPLETE flag to class
 driver
Message-Id: <176908836637.85917.15733709971966901054.b4-ty@kernel.org>
Date: Thu, 22 Jan 2026 13:26:06 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 15 Jan 2026 13:17:26 +0000, Charles Keepax wrote:
> The SDCA class driver currently expects the device will be fully powered
> down on system suspend but not on runtime suspend. This is typically
> required as when audio is not active (ie. runtime suspend) jack detect
> is expected to still function, but when the whole system is hibernated
> there is no need to recognise audio jack events. This means the class
> driver needs to always be informed of a system suspend, so the direct
> complete optimisation (where PM will skip calling system suspend if the
> device is runtime suspended) is not appropriate for the SDCA class
> driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SDCA: Add NO_DIRECT_COMPLETE flag to class driver
      commit: 702ce71d32f2c30b4f45b7c6b701d87583c58df8

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

