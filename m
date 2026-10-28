Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194091;
	b=ZBuvm4zTPGagXIE6Dox0g5FmIGDuTezAzl4Swwy5JIx/7JsWGMZfQxP35P/7Xw0vVoUv
	 XiPGZLMMY0qwlr+cDEIy8jtY/Ckfad4OL9k19BfHnOELGiEDpM3tekQ2oeYAli2BFq3fi
	 w4vq9JkgMPRxRWoJ7pnGF4q6l+4xun1PqtbKQffsZHX8FQ8p489dDJ+lfUUPhi02Ov2XU
	 Gk/9giimYaq+LNWfxF4VlmzB6P7X66V575Hbd7w9HBv013Khby6+BonyzDALhd3evXUXZ
	 GfPmORgd1P4GxVU1yfOC1La6Z7aJfPbwzvDcTg4RQ21kb5kKc+hDJAZjT/2WMJhR9WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194091;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dguWzmy1fO5cn8/7TwM3KTtc8nZLyA6X3w9/d84TI+Y=;
	b=XBdPXbbgLPanz4dSAPXj7/7iSNPyqv/weIgpG+kZ4yuqopt5rmTnQwcnFffRyJRXDnTm
	 aZ7upjgm5C+OCNP+31096+KyjzBsKlROhM4MplzzjbU/mWZ4dabgmu2Ndd5N4mfijgTcy
	 vP2udGkjFthxm7ljhgpQMs/JRqQag8VdoihvYcWU7FZA+5J8WwXwsulrndVleiM8j4FJt
	 mFItt3ef6jyoB244xdbWz+OWFkh4AMnGsKZVcdj1oIEPsLebtN6Qsh8fH9ppsHVcpCsHi
	 83KJozSIfeXQmyvKsrtqHiq6BSgBBy8Phl6GGVehBvP8XoU7ipP3QAPuM1pNQqj0BNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHORANrj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E437606A31A;
	Wed, 28 Oct 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHORANrj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354491F01825;
	Wed, 28 Oct 2026 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194090;
	bh=dguWzmy1fO5cn8/7TwM3KTtc8nZLyA6X3w9/d84TI+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mHORANrjbDbgzpk5akf0G4hAmrJFvXsLUUDs7fAxZlDnxCnDiFHdUNJm82eFJAHo1
	 Nw6Zu2aFCAwkk+0HkvREErBtwfypdH/QixmtcMTnCvgwH8BQrb/ZEdBxTcsa27GyyG
	 V8P7agLj2myIr2RlEeX51t+5a5v83n1ziPMCqYttLLYHUQRDJumAWOxepXcymILN+c
	 sbyU6hl6TGXWAMs5aJ/P5Q3KbaVaEHZF93B4Fr9NFzwlnk0xWOi8Ii16DoDVt02GWj
	 IdrfBsl8pVA6M0Vs08ES3cuoB3PgHPRNUippa/0gSuvXyiRvB9oX5pzhvx+xzFGPSQ
	 RBBUW5dsLKcYA==
Date: Wed, 28 Oct 2026 14:28:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	devicetree@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, 
	linux-arm-kernel@lists.infradead.org, Mariano Marciello <mmarciello@google.com>, 
	Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org, 
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>
Subject: Re: [PATCH 8/9] arm64: dts: google: Add Laguna CPM node
Message-ID: <20261028-handsome-chubby-toucanet-0e7cc0@quoll>
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.8.I4778aeffbdc796147efa8114431efcb201063b59@changeid>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026144346.8.I4778aeffbdc796147efa8114431efcb201063b59@changeid>

On Mon, Oct 26, 2026 at 02:43:46PM -0700, Brian Norris wrote:
> The Central Power Manager (CPM) is a co-processor on the Google Tensor
> SoCs, as used on Pixel phones. CPM supports power-management and a
> number of other features.
> 
> The Application Processor communicates with CPM over a pair of mailbox
> channels. CPM provides clock, power-domain, reset, and interrupt
> services, so we include the appropriate cell-definitions for those.
> 
> Because this also adds clock, reset, and power-domain support, we add
> them to the UART node at the same time.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  arch/arm64/boot/dts/google/lga.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/google/lga.dtsi b/arch/arm64/boot/dts/google/lga.dtsi
> index 6ceb9ea6a100..83b2361c5f00 100644
> --- a/arch/arm64/boot/dts/google/lga.dtsi
> +++ b/arch/arm64/boot/dts/google/lga.dtsi
> @@ -7,8 +7,13 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/clock/google,lga-cpm.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq-cpm-google.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/power/google,lga-cpm.h>
> +#include <dt-bindings/reset/google,lga-cpm-reset.h>
> +#include <dt-bindings/soc/google,lga-lpcm.h>
>  
>  / {
>  	#address-cells = <2>;
> @@ -356,6 +361,16 @@ abl@be000000 {
>  		};
>  	};
>  
> +	cpm: cpm {

Name should be rather: power-controller

Best regards,
Krzysztof

