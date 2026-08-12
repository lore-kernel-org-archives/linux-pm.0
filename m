Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52503A9630;
	Wed, 12 Aug 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533947; cv=none; b=iPKSdmqs0RRK3pCgGuLzpoRkKkp6OPtyLESOkDNkrqtEEDnCAAOJ15DuW40xAEjF84VixBmgNgCAyIKLJFDSE/R+EfJGe5cG9W3IUROZiD+f8u8tdXP9K0N0fMcBT4zGDHwU217yXzeufm4pn2bTLXS4S0D1O+x488zD4MDmIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533947; c=relaxed/simple;
	bh=I2wXAp1K+YI5d/NgOO42iMyLG3QE2f0VK42W3SoUxAk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mDHNIqkI4RubOra1rBrSC/xf3yJXqOj0DbAJ/yQa/DKSiLwNbZ45mdLVMY1qZQ00syX3ZlxOvH84CdLgGBQgKmhFdNT4ryHfJv4FO+XQ9lkC9j3F4iMbz6kK4zQom+Q+GXTErPiNZ0XWp0bVPOjl6FFHdmcP5jJqDbxlRhEd4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICLDTn3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICLDTn3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F119D1F000E9;
	Wed, 12 Aug 2026 11:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786533945;
	bh=ddodq+ZTTmGF3leYzH9QS+cPvj+UgDzxn1f/c1nGk3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ICLDTn3pyzoqViRux6DSg3UvYyCDcWDlQiQPWaIpQ7VeaE0dnPOCGt8Pm80wjpikR
	 2PCYsQqyRfuqL3wJD/cCkmwhw5nCJL2OHr8td+phjGwuHqX8fp2fDCnLP7oq7CVtCj
	 nD0D7GT8iYd6EFCCYbwTHsuILrnGg/b0c5AAbnvT6SQd0A6hl6+VzS5ni9oeB6rkOl
	 OTzV0iiIIplCA5IzN1ZeDEBELn/OZnjrdQHFuI9XBYnf1wNS25NwCYDHzmwTP3qfsh
	 Ud3HSgRNkUjkEGCfM88VGn/0J0iVn3HXpCzQZZCyriwfS0Uuo5NB3JvIgUc7BYdssb
	 jTIUwVJHgSurQ==
From: Lee Jones <lee@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 zhanghongchen <zhanghongchen@loongson.cn>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, mfd@lists.linux.dev
In-Reply-To: <b76405a88b0cded91ba370139d7223fe2d6953df.1785829933.git.zhoubinbin@loongson.cn>
References: <b76405a88b0cded91ba370139d7223fe2d6953df.1785829933.git.zhoubinbin@loongson.cn>
Subject: Re: (subset) [PATCH v4 3/5] dt-bindings: mfd: syscon: Allow syscon
 compatible for Loongson-2K0300 chip id
Message-Id: <178653394272.1364218.6326646131780320669.b4-ty@b4>
Date: Wed, 12 Aug 2026 12:25:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 04 Aug 2026 20:43:56 +0800, Binbin Zhou wrote:
> The Loongson-2K0300 SoC exposes its chip ID registers through a syscon
> interface. Add the specific compatible `loongson,ls2k0300-chipid-syscon`
> to the allowed list of syscon bindings so that it can be referenced from
> the thermal node via a phandle.

Applied, thanks!

[3/5] dt-bindings: mfd: syscon: Allow syscon compatible for Loongson-2K0300 chip id
      commit: 2b02aa1b547a57e1e7aad1364a57520cf4ac49cf

--
Lee Jones [李琼斯]

