Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F75A4A3D3D;
	Tue,  6 Oct 2026 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310888; cv=none; b=qsmR7X1Ce4J5YGGhthIWnzqEGzcmXhMilIjRIdXmBnevZqMLv9wcFi04/5yHKiP/FpcKsPuPrZ4UJbFfyxEritxpoVwEoKLbOBCR6sccgjRQJ1qmt+KTStDXSUW4RaBVt/96p+x+8sCGsT8dwRe4xu21ZBXxnlNMn1Y81oNAgsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310888; c=relaxed/simple;
	bh=yvEowojj7lTWt336vh/tC/kyz8qXTbPbPQ9eaqjKYWQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AREqOh3CCUz4NfXwpEH+Zzybk/tg8HK+FOXEPSRKRCa/hsQypZsJ4fHwBnJuN/iXC+lByWb9kwDmMNwVylqtU2W8GACYme97bIw6QRpGps3X7pvGZ1ThAHHjNVDKlrOi5E6ELfb65Uvd1NdKIL6da2Nt0L93q2uy6xGZoaCgq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=pF6YMycd; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=2BpKq7No; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="pF6YMycd";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="2BpKq7No"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791310875; bh=hsmk0xUQOeuU61kOIu34tRH
	SVUNEeNow5kkjB0uZ+9g=; b=pF6YMycdqjwNjEKoQ2HhTUkccc1ie0LzKTbc8VH1ENWUlajLTN
	eLNWV3QYSZ2ffFEEIpUeX8V7ZDDaduBJ4D4Ia8n2Mb0oY4t53asrd8+2qxf7PBOtEgfdfwks848
	K8s7TvXv88IYrmMUZaRvCid4EinhdkpIH5BRezL0ykl1F300tLsBbCsl/RMDw/Rz723Ly+lZR6K
	B6qhp53xsepukvp/iMnNyufHPMubDexkc6pA89jT/ioE1V0zM+z3kOej49C4lOjxpfxcpvDy2lZ
	3/qL02wrlon6i0xtoz9I9f4vJllfWer0w2rQwD4cDCuknRHWkZeyYxkBm97hdfmQDcA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791310875; bh=hsmk0xUQOeuU61kOIu34tRH
	SVUNEeNow5kkjB0uZ+9g=; b=2BpKq7Nox97rfTEWiyv6Gr2GUGWcJos/PFfvxRVuoP8vflWNNw
	JlENeUSVpEOU6GQweHpKoRsfCm3qWpjlrPBQ==;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 20:21:15 +0200
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
Subject: Re: [PATCH v3 3/7] pmdomain: qcom: rpmpd: Split SDM632 pm domains
 from MSM8953
In-Reply-To: <i4zm6zil2qyfdrclkxf6sifgup4phi6dlggspxrd7khlvbqv4e@yxotc3cslqss>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
 <20261002-sdm632-rpmpd-v3-3-95c47d0f26cf@mainlining.org>
 <i4zm6zil2qyfdrclkxf6sifgup4phi6dlggspxrd7khlvbqv4e@yxotc3cslqss>
