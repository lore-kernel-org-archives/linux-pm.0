Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA26437864
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786392207; cv=none; b=ZCDo4oaHmEiE61yR8cXqFU5xVmZSruC6KPqFWG4IWdlr4YgewMWCxaOn3SF4T4U38AI6eDY9r9lr55GZ5W14dvx6LOUaYlsC9rG9KwS96V/RZnq+ENKJn6vu+Bec12MhStDodk7Yrx8CDDBrTtiSWbW5DWYquEdChaqvceI0idY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786392207; c=relaxed/simple;
	bh=T22wC+AG2OIsJgyXoLDKjPj1WSjTxMwaoMhhUG4iOI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOigFy1/c24v/fixLSnGW2YJa5NJhxy8EmKlqeiQiUiJr5vwLwE+SinPbMfIE/gndlKxK4iRLpZ/Q7Wv8zaVOBKvgr/kiALav5AhC3YsrnK9L5GK4jABC7fIUOyIyYAJp1iqa9TyIioUOWudFrNduzEfHKYJVD5D8LsPS7+lpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pf4cRDK6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pf4cRDK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4A21F00A3E
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 20:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786392204;
	bh=rC1rVxqM5ZYISCIH4TAyel4S6fVMMHIK5wyEPeERNAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Pf4cRDK6xvYn1fyh+kqGX6+BMnq0+Sh0PuHO5qqk7sDFOQSZu6zJmY5FWZq2D5WK6
	 D3tHWjNvCA6y77ou2cytCB3ASrrYYzbW7gVV1xVfVkV3/FkGxoM8cWYkucFRo6CLyv
	 5ObRvK0Fu6trbuXMe4yKq3SRWHHJ5yYIsmFiuziGJslOQl/4hMQEfa+jzF3oDo28zu
	 iDjKPGFxHOuQHZjvRcNba0pgVMO+QPzARqCx+uUJJC4C3auoRW4b4ZQrsdjFBAe5RL
	 OcyDZ/Q7rF25XAJ6cakKzSfV6ZNZzkSOpsUnCmn/qey2fsIq5FV/5ZOuJwjKgaSLtY
	 fWieMcfcz4vnw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so2238541e87.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 13:03:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoMPzWQHwHS4g7+xr0ob0NRTnuh0DzsIrnqboB63EDLCFug8NYGeBP2IwwxSSkmo2TgnlEspFyuLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXMVEbH3H62iNI56acxZMduMYJK/lO9OkOZR1hPY107zTeBci
	LbbriEAd8e9WqhNGY8ryh8mW+CbAWKZ54Y0w577OlXMBIuagl4hOEUvePc4H87g6lwWliMFPVBh
	VM+WUiv/2pC17lD972Hr+CA5Pi9v4kbM=
X-Received: by 2002:a05:6512:6812:b0:5b3:419:7c85 with SMTP id
 2adb3069b0e04-5b30b723e05mr2481053e87.16.1786392203471; Mon, 10 Aug 2026
 13:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com> <20260809-kuno-soc-support-v1-15-5e0ede4a0c72@oss.qualcomm.com>
In-Reply-To: <20260809-kuno-soc-support-v1-15-5e0ede4a0c72@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 10 Aug 2026 22:03:10 +0200
X-Gmail-Original-Message-ID: <CAD++jL=M1E+Bvfe9tHw3FaSTFgR1Nfzyn==xoLETvARLZHPrMQ@mail.gmail.com>
X-Gm-Features: AUfX_myFok2F7A7L92w2o_ISKTNy-XQlclUV5wW5DA8yU_ux0Q3094VpM1fVTx8
Message-ID: <CAD++jL=M1E+Bvfe9tHw3FaSTFgR1Nfzyn==xoLETvARLZHPrMQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] ARM: dts: qcom: Add initial device tree for Kuno SoC
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hardeep,

thanks for your patch!

On Sun, Aug 9, 2026 at 9:29=E2=80=AFAM Hardeep Sharma
<hardeep.sharma@oss.qualcomm.com> wrote:

> +       memory {
> +               device_type =3D "memory";
> +               reg =3D <0x0 0x0>;
> +       };

Since this is clearly intended to be filled in by the boot loader, then
write that in a comment.

Other than that is looks good to me!

Yours,
Linus Walleij
