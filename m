Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57519488762
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283378; cv=none; b=j3OUpNtRYzEzKXcl9mtOGRPddKKfX10yM8Lep0XI8UAfsBMLqR+qoX9n/ZLvieTucK397WuCyfo8KpcJxJ1UpNcFNsdoCt/5rE9TuEIYYuJgw9ClbtWXF8wwfRWzMfYjPRTZsiDvV4tIhqF3h2AsudAgqGynggSWj3mFUhGpLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283378; c=relaxed/simple;
	bh=Ad1DukBGwLi6ArucFKVFRHpCwR2Weby1EPL9ATOHJ1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0eg6Xl/BhWKcR8scKvsnvgU2pzk2/U/L6/KoEjxslJAZGHE/jsvkJcM8xJohT5Itz4Evkp15rapH6VPk8h7R5JnpCiWI33WptaeAW74wB2WJ90EHuOlHaFreogUXUTsaMuDoc/VnuT4uagG7DTH+7rib48sGnuX+Td1dKLhAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLT6pqk/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLT6pqk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F381F00A3D
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283377;
	bh=Ad1DukBGwLi6ArucFKVFRHpCwR2Weby1EPL9ATOHJ1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hLT6pqk/N3t4GsJHKh6IsbFpP3/hTTyorJFTxXTtgNJXA6dBXcp/OsAr/8n8udXL2
	 yPmUjPQnbS7tthwscVDgkBq0SpjosQzqiNizqvhoNY9oQT6oPiGLUAcgp7cbmnMb3Q
	 FzZjM3JzC2jleBf4G97WdhXulwnZuZrKjMpUOQMSv3N39ayy9KVor+RQs1iQnnZkF8
	 A2NkG8MKPzXB6EiPADiumEzl35X73acZNA96sFjXu35zszn+mHIm/2C9zB1BIGnDfN
	 YrQ1HzKChXi0MGA2X3ERbmr4r2zuBI2tFkW6LwhYtie1Ygd6J8oea2NX2at8grVpE8
	 bZuBEPcgIAgnw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b5e1340faeso1070144e87.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 10:22:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy3S3/LcnoeRxaVTg5K+KkqAvXOcnhCCimrQr3PA7m+KiHXZQ1YnzcLjGQ2JlUln38EtvFTIprINg==@vger.kernel.org
X-Gm-Message-State: AFuF++l72SL/0r7Nq/CRadg6ar3pXfOn30ax/BNcHN08nB7KLUpNxSE0
	yOny04K7eAe/OiKB2i4XVlHd2Jkm3lcx7TaYLijfuzqLPJJy6bcum/U5OZMGzFJQ986hcBXsRuP
	jsVwIkS3kvH9uhJCFzNH1zMujE7sRDis=
X-Received: by 2002:a05:6512:ac7:b0:5ae:b998:9134 with SMTP id
 2adb3069b0e04-5b5e68a7adfmr11827743e87.1.1788283375630; Tue, 01 Sep 2026
 10:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com> <20260827-kuno-soc-support-v5-9-6d47636a8f09@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-9-6d47636a8f09@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 1 Sep 2026 19:22:42 +0200
X-Gmail-Original-Message-ID: <CAD++jLnHCrhvdVCzbU5JA1qVOQ7hh7B=gwPr9QPtZdqh9ZxADw@mail.gmail.com>
X-Gm-Features: AcwNN1V_scX2qdh9lKw1huy2nxRfP13bn5JqOZZxyJX3f5glJ69SIw1ECTFLPMk
Message-ID: <CAD++jLnHCrhvdVCzbU5JA1qVOQ7hh7B=gwPr9QPtZdqh9ZxADw@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] pinctrl: qcom: Add Kuno pinctrl driver
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, Taniya Das <taniya.das@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 7:52=E2=80=AFPM Hardeep Sharma
<hardeep.sharma@oss.qualcomm.com> wrote:

> Add the TLMM pinctrl driver for the Qualcomm Kuno platform, supporting
> 110 GPIOs and their pin multiplexing, pin configuration and gpiolib
> interface through the common pinctrl-msm driver.
>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

FWIW LGTM
Reviewed-by: Linus Walleij <linusw@kernel.org>

Bartosz will decide and merge when it is ready.

Yours,
Linus Walleij
