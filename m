Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E4566C58
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999099; cv=none; b=hmISRxkG+y/n9i10WD6vist4RFsJmJymjUpTKT1jtdpy4YCHdLdynuz/AAXsaACrQ007JK8uW++G1dCYZXmuORnR0SafZ3FYvkXF2Chg2u3+HlK13tBTyfVybPbaXW6HABfvlE82Uat6tUR0Jv55Ze/HcKZ3RX5HoBqbiSAPzMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999099; c=relaxed/simple;
	bh=121EF6tgvtQmCI553ZeF6I+UbkvEWY/a0feXoJuQ+5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1fBpew777xqnq6FwQSzlNHSRb5Sl/83kcZzqePuXUHIRvwzLc31uoIj5O29OzGUTQweLmeV2jK8k0FBs0sOA2PjNzDtKv2kqhBPDAzJ94WKBAulnWMRcRjGw96evauuSj0RC2qMrfQNoU/GwAakcS+vG4V8HLYsOK5762JoiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ARxqgK2z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gYYzCE8n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ARxqgK2z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gYYzCE8n"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEbJFB3642816
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 17:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lkj6WmLM94TLi7LkJSNtIzaP
	frHo6K3hQ/enHwG6gPU=; b=ARxqgK2zwJNKzaI+JAXUrYvIyxi3iBuILGUfZu5o
	adNmbIs8cWR5bF1mcjdLC0X2gN9qfEbH5rtrGqt/iiKhw8PLlCev2O7dmQfnMqtW
	pgEsyddaZngCo70WOSYUMQNnAaZ583vLR46QT1445VfJPw9lY4T7uiejGi1miA8E
	w2d08GyguICu3r0vPDwOT11FmEp0dlWkJNcqXBdU/5DC57wcZWisTRkKL+fk3vQY
	mfDam/3cu1JN0F2NWJ7PsquCMfR51cnlosF3wy72BN6NsSGBrZaHHdY9GRs5W8F5
	7qbtWK6e9GOeVJn9BoOdgtVz9Y19ujsO4RSKLLg3NxuYLg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470ar8e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 17:31:23 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91b994cb09fso13407316d6.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791999083; x=1792603883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lkj6WmLM94TLi7LkJSNtIzaPfrHo6K3hQ/enHwG6gPU=;
        b=gYYzCE8nAazUmgO668F6jwWgghVWX5J3kT9opv1/prfq6uVx7Fjs+CXjHBTmV6/D3K
         TvDC/PbtpL4ugo41EmmswzmX+WHNxLzY8zuU027oNhD1YUDPBDs60hdLkZGtKobLj410
         bOYEvEtBxsiWwLA7F03W4bXi2pU8oDdwcgaTrpu8tV3a5AhhZjg+V7hQ3aBGqS1GuqJ/
         wGOVbRcWnEe16vsPRFVzZhZ04ooaXkwr/W+rGBahVVY9Wml8EVgWEAPQhQ5EtLHACctv
         wsSbxrVinUvFLEwvfwVuyi3xweTZWdbzW1lTsEO7aBO0MMyWXbRLfasL9vOITz1oYVYg
         8ATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999083; x=1792603883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lkj6WmLM94TLi7LkJSNtIzaPfrHo6K3hQ/enHwG6gPU=;
        b=oUkvhgBKv5/U0LvSRivkaF3YqT5b4UrtqYoV+JbTThfwE206b9b00Wewi7PJ4KfgyK
         QUnQye4sUrW3uwStznKY6R9qiYgRXL/syN2vmHpCVQXv3lpO5zInaVD3uDg0IeojTmgw
         h1NFPMdVjSyMX6osDWQ9N7JeUoNoPqaR5kG5BWB7rhz+8zmqUOCXLw9fhQtFnccFx6e2
         KBctmWL+rbPlZvKiD8DCYg1+4SHT4wYxHRWI/xveWfPuMI3oN6O+hTn0odssIBRELxMn
         syWUP+3J9J8TSM3OYwwN2DAQjMB4XIjG5xxFLp4WaCIaCQjtKDTXqLAqHXUdfsXDyyff
         ydgQ==
