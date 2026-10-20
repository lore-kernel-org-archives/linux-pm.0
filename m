Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482064;
	b=ZaxNdA9IB+6c/ly23ihi6WyYXX0TFYVxcI41OQSbuo9YaGR3gQ9IeIRBJbnwgvpESd4L
	 OV21+qMA72UBdWsPktyHv0LuOChf6ithTCxFQMFP/lIIT7awOKTx3oSND7GOswKUFg2uY
	 k7fmnzzIni8MCIfG9idYjtkAkDTQNR3yNYlvnIClBwHKGhERPTorbrFKOUvEldkUPsKC9
	 a0M4Tfb37jqFBSXspG2AkFEgInr49/sH/njhejlFr3mrDF/jn77zT80RzX+/huSw++Auw
	 /QfuLUE+CH/rwSrxR6NcS09Say8CWTBRrlWGs17+BTavjDn3ykLKGuVz5yWwnbF3XTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482064;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WHyBOCxfyR08rNIzaaeSaXMBvmHX20z2ZAI9yVNfQCo=;
	b=m1au5IdkUYoWXhX1WDGlbBvkCs/8ZXqeDdMYWn1RZT4R2vkCpN22cIP6/nrg6mgYB2co
	 OZzlLKKL+Wi/MGUTHriM69f7dgaDFs9vL4ePWBvM67tCvZHBczRxToc9stV/131b4flp7
	 v0hTe2nwUW8RPT8nq+NAHzZpP5XjMFFRIU6bAvjenyVgLZ4Mf0Jo1hoe0K+mGNPz2E/Cv
	 fnCwRF3kL+9IKrlvj3yp4NV76nYO/vi4/VABhIaNdjwBRhZm7OuZV5AoVl0kQiqxn0TI3
	 u2xPyuJHPmCqrotBNIftMuRDx+RScIOwCD0Z0DOmkt1rj9BtiKE88pZEbZEle5XL2GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fLNiTKrn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BAJpXqTD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85759606A329
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85759606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fLNiTKrn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BAJpXqTD
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0tD3m2877763
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WHyBOCxfyR08rNIzaaeSaXMBvmHX20z2ZAI9yVNfQCo=; b=fLNiTKrnOBPyf1/E
	V2zDkk9bGOlg4SOcYxissGvnz8OBNDf87jH0opux+vHeArndM1oEDDxAaMeab8hw
	jI0RYFzm4JAqYhfvHASL1C7nkKCRw/0GcmSNBsIsd+qijrhP4cwvXd+xItb+SRU/
	SYxV1ud0ar4BkiOv0OhmQTxTsQO9NYF6DQ1lkeGojNfHf0PAeHX8Xa/lO2nHakDV
	R6aJ5Dt4nehkKO/gmbOc/PmkU5Rdegt7qzZZEczaLCSfhW3kUdtszdda13fiNsMW
	bLXtkNA9UeDGrTc3iFh2x2+5SStB0Kq2ZtH/C6urwn2dd5A7PLZp2PZiNDgiS/6t
	RGfUEg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5pse5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:41:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ce7a85f04so594163485a.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 00:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792482063; x=1793086863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHyBOCxfyR08rNIzaaeSaXMBvmHX20z2ZAI9yVNfQCo=;
        b=BAJpXqTDMdaOdil+3GEfoNO+K5s0MMzRZxjtoMmV3+SrQaYnWEKhlAvz1fRQN/yw+Y
         T8HVGtbgvmCJ5b3ZU7QmWo7Pzm5mtJAIyIEPEJN3WFL+fCkyT7Ctmd9XDNDtg1sd3iil
         fcnPQ1WSSIe//5Fmd+HGdp5in3qMgiJYe348XZkN4pFNKL/lmmxjNBLQbqUr9i85BLR7
         ZTpMb7U6Dn/kFbXfmYs7neaMWSh68h+zrHGykpye8Ym2BD3BC2ITDQYtLzzIgew0pWJQ
         Ud8N00wGTphzIcY5Q3r7yXtk/t+knUq2I578uY4JDQ88hGPCDIYPX032ZoC8lZcOQKwY
         LB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792482063; x=1793086863;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WHyBOCxfyR08rNIzaaeSaXMBvmHX20z2ZAI9yVNfQCo=;
        b=uOQFqqmTsRzN4xJIO/awz2li4RwDLdyWHT9GLcZQbGRPX5HXDH/iPlXBcuG47+uD+M
         WviTMERDRSHMEnaJgGOX0Ij8+kngmz5M58H+dGXrFqdVfm7WXz4H40GrgUTEAspxK30Y
         +7iVx826JcBVJ7FJx3wVhBTbIlCFpMyE21jFmPd9guffBkBuGPPb8x4C0ow2Pr/zKIl4
         aWhFPwCpQI5NhQmtWOJDlv9hAXHWKr6ccjja4YX96PTZrjntZzlYLvH4/bbjdSz3ZNdq
         YrYHOOVUrw5jhOiv7LNm/x7Guk9fBRW03M6nfHdUcAvjjAtcqJ9DgTSc8rHL6B7rUr69
         yWJA==
X-Forwarded-Encrypted: i=1; AKwUvBzjLfSUVc9EAWDOYgx4Wo9+XqR098idH/uDY4tLaELWljUui9omzQU4ohw/74YgzDFPtI2aRN1nWg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJridCkWCW9qOtYFDiZOHvoYzuZkARCVLYxQACnIVljXMsNwntA
	+SoqHu2ZmBbCFgRp0+fuSwCHU9ppioBZppOnQYEFElRUD9H3DWGNvYttYcQtTNUANkEnnSIXdOk
	223iyqsUtdF1MJoKhPdpI9RbgT8W6pB29tm11CLYPmnmKaXDTVA5k+YUonl700A==
