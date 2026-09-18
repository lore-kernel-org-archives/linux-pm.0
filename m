Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CBA5172C5;
	Fri, 18 Sep 2026 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749686; cv=none; b=tkVhRGMY+meatIH7Th8AbmCfS/ndiwichPIz3pHKTEHMcoWzBR8+PSsYH5hgFUjcmnaneTPpNhegeWDtzz7qdtkOmPwb0n/R5AkaC/6BwzVdgRqyA8V/WUNx0WkBlkTHYyf1x0lAq68v7pKNmB1wmuXghuFCLIovr5Wn++8Vv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749686; c=relaxed/simple;
	bh=wHDE/ogxFqC0ePubpUai8RfXfh2NL6ahN/FENdluccE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=cgXXMbkpEns+SfZS+/semEf+dO2I/zBqLE4eqQ2cpkDfvIpQAfDlqv4+KXs86BoFHkZhOwPCPc2umML2cOAWzWc+HwtTRP6bz8dbmOiZ8cTIWovys9cBs4yHT6KIsu/+W8na8FRALmB+oCJEI8cF2ongugqna0YSa6N7Ho3XdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLLNwwwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLLNwwwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92771F000FF;
	Fri, 18 Sep 2026 16:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789749680;
	bh=LPArZUqqB353rHy4QKLaGuKuBspay5gmps9/H6dZ24E=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=lLLNwwwJiE5/2cU6UHhp/fjL3PKGf72K/YZ6rzfn/unLjMVnMa8IHZRfCnJsgR8j9
	 4kPw2kqclFT0xeZvvl+N1lhn+1qDk2xxcsKKDFNKHytEzGY4NK8Vfv1n2i2Kcjs1Sb
	 dmG5pNpsUGoo2xONeCiRLf9VAz1Miv7nwg9fCaJsumBL3AekoTnYZECJlegh/fzjvH
	 S7FUg/TvBwSVs6oCghNBU6NUn3dCU4iCHzWHUbGUw7xWmls4m0O/jdNBsUS6tWIXFy
	 vPQJjJEKgZiki1Vwkn5fYIs8l52aP6SgIpMyBjbI1dKusS4I6VDmY3PEEgJt1Up5OD
	 /5K2YW7WAHfnQ==
Date: Fri, 18 Sep 2026 11:41:18 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 devicetree@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, 
 linux-pm@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, 
 linux-clk@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Stephen Boyd <sboyd@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20260917-rockchip-dfi-cleanup-v1-2-4f00a97a69a6@collabora.com>
References: <20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com>
 <20260917-rockchip-dfi-cleanup-v1-2-4f00a97a69a6@collabora.com>
Message-Id: <178974864508.290014.10595821680814130371.robh@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: devfreq: event: rockchip,dfi: add
 clocks to rk3588


On Thu, 17 Sep 2026 15:49:14 +0200, Sebastian Reichel wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> RK3588's DFI has pclks for each channel. They just weren't noticed as
> missing until now because nothing ever gates them, and they're ungated
> by default on power-on.
> 
> The RK3399 clock situation needs no changes, as there the hardware
> really just has one monitoring unit for both channels.
> 
> Add these clocks to the binding, so that drivers for this device can
> properly know about their existence.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/devfreq/event/rockchip,dfi.yaml       | 84 ++++++++++++++++++----
>  1 file changed, 72 insertions(+), 12 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml: properties:clock-names: {'minItems': 1, 'maxItems': 4, 'items': [{'enum': ['pclk_ddr_mon', 'pclk_ddr_mon_ch0']}, {'const': 'pclk_ddr_mon_ch1'}, {'const': 'pclk_ddr_mon_ch2'}, {'const': 'pclk_ddr_mon_ch3'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260917-rockchip-dfi-cleanup-v1-2-4f00a97a69a6@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

