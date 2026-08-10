Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6E3BB685
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359811; cv=none; b=CnB1rvQEjGCjyMJGFEx3nYY/CAHS++rljWwAHqIqDdVSJlUFzjJZ7SgzLZYfJcVA91w62VxZfT/7UJ1TVzSllp5+mIQwl/dCBU02F4EJd5d314tEM2rxtPtkby+iU+upbhKid0S7RCqN3tcjf1IlRZ3gwzF5E2T8JbY4ogWY/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359811; c=relaxed/simple;
	bh=p49IchS1moer5f9ixq9X0KkzRurkRwI24S8WQ72LvTw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTO0DuSmYemq/a7Jo6S0HR3OdhcllU1qTp2Mn6ICj8eqCsmPBBpNIuhCjv4NcscxAmGywqcYqCkCTzV7sYE8Jo7A2CZtFdgn9e6+H//7XXMgljwBzfQKPGzjYVw3GaPVAISadhBHEjixP/O+ZooFX3KucwZFlp8lVr9WVKGfJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdWyUmhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdWyUmhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2D01F0155C
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359809;
	bh=ekwf+Zy2P4O9p1ZEiUBKTIiE5IQ8iZ2Cubn4LVEzpyY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=PdWyUmhy2AasE+KLSnEw1XSU70YHC5HSdHrKy1otm9Lzgbn9zbYcVShJ4LOzbyAVn
	 GpCp40kZKFJ696slzMadXDSCfyokg4pWnXY1TCnwGYomnVsi/qbxH9TlR1NSt0IDBs
	 zjcYwEDHnsC+rmnUTdJ68gbm1a5b/6jZP0g5KbGykg74EhRavTqBTy0dnYw6ojAX0+
	 665yWOCea3+VPGQReiwpe3jmwm4CyEQ7+smo9LML2nxQPFmzF6Itv4H/mGcWNcxzyS
	 9crUlqnc0lZm5yxIWBInqSX08UTidePGgYpjGyywZmnNJUb/8eWNKfr1EALiNNQnwy
	 7IUlzT0KqP4zw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b3119957f0so1154918e87.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 04:03:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq1uR9DdJKIb7CArnU/bfkJ9jokf9hWT2F27uIie5wkUvnYhuKSyQID71dV1RzfI43fgaXgM6OtPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxooBQ0vmNIKcy4vr6l6jyRoSW3CLKk0pjkHN3BqitJCccwK73x
	+w2ANiLMpLu0crvuwEVFuyEf4zwnu3qpjqv0AnYU9jqE1diuNvZ9MNsxIuthL+UWEMWtjt2pb1k
	u90EBoVxLzFxgN8MLH+S5IakeBAdpk8B4EWWKqIB6NA==
X-Received: by 2002:a05:6512:610:10b0:5b2:9391:40e1 with SMTP id
 2adb3069b0e04-5b2f4cdc1a1mr4534940e87.51.1786359808243; Mon, 10 Aug 2026
 04:03:28 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 06:03:26 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 06:03:26 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260809-kuno-soc-support-v1-9-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com> <20260809-kuno-soc-support-v1-9-5e0ede4a0c72@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 06:03:26 -0500
X-Gmail-Original-Message-ID: <CAMRc=MeRNMug6hZ8Jcv7drVfKbLRxG=FG8r9--PkwEpcj5JuCA@mail.gmail.com>
X-Gm-Features: AUfX_myvx7TjMFh-i1Xu8rFjTgNwvi8c6AXDbCHE0yc0UfXzrx62czbv7eUvtQs
Message-ID: <CAMRc=MeRNMug6hZ8Jcv7drVfKbLRxG=FG8r9--PkwEpcj5JuCA@mail.gmail.com>
Subject: Re: [PATCH 09/15] pinctrl: qcom: Add Kuno pinctrl driver
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Aug 2026 09:27:08 +0200, Hardeep Sharma
<hardeep.sharma@oss.qualcomm.com> said:
> Add the TLMM pinctrl driver for the Qualcomm Kuno platform, supporting
> 110 GPIOs and their pin multiplexing, pin configuration and gpiolib
> interface through the common pinctrl-msm driver.
>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
> +

