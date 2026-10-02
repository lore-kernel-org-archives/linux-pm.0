Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409D37FF5D;
	Fri,  2 Oct 2026 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949954; cv=none; b=JgSkjq8fI0ncbO130XFpdjsvjDlbGVgI+IOu7ohf0Dt5gU+DferiXZOb5Qj7vrFEvt/j2QZ1FVxuKnpdIhHkEAem0oxKIXfXjbIUQ8L6oVeokxwYtF6uCs+gdWxnpmp6XQHyqqBQTZ/4aUU4O14ptwIKxgVRq7td64faYfIhuZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949954; c=relaxed/simple;
	bh=2BzBL+9Fj6Etoj1AXjwY+hk1W1wBaTAR5PrzxGzcSuM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ikHIFUrt7QHgp2eXnNMrQ2GdawMI9qa+GxdFc8I8niBYin+QGMisD7ywZKbwkYNH5j9RiHd5bUWYvkcZJnXZU9r26afWC3PZZV0viC1Cw/lzbAgzPiEO4fVz2lKVlYo2FBtkHGumHA4eyfVq3L9St5i7TDkwfnbebdogsRKYLy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=eRyXiUx5; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=vn64j82P; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="eRyXiUx5";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="vn64j82P"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790949949; bh=mHL/BOVFSAOPaNiCLEkD1jf
	sVqevMgs0vzjPXTnQo+w=; b=eRyXiUx5MvdveHmdB9ixsYcdXnlaWIalblChZS0SAKqn5XGSSL
	BkvJbSCvI3pbj6yrOb9VZU+Y2y1U/CJdTX3CIg0knY9JIAo2jgzsekSJ9UQufcqiWG8CFMShX/6
	NNEK4RNIpP+ni/eqXgYFh7xl0X0hreGWy0ry9bA38a0NrPDehD4pv4a3I6gj5WFT3uzdyxomXJ1
	ZE+kBLsUlwaO2s/fAIscXmYugw+Uufg/MhmpIXMBF0MWOv7iOPMNJS6TfjVDNvyhIBBN1kth5Vj
	ap0a8DY0kinylNr3BLxj2LSUqJ6Qt6/B5J2lXPNzcFCQax/QtDtXZLLZ+gQZ3usb2hw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790949949; bh=mHL/BOVFSAOPaNiCLEkD1jf
	sVqevMgs0vzjPXTnQo+w=; b=vn64j82P2D1GAxA+u8TNGd2HX9J4yFDI63Jty2wvFn3aAtXfVp
	Xnn30KAa1heg942ppERR0JFYqK4DMyP1STBA==;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 16:05:49 +0200
From: =?UTF-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
 <barnabas.czeman@mainlining.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson
 <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: remoteproc: qcom,msm8916-mss-pil: Add
 SDM632
In-Reply-To: <20261002-speedy-alligator-of-courtesy-5da662@quoll>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
 <20261002-sdm632-rpmpd-v3-5-95c47d0f26cf@mainlining.org>
 <20261002-speedy-alligator-of-courtesy-5da662@quoll>
Message-ID: <3d4f5ec99761527771fb197d38774349@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2026-10-02 12:01, Krzysztof Kozlowski wrote:
> On Fri, Oct 02, 2026 at 12:38:33AM +0200, Barnabás Czémán wrote:
>> SDM632 MSS is very similar for MSM8953 mss the difference is
>> mss-supply is a pm domain on SDM632, previously SDM632 MSS
>> was represented by MSM8953 MSS. Correct the bindings to
>> described it correctly.
>> 
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>  .../devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml     | 9 
>> ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
>> index 4049157dd83d..049191cad5f8 100644
>> --- 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
>> +++ 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
>> @@ -27,6 +27,7 @@ properties:
>>            - qcom,msm8940-mss-pil
>>            - qcom,msm8953-mss-pil
>>            - qcom,msm8974-mss-pil
>> +          - qcom,sdm632-mss-pil
>> 
>>        - const: qcom,q6v5-pil
>>          description: Deprecated, prefer using qcom,msm8916-mss-pil
>> @@ -79,14 +80,14 @@ properties:
>>                       (not valid for qcom,msm8226-mss-pil, 
>> qcom,msm8926-mss-pil
>>                       and qcom,msm8974-mss-pil)
>>        - description: MSS proxy power domain (control handed over 
>> after startup)
>> -                     (only valid for qcom,msm8953-mss-pil)
>> +                     (only valid for qcom,sdm632-mss-pil)
>>      minItems: 1
>> 
>>    power-domain-names:
>>      items:
>>        - const: cx
>>        - const: mx # not valid for qcom,msm8226-mss-pil, 
>> qcom-msm8926-mss-pil and qcom,msm8974-mss-pil
>> -      - const: mss # only valid for qcom,msm8953-mss-pil
>> +      - const: mss # only valid for qcom,sdm632-mss-pil
> 
> So not valid for msm8953, but msm8953 has it, so you just introduced 
> new
> warnings, no?
It was never valid for MSM8953.
> 
> Anyway, changing existing device needs its own rationale and usually 
> own
> commit.
> 
> Best regards,
> Krzysztof
