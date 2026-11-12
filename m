Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481032;
	b=hZY+H0pwNiG/c8mQzWr69zXMChn3widNzrWG1SVii927Hfisnv6nBY8ZIQKEtiICQhPQ
	 J0iC0FdRWEDej+nLN3XtrdPX70F0pNAE3UtlAWtc2NZ2ojJKAtsKJY3eA7Jn3e7LtR+UO
	 fA7aYJjReQWnXbUC96XcS3EJz8uMiR/XI1O0C1b5xk5zOD5U9lbUGTv3IDTo6tIkAtR23
	 6IL30tESlaECELW2OIJNyVYTS4LLAT7wsx68HIjyXnoXVFEu0QL3dakadJYlTgyvb5A/X
	 sLjOyd+2l8NrlKpQyasHo+L5m4zwhG8K+49yf6SlVyw5NmiLoA0Ex/HQugqeigbMFZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481032;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CaAlmqccaq1A08RrxIHF9ttWnYDk4b0C2sEgkxs45mk=;
	b=tl4iFf1kBXjvWR0I4IerNhKGBYbaksXOtWroGsp0BoUw0J/Y15/3zrtW8kkLQ/Ls1UGc
	 2vhFJRnIDg/97jnpG2p+tvngo3jqvmAJ1SHqJ2RrTFrPsuJUW2PVpkF/R6H3nbhjX/MwQ
	 pb85ggNjJOK5uyDD1ak7GLQfXTHnN054B9yOXkgbRN3YwF6yMgZkPDR+8aE1heoX3e2TK
	 5/qBmCDUKgtuQMFNWbmc7Pcia6XZVuWuSI0ohYiQWq0scnf8r7f31XO1RvECINI1fZd3r
	 T/efcGDNy4//PCeBTHeC7gsv4V8a2eArCTGHOCCV4anqMX8aaUW1d7H/H/OwzLn/yOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrBnMRkg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E7606A31C;
	Thu, 12 Nov 2026 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrBnMRkg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A98A1F00A06;
	Thu, 12 Nov 2026 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481031;
	bh=CaAlmqccaq1A08RrxIHF9ttWnYDk4b0C2sEgkxs45mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KrBnMRkgr+lw9sIuVkgMOvSYBLAvEUefXnyijCRf7+tQyW0bguz6XLIpkdyqGjnaf
	 y2rzXO0GPX+NnOIXGUUW2zrp6DTG6fjDIBOyc6aFPAY4UJtN3j6cz/TUguqfD18bDI
	 sMkrBH/eRYZAR6T2MI7rOa7Mh/NlK/JiIDVmFTe9DiJRvRwz81BZH0hnJgIwxormtf
	 8RB2gzEaQE2NKzSElZMY48v1qJ26emDJWdpNxxCpRrBPXDw/+aSwpxo+dTfEtKVPWM
	 XFwwxOrrYXUIX07w8xL+k+Pw/C5YDpG26usPgnoRM2MpvIkeWFvysJ8IB3f7d9zPlR
	 ZcZVu0Nx7mz0w==
Date: Thu, 12 Nov 2026 11:57:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luo Jie <jie.luo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Richard Cochran <richardcochran@gmail.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	netdev@vger.kernel.org, quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com, 
	quic_leiwei@quicinc.com
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: qcom: Add NSS clock
 controller for IPQ5210 SoC
Message-ID: <20261112-wild-accurate-cockatrice-a80efa@quoll>
References: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
 <20261111-qcom_ipq5210_nsscc-v2-1-7e2c1dda3ed2@oss.qualcomm.com>
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
In-Reply-To: <20261111-qcom_ipq5210_nsscc-v2-1-7e2c1dda3ed2@oss.qualcomm.com>

On Wed, Nov 11, 2026 at 02:00:55AM -0800, Luo Jie wrote:
> NSS clock controller provides the clocks and resets to the networking
> blocks such as PPE (Packet Process Engine), UNIPHY (PCS) and EPHY on
> IPQ5210 devices.
> 
> Add support for the compatible string "qcom,ipq5210-nsscc" based on the
> existing IPQ9574/IPQ5424 NSS clock controller Device Tree binding. IPQ5210
> additionally exposes a pair of EPHY-RAW Rx/Tx clock sources used to derive
> the clocks for its integrated 2.5G Ethernet PHY, so extend the clocks and
> clock-names lists with "ephy_rx" and "ephy_tx".
> 
> Also add master/slave ids for IPQ5210 networking interfaces, which are used
> by the nsscc-ipq5210 driver for providing interconnect services using the
> icc-clk framework.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
> ---
>  .../bindings/clock/qcom,ipq9574-nsscc.yaml         |  47 ++++++++-
>  include/dt-bindings/clock/qcom,ipq5210-nsscc.h     | 106 +++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,ipq5210.h    |  18 ++++
>  include/dt-bindings/reset/qcom,ipq5210-nsscc.h     |  60 ++++++++++++
>  4 files changed, 228 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> index a35bbc7b1924..dc7d90a99dc7 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> @@ -4,24 +4,28 @@
>  $id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574 and IPQ5424
> +title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ SoCs
>  
>  maintainers:
>    - Bjorn Andersson <andersson@kernel.org>
> +  - Luo Jie <jie.luo@oss.qualcomm.com>
>  
>  description: |
>    Qualcomm networking sub system clock control module provides the clocks,
> -  resets on IPQ9574 and IPQ5424
> +  resets on IPQ9574, IPQ5424 and IPQ5210
>  
>    See also:
> +    include/dt-bindings/clock/qcom,ipq5210-nsscc.h
>      include/dt-bindings/clock/qcom,ipq5424-nsscc.h
>      include/dt-bindings/clock/qcom,ipq9574-nsscc.h
> +    include/dt-bindings/reset/qcom,ipq5210-nsscc.h
>      include/dt-bindings/reset/qcom,ipq5424-nsscc.h
>      include/dt-bindings/reset/qcom,ipq9574-nsscc.h
>  
>  properties:
>    compatible:
>      enum:
> +      - qcom,ipq5210-nsscc
>        - qcom,ipq5424-nsscc
>        - qcom,ipq9574-nsscc
>  
> @@ -42,6 +46,9 @@ properties:
>        - description: Uniphy2 NSS Rx clock source
>        - description: Uniphy2 NSS Tx clock source
>        - description: GCC NSSCC clock source
> +      - description: CMN_PLL EPHY-RAW Rx clock source
> +      - description: CMN_PLL EPHY-RAW Tx clock source
> +    minItems: 11

Please place minItems at the beginning, before "items:".

>  
>    '#interconnect-cells':
>      const: 1
> @@ -63,6 +70,9 @@ properties:
>        - const: uniphy2_rx
>        - const: uniphy2_tx
>        - const: bus
> +      - const: ephy_rx
> +      - const: ephy_tx
> +    minItems: 11

Same here

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

