Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260248;
	b=jNobZxdoPl017qD3JoP68YevyZ12q403dq8AEDocPg8L+pV7N8dnIay/RqziDRBuBfTT
	 yxSo/7wOw7XneDYMsFWbgzxo4EjOvCtlwBS9Ty+j7OZoPSCI4hg8CsawJYrGjxTeK0Bxj
	 vLbKzaVMpOwrOLpdW4dCicPNNAjeNNWhH2G1g56DpGZg1xjhbWgUl65zbriBt+SxypLH6
	 rubIn0Gk0je5TNjGVmJUiv4FO4j4qAfZkSaa7jKVi5M+c6Ruvj/PdyLpbVeQWxFVMtkEO
	 jMdM369v5cxwXevleJi+G1GecM7RJG4c76JXK5sfrVH7hfM3A1i6GvQy6e29Anf/kwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260248;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NRjITIPkdmWIGWowLy1TC+g49D0fUwGLw1HxPYp7dRg=;
	b=fkSHR+e+9GQsTxrqj7WpQJsBpsXcX670gfFhpRhy9vOq9r5zVcwh/NLT6y+cULfuOjce
	 LHRS10v8OHaS+RMnmMCATLs/QDdcT+iMpuBkP7AJwVOcVTcHzTjCacVNu1BS21VhtQb1w
	 0gv3y/feP6d+8S5UqI0OZSdllgaCz2g8KL54iqWY4rOWXRgUEiSSQA750ReUPvfjM0mbE
	 K3aW/CkWZE55SGM6jXbPUaSwNrYrub3Xjm3DEwyNvZhkt79jSBWBKjR7QVNT3iuimsIY+
	 lu2UMUaaitGqfsUxqSmKq9rU4qqQZ4oCueglsbOSc5t7nxo/hlO5B2fPOVxBRJl9Aow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H9GB5CwF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Dq/YHesS";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4DE606A31F
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E4DE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H9GB5CwF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dq/YHesS
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T5H6At3282389
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NRjITIPkdmW
	IGWowLy1TC+g49D0fUwGLw1HxPYp7dRg=; b=H9GB5CwFLiO5T00Hz8eY6N8cqBf
	Zq+34UgfeztZ0VA5dItQCf+rQHeTHWp4qsFS7FsHIA1W/jF1/zKydiN+bhS8FEHw
	9wZ0ClUjLSKCVL+GCkPWz72HdTm0QR2lpn5xFlAkLAyX8szPqIwGXiEUuw+hkffM
	lR8JKMn2WfihnSjWhSbggLU/wVTK88GhfY3ovaLXwBETgVmyqyAgejiIGu8Jqm2O
	fQ2UAEFHVpQZ4eMMVbpS+Biw4F/HrBHnOZfMCzJ7fdqQzlmUQNZjPI6dReVW7Uar
	c3LUVr0pG8nmulbfCrc/VR4AZcavxUO970pMTxs8QKMCjmtMU1r96gZKrHg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgptgwp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:50:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-944138ed63fso107072585a.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793260237; x=1793865037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRjITIPkdmWIGWowLy1TC+g49D0fUwGLw1HxPYp7dRg=;
        b=Dq/YHesSlruM8oYYOdePIQ3WMvkiITNBWS5lRuDNeNWeKahCRRZDk77HfhE2qz5Zvc
         +EEYnH9gPOlRSASOcK2yh+4yuQxOmXmSXXWRKPh1RD4WSrApyXEDUgWPRJmk/m6kUqVE
         vQwIcaUt65MKuagLCfhuRD1tS7giY4rtAXeBLuzsh7SCucVehqXKNn9CMjRHpDDBRSsm
         kgbglsVbuMT/IDJh7eMazhIHBwCOigvlORjC/O1arU8FrmxyyhkLJurLNop7HKOfrvqJ
         UebP70DSVlvQ82XGkpyjiVPjy8qitbahkeLCyJayfpTrm22pyhC58b0uxfxrflQzzsiZ
         4x0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793260237; x=1793865037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NRjITIPkdmWIGWowLy1TC+g49D0fUwGLw1HxPYp7dRg=;
        b=epmwY0GJZCxIo3ECZbekJJMn1A5heDXyh28qcK+dQR/D8G0gMOFP+1dg2oMaKhnN60
         nJnZq1OGhPQCBeUsRzL6vAFRf1/3EcnRXFNDNpB1pbEZJPFkssEplTUoWdsvdsxiX7+5
         eUjLBsQpYaOXZU46C6UnqdVbsiM0by1zXHxRL7qZwLzogZZzLiRXVJR+V2Z7FKBhwIuB
         m0X3+c3MNmS7j2kHzvxeFsCBdROQAVtcudhq+F9tO4pa7afYTkukCezPqxz2pwSBtw85
         6I8YjyQp+9NJA04EbN8Je8eE/A3HzKeHYpuQBPFTk36KX+x/apQBmqw4sgYI9d6KUN7H
         N2hQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxrtjyNNOENl4kQC01hA3EjxLwoBmxSv/4K74IfRKszHOE99cl/lQ+JD+bx/6i99ECBDLI9z7GGw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLrO/huQX1ljGUwJr+kxnRv5Gx/6tOLGfBSWwEmf7HawSTDSjv7
	1e/OSvu7hR8vEwCKbb2pkCtH0RaLAif8ehpFo6mtn+1EWw8FSpumXGU8ZrwuZtuNVyW+Nr/CmkW
	WFBMjWX2y9sgMgXie+J3o3PgTgQUOTc66G1HXeG+sN0camqTWw4shDD9cqXeBiQ==
