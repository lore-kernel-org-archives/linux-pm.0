Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE937A83D;
	Tue, 13 Oct 2026 06:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874041; cv=none; b=hMKrzpVFqUUiK9mRXYKunjbG48t4C6WbT9B760D/mkE7Js6nQT0ygyyoO0jWFT1goctq/lrLoFoQLzVta+h49jgZbaXmGFud2nEDR0gZ7plGxcROURGoZ9pIubhf547KsV6uYjgT7Qmi4/scQB1BlhbDJf2hBxcFqFuwKFttbG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874041; c=relaxed/simple;
	bh=z/0RGM361wfCXCOt+CPmz0u/LJ99vEiwt6H6yWglVI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVBmGqdRf0hWbZS+DBYpPlnb7NXyfLFjxbBFNf1lgQvk/W/urBprWjMaGytY97sda3iSKCjHYjNXBmz4rDI5kBtwJyK+XF/Mq+XziLnrRs34CGUVUBYjCTsLsE2uXi4x6sGEOGnXVApeTcc5N/77sWBjdOENY3YnBn2Y4k9dKIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsx6fm1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsx6fm1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCCB1F000FF;
	Tue, 13 Oct 2026 06:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874039;
	bh=YgubnauHoRzWWNqrJG9hHcLGUmIImOLCkWtfx/PDZCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bsx6fm1PRkMz7Y4e5P/667vo9dTLauDRCPCS5rQUNclF8LwLkVfzYzVW4bZNWhaFO
	 ZCxZV1KZbsIzL0QebMXP19qkvDEpPmQiKLTyGvdCoQExlbTkTNmbraGO0sLhLaKRyG
	 Ljeb6BykUdbwxf1/7CoIqgPqtVSpymkSAv9vbQ59kzP3/JC8OST1a5m37MMwj870VR
	 JEGBFgEWHqmthxpvCnc28O7kkKqbRF3EFn+Dbig50eAoSpMgB6MbAEj6MH+wat0Hfl
	 5uJIHe28MUr+O1BjsMacr/Mllpno5OPw5m6HNACQxGCpFkIcrgtNDcoxrtc5f2g/q/
	 9xB93UYoqxphg==
Date: Tue, 13 Oct 2026 08:47:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: clock: ipq9650-apss-clk: Add IPQ9650
 apss clock controller
Message-ID: <20261013-quantum-keen-mongrel-c3736c@quoll>
References: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
 <20261007-ipq9650_apss_clk-v1-3-fd4c2b3cbdea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261007-ipq9650_apss_clk-v1-3-fd4c2b3cbdea@oss.qualcomm.com>

On Wed, Oct 07, 2026 at 12:20:46PM +0530, Kathiravan Thirumoorthy wrote:
> The APSS clock controller on IPQ9650 provides the CPU and L3 clocks and
> has a register space separate from the GCC. The four Cortex-A55 cores,
> the Cortex-A78 core and the L3 are each clocked by their own Zonda PLL,
> selected through a glitch-free mux whose parents are XO, GPLL0 and the
> corresponding PLL. The L3 needs to be scaled along with the CPUs, so the
> controller is also an interconnect provider.
> 
> Add the binding, the clock indices for the Cortex-A78 (gold) cluster to
> the shared APSS header, and the interconnect IDs for the CPU and L3
> nodes.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  .../bindings/clock/qcom,ipq9650-apss-clk.yaml      | 58 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,apss-ipq.h          |  5 ++
>  include/dt-bindings/interconnect/qcom,ipq9650.h    |  4 ++
>  3 files changed, 67 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9650-apss-clk.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9650-apss-clk.yaml
> new file mode 100644
> index 000000000000..6b47183edd56
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9650-apss-clk.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,ipq9650-apss-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm APSS IPQ9650 Clock Controller
> +
> +maintainers:
> +  - Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> +
> +description:
> +  The APSS clock controller provides the CPU and L3 clocks on IPQ9650 and
> +  has a register space separate from the GCC. The four Cortex-A55 cores,
> +  the Cortex-A78 core and the L3 are each clocked by their own Zonda PLL.
> +  Each clock is selected through a glitch-free mux (GFM) whose parents are
> +  XO, GPLL0 and the corresponding PLL.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq9650-apss-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Reference to the XO clock.
> +      - description: Reference to the GPLL0 clock.

Why do you need a new file? Looks exactly the same as existing
ipq5424-apss-clk.


Best regards,
Krzysztof

