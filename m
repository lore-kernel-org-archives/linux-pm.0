Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244CB27727;
	Sat, 11 Jul 2026 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771620; cv=none; b=vF7dG4fDp596VhFRmdXP3NX2SqNs1f4vVw4CgLpbUxN7HolQDdAQz20uENfsopJsSkmGVG8CxuN7xp2Z48mLRug2/f3eB2bIONoYBUzsLwbgNXYSRFpGymN+0q/yGWFtX48h1SeVwx/k5ZvnEzGqIzX6XKJAkI0Oa/bnzYQOv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771620; c=relaxed/simple;
	bh=94CYsiDexERxDxvOZOkE1u9ftHBcDrrD7y0s249+GZQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BJn7/af5IzdRm9y0jbc03dh88etP+IzIQYoqK3Ix+j1LCh0ypO+sDzlZogknAaTaV/nmRG2D9elyDlrXFZVMuFb5Wih/+GDqaaPH9+1zY9m8soTxbJKGZCDMimGKoKdEn2ojcvw9b+ss+WToOfFyoh42TJvDI5APQCX1/dp4UYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWvJJnpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWvJJnpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1E51F000E9;
	Sat, 11 Jul 2026 12:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783771618;
	bh=94CYsiDexERxDxvOZOkE1u9ftHBcDrrD7y0s249+GZQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=bWvJJnpygOWrz6y4yUrpFU0RiIJol7arw5AIT4SfCe9VKa2FBpiOE48pJLB0YuXmg
	 xzQQ9TMewrxDop5z3HJF3TsdtjKj0ZvnIIry9iyG7yTCWegMF490Od67XLkl09VYHb
	 qCXb/gCVwUVKqdWa/+6o1MDJjRJBR19GYGH8JdYuAdiQVKQXmg4PFMQt/D59pvb7qv
	 UkVa4MwSBhpX04MguJEop5N6Hclhly8U0DdOm5ApkERFz3SRIVarmIy7v9uSjY5AJJ
	 6Bo21+DzA6yvrrH/dpK32qvzyIzRwTwvOZHAvirFppLe8Jsw2oYaZJutcQRkH1sbkW
	 bIuMidr5hrU3w==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 14:06:55 +0200
Message-Id: <DJVQ9J8WQP4V.37WGL1ZZEL3LP@kernel.org>
Subject: Re: [RFC PATCH 1/3] rust: i2c: add SMBus byte transfer helpers
Cc: <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sebastian
 Reichel" <sre@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Tamir Duberstein" <tamird@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Boqun Feng" <boqun@kernel.org>, "Bruce Robertson"
 <brucer42@gmail.com>
To: "Igor Korotin" <igor.korotin@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260708214738.25008-1-brucer42@gmail.com>
 <20260708214738.25008-2-brucer42@gmail.com>
 <178376605131.22511.1602274538745913609@linux.dev>
In-Reply-To: <178376605131.22511.1602274538745913609@linux.dev>

On Sat Jul 11, 2026 at 12:34 PM CEST, Igor Korotin wrote:
> I'd suggest holding this patch until that discussion settles -- Cc'ing
> Danilo here too, since it's ultimately a question of whether
> Io/IoCapable is the right abstraction for I2C at all -- rather than
> reworking it in parallel.

Please see the reply in [1].

[1] https://lore.kernel.org/all/DJVQ852J7SOH.26YBIJTQ9B66G@kernel.org/
