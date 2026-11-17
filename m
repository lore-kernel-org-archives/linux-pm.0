Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927862;
	b=fIkEX/p0Rg/NuJ4MEU+Sv7o04JQDKK08SDn1qrUtoSNEH0bl7MBrNEVAZxjwPgXNDo3F
	 Msv4ihqbeE0C1qIqn/PWhB4s2uOXRFeL26X9BR3h1lWdi3g28+frOanIkFP4EVG3xNtYV
	 hBraGY7l7G/X9gEXyWcnCMI9y1QI3VzQs5Lav7c7+h75DMqCDYaa9kag+HxFQBgmz5zc1
	 gvycqq07y6OQoStJ1GBMC6H88hJdarIsnQDXXvVumEfXroCkhhDRdy7tB4e8oAk2v66hg
	 7DVfwe+DQ5q1laRG2wUp7MRZFYxDAcoGG8RR2RXRpU+Cdv1KsO8Uw0BTtkyRoyGitSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927862;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=AHXyk6QEYpxdCP04rxSDRnWXaEbcjS1wiyKd1DAANnM=;
	b=UpBehlN+gi/DIWn0qvhCSJaBr0bVAe7qDsNIvkZIoYPj9XnbWe7chJlhIxreAndv0QV0
	 77HqAaQ5EEu5hlwvu8F0iKwD5kYHiXtfsD++MjjUp3dN2/A8OWPPBkstR+XpMJdkfSGfR
	 6XOQjmpEs9nqWl5Bs7F2v7emcLYSzdbmt9VkG5U5hQ8eyrjSNdX3Wl3pgmCNy9KojmcdI
	 YzsOrCnstchDff293nrBuc4fDxEQp7Vs3rgkx3QAHGNw1FdJJHWA/LNglZpIrR1AYZiGn
	 Bq+lsJv96C6+LV4bTn2F/zy9jBhTz72cCT4V6D4x08jYDZd50Pct5Y24XCMqfkxRFOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwrRu7zp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5059606A32A;
	Tue, 17 Nov 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwrRu7zp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9FF1F000C5;
	Tue, 17 Nov 2026 15:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927862;
	bh=AHXyk6QEYpxdCP04rxSDRnWXaEbcjS1wiyKd1DAANnM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IwrRu7zpyMwz+3pBMKZEdNa3FOOhkJJ7rRDV7FsoGiEP25UZcd6COzVp73Ra3sDaY
	 QTCIyNsfnvgjLMSziVizOUfmrmkBtgii/2XyZVbmzhERUvB2hsjTyXA/H4bwHHgolg
	 iK8lvuKUTamnBheTf5ktoHxqC5Sq4or6kvlmDoN6rta1sp+KxZsYsrKlOO2wisUnVZ
	 /mcsaO3ym5Ep9bdiCvKnkPwJbA5e2VMj4QIQ4+LHFk69aznFnALfdwhKClnREIU1Lf
	 4sJEcX/+UELdExcK+3tr3TwMrq1jy4OPSGbMdC7ssnm7I1A3P/4cMGkkfE+3kKYI26
	 GaW58uBuAsrjA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Linus Walleij <linusw@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20261115-ux500-asoc-drop-vape-v1-1-46315e14642d@kernel.org>
References: <20261115-ux500-asoc-drop-vape-v1-1-46315e14642d@kernel.org>
Subject: Re: [PATCH] ASoC: ux500: Drop the VAPE regulator
Message-Id: <179491836927.77896.17333378148547307247.b4-ty@b4>
Date: Tue, 17 Nov 2026 12:26:09 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Fgd21gAwinj6UKOy3s9OTwKF0VSp7ifD/mLKvmpQ5mg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+5Hy+9cji0bmMb0eDf8fMtrezUG3b/HyGIW+i2eOe7
 5sEfZwmd5SyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAi+2YyMjR33XbW4ectXf2S
 2WL/s7ki1Q6/yhQ6FkiZVU7y6vt2sJfhr9iBy12unYnGS+f6KT+wvvcj5uLtG4u+LDtew//Kef6
 7+5wA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 15 Nov 2026 23:38:14 +0100, Linus Walleij wrote:
> ASoC: ux500: Drop the VAPE regulator

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: ux500: Drop the VAPE regulator
      https://git.kernel.org/broonie/sound/c/5515e4601aa0

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