...

> +static const struct pinfunction kuno_functions[] = {
> +	MSM_PIN_FUNCTION(gpio),

MSM_GPIO_PIN_FUNCTION() ?

> +	MSM_PIN_FUNCTION(audio_ref_clk),
> +	MSM_PIN_FUNCTION(coex_uart),
> +	MSM_PIN_FUNCTION(ebi2_lcd_a),
> +	MSM_PIN_FUNCTION(ebi2_lcd_cs),
> +	MSM_PIN_FUNCTION(ebi2_lcd_reset),
> +	MSM_PIN_FUNCTION(ebi2_lcd_te),
> +	MSM_PIN_FUNCTION(emac_mdc),
> +	MSM_PIN_FUNCTION(emac_mdio),
> +	MSM_PIN_FUNCTION(emac_pps_in),
> +	MSM_PIN_FUNCTION(emac_ptp_aux),
> +	MSM_PIN_FUNCTION(emac_ptp_pps),
> +	MSM_PIN_FUNCTION(gcc_gp1_clk),
> +	MSM_PIN_FUNCTION(gcc_gp2_clk),
> +	MSM_PIN_FUNCTION(gcc_gp3_clk),
> +	MSM_PIN_FUNCTION(mi2s0_data0),
> +	MSM_PIN_FUNCTION(mi2s0_data1),
> +	MSM_PIN_FUNCTION(mi2s0_sck),
> +	MSM_PIN_FUNCTION(mi2s0_ws),
> +	MSM_PIN_FUNCTION(mi2s1_data0),
> +	MSM_PIN_FUNCTION(mi2s1_data1),
> +	MSM_PIN_FUNCTION(mi2s1_sck),
> +	MSM_PIN_FUNCTION(mi2s1_ws),
> +	MSM_PIN_FUNCTION(mi2s_mclk),
> +	MSM_PIN_FUNCTION(nav_gpio),

Possibly here too?

> +	MSM_PIN_FUNCTION(pci_e_rst),
> +	MSM_PIN_FUNCTION(pcie_clkreq_n),
> +	MSM_PIN_FUNCTION(pll_bist_sync),
> +	MSM_PIN_FUNCTION(pll_clk_aux),
> +	MSM_PIN_FUNCTION(qdss_cti_trig0),
> +	MSM_PIN_FUNCTION(qdss_cti_trig1),
> +	MSM_PIN_FUNCTION(qdss_gpio_traceclk),
> +	MSM_PIN_FUNCTION(qdss_gpio_tracectl),
> +	MSM_PIN_FUNCTION(qup0_se0),
> +	MSM_PIN_FUNCTION(qup0_se1),
> +	MSM_PIN_FUNCTION(qup0_se2),
> +	MSM_PIN_FUNCTION(qup0_se3_mira),
> +	MSM_PIN_FUNCTION(qup0_se3_mirb),
> +	MSM_PIN_FUNCTION(qup0_se4),
> +	MSM_PIN_FUNCTION(sdc4_clk),
> +	MSM_PIN_FUNCTION(sdc4_cmd),
> +	MSM_PIN_FUNCTION(sdc4_data),
> +	MSM_PIN_FUNCTION(sdc4_tb_trig),
> +	MSM_PIN_FUNCTION(sgmii_phy_intr),
> +	MSM_PIN_FUNCTION(spmi_coex_clk),
> +	MSM_PIN_FUNCTION(spmi_coex_data),
> +	MSM_PIN_FUNCTION(spmi_vgi_hwevent),
> +	MSM_PIN_FUNCTION(uim1_clk),
> +	MSM_PIN_FUNCTION(uim1_data),
> +	MSM_PIN_FUNCTION(uim1_present),
> +	MSM_PIN_FUNCTION(uim1_reset),
> +	MSM_PIN_FUNCTION(usb2phy_ac_en),
> +};
> +

Bart