X-Gm-Gg: AYBFou3sUdftWUvSluUpAyMb2u4/Yuoex/a6EAtGUr9RrpyyQGeMY5RkvnrBiGXNrC7
	9L9/j+vr0+Sq/DRPyYuvjcKvoyUwVGAOEO2+N2uLWuEa6bE0VW8GuC3vmEicc6J/gLlrWC3uptb
	S3pM8Wd7dheHegbZHk03eRfqESwDTnYrh1qw7U+8skRHqZKVKZTbLpI5XxXJ0YiR2baeau5ypcn
	h2gjYf7nlV3xFDxfrYFRczzijNbPKNAdl9uq99B8X2AgUi2JcSoPEY/C8qknfdF+lzz+Ly8jrPz
	iHCFYCgaCMQlWtbD+9N7yeQtJFq3gMOWehvh1B/DOeyZX7uw08ohU+2mPRQ3up6ml/z6WvNp27h
	+hAF0d1MbltzYi0HqKxxqs9ezAdZ1KG0WRIHR6JIA
X-Received: by 2002:a05:620a:6410:b0:93c:c538:2b23 with SMTP id af79cd13be357-93f29b7e6f0mr1606490785a.1.1792482062660;
        Tue, 20 Oct 2026 00:41:02 -0700 (PDT)
X-Received: by 2002:a05:620a:6410:b0:93c:c538:2b23 with SMTP id af79cd13be357-93f29b7e6f0mr1606487885a.1.1792482062245;
        Tue, 20 Oct 2026 00:41:02 -0700 (PDT)
Received: from [192.168.25.64] ([94.155.124.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f6631abfsm34100475e9.1.2026.10.20.00.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 00:41:01 -0700 (PDT)
Message-ID: <1eb062d9-6662-4b10-856c-6f5a3daa3962@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 10:40:59 +0300
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
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: qcom,camcc-sm8250: add
 interconnect provider
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Atanas Filipov <atanas.filipov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-2-atanas.filipov@oss.qualcomm.com>
 <20261020-bloodhound-of-remarkable-debate-11afe3@quoll>
Content-Language: en-US
From: "Gjorgji Rosikopulos (Consultant)"
 <gjorgji.rosikopulos@oss.qualcomm.com>
In-Reply-To: <20261020-bloodhound-of-remarkable-debate-11afe3@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DrrDa2/+ c=1 sm=1 tr=0 ts=6ad71b0f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=eGCDHFSXubCXFTSSGhjuOA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=YZ1k_EG-GQ4t5jaSdRAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX/i5kQaTujh9L
 5p6IiWl3KTKLqUqnYrGN+44unGn517drjMtnX04tokalpuFDs9OonL1Axm9wAjR3UH79wL4ttO1
 uOI92BVgT/6IoY/xDyXhF6SJvMTFkSPdlyOoJ5AmuAPcx0IEGBKVNnOo2OSDRVdrRb7N6EEGh2m
 38xFW0NNOt8kAzLTqByLp0uD6OdADXXf+WER7LU2+etMSFX0Qg2cqdeL6krrcCORYZ9HAqB63bv
 WvfjBI231r5TYmWB72xxKASUmBlXsR+cpxs26yDIFc9Bg6bDShp+PZUiME3Kp9TE96IOAh/ZeZj
 hJmg3vKUM78TB1fEEhRHsKaOQFgfvN6NbT+orVtcDAPUsO582+9ZdxnA3wx65729WVSmDwKlva7
 oGH/j1cAvm/0BLKwkITIIR6Uo4Qe15IYascrbHxdmq9RoZ9BroHWzzSIoAm3wrdyB29/ey3aHSp
 0JUSKMlBcNU0iFWBp2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX1DULnUEQKJHs
 V009y521VDs7VN9dJyCQPehsgDGL1y5g3wpEWgYQ303AvRDf+bGYOFowd1pc62DEC9g5dNAo/Cq
 NC5UbzAe3vbGxBz5/mStVIG16FLiHfo=
X-Proofpoint-GUID: 0FhhaBcfDCYuZB600yIcBQJ6havE_HM1
X-Proofpoint-ORIG-GUID: 0FhhaBcfDCYuZB600yIcBQJ6havE_HM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200030

Hi Krzysztof,

On 10/20/2026 10:12 AM, Krzysztof Kozlowski wrote:
> On Fri, Oct 16, 2026 at 08:06:59PM +0300, Atanas Filipov wrote:
>> CAM_CC_CAMNOC_AXI_CLK is shared by several camera blocks. Setting its
> 
> Clock is not an interconnect, although AXI suggests this could be
> something with bus, but it seems you solve driver problem with
> interconnect description.
> 
> If you only need to solve "last writer" problem, why not fixing the
> clock framework to accept the votes? Otherwise this should have
> description why it is an interconnect.

There are two approaches which we have looked in to resolving the sharing of the AXI clock.

1. The drivers newer touch this clock but vote on new icc camera which controls this clock (The v1 and v2) patches.

2. Use icc-clk in the extension in clock framework same approach as: 
https://lore.kernel.org/all/20240430064214.2030013-6-quic_varada@quicinc.com/
This is already merged and i believe resolved similar issue. 

3. Which you are proposing to have clock framework to accept the votes.

Before we jump and implement the v4 it will be really good to have common agreement on which direction to go.

Regards,
~Gjorgji
