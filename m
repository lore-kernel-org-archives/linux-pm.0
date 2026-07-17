Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D063AC0ED;
	Fri, 17 Jul 2026 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275668; cv=none; b=uovMVd8caEpXH1CdpBHPzNQjkbTGYX9Ja3kURkJzp9qPGEzaDd1AdjUyoe1TQM6jIYZegVOo90ogK7TbhXzMVfGZP9wmulL+AKrp0n+X9bGJkuHFONcQ6odrH4olEpRlKu+Ui6TPYKMBQ/8U6oLPN18AuaDc73Y3/kMQAGrOKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275668; c=relaxed/simple;
	bh=VZL7Dfked0w2UNCJXV1biw66keezEniSdfHE/FNmBoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJtg9Y9ayO8Bn/pYL9uhN9jW9p7dlvnt84MSL2fjnVMJ5+2PmG2Af+cBdnQuvU9icU3zwh1xh7O/+B73P+TkYzLt+Kk1T6HDvS3ATR8JwI8LFqMuugdiPGn7SVIVQrz5xTdLt1J7+Mo4wLPkqyQyWEEhv69yHRNqqhMtpFMx5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4eP2GQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4eP2GQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD471F000E9;
	Fri, 17 Jul 2026 08:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784275667;
	bh=Sx70MohSQI5OynyQy2bJT7hUudD6UKCIjL2zOELkr2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V4eP2GQ424QXG8DsrGa+QfSculVk9t6+kC9JuclpV+X9VGf3PzNm9R+fyPTZ8LJzO
	 LqxvITYf97PSGsyN6o8S6POvpbxoVVT3zG4i/hRLi7hD4w8AsST+qyjd164XSQT27g
	 Uk3hItdMpM1AIe97BLN0+jrPEV4ciR+UM5SmKmaE1IM3Tv4my7Y7Shtuc/2APhR5HA
	 zU5D5oyvt10g1nMA6zxJIEPZic4+iU/MDnUtd8ysUjJXOWm1u4tISZ0vmch8lIdsYQ
	 lxQPcxCo2dIRqIF0d+7SMQHNGiwLCUJvBr+zPmbh+iQyJzdLvNLpHwrp7OApPlNMJE
	 1hHWImuCp055w==
Date: Fri, 17 Jul 2026 09:07:41 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] dt-bindings: power: renesas,r8a78000-mdlc: Add
 firmware property
Message-ID: <20260717-pragmatic-alpaca-of-spirit-ae497e@sudeepholla>
References: <cover.1783505329.git.geert+renesas@glider.be>
 <b4d16ddb0c0af56f4103feadb3014e71899edec1.1783505329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d16ddb0c0af56f4103feadb3014e71899edec1.1783505329.git.geert+renesas@glider.be>

On Wed, Jul 08, 2026 at 12:16:24PM +0200, Geert Uytterhoeven wrote:
> Add a firmware property, for systems where SCMI must be used instead of
> direct hardware access.
> 

Please add more info to explain why you think this is reasonable
approach. Until then ...

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Spin off from "dt-bindings: power: Document Renesas R-Car X5H Module
>     Controller".
> ---
>  .../devicetree/bindings/power/renesas,r8a78000-mdlc.yaml   | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
> index 1dba1e1b1c5b52d0..9616f0244415896c 100644
> --- a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
> +++ b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
> @@ -43,6 +43,12 @@ properties:
>        and thus identical to the second power domain specifier cell.
>      const: 1
>  
> +  firmware:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Reference to the SCMI firmware device node on systems where SCMI must be
> +      used instead of direct hardware access.
> +

NACK

-- 
Regards,
Sudeep
