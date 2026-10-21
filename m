Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604614;
	b=oXg9XW2C0Bwf3Jwl9sh0Kr8hqIupPQlPubnwbWbiKWu5VMbPiM/04pPewxk+Uza+IiKM
	 tEHULqeB0+og6vTjY+FbdpbBiUFkcIKD+IxvunsW+NVWNkIWCTmN0vpKnGNLL6iIGmShP
	 NHg2LjUIJCz4MKiFkCEWDwh5sAl2thKxBbiS2VMKlgoXG7qin5BTItVj7QOOeE34ZUx7Q
	 ataPSajKsCmSpFu2WGzM/cud7wvdp+9LhFjcbg7+qa1oiU3WEzPVTpsYwzIBebnSWWofs
	 OXfjpmp7sfLtS2+H8ZKbeTZzWM8VdKqRDCCtJbjgDPbZFwQI9nbdkO9CeapWOb2VhRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604614;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aSFKPdeTRbaa2HPhrRZ5lrX5j562cGmEBOpF2qSZv8s=;
	b=bHcS2wndRgi1z86TuW81vNYUIwfW6OzSptqUKKFg4RWpQdtJsh4TQwty5qR1Grrj8H0M
	 dY3uKAFqNFqqJHrAr4d/yIVdpU90cvP5m1lsOR4ZTIvRZgAMOkPZx8uc4Sc++9sTMgwKh
	 taLdtgl1JJcDZvWMWH2jZTO41UY98XOHYSHLqF11guG5blVCv0i2VFkjWY4gwIdDxYkJT
	 HPJ9NRSufEQCMiSn/3gOda+zgI0q+XqKl4MPvuUca/WwS53jLgbyBqcKih+moVDXjIn4E
	 Yt5yrJsB4va0q2AKcEAAxkzI3rkGK3RzgHmSSWUnbtIYhqkfCGiUd/K62bSDM7PvpIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=khjXYNgY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c6GMfbiv;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8B606A323
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DA8B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=khjXYNgY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c6GMfbiv
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LHXbZw1834205
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aSFKPdeTRbaa2HPhrRZ5lrX5
	j562cGmEBOpF2qSZv8s=; b=khjXYNgYOHV8sfchxq2tMxChs5gp1WBoK0+wGuuV
	vrubl1HA/2f6mHJ/1GdZHeEEjTsGufVlDRIDYhhf6TlrLzYusF8ifSqsd5wE+Abr
	ewlyso1tgsJDKqPW2E7FEgTk2y/7HKmg1Tee05FkYZZF0zI428AXaBt9BhhVnQBB
	+SkzeP/dfIevydKZatyDL1pMO+Z6mte5JRAGq/IMounxO/iRlt3FVUw6CQL2Cx7L
	+ytgjwP39PwH4lCvSKTFDxhxr8BoRdcE9AFyqm/twgU+8QAulUUk1HqYGaxlswlS
	F6CAV4HrHchMvniE8akFXyUO1X2up4jPjZHiz4C1abruhw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0v88bpq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:43:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ce7a85f04so202688085a.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792604612; x=1793209412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSFKPdeTRbaa2HPhrRZ5lrX5j562cGmEBOpF2qSZv8s=;
        b=c6GMfbivKwOJEbwQEqusmJnQuoyA0rceNTaP05tZGHPJT3rIu6D3mpjmSST34U4i9m
         /LondL6WspkPxJpIBlFkZGXPp1Rmv1G8uQGMlNEHVOWqhMoxcmkeVVf8MiTUs1nnk0h0
         yNubxFJEIBBlBfULXLJdD+pj0e/g5tqybsJXz+Y9jmjDQCNNaE2GAXvmJ6WwFFdVW1w8
         asJRHY8w6/UZkUqVixY2oyvQsyh2RssmfTxgIQneMJPI17tfPf1GO8HxnJOKhKtmWFe8
         6mJS8myuv+lwG0dIYjkUmk0e0vukFOOmJwYx+ZOXjzZWDdH+/sDzcdaCCPgP7iM9KfF2
         4FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604612; x=1793209412;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSFKPdeTRbaa2HPhrRZ5lrX5j562cGmEBOpF2qSZv8s=;
        b=UMwXtBTrAUJaQq5gS3KCj3dGwaVSyVnqxNHIX9eepCLyC8IG5lwpQ5wiMfnFhalhRI
         J9s+ggrvhpag4AxQyk6qSip3S099ceuK+R8xDz+64puIF6+3PX7HP0O6Xm4qBr1VDu7+
         /yS5Qqtfx+hoeGwkujXJxIfPRyVgQ9DP9c7fZS6+GC2dDQVPhUTfP3ZBvYIWVpYeuSQg
         Q/SDqeo/kLH1zZx84gRk+cN42tHujzhft8sTRCtBvQfW1ypb+x86emeJQ9/WGz8SONN/
         N4ZoYoTAstgVB8E4S9UytPO8XOb56FIDSAWmOtVoRSeWcxPxpwgWvRsHtrEmVjdsK89X
         w7Fw==
X-Forwarded-Encrypted: i=1; AKwUvBxoWOmaV9C0jV1T0kcvA+eMGL6tGpihHFlWmKZiGjI1bd0PFuaeAKRJNkkAEQWO2/ggt3llmXPMJA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKfNesX7CDWfqKTKCat6donANAfH0vg2OY+cgVo8xj8rcikM4Hg
	Cn10TsuIY4bfhO/s0Xksoz5mv0nuSHn6rNCDIkT2/sEPfIQ/Dyq7UX3t0x3+b04armMEkI7EQxq
	OtKSh9+4Bv7qc0betnGlL2AfNNvpxPFV4D4VKx6b/WDg37txUJ4vf4N59VvDw5A==
