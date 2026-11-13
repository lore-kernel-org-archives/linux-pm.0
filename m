Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565085;
	b=3sOU5inRlNcQO2V8ubMMjn6kSUE4z7iTTth3IRx71th9E9gaPATWkXC+/ekKcFnGARey
	 GuOWmPdOp/ffU9SBgH/wQqR3w24ygcg5zP+z9dvN6x3curSzrdSLawYxyWzMBGAUqLl/F
	 GAp9ByROtfgPax+ZcTUYBGSWJmeHRW5216qx/7aweJZ8LE+OS1SKi5v1p76umeKszhhNY
	 mdAtEHiGjj0oMCqc2Ns0mBOOND4UU+gZD6zI+Si+3vCTV3uk3KK+nxjgpA3YD84NK1vi6
	 BmHlaynkbm9cgcqMh/DkReVC46JXkFjBCIGSKaIgY/vhHAJFywSUfogj+BnZbmKQmBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565085;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oWpj+fMcU0ldZMemXXF2GwJUPPqvOroaTzblSr6zsuI=;
	b=AqTbFAxTuGXzYz3uXbRpS8K7FOepz/681yqTVJfOtk2582oVBs6YJHtmjy4MKdmCREqB
	 VUjpHc8VRFLYIBAJwy40Xhw4rHe+NWR/T9u2j1we8oXlHGpl7VAIOkBfdmqtGKMA8hET+
	 jNzD8lWL3mF6WKMyl6i6/P74o1UZnVc38SVZFw4XEYWL7Zb60SCF0yi4/L0iOah5QlwDW
	 jdg2MeZPxeRg3cCMi0Q+fPkwDxvlfVjz3W0K8vth9ZCWBzuSz2IwW4rwpQaPwHEe2HErh
	 6bWDo39e2v81iCdj83QSplDkJSDdIWSj6iWa5eXml9UZaYTzcqf246IR+Rcucdorq2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qh7eaR3m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C5606A33F
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qh7eaR3m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CCA1F000C7
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 10:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565084;
	bh=oWpj+fMcU0ldZMemXXF2GwJUPPqvOroaTzblSr6zsuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Qh7eaR3mKL/KtpLKgrkYS9K+6dQOEJpZBEUDnt//WDGrk5Id3GM50FoNbQ8fhBn5L
	 92XO4UVO8tvxi3aqDMLTs2YhCxGcoQIIiFTCciZH9oE8KaHbDxtgR9Uh8FgbiE9wwo
	 CeYQ+HJ3k+ILOSnvat9n1e7hUGFQncLPzCZu1ab2OKmhoLf/IbOyocO7mkbqxwrRlz
	 V4IbnQxnbHQrxmZYh8oyn1b/ZYYQH2LxhVzku/WQb64ZCijhaKl7OleFmZzYIOGovG
	 H6kHUMxFbvH75aIn0rxXcFYusN5NJanO2wZTupcSL1iO3Vk5pUeoA7G5XERe11wTxH
	 m45l4nGo7wukg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6dde81a6820so979488eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 02:18:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF9OOdepWzV6fGqNPJtCMGFRadC34u467R2Um8bPA6yczWNa3Cw23TQ2c92dP8lCS47HNzzAlAkDQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+qO/oQL7vvF5LwHezcYwaw2xQWR3+sfBPr1vDUVqRN8LNY1nff
	aiNM/rh2IrMWDCpav7d6evNLIOnTo3rdL7tXK7mGfy4O4VN30SpnrV/Wk8WGMVELlYNE06uGBge
	blCySnRaVIPTA3hDbSzIPrdaiBP296gI=
X-Received: by 2002:a05:6820:2228:b0:70a:1787:2696 with SMTP id
 006d021491bc7-71ab50522aamr1246436eaf.61.1794565084106; Fri, 13 Nov 2026
 02:18:04 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com> <20261022-add-board-ok3572-c-v1-8-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-8-0b0fd85a31ee@qq.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 13 Nov 2026 11:17:47 +0100
X-Gmail-Original-Message-ID: <CAD++jLkJsYtjKOF7wpiUqSLoBuiOe+C5sMEQo7XZ1dW773+pJQ@mail.gmail.com>
X-Gm-Features: AclHuK9FczXasoO8qxg9IxepytTJahNxlbbuShGYzvO1iLyvCzMkO5H7q2dWjZE
Message-ID: <CAD++jLkJsYtjKOF7wpiUqSLoBuiOe+C5sMEQo7XZ1dW773+pJQ@mail.gmail.com>
Subject: Re: [PATCH 08/27] pinctrl: rockchip: Add RK3572 support
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
> Support RK3572 pinmux, bias, drive-strength, and Schmitt controls.
> Enable input buffers during mux changes for the RGMII receive clocks.
>
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

This patch 8/27 applied to the pinctrl tree.

Yours,
Linus Walleij
