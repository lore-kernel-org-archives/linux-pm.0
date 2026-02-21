Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5417BCA
	for <linux-pm@vger.kernel.org>; Sat, 21 Feb 2026 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771650363; cv=none; b=TEBdWBTJpVsJwIFfUDe3BwyiV6jDY/OksaHFB+BxKRk5rsdF72S8AzEHkb5zlRmAqwBIO4JDBwxTTbkXQR5ffbhmcA0cf31cglkuBZEHWEW8B2QR+LhLkd+7Q3LZiWUx3B9dqNqz+a0Qlfh8ypxtr/WIa+KMNW/8Qgf6+EPxLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771650363; c=relaxed/simple;
	bh=CgpXa30rV7bbhp6oVHWrrq4qO3E2hsaZPSYf0NAhynI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CstxD3w5/xvyHN8EXS5Xlq1xXAKeIAGOgRd6AMYzN2f+KRFdwKlkzzEWjbMiUqtSb7JGSfNEIMe2XssybKAmMqelxTz3X+PekglA+wdO2XjDWzTPKsAfr7sX+K53pAQjkV2/m2GYVbgNd6jIyPtuw12IWKIplO53BBkSPqAljIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqNlXVcO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqNlXVcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0E7C4AF0B
	for <linux-pm@vger.kernel.org>; Sat, 21 Feb 2026 05:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771650363;
	bh=CgpXa30rV7bbhp6oVHWrrq4qO3E2hsaZPSYf0NAhynI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=HqNlXVcO0tqqoAL3a1CXClMlyTMVFeo/HbeB/T+Y0kuIoGDruyIvcY+YzPrlHiSzC
	 88Kyrx93Is+AWwnjdB5t2/1h9gU5xVNzF+fKtMEIMOody338zA59b4KrCBZBryBXOq
	 XtZlQmhHxQW1iGU/y4V+29QX154H7+DtS5HszA56DUM+ij9RGXf7Fl+yIfCY7wQqp3
	 51O5jq48LuQqf468Vjhltvx+ucx+19PdLiGu1qpxfGzL1v9/xH54oVUy6qpqcy1wAK
	 F8Y9s6JXvauLw9OmI3+suzaH3ykoPY0OY3fUYPTMonBgk1QYDukJ9odZvPdo16CO1e
	 nV93jZUn843zA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38708180241so22008081fa.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 21:06:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUW2eUbTvy5/7m35RvpWbeLJ1ZHLzxuB3h1OFwGYF731mWfcgqwnIiDWeuNHLYilkL1E3C5xYG6Mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPlfcRpHSKilrSJAsIg7mQDRZN2Eiwp3lIgR5bOfJ3RrE1z4cO
	LU5H1Fe03i4WGDh4G5cjR9BokK3MPA+WBdyPuEuQ5henbe+0BZoYK+HahqoVu5ndIXEs6URkoLc
	Av4uX3Tgwnal674icXYYR2LdxFiXlYUA=
X-Received: by 2002:a05:651c:987:b0:387:197d:2067 with SMTP id
 38308e7fff4ca-389a5de07b2mr6463451fa.28.1771650361485; Fri, 20 Feb 2026
 21:06:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com> <20260220174938.672883-6-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260220174938.672883-6-krzysztof.kozlowski@oss.qualcomm.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 21 Feb 2026 13:05:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v66_QYMKVD=uZa5rAzd2GoRXovXpMpaPXRQmnwFGJMtowA@mail.gmail.com>
X-Gm-Features: AaiRm52nmrMc1fR_zFt5u_cs3Vt49aySbZq1WGzkhLMfbdFUJ-LvR7JLDtQy2uY
Message-ID: <CAGb2v66_QYMKVD=uZa5rAzd2GoRXovXpMpaPXRQmnwFGJMtowA@mail.gmail.com>
Subject: Re: [PATCH 2/4] power: supply: axp288_charger: Simplify returns of dev_err_probe()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 1:49=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> One of benefits of dev_err_probe() is that it returns the error value
> greatly simplifying the error paths (e.g. three lines -> one line).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
