Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627727;
	b=mL79gFo3gri3ZodF18VKHqGF142LOBkrL5T92wkIRv/EReWhhzFJ5d6JbZzli2JgHhvy
	 sV+I1ZxrWAR7LSPHurD9qfal6HtCVFciYTXTYA3GO1ro3XrKv4tXElvZacOWJ2oEmFZt3
	 ycadNo89745Z22/caWp0y6QL/ldywQMwbMq676lMYq3i52sOrxHNe1r0tN1Gf2b4HNCj4
	 4zmHDzInkOs3jlEL8/Ctox2ZLYL0xQTkS6QK8u1DRX0KCNRwIp2N0Ac25GUFdIejKkBG1
	 0cRQ7HWjNnz0vnXTSFxHdy9PoVVVnSvWlPqTMk/okmBAA8sH4OiPFQ2Lx/TwrSQyasA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627727;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/LRV8VwiQw6HtKDeOUJ0erKvwle+mKOkUqkP/Em9dWg=;
	b=HogaEPr0FfCTbJ9qJ8WGhTCF/isbNsu2hLc+RUkFoyKYt/QGCnLuK74uaA/HaV5sGbsI
	 W4ncQ+0G0R2Ae85R6FQCdX+bjXhkqTziDkfse6txMvgaJLHCVr8la/u2kLG2lZuK+Driy
	 thp3LWVsDsVXiKXdTpK+r87ARu7FY4yG0k46n3vso30/8K0nlJSaC5WVS5pmQM5twjTsk
	 d4SgEFpAhNP3X7XbgysArneipodglB0v1QVbBptYkmSoKRx0xi6VrUUJ9i+97pC4sZvH8
	 XqXMoqrrL3923rXFc2Cukrvv2sXx7wuLzIHaFumCNg1AbfrALX5LNuRMn9+9nqG9S4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UfRw1LEb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC948606A31E;
	Wed, 25 Nov 2026 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UfRw1LEb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08AE1F000C4;
	Wed, 25 Nov 2026 17:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627727;
	bh=/LRV8VwiQw6HtKDeOUJ0erKvwle+mKOkUqkP/Em9dWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UfRw1LEbWfWo56ZwdZs6IKWItBDJ9KMIjJQ/3x0uUJ2wX2HG+FLlzRiVWjqLkBSqE
	 L80rrYU9WSnmRL0QZ/Ld9FI4vi9M3zos044R83QWjpBzxOBUhX5LId+Tgk2URazbbs
	 ufxNs0/heFFGuhH5XSe9XQLIw1kkom2zQAFnsVsYJj/u68V6Il6hZaD7Xlk1USbZnC
	 fuEqDLEyQzPI4LHcs1RJFEHCnMOTd6+YKgtfsBm+cmE8axj6QnNcyWij4Wl4HEVSey
	 x7A5ly8Rp2Eu8toPYBVxlgDCKvt5sQLwP54Qtb9QYqrnVwb5Q62opQhOCYXO7nKFVF
	 pklJK2t/U5dSA==
From: Miguel Ojeda <ojeda@kernel.org>
To: mmyangfl@gmail.com
Cc: fkan@apm.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sre@kernel.org,
	Aurelien Jarno <aurelien@aurel32.net>,
	Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH] power: reset: syscon-reboot: Use devm_register_sys_off_handler(RESTART)
Date: Wed, 25 Nov 2026 18:28:37 +0100
Message-ID: <20261125172837.29526-1-ojeda@kernel.org>
In-Reply-To: <20261026092049.84858-1-mmyangfl@gmail.com>
References: <20261026092049.84858-1-mmyangfl@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 26 Oct 2026 17:20:47 +0800 David Yang <mmyangfl@gmail.com> wrote:
>
> +	err = devm_register_sys_off_handler(dev, SYS_OFF_MODE_RESTART,
> +					    priority, syscon_restart_handle,
> +					    ctx);

In linux-next (next-20261123), booting riscv64 under QEMU, I am seeing:

    syscon-reboot reboot: can't register restart handler (err=-16)
    syscon-reboot reboot: probe with driver syscon-reboot failed with error -16

My LLM says:

  The SBI SRST restart handler (`sbi_srst_reboot_nb`) is already registered
  at priority 192, which is also the default one for this driver, and
  `register_sys_off_handler()` only allows one handler per non-default
  priority, unlike `register_restart_handler()`.

  The following patch moves the SBI one to `SYS_OFF_PRIO_FIRMWARE`, and
  with both patches on top of v7.4-rc4 the driver probes again:

    https://lore.kernel.org/all/20261118104935.1716-2-linux.amoon@gmail.com/

Cc'ing Anand and Aurelien.

I hope that helps!

Cheers,
Miguel
