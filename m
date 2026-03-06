Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C93A63F4;
	Fri,  6 Mar 2026 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805594; cv=none; b=HsFpNIN2X9xWIh5qrdsTSzhyZaqgy58g3gN2xxWxphR1I65V0hS1xcdh4BLt/kd1sfPEGADamMwcx2HVzbVwkPxzUKtEMYYdxXa0mbeeq8WmATqCElCN0YNA2gn+ThJ4FyFDnYJg8DpnpwVrydvtcfvMNSRoz37MwPcLM9JKEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805594; c=relaxed/simple;
	bh=IBx8s4MEb82WlxxgDM5bJV6i1OaR8I0L+CFSnAv5e9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L9kpY/xFwLgLhneLk5PHOFR1RfLO7psD5GdjTRhMwPdgCdLRl8q/i5TN7TrDz5e5Ig/ja+z+DIIvXa+Odog8gOgYv5ii+ygzKaR4rGckpvtXvwELyzybmvna+4YZVq/dMvXuP4JcPdhiaUdgceKBFhbHq3cso4WCYkFifSZg/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igF5XwZk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igF5XwZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B95C2BC87;
	Fri,  6 Mar 2026 13:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772805593;
	bh=IBx8s4MEb82WlxxgDM5bJV6i1OaR8I0L+CFSnAv5e9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=igF5XwZkDIVguvOozPEcoDIOUNb4XQBtPfO7s3jYmwgSbWpeqIZBYS5Gf/5uvLEzE
	 rSirtVCE+D17p03ffGx+3ruUkP4hE6XWxEywzZn4VtLKXQONo9suR6p/3aVC9BROdx
	 gSBNQuIGpqgXxwk21GOrfsqdQ4fWrupIsR+LbGcwCtKBkwVH6s/0EjqfNQsa3C2tca
	 GhBCMi7uezfrCWIjRhVKJAN7TOwHo52Z2pAPStb35e7DoyVgbUQISQviVuJHkjwA+a
	 Xl0eykpl9YXDOqtru0gBz6CDfejU6Frkuzp/pWsANxP21cme2JVECT//60L0kmR9oe
	 zR2fB8i9xCcpw==
From: Lee Jones <lee@kernel.org>
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Michael Reeves <michael.reeves077@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Hector Martin <marcan@marcan.st>
In-Reply-To: <20260217-b4-macsmc-power-v7-2-4a4d63664362@gmail.com>
References: <20260217-b4-macsmc-power-v7-2-4a4d63664362@gmail.com>
Subject: Re: (subset) [PATCH RESEND v7 2/2] mfd: macsmc: Wire up Apple SMC
 power driver
Message-Id: <177280559145.1054360.6985204095532084985.b4-ty@kernel.org>
Date: Fri, 06 Mar 2026 13:59:51 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Tue, 17 Feb 2026 21:47:26 +1100, Michael Reeves wrote:
> Add the cell for the macsmc-power driver so it is probed by the
> MFD core.
> 
> 

Applied, thanks!

[2/2] mfd: macsmc: Wire up Apple SMC power driver
      commit: fd708bd746a1c81e7467f61ee1b538b1f4f23383

--
Lee Jones [李琼斯]

