Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539688;
	b=D5hR98RlVIRRy2XyLBJeWCXQ+2kYKssBvmAzWEPsB0Q/LMBck9qmrXe8S+0zLhlaKLDR
	 Yku4+8G2w26N+m8t7VMdWitueuNKhFdqYkqqMWG4W5ljlcKxbdxRh7YIRTkZFMupcFYPY
	 JdKLgFyv7vBtLTwjn5dIZYfcrQ4SGHH+uyatmbN6i0qI3/LJkG+7mkiOPTc6F13q628qR
	 QyC9b2+B7SN11dhOURLnM3rymx8g6UzxnRNXXaW4nK2OnE5lCQXL1rFAfywBIPLZ1jx/P
	 lJMYON9GrDSFtuxOakzD5Rx63jydEqfs0groXKRJA5/irW58fKFcmTXbRs8tA7f1e4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539688;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IDzclnct8WA8a6C78MYePSDwkn2DldpsvUxqm75JnPg=;
	b=MCgL30X5pJYLzBvSziGq2fbLt2zCp0TfjTk6pjPFE/axs0+YNH/8ycYWP8vMW784fY39
	 z9xKQ/OdO1unYJfvZKv1N24ASw97RUSTdQQxd1SQ3PYsjhNROmULvNyGvrp/5atT87qN4
	 yxsJcws8TI0M+/tbGKo7q4mvBXQ9OJ9Xu8ISxA7EYD5za8HIwFRDsWVy00J/tdQ7fHEYB
	 qukAkt2duw/iOr9EzgGreUiMJDNiH5sV0bEG/NdTxOL8jOQJnaG/WYW7+0kl/J/5Xw4BB
	 39cZeGPdbQN2m/gvy37+UcM2LSoSF8eTbx5bA2z8qAHCDOhE/y+7VUDflez8Fc8sbGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd+0mX+b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42417606A321;
	Tue, 24 Nov 2026 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd+0mX+b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD981F000C0;
	Tue, 24 Nov 2026 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795539688;
	bh=IDzclnct8WA8a6C78MYePSDwkn2DldpsvUxqm75JnPg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bd+0mX+bTVWMLTn4CQSE46+nfqgd0ABeNiCzAm0TxnwofXmJ0w5usxsHQ7qSOFKIi
	 pEO0DMzttBu+4SkrXcjDFOzQmJJga2PNIxM+q06wR9BA+Ocedl5ODmEmkple1At4pA
	 7ch5dTLl3RWrDRSnPZmogHayUFuAWBmy2kiRnQC19a7qyZOE2g3BMXGgt+vHNCXITq
	 mFgo5Taxav0ADHcEsJbrveTLWlcm/tuo+tcEkbdO8+1s3dzH4vZcRpsBe7I0ywXDjr
	 a+ok95WVND4sJaJ9QOrQkgS6T73TlyGAbexJNkpQDEOrql3j19NtYQmeryOA6bazjY
	 Da2NpjC89U/hg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Brian Norris <briannorris@chromium.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, linux-pm@vger.kernel.org, 
 linux-sound@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 linux-arm-msm@vger.kernel.org
In-Reply-To: <20261112111937.RESEND.1.I5cd238b1d4516d4d6980565e0a4e1b83d9abce63@changeid>
References: <20261112111937.RESEND.1.I5cd238b1d4516d4d6980565e0a4e1b83d9abce63@changeid>
Subject: Re: [RESEND PATCH 1/3] ASoC: codecs: lpass: Discard
 pm_runtime_put_autosuspend() return values
Message-Id: <179552812780.264265.5289486114789888312.b4-ty@b4>
Date: Tue, 24 Nov 2026 13:48:47 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OQ/VGJF3rBrOALX3r/NGNh5X7pkoGJ8oI9D2vpyqMPo=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJZDz0+fmtOU+naSTd2xzFtnv7Dhs3/6aNaaXXPh4EqX
 VPnqudO6ChlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBELixgZFh8VmmtT9STiOnM
 8+ceDnC3WfVK59x3pmk1V/vkvqVHfuBhZPiouT2+xs029/6/+UvmSL3z1WKK3LA9/ZDAh889Sxp
 naDICAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 12 Nov 2026 11:19:37 -0800, Brian Norris wrote:
> ASoC: codecs: lpass: Discard pm_runtime_put_autosuspend() return values

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/3] ASoC: codecs: lpass: Discard pm_runtime_put_autosuspend() return values
      https://git.kernel.org/broonie/sound/c/673701e1c6bb
[2/3] ASoC: intel: atom: Discard pm_runtime_put_autosuspend() return value
      https://git.kernel.org/broonie/sound/c/ed3284607d65
[3/3] ASoC: SOF: Discard pm_runtime_put_autosuspend() return values
      https://git.kernel.org/broonie/sound/c/cbe3a1192e7c

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