X-Gm-Gg: AYBFou2BcR27IcL1wrgrIEHo2n/Z+NUOz7FqeD0ZLoYgL3PuwYThSgapCmUvvHUmkuH
	c/koiCCj4+hcUhcZrLjN9Jm5UuWah4mw7gTzSf3zNbxT6uljTs4Ar9ewdSAQHZQlhd+f1rkc0lz
	4ca/Qi4ik4HVJyUXWlu87l/b2DfszQealgaSwPBTxuiZ53DSK2UqjI86NB7+WP89V0OYOZESAcn
	Art2EK6XmjhJLuapVT2sBGA0eZsCygGo8GTEMwnVAHBdzQVuvg/3U590eBUu0G7gw3WviJt9hX+
	tHANzAiJ6P2ITqT00SjBvoP8kc2ueqiMSAR5wLnASUs8DGrEdpCCDdzdsKRsi+y9JIAWI+8YE1H
	qoF22P390MQRb5cJ7AFxGuXDa+7uJs7PMnh5zyq802w8wfLj3866LZF0KyFxrmM6ddk7D+89auA
	==
X-Received: by 2002:a05:620a:17a9:b0:93e:94f2:ada9 with SMTP id af79cd13be357-94408cf77dbmr715123385a.58.1793260236700;
        Thu, 29 Oct 2026 00:50:36 -0700 (PDT)
X-Received: by 2002:a05:620a:17a9:b0:93e:94f2:ada9 with SMTP id af79cd13be357-94408cf77dbmr715122585a.58.1793260236287;
        Thu, 29 Oct 2026 00:50:36 -0700 (PDT)
Received: from lin-0772.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm31876763f8f.14.2026.10.29.00.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:50:35 -0700 (PDT)
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: atanas.filipov@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm8250: add camcc interconnect cells
Date: Thu, 29 Oct 2026 09:50:33 +0200
Message-Id: <20261029075033.3558229-1-atanas.filipov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6ivurpkaxe7rs5lxpbyahpst2bqzpkcb67whcymoopdgo6sjvq@xd2otcdpe6gg>
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com> <20261016170701.1504338-4-atanas.filipov@oss.qualcomm.com> <usade5zkrncpry4ufbdtaahoa2zyd5hx7tjgfvzfte2aqbkgs7@t3mej4maj6za> <3e5b7781-20ef-4e84-bb62-29a081c26d8f@oss.qualcomm.com> <x5x4av76vm3swozvwe46uq5vz2ys7bvo4bducpp7flnmhykg65@pvr3znxyktje> <a01d8d86-740e-4a25-96a4-d4dfd664af5e@oss.qualcomm.com> <20261028174523.3514860-1-atanas.filipov@oss.qualcomm.com> <6ivurpkaxe7rs5lxpbyahpst2bqzpkcb67whcymoopdgo6sjvq@xd2otcdpe6gg>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzMCBTYWx0ZWRfX5jJElJQWdUO3
 6PXdXkFh1gL4d/u4HF7v0bbg4CqUAou1RZd67dZ9ByG6ZwG7/K6hJbAaiA8l6aK9IuGYKdEIm2m
 xGeBLMxKWb3nCu99tWabvW3ChTNoJ2bd118mBLuDu4LoF/vn/LiZlnpRDNdBbb03q8eoXh70nmA
 lLRbRVHLZ6FDGNeyQtS8muNWEToyMxbZq+boS2PFJcjx2JHPqVc/TprRu74igsV7/kHZ5zQNElj
 yMugm5CdVMQK1hh4QUFItMVrmx+UHWhZeSuwrVz1jscWXeEL+Kf6JsPD70vSaJuhINH10tMaLgN
 O63WTydVSuiKCC1l/kiyF+XR/MjwA3vVl7HoJjjAjpDOHbZwrU1awtxJuRlxyonkgw3rWjMZeNE
 XNlbhNdxLhYr1Bfv27I/V9PPjsn0bsS4ZZCD4lpJuxkORo3uFwO3TSE5KadV7Hxau9Y5UFebnU2
 9oLWbdPxAMX7IiggFEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzMCBTYWx0ZWRfX32TiAdFuIt3w
 nlcWyJE3zGpe5xN3iHbfzRFrhSYaAptPc3z6IOmk1PA4H8jERkobwIuSri27eF7MyAmhOEF0JYs
 EcyJEnlG18EtY0zXrcsM/EtmsfY7Y/k=
X-Proofpoint-ORIG-GUID: 4B6Szu9Ac9e5YKxv0tp9b4LzvqFv5ff5
X-Proofpoint-GUID: 4B6Szu9Ac9e5YKxv0tp9b4LzvqFv5ff5
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae2facd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=tiiBXXJjtJp2WioFvjMA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290030

On 10/29/2026 3:41 AM, Dmitry Baryshkov wrote:
> On Wed, Oct 28, 2026 at 07:45:23PM +0200, Atanas Filipov wrote:
>> 			power-domains = <&camcc IFE_0_GDSC>,
>> 					<&rpmhpd RPMHPD_MMCX>;
>> 			power-domain-names = "ife", "mmcx";
>
> If IFE_0_GDSC is an (indirect) child of MMCX, this is an overkill. You
> should not need to cast votes on MMCX, IFE -> TITAN_TOP -> MMCX will
> work for you.

Agreed, IFE_0_GDSC is a subdomain of TITAN_TOP_GDSC, which is a
subdomain of MMCX. I will keep only the IFE GDSC in the VFE node.

>> Does this match what you had in mind?
>
> Yes

Thanks.

--
Best regards,
Atanas
