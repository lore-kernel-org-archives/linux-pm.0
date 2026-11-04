Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797526;
	b=3q6i83EDIXhQGvD/JcGVc3PX46vbwHCSWoUc0BDVhOhZ146OvtMqkNsiz+4c2IkpKBj7
	 WUuKjB2skR1uyGYx1yv+itiLjnoZhXq+kfB9O+aehtq7RlSzyETOQK9nJ8/rIqhme29aj
	 JyyKCmgSX3YPwwfD4TIDKq1YA4T5e5PyNdK8FcRjGHR0Q7UhSPzFmq3I4s3Vzr1G28BtX
	 IADOqFiGCd+ynUwFjorQogWeXRECPf+dykLGn3L/03bBOXsiWb1jRtTQpR4hyjjGYl1tZ
	 5KC186d54xrYm3bE4Tp1gAP+wrBFV7v8H4c/bAZUyLg78dafmWTXmGbP/SHwwZmGWMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797526;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LPKBxmhyg89L22fIaf9IQyOx1ftYYGNVMEyFVHYOx+w=;
	b=tGa3uTXqjc1mg1BZhe4y8/IA83xsy17oEsvoOKGaS4w2rN9HhRYMOLpyUPxugZJuXFN1
	 entDLF8/wjTEmlkmCj+09jwWwlqgwojhzNJ2r0+o8+VIiE8cx7aLHnZZ2z+mhdJZX1QIN
	 9RQGhZ77qcrdK57OovsgFiVyOYoCUlv9B9E5ekqQ+A0YWmRVuzymiPqaeufirsoIDx3oL
	 S7aRGk03Vkextk7eG6S2z3P1F0s6Xkq8gI7SQ0jX6sKN90PnSUkXX14afaSdLNe1Vf9pX
	 leK2KxKVckt0zQlGbLv+XXFu4LHFpGuY0mylFAo0tQ9wEW69TWd0kTQ7qlyEJwg3bZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVrWEomG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79446606A33A
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVrWEomG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B371F0093A
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797526;
	bh=LPKBxmhyg89L22fIaf9IQyOx1ftYYGNVMEyFVHYOx+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RVrWEomG/IIX5cxMVNeQAJqg14gY31z7wjGrtqlnEeyw4TansTn8u898lZjy38P8l
	 IOYQ9fyLUGCmGGEPqik0GJA2klQhNatrvFkvVB80aWjIvTHrBVzlCQFszwyf2gduN3
	 mcROiofudnBjB9++SPu6MauEKpax3EiJo+g3lZKCtLcPdCnZImr7QgHyKGGO6at0N2
	 O2NmcLOL3Edcev8rg6ppQLVQ+I2k2e6OXcijhVELFd0GgCI9aN8TntOMvjEhPIcvBM
	 bOQFp7iInM+ZQjXmV7bD/OMvupiiBncz9rL/Q0PN1gE5ALQ0tZr9fLd/jdH6eVQnKV
	 aRwzuZ249826Q==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso656453e87.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 05:05:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw6tcUPLMl04l4eFKuOqXpN30igAHC24I/p80tpq0s18aJKg1hyoFp4a36VgXtcCll8HIdAqNKPyA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+vksKP9y56xMk6cXJaUurTeOR+rOyPmjQ0JZAlA+rgwqVIQM9l
	7q2HGBiac7uNtWz5j8YMplootxeMNMq4SWOClh2O53kRrYrGnhlxRtNQFVxRkS5uFPipMr47sHP
	2Lw+nuGDNcAk+HfrM2qLowM054gVUqTI=
X-Received: by 2002:a05:6512:3a89:b0:5bc:c446:760c with SMTP id
 2adb3069b0e04-5bfd956f3c7mr5830020e87.48.1793797524594; Wed, 04 Nov 2026
 05:05:24 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com> <20261022-add-board-ok3572-c-v1-6-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-6-0b0fd85a31ee@qq.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 4 Nov 2026 14:05:11 +0100
X-Gmail-Original-Message-ID: <CAD++jLkfnsnqr9DeJG1UY1BNPmXV=L1fh0o1fRgq2N70k3Aq2A@mail.gmail.com>
X-Gm-Features: AclHuK_mv5t_ofBXXvFmTtsscxk8ZZZWMu9yfbYuWEEuKyuLUDpVdyNQz1Is1sQ
Message-ID: <CAD++jLkfnsnqr9DeJG1UY1BNPmXV=L1fh0o1fRgq2N70k3Aq2A@mail.gmail.com>
Subject: Re: [PATCH 06/27] dt-bindings: gpio: rockchip: Add RK3572 GPIO banks
To: 1579567540@qq.com
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Wu <david.wu@rock-chips.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 6:12=E2=80=AFPM Cunhao Lu via B4 Relay
<devnull+1579567540.qq.com@kernel.org> wrote:

> From: Cunhao Lu <1579567540@qq.com>
>
> RK3572 GPIO banks have four parent interrupts and a separate debounce
> clock.
>
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Perhaps Bartosz can just apply this one patch to shrink the series?

Yours,
Linus Walleij
