Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575D40711E
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041296; cv=none; b=At1Yo7mwkSvTNmN97l/kMF5jlQVT7+GWJprBT0he028kOl5YHfNwVxUvvWfm83ygi6NJnRbTSlb5L4DpRsi5KWZ6qFzw9mONtg31vn7hfanZgOIG6uq7/eiXcd770R3pM0Alh7pzZLXOT4BuRkCS0oWpk4f9bNFQlduM4BXhQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041296; c=relaxed/simple;
	bh=Fa60T1J9NdG0M8J8bhvHiHZIs+TFsgPClwjQYrHu5nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8CLpGMUN60OI8kNArRZNCH3Y/hU9nJcjfA013rnntEDpZ3Sxt4DWf09EMS6KjdefL2O7OCDVoeXjkor5RnRi+PlrfBP21SMNs3/EU2OhHOUxjPawsWNP6ZouEEYrszGr+o7pnyZK8YTP69XC4yw+ycNAOH7iGQvHEdG/AKBgRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YmHJDtXC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zx2l5k1n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YmHJDtXC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zx2l5k1n"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6316fFed3103832
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 11:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Um9bWYbqbpemNVrExQ12MkVwZ+nPwCvsKWs7TNNv7x4=; b=YmHJDtXCinnPJ2gU
	A6y3Ab8rzxFvUbMoxOyNnpMuzCvBi2K12IXUQvKdZ/uRtmfRJlDThZabVWBqgKwS
	rx1g90D+TB9X8acBauwZJkxmnXZev/o9T2cd/D68HunUsq+6xE+ZUhiNc2Mdig25
	wXiUlJvGHTKwqd29H1OVn2Df6GnzaYuCwbqB+GhXXJD4tFc2y5epaTNky3w90Xkk
	pGfKWPed+lwJNExv5KqbpoXFc+sFysTrH4WSyJUVWJlRFwwDvOebar89AzRIg6R4
	FxR2Pu+5ZRX/S0JJAPJqmiayrnWa0HmUGntdnLmtQahVV/odLFNmt7GhWv18PDi8
	NVp2sA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8js23yqy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 11:01:30 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56aa6d6bb5bso5761740e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775041289; x=1775646089; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Um9bWYbqbpemNVrExQ12MkVwZ+nPwCvsKWs7TNNv7x4=;
        b=Zx2l5k1n/lhGwiPgnMrytyHht4C16Me1D9q/+LMu/xtMuuVlHHyafpKNhPLuemdXuA
         RNTTn2JZPPTz9ZBlkZWT9rEp9n5hwTjxBotIG5RugnrFsbs9IyV00NQ/Y3nNi8spY4/c
         UbQSQWI/EKIl1qfsNXmK5prd/KupfWEJFDiQpCbFQie/wS9Zqdfm/tNP8XnTmiaoQOcR
         xdm3ITSLFSES/SpaalgJNqPGshwAG0ea7GbFi7LWBtDgxhhWNaP5+dgSAcotQM3V6t0S
         t7ziD+M8LWhTFxR1kzLUTIibyHXUMUNvu40z+fGyAedbIdVSxv+n+tNnC9hYqbQghVNa
         27ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775041289; x=1775646089;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Um9bWYbqbpemNVrExQ12MkVwZ+nPwCvsKWs7TNNv7x4=;
        b=j0Ztnl2ilBytNM2GCGBBAdjpX5D0XePg1FcdEvMBU23UZITsSpQVy6tHue7jNGP5fL
         olOwktjOUbMwW0DHMMQ3AWjL1D18p6nL5Xcy3MdeA6Jl1ymQMVxMhH7WjHVEn8LPlnyI
         kYuEOU6hj4PyCVJ+MSb+NFb3QI9BnrWfv8hjnaouhwWj6Wf5uNCIU3fZKdRy8DynbPH+
         5RDCW8yw/DfXGvbmtVDbIJcywQw6rnP7T5GbkB/oZI1CGF11G7UIPXR/CIs4eEOXUVee
         E17m5PJ+HTaI3SIbHw4aV+GWSLSqt5F3prtyu/mGxgRc4PuZe0QHSCo3s3Ad+U2aggeZ
         B4HA==
X-Forwarded-Encrypted: i=1; AJvYcCUhc9a4Zsvcc5BlIk5g9q1xJz4ccaclUCwvxgUmJtixVVx1D3/eqgPZ7Fz2xOpaY9c7+HwE69xDSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFeNbtETFEls3gTwCxGY3pg9MVNE0d/O0ddzJrtOLYwpwTEvG
	5HVQ99owXGxyAYKzNtY+0R1yTPdnPLJWG9JeL2PMKPjvjp8hqFwF3g6YTTTn9cen+cyzWOLf5Un
	XP29TZ6HA29mYSJPs6CsmKswasXI71JjTW2+vuV2NykcqJgQl83K9vCEfGuVx9Q==
X-Gm-Gg: ATEYQzzg1O/baMZqXljzafx4ZgPOyRDhxcGI13Y0tHEyUMuFmrInuNrc/CYyVJWDxxQ
	OtJNwvtpThhMreLvadv644XX1JIYV7SXSsMnS+IvzMOuSOWebXqbGqdAgrjdxqInyjOeQbtIYCQ
	8zyonhkrlfKoWfGux4DjqF8WBxAlYqE53dS5UBJgyo55dZr/OWmhbrvZABNq9Sk+zd9retYzfUt
	CfJZ02DVtNr8HwpJ1NsZluPxBjRMro/IITQ2anCb+by1bQx3eHr0zLN6cbpZa/L2lkYse9rmHpl
	wz3EY1EmH8KgkrstcP77pQLdLDAZ+ldcEoCxLBMnDm3dYy7wMPsH1a8D9dcUpsTwaYlMFLPo+Lu
	bVXngCjGNHyZD1FkDckCriL+VSku8Ti6eNsxeMJIyews6xfD5z2aaLDYAfHj4mdyCsBEOWwvzDF
	j0WmlyqyvuycHT2e9Rz1YhOIeMgGoQIqfbdYI=
X-Received: by 2002:a05:6122:ca1:b0:56d:471b:c814 with SMTP id 71dfb90a1353d-56d8a817f69mr1167208e0c.1.1775041288903;
        Wed, 01 Apr 2026 04:01:28 -0700 (PDT)
X-Received: by 2002:a05:6122:ca1:b0:56d:471b:c814 with SMTP id 71dfb90a1353d-56d8a817f69mr1167104e0c.1.1775041288262;
        Wed, 01 Apr 2026 04:01:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2bc5f3377sm1384251e87.74.2026.04.01.04.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:01:25 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:01:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v5 2/5] media: iris: scale MMCX power domain on SM8250
Message-ID: <4fiyjcqt5smotudsfzyqrevxxnx3sf5grbgfluzkndbp2od6pq@vlyikcvl3xkb>
References: <20260209-iris-venus-fix-sm8250-v5-0-0a22365d3585@oss.qualcomm.com>
 <20260209-iris-venus-fix-sm8250-v5-2-0a22365d3585@oss.qualcomm.com>
 <5e2635ac-35de-645b-b5e7-235923f844ce@oss.qualcomm.com>
 <x5gv6dxdum5klzfjyo7xjqull6o43okkmkn7avssg26epbvrz6@z2brpssbk7iv>
 <0b41ee7c-83fe-d604-b750-8a5a0bd62bf8@oss.qualcomm.com>
 <CAPDyKFrO3DzfG0aW4z4w87j_iWM=3dpvp=2Wgr4MX1Bin5-6ZA@mail.gmail.com>
 <6yfn6ux3gbin2dtopdxxv4okinspueryuey5vfdq633gsewc6r@ttp56brnpgvr>
 <CAPDyKFpm7ujNw51dVpPaHCwssjgYe1JVBEyrQ_1CsPbDJuW0Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFpm7ujNw51dVpPaHCwssjgYe1JVBEyrQ_1CsPbDJuW0Ww@mail.gmail.com>
X-Proofpoint-ORIG-GUID: L5FWmtLsWd6AucpvoGo9Phjvga_eCM4R
X-Authority-Analysis: v=2.4 cv=XfqEDY55 c=1 sm=1 tr=0 ts=69ccfb0a cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=sXGUrAVt7bPh_wKNbm8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5OCBTYWx0ZWRfX73uj3EKM9j5U
 2kWkhleeRT6YR9ALLDzlwQX/DKCajiIZ/103Z98N+Qhq64KOCfScPKWR8CpXwhODcV2p0kKL4zm
 MBIhGJZZW/H/o+WKyKwvl90x1/wT+vxnrn3GeQDNSA0ySLhW3tYh/PgpyF1EvK9nzYBIrNls0J6
 3k0VeDvHozqoylGSj3bmvUKSEgtBJQ0V+4yeob1YkXXKzbZSfGg2udtv76pFPvQCigkujTMVSeP
 wDDeYQO7zTUaoNrqC09w/zSMVSLSDC+9i5x6F8unO/l/neLOf5CFtTolF2DrwV14iHeJglDxfGd
 GtqNK5Zn0ltoLt29fMmb1Q8sed+fknvQGuxYeqdBbwO5lTVMIkZC5W8MXrqL6AImTe+GIVFa84h
 lvS4qKTXkyTjfVwmAHM6g7LUW3i5F+fXe50L7MDU55v3OBfpvFe3+uHRs6osgfVuggs9BZKKRiG
 bCgMoGUaSqMUraEIoXA==
X-Proofpoint-GUID: L5FWmtLsWd6AucpvoGo9Phjvga_eCM4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010098

