Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096396;
	b=Eq5cpINOa0c3hDv+XGJPskrywFqwqZPccONvrokUiXQJp57d32+tVXFng4YmtBkQxL/f
	 wAMVzQnqMbW72WGw+fqhemv8Tk8TA1nWJETHa7hk6Zy5A8l22xeVPO0F1B3mBWHMzqA7X
	 RlWILODm8/duPcdF+G12/66CdzmcDaTP25Mf2Fyf36+TjQrzU3GeU6WTdGN7bQqpH9TSE
	 wPyeaB1kZ1t5xyes1tngKfgGAsPItt+5ERYmd1F8e0cpt/3AbwTKn8w0wvKTTj9GKNRzW
	 Oyfcy2y+NTyXicZFUhpnWdftb/Z/jgeT7xEEmLNUxePmqeDY/BVJ+jv2ZkYGSCkRipg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096396;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9+6WXn/sngVPgeK/31SK6qm6xo9Fs6RGiV0s8gBtFpw=;
	b=4QAxl6x8rx9egm2D2fNUSaRiPWkzCtHE5/qtw1GpU++7tQvtYtxVnx9KW2P4QCMYaSWs
	 stPMwFH79kSzIgSjufNXubdkjqXhjIF5TEUth9i4MFpLbQoWw4jIVUeJKRCt53FiwSKAD
	 19npNtT5oNbThCT0vuzCQDAYzKKAcedggyUU+F1Z6HQyDImOYgUVR88508eKy5Iokiz/E
	 HX2RONnVaXv/dI6wBRN18N7XqZPYONvA9GhHju0EBbutHtHoQUHnHfPvhzlhkpyfa8HFH
	 JDlMmlOc7lnfq4S5jDm658BcfZ0sVTuPzTCxu7waPbdBzCXHlKJhG5hoyYVsMAP08Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGinBhwM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E773606A32F;
	Thu, 19 Nov 2026 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGinBhwM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1291F000C5;
	Thu, 19 Nov 2026 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795096395;
	bh=9+6WXn/sngVPgeK/31SK6qm6xo9Fs6RGiV0s8gBtFpw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jGinBhwM1BzloYX53rNR8HdAbmfw8mdQqfNiEE3eohKpb4xrggciKIRaLbOtlxnTf
	 qm7OiEBZe6nyKgEN9nKkTFhLRiAlFBzmZdJCeHSgM+4VjtmP3jN9pSP4O3G75Uj8nS
	 /skXUMqXFusQWMQ3cJ2RT+RKqWxl42sW9YDzXZNd03JSL0EoKSmxBbE96n6CrW4gKR
	 IR8tV3yV5pQj5gQAYdNzmzwtDhYjlaeR7SS4HWNl6BbVqGPcOqcP7UAYyABlAVAiw2
	 bEt7Be0hyDeSeHJG7/esbk6eWqSMTXvGJPgKEqZVuvvKYxmxGPxVjBFIM6mxgfXZjn
	 PLFLroMx1LNgg==
From: Mark Brown <broonie@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20261112112334.RESEND.1.Ia678a25bddd5942c7f3e11ff0eb807754d7e2aa2@changeid>
References: <20261112112334.RESEND.1.Ia678a25bddd5942c7f3e11ff0eb807754d7e2aa2@changeid>
Subject: Re: [RESEND PATCH] spi: ti-qspi: Discard
 pm_runtime_put_autosuspend() return value
Message-Id: <179502780705.810609.15184984112998051449.b4-ty@b4>
Date: Wed, 18 Nov 2026 18:50:07 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bYH1S/fwju1d/VUJxAr4qycZ4YK1nIb/29E5gVcVlz8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+/fe89jPBxECy1rF2wwb5LSc+36p9t066QoFFeWX/6
 23/WPZN7ihlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBEnPkY/ulzlNdaVNdxSC3w
 4eRILP8jcUTkyrQL1z9u1T36+vqsEB9Ghg/HHG49yjr6webVxIWTnW+uuvA4J3LiJw9V1/PZZUt
 MJrICAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 12 Nov 2026 11:23:34 -0800, Brian Norris wrote:
> spi: ti-qspi: Discard pm_runtime_put_autosuspend() return value

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: ti-qspi: Discard pm_runtime_put_autosuspend() return value
      https://git.kernel.org/broonie/spi/c/99885daefba2

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

