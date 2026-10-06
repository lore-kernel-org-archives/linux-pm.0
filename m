Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0C49CF40;
	Tue,  6 Oct 2026 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310750; cv=none; b=Xcl2tzXEnbrTnordYsZHdG9Tq0qEBkKJnLB2nOPZXbKPtINzgInLxoKjCdLEBl7YqIDOOkOS+swnsw01Jox3988bVh+SVtIxkrcb0WMPAzGv60XSyikFmPujlusnGlnwgUOxHaRec3gtKXcZo9aTDNetHIq9r8fTtfgXPFmvr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310750; c=relaxed/simple;
	bh=x76PvVJzfUXADtn2/WiHhUwGRC79PKnl4XVrhi+LP4w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Rai7glIRmT0AJHkt6Kt3t3wUlSCjM+kOoHbgVkoQgmu0GOFviQmwLpjq0e4+xtXOOGCfWPu/D2v/Ua3HElHGKvFImSR50WAK0YrAl+FLCWGRZgTUrmLALEWRm+kTlibm0b98/VCpyoj6k2lb6uoju8sU2fd5oLcocb63+6emEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=UCNmTmEp; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=V3xtN956; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="UCNmTmEp";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="V3xtN956"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791310737; bh=CZCUObdnJ57eIky+7KGcAKV
	PQRaMYagrlpGzJWR6MYg=; b=UCNmTmEp0bba8Tf9ce6AkcBbruE9xvAZaBWzPsAzYk+me7GIek
	WzoEFy0l6RPGRyQow5kci4vd+IQEagXiYDx3RH/LZDsBaMNr3Zwydpwc7htqclxQqBqIWYI+jeT
	kbGr0fY5MA+Ewt4/HxslHFvIu+VYJqeN7xqRvA+UhtOrxZ/tqVnbr9jqA1B+5sNNepChEvIEbz8
	vbBwLce450cfkm6DEKcggWbew3ytMuxcKCHGXdNcLLERbKkOVoA9pIGpZF3QPLCOX3jBfWrY3Ca
	Rf0dLgClXmNpEK9M1QxjBqG/tsThDV4Ke1gKiDfrh0bu8y2Ydbl/XnXYZ5PbwY38fiQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791310737; bh=CZCUObdnJ57eIky+7KGcAKV
	PQRaMYagrlpGzJWR6MYg=; b=V3xtN956c1Hk0aHpnqOA0CRPdXdpTBC0Nau9wHAh5qknvK0sCi
	x+5fSIEmz72ssEH1gcN7xZ0Qv7DpQNzvuLCw==;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 20:18:57 +0200
From: =?UTF-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
 <barnabas.czeman@mainlining.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson
 <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3 4/7] remoteproc: qcom_q6v5_mss: Use mss as regulator
 for MSM8953
In-Reply-To: <7smt722arn43gwpfhbgagevi3ut6gdxalgfre3mzm4rb25fkkq@ftsucipakelm>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
 <20261002-sdm632-rpmpd-v3-4-95c47d0f26cf@mainlining.org>
 <7smt722arn43gwpfhbgagevi3ut6gdxalgfre3mzm4rb25fkkq@ftsucipakelm>
Message-ID: <f5af0cf39d3cf20b52e1d268ef418a88@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2026-10-05 09:06, Dmitry Baryshkov wrote:
> On Fri, Oct 02, 2026 at 12:38:32AM +0200, Barnabás Czémán wrote:
>> On MSM8953 MSS regulators is controlled using the voltages rather than
>> performance levels. Correct DT definition and model the MSS as a
>> regulator rather than a power domain
>> 
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 5 ++---
>>  drivers/remoteproc/qcom_q6v5_mss.c    | 9 ++++++++-
> 
> Two separate patches. Yes, one will be broken without another. Write
In the first revisions i was asked to squash it.
> this in the commit message and explain why you can't provide backwards
> compatibility. Don't forget Fixes tags (or explain the lack of them).
> But I think it applies to the rest of the series too.
> 
>>  2 files changed, 10 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi 
>> b/arch/arm64/boot/dts/qcom/msm8953.dtsi
>> index 753167c3f861..c7dc08858d54 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
>> @@ -1451,9 +1451,8 @@ mpss: remoteproc@4080000 {
>>  					  "handover", "stop-ack";
>> 
>>  			power-domains = <&rpmpd MSM8953_VDDCX>,
>> -					<&rpmpd MSM8953_VDDMX>,
>> -					<&rpmpd MSM8953_VDDMD>;
>> -			power-domain-names = "cx", "mx","mss";
>> +					<&rpmpd MSM8953_VDDMX>;
>> +			power-domain-names = "cx", "mx";
>> 
>>  			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
>>  				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c 
>> b/drivers/remoteproc/qcom_q6v5_mss.c
>> index 2f71ed2feff6..8f6312213e1a 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -2728,6 +2728,14 @@ static const struct rproc_hexagon_res 
>> msm8953_mss = {
>>  		},
>>  		{}
>>  	},
>> +	.active_supply = (struct qcom_mss_reg_res[]) {
>> +		{
>> +			.supply = "mss",
>> +			.uV = 1050000,
>> +			.uA = 100000,
>> +		},
>> +		{}
>> +	},
>>  	.proxy_clk_names = (char*[]){
>>  		"xo",
>>  		NULL
>> @@ -2741,7 +2749,6 @@ static const struct rproc_hexagon_res 
>> msm8953_mss = {
>>  	.proxy_pd_names = (char*[]) {
>>  		"cx",
>>  		"mx",
>> -		"mss",
>>  		NULL
>>  	},
>>  	.need_mem_protection = false,
>> 
>> --
>> 2.56.0
>> 