On Wed, Apr 01, 2026 at 12:46:01PM +0200, Ulf Hansson wrote:
> On Tue, 31 Mar 2026 at 20:46, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Tue, Mar 31, 2026 at 01:33:35PM +0200, Ulf Hansson wrote:
> > > On Mon, 30 Mar 2026 at 15:06, Dikshita Agarwal
> > > <dikshita.agarwal@oss.qualcomm.com> wrote:
> > > >
> > > >
> > > >
> > > > On 3/30/2026 4:45 PM, Dmitry Baryshkov wrote:
> > > > > On Mon, Mar 30, 2026 at 10:55:02AM +0530, Dikshita Agarwal wrote:
> > > > >>
> > > > >>
> > > > >> On 2/9/2026 7:02 AM, Dmitry Baryshkov wrote:
> > > > >>> On SM8250 most of the video clocks are powered by the MMCX domain, while
> > > > >>> the PLL is powered on by the MX domain. Extend the driver to support
> > > > >>> scaling both power domains, while keeping compatibility with the
> > > > >>> existing DTs, which define only the MX domain.
> > > > >>>
> > > > >>> Fixes: 79865252acb6 ("media: iris: enable video driver probe of SM8250 SoC")
> > > > >>> Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> > > > >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > >>> ---
> > > > >>>  drivers/media/platform/qcom/iris/iris_platform_gen1.c | 2 +-
> > > > >>>  drivers/media/platform/qcom/iris/iris_probe.c         | 7 +++++++
> > > > >>>  2 files changed, 8 insertions(+), 1 deletion(-)
> > > > >>>
> > > > >>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen1.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> > > > >>> index df8e6bf9430e..aa71f7f53ee3 100644
> > > > >>> --- a/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> > > > >>> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> > > > >>> @@ -281,7 +281,7 @@ static const struct bw_info sm8250_bw_table_dec[] = {
> > > > >>>
> > > > >>>  static const char * const sm8250_pmdomain_table[] = { "venus", "vcodec0" };
> > > > >>>
> > > > >>> -static const char * const sm8250_opp_pd_table[] = { "mx" };
> > > > >>> +static const char * const sm8250_opp_pd_table[] = { "mx", "mmcx" };
> > > > >>>
> > > > >>>  static const struct platform_clk_data sm8250_clk_table[] = {
> > > > >>>     {IRIS_AXI_CLK,  "iface"        },
> > > > >>> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
> > > > >>> index 7b612ad37e4f..74ec81e3d622 100644
> > > > >>> --- a/drivers/media/platform/qcom/iris/iris_probe.c
> > > > >>> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
> > > > >>> @@ -64,6 +64,13 @@ static int iris_init_power_domains(struct iris_core *core)
> > > > >>>             return ret;
> > > > >>>
> > > > >>>     ret =  devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data, &core->opp_pmdomain_tbl);
> > > > >>> +   /* backwards compatibility for incomplete ABI SM8250 */
> > > > >>> +   if (ret == -ENODEV &&
> > > > >>> +       of_device_is_compatible(core->dev->of_node, "qcom,sm8250-venus")) {
> > > > >>> +           iris_opp_pd_data.num_pd_names--;
> > > > >>> +           ret = devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data,
> > > > >>> +                                            &core->opp_pmdomain_tbl);
> > > > >>> +   }
> > > > >>>     if (ret < 0)
> > > > >>>             return ret;
> > > > >>>
> > > > >>>
> > > > >>
> > > > >> Hitting below compilation error on latest kernel
> > > > >>
> > > > >> drivers/media/platform/qcom/iris/iris_probe.c: In function
> > > > >> ‘iris_init_power_domains’:
> > > > >> drivers/media/platform/qcom/iris/iris_probe.c:71:46: error: decrement of
> > > > >> read-only member ‘num_pd_names’
> > > > >>    71 |                 iris_opp_pd_data.num_pd_names--;
> > > > >
> > > > > See commit 7ad7f43e568b ("pmdomain: de-constify fields struct
> > > > > dev_pm_domain_attach_data")
> > >
> > > The intent was for this patch to be part of v7.0-rc1, but I failed
> > > with my pull-request to Linus.
> > >
> > > Instead this will be part of v7.1-rc1, assuming everything goes as expected.
> > >
> > > Is it possible to drop/defer these changes until v7.2?
> >
> > It would be very sad.
> 
> Right.
> 
> Since it's my mistake, let me reconsider. If I rebase my branch and
> share the necessary commit through an immutable branch that you can
> pull in. Would that work for you?

I think that question goes to Vikash, Dikshita, Bryan and linux-media
maintainers.  Bryan, what is the plan for this patchset? Should Ulf
rebase the branch? Or is this patchset delayed for some other reasons?

-- 
With best wishes
Dmitry
