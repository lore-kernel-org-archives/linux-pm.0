Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6B33688B;
	Mon,  8 Jun 2026 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913284; cv=none; b=KwtBRYrWUXmCB1pK1/RZCUZnNyGxugQtIAEXzLkTVsA5YTeIxvMO59CBZuDqstE/fRGXDEwrBudEYqpzYzbmWAbX0suwVs8QOFdtt5wW8+AO5SnziiuG6gPiuyddnt8Uc1wxNOoWDtG++OlKb5VdtC/CyDu6vmIt5t/cHhOyeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913284; c=relaxed/simple;
	bh=0WAZOkwh1M04H1c0YVum0mSxyq9dqMkuIAOwausNF/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNgAjq8ea2dkcZaLc8bQthPhDQaQuzgHLAIeAJ7e3NxIoRew8pv17lvd+0LzKWw0JqjHwXyn6F3nFNvTi74SpJRQsV063wTNT0gk1UlwQgzzyEhT+54X3s7StlZJqBx082G9zAtVypJgi7sL3cOWH+ZX6RnWJnT30va4G3RX/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXnT4uaM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXnT4uaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460841F00893;
	Mon,  8 Jun 2026 10:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780913283;
	bh=rVBSLeID+xxuzIUnmbvTiFn8KX8C7lbOTIFzb+QeLGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RXnT4uaMgFi6ipFBh3wPhIQCNm8yuExJotY0hKUy1F1DDlMPMHGnIKu3sikVOkftg
	 hSxpDXEtTZ8OF4azNz8+ojGEWQVT65DLx+6xm0RrQ2BKOMd58VfKpvlKQhZgCLTnf0
	 IiP530duViStlyQ/ci2R7GS7jqMdiZBh5CokrTw4ZIfn4LUnjqRKG5RXoxYZIKuBs/
	 e7G0LzScAGWxqg1aqcc3gG+tid+/qKbbI5DSEdzuvCQDKnKGdC3X3Lv1yu42sehbwi
	 ZnW88gPg9XvbBu1OLN3CXjk0WEs/7XjAuzP1mu57SK8IajnyIuM5uqLZ8AehFZWwFz
	 O7EXf4UNIg6yQ==
Date: Mon, 8 Jun 2026 12:07:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Stephen Boyd <sboyd@kernel.org>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Ajit Pandey <ajit.pandey@oss.qualcomm.com>, 
	Imran Shaik <imran.shaik@oss.qualcomm.com>, Taniya Das <taniya.das@oss.qualcomm.com>, 
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: Add Qualcomm MBG thermal
 monitor support
Message-ID: <20260608-sweet-powerful-ibis-8b2adb@quoll>
References: <20260601-spmi-mbg-driver-v1-0-b4892b55a17f@oss.qualcomm.com>
 <20260601-spmi-mbg-driver-v1-1-b4892b55a17f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260601-spmi-mbg-driver-v1-1-b4892b55a17f@oss.qualcomm.com>

On Mon, Jun 01, 2026 at 04:31:18PM +0530, Sachin Gupta wrote:
> From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> 
> Add bindings for the Qualcomm MBG (Master Bandgap) temperature alarm peripheral

Feels unwrapped.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597


> found on the PM8775 PMIC. Unlike the existing SPMI temp alarm peripheral,
> the MBG peripheral supports both hot and cold threshold monitoring across
> two programmable levels (LVL1 and LVL2), with interrupt status reported via
> a fault status register over SPMI.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> Co-developed-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
> Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  4 ++
>  .../bindings/thermal/qcom-spmi-mbg-tm.yaml         | 72 ++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index 644c42b5e2e5..5f409fe700b2 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -193,6 +193,10 @@ patternProperties:
>      type: object
>      $ref: /schemas/thermal/qcom,spmi-temp-alarm.yaml#
>  
> +  "^temperature-sensor@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/thermal/qcom-spmi-mbg-tm.yaml#
> +
>    "^typec@[0-9a-f]+$":
>      type: object
>      $ref: /schemas/usb/qcom,pmic-typec.yaml#
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
> new file mode 100644
> index 000000000000..a0ecc9f35cf6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml

Filename must match compatible.

> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qcom-spmi-mbg-tm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm's SPMI PMIC MBG Thermal Monitoring

Best regards,
Krzysztof

