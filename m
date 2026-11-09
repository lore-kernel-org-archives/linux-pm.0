Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209449;
	b=0BJRNrXZCTQBJ9i/XkVyw7MGOJ3oC0NHkCH8YrdH6W84Op4oHFfDJn2VmX99uGm74jdO
	 tS2nTqhXrAGmUojAtCwxh2tcVwEtqdp1RM3RpYSXzhklMO2kPwq1zhiTqR96Owi6QkCB4
	 jGo9DOyivuVPXsX/VkEcsOQm4DeQQxKPpnpOCr/sPdSv0SpUI8fU0/WTRfLmbgjLetIV/
	 degFr1Uwiyg+3qm8AC/DQdAJLrwz70bqOYH0s4OPqyswA95hRjxjT+yv7Oqid6YG7r9o2
	 YCxI9xYMC6YXRyS95fOsVZVColFLDjXvbEZvfTmGeNF+foxqqrORQA2bWOyZVqDdOpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209449;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=gwQguMjWTXj547Wlb0YlIL6VP9/rSHj8jIm9CFG7WT4=;
	b=As8u1V3yiNAQaI1JSamo0hTg5lFxnuOy5cIIezeeKAAKUQF/9yQrkls73C/AzjCe6Hsh
	 +xAF8bCySN6XbW3xnrUDf2ttuzlyM7iNLqLJyjTPQugn/0Y+fXqP0xHE1QF1tK4xfA7LS
	 Unv0dIEmd15YYsg6lMO4k+9nRqEe7zsCu0dFhZaTf2zYTJJgaq/vHdAa7eaIjYBf9yYrN
	 pLYTZ61dXkieIQB4TUQtjJogUUoEh+U7xjn4WbwBrAKeM/TJANIYqMgh9Flnq17HpaQPn
	 oYUbCcObHhycHeQmZC5c/8pwo5IwZaL92TWszluJSvSRmv8+Pd8z+6Fs00ziLvmhYBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI8528ES;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E2F606A31C;
	Mon,  9 Nov 2026 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI8528ES
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0681F008A3;
	Mon,  9 Nov 2026 07:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209448;
	bh=gwQguMjWTXj547Wlb0YlIL6VP9/rSHj8jIm9CFG7WT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RI8528EScJoHQR7kmRMgze/LCi7SBj6zZOm1eWudN14dvx8utmgoeoOTlwodaTzEJ
	 Wo6QM0nT3aCQMhaX8QniBs0+jbKz9cJUQcOtKYpMcaXqjM9qOtq0u2m+bm+Je/C/mc
	 2LOm8+Us79ByF6XABhqpy9vAIUV2TdUMr+x22tAVbdGVO6aDfsoIAU3eitosigdoFf
	 K9Pie4k5fuylYTOraY/aPbCA4dWQIydbfqzN3DWiinlalsQDCMGHsvqmEWLHx7+ZS9
	 K1L1P0hFCXDIVJRGKnfZtc+0hpJfkKaH4gO0hZWC+aimLr+nPy0E91f6NvyijUH7U0
	 o1FQUfHzVIBfQ==
Message-ID: <3b4d9f8a-2b5b-49c6-a2fa-666548029975@kernel.org>
Date: Mon, 9 Nov 2026 08:30:44 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/3] power: supply: max17040: pass the device
 fwnode to the power supply core
To: Hugo Karlsson <huggek@klattorp.se>, sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 matheus@castello.eng.br, me@iskren.info, m.szyprowski@samsung.com,
 clamor95@gmail.com
References: <20261108154241.198160-1-huggek@klattorp.se>
 <20261108154241.198160-2-huggek@klattorp.se>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261108154241.198160-2-huggek@klattorp.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2026 16:42, Hugo Karlsson wrote:
> Since commit f4b782af61ae ("power: max17040: pass status property from
> supplier") the driver forwards POWER_SUPPLY_PROP_STATUS to its supplier,
> and the DT binding documents a power-supplies property for naming that
> supplier. The driver never passes its device node to
> devm_power_supply_register(), however, so the power supply core cannot
> parse power-supplies and the battery never gets a supplier from
> firmware. The status lookup then always returns -ENODEV and userspace
> sees POWER_SUPPLY_STATUS_UNKNOWN.
> 
> Set psy_cfg.fwnode the way max17042_battery and cw2015_battery already
> do.
> 
> Fixes: f4b782af61ae ("power: max17040: pass status property from supplier")
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]

If you are resending, then at least you could run checkpatch.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof
