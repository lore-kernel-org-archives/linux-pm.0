Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5064582E8;
	Sun, 20 Sep 2026 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925996; cv=none; b=WDofC6J0FjqdujO1RFZ18OGozgN2yQbCwbvKZS33b31SmjWhtbeXQaHDQsI8BgqEbjYPMRUzskQ4ZdPi6znhjzCVzsMXorLA4hj/hwJbs8n3S6Ch+kQMRF/RRV1bYsSi1dkp0airjxawcZSgT7iYMdD5dtZJLX5D2Nz72vo6Fr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925996; c=relaxed/simple;
	bh=UuLrSrIlFQ9JehvKhIf/e7djgtsY/z46hmjOd1vl6CE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=FzG9pycZWwXMiycpPDrqXGQ2ZynPqc0V37BlzcBoqVi0mN1ekH0YNVUj6e5y4JL48Y/TUT0V1A3s29l6YS/eboxkfeJWtWeedvipFodF/AW2aA/SOZ1/mZpIqga5dKpfoiDwOAHsYhl/+/T+ycLsF66o85ux3vEos7G1HOlgrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+Hlmsqb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+Hlmsqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CAE1F0089B;
	Sun, 20 Sep 2026 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789925994;
	bh=r49z117kGKVvD9l7cQffPVPF1FdJw4+tF4s9KCbObss=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=O+HlmsqbwvQZ85iabVwfjHtbApvorpN93buCWdBQNCNaJ5D3EgIQbmIjnLMqzKgeE
	 9pGmsDgSrDKR+hO15ocOy45WsldMFBZCBVCPqz+nu73i+ObxxCPEtb9J1f0PQR789x
	 Np5r4BXh5r2iwr3p97aXfab+OBnrYHifPkEM+C376lq9nHoPKhEv4pc/thOjMsT+Ub
	 PODDuARJP57PMuP3kiLWDhOILWSjLjjO/Tc79KFMG1h8XuZnbzRV8k+Q7xaPfuq0kV
	 Ic+zVx2QEJDgbjyZ7rncozcoYprVW4BaUPWk3VGv2XfXMxpGoNIpv0Yl2CHMPtRw/U
	 nncbMf6/Gn/yg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 6/8] dt-bindings: iio: adc: renesas,rzg2l-adc:
 Document RZ/G3L ADC for TSU
From: Jonathan Cameron <jic23@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, linux-pm@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, 
 Biju Das <biju.das@bp.renesas.com>
In-Reply-To: <20260918150730.122056-7-biju.das.jz@bp.renesas.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
 <20260918150730.122056-7-biju.das.jz@bp.renesas.com>
Date: Sun, 20 Sep 2026 18:39:26 +0100
Message-Id: <178992596604.706584.10451227613547984363.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=789;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=UuLrSrIlFQ9JehvKhIf/e7djgtsY/z46hmjOd1vl6CE=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsBpoUK3bnfohIeRE/l9QuB627gyf68nHxI4+9
 OnK0CKtmXGJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarAaaBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiMs8D/4pPJrGB14Q+9HwJmYiKqgBUDky/vQsiSQd9UVBhswXowa
 X5Yz2bm9cHfQ0Kbxr6eCFcJhyTXE6G2zZhHHvd57Jl2VNMbq57FcSCOU5TpvMBMpPyVaH40J6+F
 EdbOns6u2su6hScaIUnAk7SVCcoLMEn5p4gNe/dqx7LpSMJii/Du1qrizGCEny3ipa5JlpMxdu/
 hqZu9moKrzS6Se7k9pX7uhOaLxIf/hIo899sOnPIb5j/K7vWBVZL1IKQWL9wFW6ZN/Y1kSHuF9C
 mR04/r2wYAJpd226NUeMbg/CXEVvJwJg43RyURulUv+jnku75vv56cUo2nNAW3fDpHBb9UvxKmr
 9Fy7cyI2P8BdSnecuwh66HmYJWR6J0nZ3b9KT1aM/4NxJ1/I/c/QtOl6qCuT5mTgRdth9XrgoaW
 NqORlRXctnn+t26Hn5T9xOFDHNLcmG4naMkvhvn+pryXZXKIPHfQ3GiFFgn2+KIu2f4CT4b7G08
 t866JuBtdXILR5J90nos3ll+mfLg3ly5udd7z7mCx1LUjy9ocbyBQhJdhOEGX6xN+KeuEY4Om5P
 TnbBU80KPOFnGvL5H+X55hYe479yxGhk9dnmBgtP3F3gFOJkotbU34k0JasIfd+FqWJCVucMTKc
 abiKMGtKDbpBFJTayUQKLPYRDd6Df3ACLaWtCmg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add renesas,r9a08g046-adc1 compatible string and its hardware
> parameters for the ADC1 IP on RZ/G3L, which is dedicated to
> the on-chip TSU (thermal sensor unit).
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 408fbf8c29cc..35eaebfbdd77 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -500,8 +500,17 @@ static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
>  	.adint_inten_mask = GENMASK(11, 0),
>  };
>  
> +static const struct rzg2l_adc_hw_params rzg3l_adc1_hw_params = {
> +	.num_channels = 9,

This maybe needs a comment that only channel 8 actually goes anywhere.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
