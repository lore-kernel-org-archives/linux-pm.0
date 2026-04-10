Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74433DA5D1;
	Fri, 10 Apr 2026 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838503; cv=none; b=VpddTh+3K6oGJ/+NfgCN1bg6yiMFY5BUSYYp3OS0lZ5uasJu5NipZ2SZ2HXUmVAe4vsQkmULz99F1xx2buuYde/Co8iSPtvIK2p+BF3aBIXWbodqDrabfPn0I99aJGF0uyLOZHVo8uXJViVNJv8E8rePttd0aVWqMZfO3amGuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838503; c=relaxed/simple;
	bh=KDJKpZpI8gF/8EhfJCOR6TdwnZwUN1VzGf+Iv+pFLrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jKpp2/ESEfkSpcsCJwpOWb4J7eAhV6yhPShhODzROEGF1zeWxqrG5YeojEc/79sW7OUoagnehS8CDMbD2FNagThw0P8828pzJcQ94M0QBH7MY75DWC9hO6w6dxCWc7AmXIVaW6/Skvdtpyoq5HJ1f7uATGQWRjUAFBp7hRWfq+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF4CWjKY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF4CWjKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA07C19421;
	Fri, 10 Apr 2026 16:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775838503;
	bh=KDJKpZpI8gF/8EhfJCOR6TdwnZwUN1VzGf+Iv+pFLrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cF4CWjKYbZHWGjXlvofpoDGGZ9TR1yOHT8WIjyxcptxXl3SDv2Lhf75LVrz0mcF6u
	 qR13YLMv8/btr7sxC/RzG8+B3d+QbgRlQeHYud04zgOxvzK129v/GNVQATcd0ixA6y
	 eF2kUIwv1WFFTZtM+sfVZ5voPLJmRQwjS0m7xdd7jBRLTWfTzgQgXRFxPPPKcd6D3O
	 I/ndlNekOfLNpuOa28l/ZlwkjJ+zFXCLTJUWUwFYOxxIrW/D2k9RQohdGYwxvJXq9J
	 nMFw1d3XIHZDkOtXJQfdQaohIoq5nW0vQE32bJvBmNNN1TNuI+fWXJnCigeCUOzV5K
	 6nvEkqQKZhqpg==
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
References: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
Subject: Re: (subset) [PATCH v6 00/11] Add support for the TI BQ25792
 battery charger
Message-Id: <177581837919.1070744.17621563361333380335.b4-ty@b4>
Date: Fri, 10 Apr 2026 11:52:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KDJKpZpI8gF/8EhfJCOR6TdwnZwUN1VzGf+Iv+pFLrw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp2SUieLBs4yjJAKCjA+O7IjNPiz2mxalGykmUr
 8W+kxR+IV+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadklIgAKCRAk1otyXVSH
 0K1IB/9cuplHzaSjeGBe910uWfzNFmnewSyag1dJ0LyVf9FdNk80V4JPAjU1+SoeZcdiR6pDJpQ
 OlU2bvBZmIZbceaDC5bQvv6BsDEWFzoDg3ouwsMLjdFUvh4RqfueUSx7E+Tl72Mxa3gYjmXYAp/
 LpaTeY4IopVA9rJzRvx8YB0mhpkO5gxHymlpRCEI/3iGUhTULtkMDYqMOU6XafYI4IQVvG4TW9K
 MumRXYD2ngOxsl5BSI9Rn3B6Yc/L3ApMYA9169OIIZzWRlGfcLtw2G0460s5VIVLMkKYO8f3bh0
 WSM+4lS49oz9t0NJltdgXsJqagdiTxATRZSSwygtNLBUS+wy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 31 Mar 2026 19:43:37 +0400, Alexey Charkov wrote:
> Add support for the TI BQ25792 battery charger
> 
> This adds support for the TI BQ25792 battery charger, which is similar in
> overall logic to the BQ25703A, but has a different register layout and
> slightly different lower-level programming logic.
> 
> The series is organized as follows:
> - Patch 1 adds the new variant to the existing DT binding, including the
>   changes in electrical characteristics
> - Patches 2-4 are minor cleanups to the existing BQ25703A OTG regulator
>   driver, slimming down the code and making it more reusable for the new
>   BQ25792 variant
> - Patch 5 is a logical fix to the BQ25703A clamping logic for VSYSMIN
>   (this is a standalone fix which can be applied independently and may be
>   backported to stable)
> - Patches 6-8 are slight refactoring of the existing BQ25703A charger
>   driver to make it more reusable for the new BQ25792 variant
> - Patch 9 adds platform data to distinguish between the two variants in
>   the parent MFD driver, and binds it to the new compatible string
> - Patches 10-11 add variant-specific code to support the new BQ25792
>   variant in the regulator part and the charger part respectively,
>   selected by the platform data added in patch 9
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.1

Thanks!

[02/11] regulator: bq257xx: Remove reference to the parent MFD's dev
        https://git.kernel.org/broonie/regulator/c/aef4d87f2c1f
[04/11] regulator: bq257xx: Make OTG enable GPIO really optional
        https://git.kernel.org/broonie/regulator/c/de76a763805d

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