Message-ID: <d514f6ad8c8d56dfb395f92ac100623b@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2026-10-05 09:04, Dmitry Baryshkov wrote:
> On Fri, Oct 02, 2026 at 12:38:31AM +0200, Barnabás Czémán wrote:
>> Remove modem related pm domains from MSM8953 rpmpd because MSM8953 MSS
>> is using mss-supply as regulator.
>> Split SDM632 rpmpd from MSM8953 because SDM632 MSS is using mss-supply
>> as pm domain.
>> 
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>  drivers/pmdomain/qcom/rpmpd.c | 29 ++++++++++++++++-------------
>>  1 file changed, 16 insertions(+), 13 deletions(-)
>> 
>> diff --git a/drivers/pmdomain/qcom/rpmpd.c 
>> b/drivers/pmdomain/qcom/rpmpd.c
>> index 5f55fc791131..c37a79d6bc43 100644
>> --- a/drivers/pmdomain/qcom/rpmpd.c
>> +++ b/drivers/pmdomain/qcom/rpmpd.c
>> @@ -503,19 +503,8 @@ static struct rpmpd md_s1a_corner_ao = {
>>  	.key = KEY_CORNER,
>>  };
>> 
>> -static struct rpmpd md_s1a_lvl_ao;
> 
> I'd rather see #define RPMPD_VDDMD_AO unless you have a good reason to
> drop it.
There is no AO defined here: 
https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.10.6.2.c26-01500-89xx.0/arch/arm64/boot/dts/qcom/msm8953-regulator.dtsi#L19
https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.10.6.2.c26-01500-89xx.0/arch/arm64/boot/dts/qcom/sdm439-regulator.dtsi#L19
> 
>>  static struct rpmpd md_s1a_lvl = {
>>  	.pd = { .name = "md", },
>> -	.peer = &md_s1a_lvl_ao,
>> -	.res_type = RPMPD_SMPA,
>> -	.res_id = 1,
>> -	.key = KEY_LEVEL,
>> -};
>> -
>> -static struct rpmpd md_s1a_lvl_ao = {
>> -	.pd = { .name = "md_ao", },
>> -	.peer = &md_s1a_lvl,
>> -	.active_only = true,
>>  	.res_type = RPMPD_SMPA,
>>  	.res_id = 1,
>>  	.key = KEY_LEVEL,
>> @@ -703,8 +692,6 @@ static const struct rpmpd_desc msm8917_desc = {
>>  };
>> 
>>  static struct rpmpd *msm8953_rpmpds[] = {
>> -	[MSM8953_VDDMD] =	&md_s1a_lvl,
>> -	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
>>  	[MSM8953_VDDCX] =	&cx_s2a_lvl,
>>  	[MSM8953_VDDCX_AO] =	&cx_s2a_lvl_ao,
>>  	[MSM8953_VDDCX_VFL] =	&cx_s2a_vfl,
>> @@ -844,6 +831,21 @@ static const struct rpmpd_desc qm215_desc = {
>>  	.max_state = RPM_SMD_LEVEL_TURBO,
>>  };
>> 
>> +static struct rpmpd *sdm632_rpmpds[] = {
>> +	[RPMPD_VDDMD] =		&md_s1a_lvl,
>> +	[RPMPD_VDDCX] =		&cx_s2a_lvl,
>> +	[RPMPD_VDDCX_AO] =	&cx_s2a_lvl_ao,
>> +	[RPMPD_VDDCX_VFL] =	&cx_s2a_vfl,
>> +	[RPMPD_VDDMX] =		&mx_s7a_lvl,
>> +	[RPMPD_VDDMX_AO] =	&mx_s7a_lvl_ao,
>> +};
>> +
>> +static const struct rpmpd_desc sdm632_desc = {
>> +	.rpmpds = sdm632_rpmpds,
>> +	.num_pds = ARRAY_SIZE(sdm632_rpmpds),
>> +	.max_state = RPM_SMD_LEVEL_TURBO,
>> +};
>> +
>>  static struct rpmpd *sdm660_rpmpds[] = {
>>  	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
>>  	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
>> @@ -954,6 +956,7 @@ static const struct of_device_id 
>> rpmpd_match_table[] = {
>>  	{ .compatible = "qcom,qcm2290-rpmpd", .data = &qcm2290_desc },
>>  	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
>>  	{ .compatible = "qcom,qm215-rpmpd", .data = &qm215_desc },
>> +	{ .compatible = "qcom,sdm632-rpmpd", .data = &sdm632_desc },
>>  	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
>>  	{ .compatible = "qcom,shikra-rpmpd", .data = &shikra_desc },
>>  	{ .compatible = "qcom,sm6115-rpmpd", .data = &sm6115_desc },
>> 
>> --
>> 2.56.0
>> 