X-Forwarded-Encrypted: i=1; AKwUvBymTrclOAG/nqqtau7fWXaoeq3DjVTBNH7cm5ZW0MY4mxbppMmew/10TzJ22dyazgzFFe4LCzwSUw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLSqaTRR2BdvTCNurdH+giit/+XUMEqVkh1aCYdvmpUEF6W4TDk
	T9SYTKncXWLVVpha+lTaqSdwJn1BVI0CmZB/9kLK0R7yaqZ55JQe5W1JmfDzTYlDIyoxHSBy7C1
	kt82VKr69TSgJarAL8gKc0+x0Od/8R9AmIp33/pQcAltI1F3ZuGjkI6OiD3eImA==
X-Gm-Gg: AYBFou0HOF7ObiLZOx26FRxHslH8v+7aZ/fuRScJjaIHKbMMr89ulkCH2wHvVKiE47F
	rYT7ctdKegCCIb6ZXXhp7OFPhHnAMsfWm3RoywY24VzQ08uYLrOJ5m4RRNam4U2w0RxUXZwWd+3
	B9NpYY61m1KgdFrNg/uFlZM8n32X09dwzOPc8E4gbdjgk44fxoHU1PdOzanvt1MlSSShG0IYJOq
	3HX2dO91n2kzWqjZZghw5WM9Zgf6cslEmTV6D3pSMWN9RqbYyp5DaACPYJP15FN4Vm6/IDW7WPi
	2oEaUIapcvWqKnACnu2fcTtDpi2sdDD+ztZvDLUaFHjjQw+IS/E7GIPaGYR/0schsHjweIEnC5P
	lLNLPetoEi/yTMYIrQ7UKXnXbY9RjtyVeBP88ZhBRKk7x45MZEH4DkoUk6OvVwnEMV6e3Mzlxid
	1YgkHacVumSqXO
X-Received: by 2002:a05:620a:1a1a:b0:93a:1b82:4962 with SMTP id af79cd13be357-93ebd22932dmr2719649785a.47.1791999082159;
        Wed, 14 Oct 2026 10:31:22 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1a:b0:93a:1b82:4962 with SMTP id af79cd13be357-93ebd22932dmr2719640685a.47.1791999081425;
        Wed, 14 Oct 2026 10:31:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be33d93de0sm789552e87.67.2026.10.14.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:31:19 -0700 (PDT)
Date: Wed, 14 Oct 2026 20:31:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 07/16] clk: qcom: Add clock-owned GenPD DVFS
 aggregation
Message-ID: <ussxpger36nwnvuqv4nmtogxkrn4krogw254qbtusdf7y2ofn4@pswnav4mz6lm>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
 <20261014-topic-qc_clk_dvfs-v1-7-3041b788e9f7@oss.qualcomm.com>
 <ygwhik5t6w74xcqz4igmb6t5esmjjgrmtwqqqmo4doj34t7rpu@jkngx4v76rxg>
 <6c9937a6-88c3-4e5f-85a3-73d929d3ba01@oss.qualcomm.com>
 <dbyuabhh3phhe3uq2kvhcnuem7qb2a6j5yvhl6ylizqikt2rlk@vyvrcj3lewtp>
 <dad15717-4439-41b7-8552-0176c9cd1505@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dad15717-4439-41b7-8552-0176c9cd1505@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2OSBTYWx0ZWRfX0qaPklsKtMYq
 1xvBwPzhI3SNqbrp9XDW7uf/Fkg8S5MH0GWNgfbZDdh/R6mRc1Otg7KmgLHrwDKbEOtA8DDbi8U
 mv0bMex08Y9XKKluuNiV1u7+WVOWQUPpTfAsbZxISF0rkWGNvf3RHWx/23kyykkE9ZRo7UK5Hqx
 kYU0UlLU2jxVd39ZlZgzOQvDsvBEZKJXgf9NDs01NKpGJ0IeLpn4D0INHWAeC3sCZraYtwMtmKO
 xRm+7gRocn8AJ8/WhkeCb0BAAsRIxU0cGruSQVvM5kHWBuUFwfj6wnH4ol2ENFWLqhSF/A+nkbW
 y02Obx9xw99xIQVXd5uHlt5ck99wVajbOblwBY0HuZ9aowU0MuvLwAezKT2XUAM9Z/tKheUV0O6
 ulH+EuHF5IH6MA9cizKK0M1+5Fe8rahkohwoqDdmQhPONE2pd4T60MARVFDfdkISOdTzGtJNRlb
 spP7v3gaOJIht98VTLA==