X-Gm-Gg: AYBFou3+SHi9kl5mjEs7Xd1hIG0y6Ab++VVETSjAqDv8/AJLpEuJk97uuJZrNUAqUNT
	az+3iYp0V30UjQmaaVv8hCjsGHtbPRmIUgW+SP6TX8B691jtyknz2+3cf3Q2sz27wguN0nff9m4
	jBfCtTd+kcPMwACDG5Ol+N6w2Yt2RsG8voP5h42gnY46K+eJrckVyNphYBZFfTBMIqNIJd/fxSg
	FPycQEA9NJuZSddJYvISx67TZbh48i3cs390Zz6rt4FV44/nKeax6lT0MQn+YomTVI023X6dOW8
	ne1HzBl7O+LL3lRQlV4cN+TaV59sli6+3IF1U5T0a2YT5gIYvWFhwgdAdVoPu3e5mjmW0of7q2L
	qypfCs3b2dHqGGXwp50FCJhWofsyrzKJCk/L6pZoQnJbhheJccugvHg==
X-Received: by 2002:a05:620a:4496:b0:93e:5861:34df with SMTP id af79cd13be357-93f57feafa5mr527031885a.47.1792604609970;
        Wed, 21 Oct 2026 10:43:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4496:b0:93e:5861:34df with SMTP id af79cd13be357-93f57feafa5mr527027985a.47.1792604609508;
        Wed, 21 Oct 2026 10:43:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfa12040ecsm640028e87.35.2026.10.21.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:43:28 -0700 (PDT)
Date: Wed, 21 Oct 2026 20:43:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] clk: qcom: clk-alpha-pll: Skip Zonda PLL
 configuration if already enabled
Message-ID: <tx64ni2u6paa7pofcylmlwytjjqsi23pbiqnhp7wywbbywla2f@3xaql533unhw>
References: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
 <20261007-ipq9650_apss_clk-v1-2-fd4c2b3cbdea@oss.qualcomm.com>
 <3faeade1-1bd2-4e74-95ae-7396a1ef1ce4@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3faeade1-1bd2-4e74-95ae-7396a1ef1ce4@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=C9Z8WgP+ c=1 sm=1 tr=0 ts=6ad8f9c4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=JR2_SSPbN-Trn9morxEA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX0aj4bHwMVDT/
 orh7NuQtObh0+rHJUEo+Z23TK+61yU1GyviNWgJwufyP82wYXlYqjRKK7wh9my0rEG7PbPioHl5
 b4XFDEJDuTMQpXXpuGktiZG1JMWBKVw=
X-Proofpoint-GUID: HJtOxzLZvAQe5h_fP1NVKy3GvLQmaU3q
X-Proofpoint-ORIG-GUID: HJtOxzLZvAQe5h_fP1NVKy3GvLQmaU3q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX7cgQ8pGaicE2
 ura+op9dbDr3swai8U99XCN8vpQyONGkZEfli8Vim0+JysF/Fk4tB+/Sr4dk1x5bipSL/mJkv52
 YYRKyrOlHTSwj2gjmHl7nNszH6KeJgDq6c+sbegkwTAvrBV/9CpO/2b4z1xwwsEhpd0M/P7Rtab
 x0PLoUdnr0QfJWfLLCt0sTVbBOYK2bpPTDodOXbTJ/7iwBdAncM7AtJuOyAfGF3oDxenwyP+nz/
 vTF3AH0kpXyhGh41j9voBwFAtUHixWsOHcdbDlck+t48D7LY4XsM1oEKL2PRINqvbXoroMXsd7X
 MHbzd60+o86Nno0/ge7LulG9a7rmuREZLhhpiClirKFZYarbH7oLMd8VWexdh3aRQCuAO8xyL+I
 ocFL/gJdH5F2beaQ3f2dXd0uSaXcmyu9pbAYh/4VY/DuLUpipsgiFu9wocF5hoTpj3i4Yyg2hQf
 EryRrAlHlplnBbqk9jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210070

On Fri, Oct 16, 2026 at 03:50:19PM +0200, Konrad Dybcio wrote:
> On 10/7/26 8:50 AM, Kathiravan Thirumoorthy wrote:
> > On IPQ9650, the bootloader configures and enables the APSS Zonda PLL
> > that provide the clocks for the A55 CPU cores and L3 interconnect. When
> > the APSS clock driver probes, it attempts to reconfigure the already
> > running PLLs. As part of the reconfiguration sequence, the PLL output is
> > disabled and the PLL is placed into standby before being re-enabled.
> > Since the CPUs are actively clocked from these PLLs, removing the clock
> > during this window causes the system to hang.
> > 
> > Avoid reconfiguring PLLs that are already enabled and return early,
> > similar to clk_trion_pll_configure().
> > 
> > Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> > ---
> >  drivers/clk/qcom/clk-alpha-pll.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> > index 60173b076cc5..3641b2da92cd 100644
> > --- a/drivers/clk/qcom/clk-alpha-pll.c
> > +++ b/drivers/clk/qcom/clk-alpha-pll.c
> > @@ -2162,6 +2162,10 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_5lpe_ops);
> >  void clk_zonda_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
> >  			     const struct alpha_pll_config *config)
> >  {
> > +	/* Check if PLL is already enabled */
> > +	if (trion_pll_is_enabled(pll, regmap))
> > +		return;
> 
> Please add a debug print to match the other similar calls
> 
> with that:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

With that in place:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
