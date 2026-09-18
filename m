Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B44AA414
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743051; cv=none; b=fHckOumW0rOtVgMbja+gPxkylBnDCFWWAzYMgT/57ruDrB958QA/S7ZgQPSkaIL0f+ccIUKQbEbea7S5548+qU8ReKyKOh2jMW+ORMpn+ibiQD0vTSibUjAiXKc6vUL+XKgar4AYBgcHo5/cScBY8PgGs2rvgJXhUFxr2BxsLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743051; c=relaxed/simple;
	bh=3g32ZEKgqgdm0mzzfeeD6m0KdEMdwsvPWO8RE57p70U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BKTO1wXefQHPIx4B+FVCL23N0iEFaxmxnm0DFsKJxU9y8xhbXlBKulaYuoQFsRIQ31074Sc80tV/nUz8rubeKgFjN3khP3cttEnqzMFTxnM8kG/GaHzB6oh7o54kOqFvCyDcUY7OYu+rnDNa/J0JIvQJap/TiE2ef8SyWnr+bMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=A7uI7+nT; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="A7uI7+nT"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591bb18so543370a12.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789743041; x=1790347841; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r59C/B+bGqeFr3iprC+rozYulFppGtTTZNSFZMONdm8=;
        b=A7uI7+nT5gTJYtUZNUuYVj0NK/8INYXpvT+dj48RmCsB57fE/H/rXc36w5gh5/p22S
         p+U7aE1ARtIxOHE+TjLcNDwh9HRz30R1WDJV8m4SEgj6xvuSnN+Zet7n1YCLuo6/lLJE
         odhfsumAtx6xlZH1ZVm7ZJw14YK1AeITvdumui3LFC/QDAlGy4jsev4AD2mQKpO4fAzm
         BpJYHF1aqFycfttDoX64FQqtf8nSH6Gqcw0HS2/5NrS5HZ3YFH463J8BM1SqmddbbH3o
         BAtPLeUI1sjVn/3vr8PZISNMnL1EV713XZl2bCoMfttdl7jMlD2T9VTjl8BsYBTwPBUm
         S9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743041; x=1790347841;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r59C/B+bGqeFr3iprC+rozYulFppGtTTZNSFZMONdm8=;
        b=NBdt9Chblq1Ub7HXRsVzMxzu6tflL6WW/8LPHQhi7kboEmwU9U4d+oFjvwKlCRUiQj
         UgCDTSuzOLvauJqKvBUi2/TMu+GcOupE/5O9FzERveb839clbLiOaj6syAYX1/4MoK84
         WPt50XTK19/u8Qo7TEkW6rMYpEO2vzzE9/2ukGFuRMeBMJmummRRenKHfIiZWoJx2gck
         8bUH3aVKgIvkWytTbrxtYNg+/d6Zo/FC3uSSywf7MNADtnS5GKlkSfFBvjDiKPxNnQ6N
         49TDSJgHVXKwE2MJaLBUm+ur3XP2n6J/UBKjA2Wd6s2+tD4i7t5hOCatoR4a3lDxb8ab
         jqjg==
X-Forwarded-Encrypted: i=1; AKwUvBx/2KRmWY1O0gG2/SpOA/M2B+Vvf+Mjaeacjt5OUTZvy1RqRpVkqLq0QOmvh2CF2dLBu52Ngh5l9g==@vger.kernel.org
X-Gm-Message-State: AFuF++nb2SXM4f5edpH3kr6St5Szc2iD3gDAo60YoOiOyb7e0dHy5L6C
	P5QDBgDqvOFQ0j5R9/JFK9Nka5Iun1idO/S5TfycFT9KSyFhY5PYnDLOpgy+fxpK2DU=
X-Gm-Gg: AYBFou1UR2kEU86+GEVjdBJPIIOQO48j7T6sbyZihfLavAyUE6cBy3cKYxeas9/HH+x
	XDJWJStgxx74Quq/rC37VmwYS8idkpjmLkyDF53ixz+4hihaGnCG4lqQwsExMF8cP5NqEOD2PLX
	1R49dOraersTe+GFAScG54anh7C7k4XwaLfSEWVtTIGVmcnjK9UrOU1t4y+1Cxzly799p8NiqVO
	hIBMTn/BEUiPqrsH+8mJRU/9gQxzjYU1NQO4dPwvQfHebaNOxCXIuInQKRwhc87c3tNVDtSnkKs
	/RHe8nDQcnuZkCFnAMNgSlnRe2ldEoSwGoUTzFAXZ4N36uKOyIUqapaJBSuJpAVVSgK1P9Vrvkt
	P9V06i/kED0J8UZNWgECZUGfpOimHXt984OaWcKORDnOZcI/MzfIK9MWeuUnY0O6XRC1HWOANl3
	VX/AIvCxVuMK3+o/WMV2j/rsjQ0OnSO/YWqm2Wm+1GmNi4OM7ePtBfgf5dgym2vIL0x4DlcdR8w
	CXPNgF5jmSFLxu0hZOqcJyV0/Kv9vwl0sC3CT6NBvF3REILTk0ijg==
X-Received: by 2002:a17:907:d503:b0:c25:f7db:4bec with SMTP id a640c23a62f3a-c2a16597a38mr269720566b.18.1789743040987;
        Fri, 18 Sep 2026 07:50:40 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bb46f0csm66329766b.32.2026.09.18.07.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 07:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 16:50:40 +0200
Message-Id: <DLIIYI1PL2MG.1UYJFILKBWBEJ@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: OSM L3: Document
 Milos OSM L3 compatible
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Georgi Djakov"
 <djakov@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Sibi Sankar"
 <sibi.sankar@oss.qualcomm.com>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Alexander Koskovich"
 <akoskovich@pm.me>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20260717-milos-cpu-opp-v2-0-428813fafd52@fairphone.com>
 <20260717-milos-cpu-opp-v2-1-428813fafd52@fairphone.com>
In-Reply-To: <20260717-milos-cpu-opp-v2-1-428813fafd52@fairphone.com>

Hi Georgi,

On Fri Jul 17, 2026 at 3:33 PM CEST, Luca Weiss wrote:
> Document the OSM L3 found in the Qualcomm Milos SoC.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Could you please pick up this patch? Thanks a lot!

Regards
Luca

> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.y=
aml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index 41b9f758bf8b..17690ff34489 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -29,6 +29,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,eliza-epss-l3
> +              - qcom,milos-epss-l3
>                - qcom,sa8775p-epss-l3
>                - qcom,sc7280-epss-l3
>                - qcom,sc8280xp-epss-l3


