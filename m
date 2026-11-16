Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831303;
	b=JAQDQ5rorvDGmieClOi3yeMWwFO+YNtTia7JyAgrv9Pl6atmxJYjgy7rw7Go8S3fCb1d
	 Ti5DnriPDTCWyIigXWGcQTJdptkQq844/T2oWxXHBqXP0KIv8u+SBquNus+gri2o7zqnG
	 4K1ID+ZcYtUaRjmp7BhICLxi5wK4yE361DF05hwknpD5I8VrEYPZS2DSYxOEyMNfvIfxK
	 9jMX4vWXrNeOqQD4naDvG4bJ9UAP2YwVlC0gjGzFJ5cD0foAob4m6mVIFf4M5dhKjZL0b
	 v+O1Mwo0DhTnQ4nvsILt/EWjYKV3s/eXyLD9afyxoJJHgf9XGVci5Sgd5jl2bBz/fng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831303;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=p0OKzksFkMy4s+l/0Lf5EK/s0OAUHxiIj6XZiD2cZBw=;
	b=T3bnTLqNxyWIgBKYaICvRn2l2k8YdtzFlx4jNOeUV8DRib/BzLBL7hNKkgGtzlalix3T
	 Ep+nnyuBl25etbe5G5Oo9zXUBdPiVqQctOGnwB+Y7Xy5zoYct7ThaLFM/ro4qlh8pkPJj
	 UfHnOR7k6NvMkfoDPLAVeNXpThbvIeXjnar9/V3hzDgA607qJJsps3Ub2l5xPCQNFHF4/
	 63jZlq1yUqhv8KhNaA3xS5+NRlvNv0jPsg9foJhciR9FeewrbXkXJ1az2wRRNjB5Co+3n
	 6jQzgNygP4Rx9f7MCw7QcHULVmMlA4IGi2lUTWUKjqE16DIAhbtErOuS8aDSNL96QoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcTD0VCT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A4606A32C;
	Mon, 16 Nov 2026 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcTD0VCT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A141F000C6;
	Mon, 16 Nov 2026 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794831303;
	bh=p0OKzksFkMy4s+l/0Lf5EK/s0OAUHxiIj6XZiD2cZBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VcTD0VCThQIzd4aIf36tVET88367f7K5m94QAhwtBRVCNL0ZOljOaSLs58Qw4/Uh0
	 iQ4tstAoMQggG23lGLC6GiX+qZofYzFrSp+dfXrZ/DF/avw8/1tGa75nQ7EV26Np8T
	 urSBmB4GQb4gDprK86/fjB5m/xjFfZQQXizaMCajNcdewOFrH4z/S/f4XnPDFCRCNk
	 vPb3Q7Fdlgoi4JSSaszWl1bOIlV9GfMaC1JMo1cx/RZ4tWvmey96/d6deZjomV8Lnj
	 c3kurvoSqPCM8d7X0AsfKaydu10Rf/HU0jBeQ/m8LaHQI7n43+tV0fB2+BfHiOmTEH
	 mm2ZJAL5z3jvQ==
Message-ID: <640b5d23-6007-4e6d-b374-52b079186751@kernel.org>
Date: Mon, 16 Nov 2026 14:14:51 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: clock: qcom: Add NSS clock controller
 for IPQ5210 SoC
To: Luo Jie <jie.luo@oss.qualcomm.com>, Bjorn Andersson
 <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org, quic_kkumarcs@quicinc.com,
 quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20261116-qcom_ipq5210_nsscc-v3-0-1eaf92698379@oss.qualcomm.com>
 <20261116-qcom_ipq5210_nsscc-v3-2-1eaf92698379@oss.qualcomm.com>
From: Georgi Djakov <djakov@kernel.org>
Content-Language: en-US
In-Reply-To: <20261116-qcom_ipq5210_nsscc-v3-2-1eaf92698379@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/26 12:19 PM, Luo Jie wrote:
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
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
> ---
>   .../bindings/clock/qcom,ipq9574-nsscc.yaml         |  47 ++++++++-
>   include/dt-bindings/clock/qcom,ipq5210-nsscc.h     | 106 +++++++++++++++++++++
>   include/dt-bindings/interconnect/qcom,ipq5210.h    |  18 ++++

Acked-by: Georgi Djakov <djakov@kernel.org>
