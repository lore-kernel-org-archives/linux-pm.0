Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266631;
	b=nfNHVOo9lrPnm4UDvLNTUjm3pj5u7xFMiyk3+2PChj5E52B9Gix+w8SlDvva7V2QK/uO
	 jI38CAecaVNj58y5DqCg3tm4NzREwNXlysmOqBFW2CjqhBnmtp/2FT/EqII2e3IAHP4SU
	 NFivrtfDpOHSylJwKhGtjF96K+tpmyafjrTV2umTU99/a0jy3w5bQAhqW6tWhpCnmiqhA
	 nB7MR9eVabAwt6rORKaGTV+gxpdHL+NcM4H4AspJQzG/hnDkNvGS0Xggf4/RmStPZVFDm
	 RKizByqErYc/PHG2UcGYTjvHw7JbPnxyu7e6RIGEoVB8XB25IVl68P17JW9v4nRrA3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266631;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=k2DJkpx96ZEKH6UFEmf/RC7TQH+ipmzROcDG2Evbn/k=;
	b=YufFQfvt6M5VIvwmOouUNsPaGCWKQk76dZRUwgLIcTSSJ/ZkOBZLTOG0eHFMH5qIuqgS
	 CRjzSfwrKEhDFPF1vHlM+V9X4DerBPwwR3FxwA0Qw8OREDk+RG7q7hQ41XWYMPfizBtRD
	 uPlGOGQAqt0NpaGeukr00FKB4eU4I6fBHSQnOfZbUoWHtneo5MgeGWAQyYAoZZUm9jIid
	 EFHCf4XsGDCWisrJawWU8XqgEGBrvIxCkj2n0aesAZDAoAYtH6lz0llGjTI5w/HdbzFdY
	 3DA95sTG21EGaZwBZ1u+n94E0R390fgGYB8RndbgHS3daDcXOO8xSUr1z521l+e3utw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5FysmdL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C49606A31A;
	Thu, 29 Oct 2026 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5FysmdL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A791F01825;
	Thu, 29 Oct 2026 09:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793266630;
	bh=k2DJkpx96ZEKH6UFEmf/RC7TQH+ipmzROcDG2Evbn/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g5FysmdLLVxQ+2Ar3CcRquQy76Sd4pRBA6uhd4lt7ApRPgHHSiz/1+fqpgyZVYrBe
	 ujRepDuX4Cghb6uIigkUvsPO2sq5y/smmN833zFlMPTFeWhylDfTG5p+ZUp0VBQKLw
	 HWo/8ytHlGYf2/8zHjsE+gfP5AP9tTl8lhwYuLdtDkKNyL0MytCSjEz5jzhQv7zpz/
	 UGgyUJv9me0DKPuKcBxJ7Nhs6ONMIBmshnn0KAbdA2Ck2sDfbVCt4J5EB0XD4HH72Z
	 CrrFyyRMNqxTuUprliD8+bGlh8IwaJNvbuYAuZFTqAE20ko7zCZ4hiE8BMF9kVExVu
	 qZ14lzBggQJzg==
Date: Thu, 29 Oct 2026 10:37:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, maccraft123mc@gmail.com, zhangqing@rock-chips.com, 
	zyw@rock-chips.com, sre@kernel.org, heiko@sntech.de, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, lee@kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>, Jacob Cook <jacobmcook1984@gmail.com>
Subject: Re: [PATCH 3/5] power: supply: rk817-charger: Correct the gauge
 across system sleep
Message-ID: <20261029-supportive-garrulous-kagu-f3edac@quoll>
References: <20261026174834.1652309-1-macroalpha82@gmail.com>
 <20261026174834.1652309-4-macroalpha82@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026174834.1652309-4-macroalpha82@gmail.com>

On Mon, Oct 26, 2026 at 12:48:32PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The coulomb counter is erratic while the system sleeps. On an RG353M
> charging at 1.4A, one 15 minute sleep registered 69% of the metered
> charge and another 139%, and a charge that finished during sleep still
> showed the pre-sleep percentage at wake. The signals that could correct
> it are gone by the time the driver runs again: RELAX_STS clears as soon
> as the wakeup load exceeds the relax threshold (300mA here, less than
> an idle UI draws), and CHARGE_FINISH disappears while the charger
> re-detects its input. The BSP driver corrects at resume from sleep time
> times current and from the relax voltage. Do the same from evidence
> that persists:
> 
> - At suspend, stamp boottime, charge, current and charging state, and
>   clear the relax-updated flags.
> 
> - At resume, recompute the soc from the counter, capped at full. A
>   relax pair with its flags set was latched during this sleep:
>   recalibrate from it without demanding a live RELAX_STS. Otherwise,
>   if the system slept charging, credit elapsed * current where the
>   counter fell short, saturating at full, which also covers a charge
>   that finished during sleep.
> 
> The constant-current estimate reads high across a CV taper; the cap
> bounds it and the next rested pair corrects the remainder.
> 
> Log the counter at suspend and resume, the battery voltage and the
> relax pair, so the path taken can be read from the log.
> 
> Suggested-by: Jacob Cook <jacobmcook1984@gmail.com>
> Co-developed-by: Jacob Cook <jacobmcook1984@gmail.com>
> Signed-off-by: Jacob Cook <jacobmcook1984@gmail.com>

One cannot suggest own work. How would that work:
Krzysztof 1: Hi Krzysztof, my name is Krzysztof, would you do foo-bar?
Krzysztof 2: Yes, Krzysztof, of course, excellent idea, let me credit
you in Suggested-by.

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Assisted-by: Claude:claude-5-fable

Drop, not correct format for some time, but regardless checkpatch should
complain.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof

