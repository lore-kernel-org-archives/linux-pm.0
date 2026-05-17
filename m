Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7FD3254A5
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043920; cv=none; b=n13fMIytj66uUtp+rCW2A4jgc6LSR9AL16mwFgsqiC0IsSvkJ2QFUpunzFX0ZgHLjT98BtmmbwCWAEv066352oF7ekXlaNlUQI0RaC88HL4POpeM1QFjzWuD+7VOSzx3eIGM+q9bxjxO+TMVyHyr7SsseD+78nC7jUei3VWlb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043920; c=relaxed/simple;
	bh=Y5i9WcyiDzQjtJSx79lz5XChtinSTRrDP5DUYMTy97Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBxZCIZI6vytfTWghErHvd43wnXql2UM3sXJOylSFEAo1mcE1Yt2Oo5MEKbAFIMTgwRozz7DkRLYreGX9cy9PwXdh0qJ1sdfwui4yqR1ATKKGfMdReyx/Je6kPTY6Mf1nI37yEM7y+3KzNwt3XUroQaQYWUqI8x4mSBREC4cjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YqLG13MY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BNKU4PAA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YqLG13MY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BNKU4PAA"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H97DVI3124872
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 18:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=w8qDcE/JkXAvARu8IjsWPZkQ
	lthwgFQJ1bcCPlrXmHw=; b=YqLG13MYcGs2osLqpsGGB9+Ep4Lp7BVQA8pnn30n
	jkCl2uge06yWxC1xdsrYDWBfPghOMZkIYeohGJmDgi/e9hRhVqjqg8u2y/RhdDqx
	o1W3AgwnG9b2J9FjUEf+s2VAk5LM6c/1zKTytynM/QdjRxfC9aeE8SAYayA0r7wF
	O5m+gOAec4uFNK5IGzqavxEDh/6ASx5DIhCnmEh0p0MUS1F1g4q+4tXbj+Ie86p+
	3mm8v1l4npSsrls0yLneJYRfY/BDCgOJlf0S39CbRc6oOPIjQk61RhM4zYS+Zmr0
	1RrQtnpX57ZmRTS+SsAytHuKx1YGusMguwe1jERRJB8qZg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gyw3d90-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 18:51:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d5d1c2289so51679651cf.2
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779043916; x=1779648716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8qDcE/JkXAvARu8IjsWPZkQlthwgFQJ1bcCPlrXmHw=;
        b=BNKU4PAAl/d/4hFcuu1gCJ882A6UYQAOoA6+BIhE9U5Qvb1tdyQjSzKk81MbVz+cFS
         JkeEqwVWdvWFi66iO1tDY2XQgB+q900XS5E+hdth+Qfz7Lsq8kB+609x3V/v79KOJsfm
         e/yULAAwQSa3oSpva5IeUR9TfRaIvcgyrl9h1ZyinJfHyYkBopg/aJ8+4WWqfSXMQqw2
         SBe7/px5067JENK4ZJNt38cYq83cs+y6FrqPxuuoVdAraD8hnA9z3HijUlok2kW3Q8wH
         xQHVAW4lwhKExwdRWr6vIY3np3/5KT6U+tsykprzGBljHvaRYm1zToREOzEk9brF2t8W
         0Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779043916; x=1779648716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8qDcE/JkXAvARu8IjsWPZkQlthwgFQJ1bcCPlrXmHw=;
        b=ClLAGZjIMXfIil2I+Y93pZxtXPzORw4MtkUVSKWbS0pCVCrdkAKxILC+Svj2X1lsX9
         W+uiN41t7x7X3shLM+WTQ4+Y473ohtACzWET/s1t5i5I6lwGkBeldEC8cyIcUyeD2dAd
         8/x0tIvQEAw1g2zz6dQlVGqi6rv68vZew1cpZWdBZfXW87j88RQP7c6hYsZ3GQaARrPA
         6SUICmHPDo0XA51aVmnYizokttV/wrdbBiKfFLD4YkAxG04EoiV9y76BuzhwEICrvtuG
         f7L6pVzmxw/FvwzLgwvQsgAoaRrFumlAGMe30FEdmK4hcmxODVhUoRN9ujUsJrVNzd+6
         7Tgg==
X-Forwarded-Encrypted: i=1; AFNElJ+R6WeJk3ryWYdc6Zw7qE4s+jaANfYQhfwkLZyMKtTMwM49OjsWQhjSiy9BSvxS6C22/w1IO6ux0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjcTvIZeY19nY+AhAir5g0PMsX0XaUnAXlq6Cgi0VfzlASwmLo
	IsEJSMgl1u3dAx8+1HYXyrysapNrCd/Zo8doPIduykp1Jw0Bf1jl6hcGO0CloWc2xxODl42dB8G
	iR/WfkoO0tGS+ZJepX4IUnnZ+s8frAnQ3NVXsNsTZ1IzEX3PCnPxfh1TzQEvGVQ==
X-Gm-Gg: Acq92OHajSv1O49XIbUpTs6/VgedyNbDZld74JVprZ9iL9wlY0yYn0HAbHoX81gpGxt
	vhhdZuTzTY6er3Hxq7xFmU8NhbE2DdGVGhbvr18vu2ryqTEsC88iXH2hGJmpoBbpJY0ddmN/MSg
	SHzMTkkUIar9/NmpVNiRg8ofkPMY15CfcGOhKPidqx3v8iGzzXhXGTS9sZQRYTcxE98z32yQc/O
	WOhnVP5G4qEU6C0OOr8hBNNc6kL+gn5fBoB/KII3YxTUm/68tYXpUhvEbZQ6P2sDzPAGNcS6Nub
	K+fYBmWV9Xt1UibcuW4cP5sFp3f8MFlY216uDH7qN3wCLkbET/hHrsV34voFIgZNpqKm6fazx96
	+94pzTpeLinKqDr4Wo1Ug5di5GanXqC6UtWmXSOY0rC1d1jvDRzBUC0JttQSz37g4wmzF4A6QcN
	A1n+vEkm0zTeX7VmiVdPNl4p87fV2WtI4fDPY=
X-Received: by 2002:a05:622a:4a0f:b0:50d:a4e6:997f with SMTP id d75a77b69052e-5165a03ad56mr162139301cf.15.1779043916042;
        Sun, 17 May 2026 11:51:56 -0700 (PDT)
X-Received: by 2002:a05:622a:4a0f:b0:50d:a4e6:997f with SMTP id d75a77b69052e-5165a03ad56mr162138991cf.15.1779043915619;
        Sun, 17 May 2026 11:51:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c74d6sm6943301fa.15.2026.05.17.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:51:54 -0700 (PDT)
Date: Sun, 17 May 2026 21:51:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: qcom: ipq5210: Use icc-clk for enabling NoC
 related clocks
Message-ID: <whx5dpg3ji7lj62o5wvcytwfi7wphtlooqznkeeeeixkhegw5k@7bli6m4w6frn>
References: <20260514-icc-ipq5210-v1-0-b5070dfbe460@oss.qualcomm.com>
 <20260514-icc-ipq5210-v1-2-b5070dfbe460@oss.qualcomm.com>
 <5zdmbj56ndi7nrvdqadinrf3sneywft3uaplnoxugp5zetsfbj@5hazmuzyfz7u>
 <agc+n28PfkrxwpuJ@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agc+n28PfkrxwpuJ@hu-varada-blr.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDIwMyBTYWx0ZWRfX1RFFLyuELEPM
 kDoVmxZNLSKgFqsDW28hmof0tCuG1JtCMp2EE9ueNbIuPXcP12ku9mPqS/Cvv550a6mYMvDL5wi
 kUpIbnzu94x7gXzQ4pxLfnQzKuDkTU41rlBDf2kQKsE6UmHiN4ixj189K352T2cfKUexqv3CfDm
 q5mUbYKCiKZUhr/yni1wgWMiybIBL+ijuAS03X1aSyB9Ur6DXjYk5heAUav1o2dRf/rRydCzKhV
 0TgQgHBZ/kP04bjtDbhEUQvYQE9GfnuWV1ZQe+YREZQja7QKBpawEVWWT8TSYCze2IpPu+OYclv
 b+HuQ6kWBzXoycBmFAhdBCDdRTXucNn8JbM8/XjsYNPmHmajJmrCMKz7n2Hq0D5E5CLRPOK1enh
 SyRDJhOeihtb+Pw3mqgJKCiqeGgxfp+G13u2VqUqTYSzx3d27PAcBWaxQwQX1DD73Xk7Vc0GRLH
 QjC0Go6/MoAbTjmX1uw==
X-Proofpoint-GUID: b7EDXMg8NglgxCzoSe7X4hXuwfAGgFRg
X-Proofpoint-ORIG-GUID: b7EDXMg8NglgxCzoSe7X4hXuwfAGgFRg
X-Authority-Analysis: v=2.4 cv=E5v9Y6dl c=1 sm=1 tr=0 ts=6a0a0e4c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=92o4APbqSy6JO7topJkA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170203

On Fri, May 15, 2026 at 09:11:19PM +0530, Varadarajan Narayanan wrote:
> On Fri, May 15, 2026 at 04:31:42PM +0300, Dmitry Baryshkov wrote:
> > On Thu, May 14, 2026 at 09:35:36AM +0530, Varadarajan Narayanan wrote:
> > > Use the icc-clk framework to enable few clocks to be able to
> > > create paths and use the peripherals connected on those NoCs.
> > >
> > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > > ---
> > >  drivers/clk/qcom/gcc-ipq5210.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > @@ -2642,6 +2657,7 @@ static struct platform_driver gcc_ipq5210_driver = {
> > >  	.driver = {
> > >  		.name   = "qcom,gcc-ipq5210",
> > >  		.of_match_table = gcc_ipq5210_match_table,
> > > +		.sync_state = icc_sync_state,
> >
> > in Kconfig:
> >
> > select INTERCONNECT
> >
> > OR
> >
> > depends on INTERCONNECT
> 
> In drivers/clk/qcom/Kconfig, IPQ_GCC_5210 can be selected only if
> COMMON_CLK_QCOM is enabled. COMMON_CLK_QCOM selects both
> INTERCONNECT and INTERCONNECT_CLK.
> 
> Is select (or) depends INTERCONNECT still needed for IPQ_GCC_5210.
> Please let me know.

I've sent [1], let's see if it gets accepted or not.

[1] https://patch.msgid.link/20260517-qcom-clk-icc-v1-1-1dc6ea8bdcd0@oss.qualcomm.com

> 
> Thanks
> Varada

-- 
With best wishes
Dmitry