X-Proofpoint-GUID: BG6_--lqobrKOWCKfVQkntkHuCENU0NL
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfbc6b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=qblbxwZfGeKRjrM4MhMA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: BG6_--lqobrKOWCKfVQkntkHuCENU0NL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2OSBTYWx0ZWRfX0BOzvRuyW49L
 K950h4Xtb1wWuyidAF3SY3zfftQat35HmdVxtvDncmcO8CM2XyRmWdaEB8Tm37RSGp5AGebHpd4
 PplXsVlMXTWcnezjX9VXUK6jDlkQerI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140069

On Wed, Oct 14, 2026 at 06:45:46PM +0200, Konrad Dybcio wrote:
> On 10/14/26 6:30 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 14, 2026 at 05:26:00PM +0200, Konrad Dybcio wrote:
> >> On 10/14/26 4:36 PM, Dmitry Baryshkov wrote:
> >>> On Wed, Oct 14, 2026 at 02:19:07PM +0200, Konrad Dybcio wrote:
> >>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>>
> >>>> Clocks on Qualcomm SoCs need a minimum power rail performance state to
> >>>> operate at a given frequency. We currently leave this to clock
> >>>> consumers, so a driver has to know which power domains supply both the
> >>>> clock and its parents. This ties knowledge of the clock tree to
> >>>> individual consumers and doesn't protect other users that prepare or
> >>>> change the same clock without making those power requests.
> >>>
> >>> Why would they prepare or change the same clock without making power
> >>> requests? If it's a legitimate user of the clock, it should have an OPP
> >>> table. If it's not, it should have a separate API to set the clock via a
> >>> legitimate user / aggregator.
> >>
> >> That's the entire problem that motivated this series. The consumer
> >> doesn't know what it needs on Qualcomm platforms. The power
> >> requirements are that of the clock controller's, not of that device's.
> > 
> > I'd still say that the consumers know that they need a certain
> > frequency, which demands a certain voltage / power / etc.
> 
> Right, but the meaningful difference here is that the consumers
> only know they need a certain frequency. The required power votes
> from that don't stem from the consumer's requirements. They stem
> from the clock controller's inner workings that are necessary to
> fulfill the consumer's demand.

Doesn't Iris core also have "we need this power to work on this
frequency" kind of requirements? My assumption has always been that
those are just folded into the clock requrements.

> 
> [...]
> 
> >> The Qualcomm case is easy - RPMH is *always* reachable, so the
> >> pmdomain provider needs no clocks itself. For the other cases,
> >> "patches welcome".
> > 
> > Ok. There is a promise that I2C PMICs will never ever be involved in the
> > clock / power tables.
> 
> Or at least that someone who needs them will contribute a
> solution to this problem.

I meant actual I2C PMICs, like PM8008.

> 
> > 
> >>
> >> [...]
> >>
> >>>> +static unsigned int
> >>>> +qcom_clk_dvfs_aggregate(struct qcom_clk_dvfs_rail_voter *rail_voter)
> >>>> +{
> >>>> +	struct qcom_clk_dvfs_vote *vote;
> >>>> +	unsigned int level = 0;
> >>>> +
> >>>> +	list_for_each_entry(vote, &rail_voter->votes, node)
> >>>> +		level = max(level, vote->level);
> >>>> +
> >>>> +	return max(level, rail_voter->safety_floor_level);
> >>>
> >>> I guess you want to avoid having too many voters, but would it be
> >>> possible to have one voter per 'signficant' clock and let GenPD itself
> >>> aggregate all the votes?
> >>
> >> What does "significant" mean here?
> > 
> > I'd define it as "using a different power domain or requiring a
> > different corner".
> 
> I still don't get it

When the consumer votes for a frequency A / domain BX / level cc, usually
the parent clock (at the corresponding frquency nA) also has domain BX
and level cc. Sometimes (like in the case of PLLs) it's not the case.
The domain might change or the level might change. In those cases that
clock must have an explicit voting (I'd still prefer OPP).

-- 
With best wishes
Dmitry
