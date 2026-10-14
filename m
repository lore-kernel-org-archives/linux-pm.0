Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D852559CB7
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995466; cv=none; b=Ubs1Cx8EmSJNMSWRKWlW5OOhGdDiqiTPcewexTzrydB97TP4zFTt+JywqdXao/YTvf8bb1wdrtyd4TnX5qUgQlIN/LrS9vygAextoBtbglkVcwdpXLLoODuGO6SsjA8FTQvEIj7LqZXcC6lcshmZJ81hjoimmJmpIraj7FgW+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995466; c=relaxed/simple;
	bh=jDo8FmBNC6Zlvz5RdT+ttXl0I3pWgOXdBxK/FcXzf2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXc4iNg+Nd4Ot3DO2K/sxPUFege8M3ukrw4oIIJWfZaNbReumLEuG7jytIS4w7gWbbCYK5HZ+gGrQ59qw3IBMSBMui1SrvR5b13EA7/wi7HfK7xYVbyP8UkEl9Fs5qE836+Bcvjn5v7csJrJLO6n/f1Lkktmf6YIh3UT0Qy7EDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OfFwPvMB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X9/xw3Iq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OfFwPvMB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X9/xw3Iq"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEbEAM301154
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 16:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=F9Qrk4Mg2F0knWzLkDlgBgLd
	h1ZdAWIpmQGZLSyV4aU=; b=OfFwPvMBAeiXPOzfDsOZ3Z0SKskre0FSEH3H15qv
	ttQ7m0Kfrb2hAhh/NTshXhXygqxkvYz3J63ZbyQMbMXp9q4x+Y3grpd+FV6h3KV3
	DDYLEJQQ0vCk7HxFUg/dn8amrwBZegEBljnkcy3g3viUpoD3wGaQzd+tANtVAkO9
	VaY8FpQ3WSGa9T/f3yoKQUN4fm8SH66Fr7cS22e7feq6JUIjRBodQhciMczxFgSB
	J9X5wvjyXM0pbZ+rHZxnQ2rluSKgwcc0J+cJRfvBkthJoLP1IqMZbs0HaiHnvZnX
	dqzqtiMfVpU+Y4Znu1mThM2Y60wJcxdBbGvh9ewevLmS6g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4622hq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 16:31:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e46b4b700so96200185a.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791995461; x=1792600261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F9Qrk4Mg2F0knWzLkDlgBgLdh1ZdAWIpmQGZLSyV4aU=;
        b=X9/xw3Iq853L6pZPTlduzfioOpo9KnME/w1nlr0Plva9hjSEYdaVk5X2uQ+2LemiF5
         Ky93g+XnKPpCKs/c0Hwfk1NVNyzskXqDFG917I9CKeGPhaHjJLiG8lhi7WdRyUtcdvon
         2jiad3M1YirU7TfPT4j3YIKgSBRyKy6dP3I2szkbIHBBC3pyzbPEh9Pgm6Xp7ZV5z8EN
         +BK9mIfLeriJSWJlLX6M+/LbSaY/FGj7lFBgeUeLz6b0I6ji33x5KA59UxPrmiFZ89F1
         v7oxOWdtym1AQqPLzpOycGkFpYoO95S8Zz/oOISPduqjyWhUw0Acido88IRgBlEIdXKf
         zmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995461; x=1792600261;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F9Qrk4Mg2F0knWzLkDlgBgLdh1ZdAWIpmQGZLSyV4aU=;
        b=BKmGtVXKaUg01Vy8VDsfMmQqB0ybOtIbECfRo6GzeRA/znfw3YRMlu+GQ1+D+sJo4q
         fS7ChrDk1ZXmMhMPVmvlNVIi6U23i1zOUA8+I49zxNVavojBmZcMDAQUs4fxpv4Ve2fN
         2Ru1lPpR82j1YS4BZeaWXpY0xXyIOsTPd6XOakUA5isdxUoZSGWwDQaBo5hAu4oAMrFF
         gPnAwFkQO1cZS9pD06cO+JxeAWmCoHq8ZOlgH+zwYoSPTWOibB4CJ9OaoZnwrqymAc2/
         vtTU0BP2FAfkGPOtGoW0+0hD8MgD2t1qXn0oRH31eGD1Wg6PM19H+IvMT0T1VpcobFNi
         m/Mg==
X-Forwarded-Encrypted: i=1; AKwUvBwAb8C6jSfoP06fobpPiJmpzyRAyXFQhYnFi2hVGuvQ7Dl43dOP69KJnaCsSRb3WgQkqAoP+x0AcQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLLWOEs8yFqFfv2usP7o68N1FD8IojRrw8WmIfXARuilmotK3SO
	Hc3wn/JizvXWowzCzypWYr3Aau8Rh1zHLwmny1blU0GUvtqxInAjd98dEQNaq/TiJv1LI2a3IG6
	M8EgQlq480/OsdiKaIrXFvO9cf05Bg4OA/YSburU9k08Dy+fg/FxUJacZRWBdJg==
X-Gm-Gg: AYBFou0twSX+oa3oOadTcIJ7pap5nzNIaCI+Gg+qUE1/sCw1ZUI2dQvL7VaI4GiW+t3
	3o6xl1FI+5RKFZkUo/wmyq/Kejua2yoqP5ATfXcpjmCfr1bvz0015SUGpaJKFYAWd0OixhwrUEd
	zEMHjthmcjvwnmll9D0m4qX5rg43nczey6eJFRy75XVWM2O9cvDykJcsTG200RtSi5MZ15tbMv2
	fEWi21LPTIGvvfN1+mD8HMNbvVdpTuc4sDry5MrYoPktvO3wrWb6EYZSGDZXrJwxJfEL3sB8EhX
	tQEsBcWXcZWbaPw3mr2xjdncWnFoiY/VElXdTAOIjS8tVgsUasxdHrVoKsMEGSLf4SwAlgBxT8V
	RWaeE2JE+ms2WVCN1Q2lOPSff4zpUjJx/wQIJAE1EuNlu55ua3zeYD3fwDkpuUHR9mWvL2CmFQp
	NTUqIopCXCM4GT
X-Received: by 2002:a05:620a:6489:b0:939:3885:3131 with SMTP id af79cd13be357-93ebd0c2fc7mr2507400385a.3.1791995461278;
        Wed, 14 Oct 2026 09:31:01 -0700 (PDT)
X-Received: by 2002:a05:620a:6489:b0:939:3885:3131 with SMTP id af79cd13be357-93ebd0c2fc7mr2507392385a.3.1791995460686;
        Wed, 14 Oct 2026 09:31:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3aafdf0f0besm241701fa.31.2026.10.14.09.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:30:59 -0700 (PDT)
Date: Wed, 14 Oct 2026 19:30:56 +0300
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
Message-ID: <dbyuabhh3phhe3uq2kvhcnuem7qb2a6j5yvhl6ylizqikt2rlk@vyvrcj3lewtp>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
 <20261014-topic-qc_clk_dvfs-v1-7-3041b788e9f7@oss.qualcomm.com>
 <ygwhik5t6w74xcqz4igmb6t5esmjjgrmtwqqqmo4doj34t7rpu@jkngx4v76rxg>
 <6c9937a6-88c3-4e5f-85a3-73d929d3ba01@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c9937a6-88c3-4e5f-85a3-73d929d3ba01@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: jD-vq_d51yn3UwX-5X4S9H2ZTog4XpsU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NSBTYWx0ZWRfX4tnTdXTZotq/
 IcWbD5jo10g5y+g70l0l1409N5p6rfWwWA+iN4IZmkF8BRmf+J3+UfCxXaLy3xlmMLFKSQuaZa2
 RDo46PqlLIqT2fNmDppcl1JzG9elKRHDtbOPI134+zLvKltSBN9dmovX62o43abefL97xe2/9WQ
 JTctVQ9ITkyC9BCxtoHJXuxe2e+pDOZhpy4Gdm7B7GhuAqZG+kW83mgC0B0KueTce1UQCpOXMSs
 YD3PjGJThOf9aDytuE6k2FfeSjz/lPnCQWgmelKRfFCiVo7wl0CHHWOHMJekkiFWLOGxb1ZdbC1
 Thz8a8AfNK8AxeEjXG+w84FUXKHfhbMyo/1UNP/TyYSF0oE6Qn9VQkoReAcIKPh5pcuRDrIuCBc
 c/VlwAS2n/wEBwIU4v8EvKnXpxsGCewAKSLR4vWeDwGE/iU55O0nHtKaHj29eN35A5le3LuwIt1
 tJuClsj2K6ed9pfHUWQ==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acfae46 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=HP_GaHYFTpJcVqZjrCEA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NSBTYWx0ZWRfXwZ5SuBeWBHFX
 Nl/SbF/pqWPZnnROcTc9SGw+qpy5z2hvDySI2kfr0whNrizoZ1++yKnCy704R/KGLAgPifcupmN
 c2bm+klPzVE5HPWXLet33lmwVUKdDbA=
X-Proofpoint-GUID: jD-vq_d51yn3UwX-5X4S9H2ZTog4XpsU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140065

On Wed, Oct 14, 2026 at 05:26:00PM +0200, Konrad Dybcio wrote:
> On 10/14/26 4:36 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 14, 2026 at 02:19:07PM +0200, Konrad Dybcio wrote:
> >> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>
> >> Clocks on Qualcomm SoCs need a minimum power rail performance state to
> >> operate at a given frequency. We currently leave this to clock
> >> consumers, so a driver has to know which power domains supply both the
> >> clock and its parents. This ties knowledge of the clock tree to
> >> individual consumers and doesn't protect other users that prepare or
> >> change the same clock without making those power requests.
> > 
> > Why would they prepare or change the same clock without making power
> > requests? If it's a legitimate user of the clock, it should have an OPP
> > table. If it's not, it should have a separate API to set the clock via a
> > legitimate user / aggregator.
> 
> That's the entire problem that motivated this series. The consumer
> doesn't know what it needs on Qualcomm platforms. The power
> requirements are that of the clock controller's, not of that device's.

I'd still say that the consumers know that they need a certain
frequency, which demands a certain voltage / power / etc.

> 
> > I see one usecase where this would help though. If the clocks use
> > different power domains and the corners on one of the domains don't
> > match voltage on the other domain. E.g. it's not infrequent that the PLL
> > (powered by MX) requires performance vote change at a different
> > frequency than the rest of the clock tree.
> 
> Correct
> 
> [...]
> 
> >> Move these requirements into the clock provider and aggregate the votes
> >> per power domain. Keep the highest level needed by prepared clocks and
> >> in-progress rate or parent changes so that one clock can't withdraw
> >> another clock's requirement. Use separate virtual GenPD devices for
> >> these votes and controller register access so their power requirements
> >> can be managed independently.
> > 
> > The biggest question at this point would be the locking and lock
> > nesting. What is the expected order of operations? Currently it's
> > limited to pmdomains, but for some of the (older) platforms clock
> > supplies are expressd as the normal regulators rather than pmdomains.
> 
> The Qualcomm case is easy - RPMH is *always* reachable, so the
> pmdomain provider needs no clocks itself. For the other cases,
> "patches welcome".

Ok. There is a promise that I2C PMICs will never ever be involved in the
clock / power tables.

> 
> [...]
> 
> >> +static unsigned int
> >> +qcom_clk_dvfs_aggregate(struct qcom_clk_dvfs_rail_voter *rail_voter)
> >> +{
> >> +	struct qcom_clk_dvfs_vote *vote;
> >> +	unsigned int level = 0;
> >> +
> >> +	list_for_each_entry(vote, &rail_voter->votes, node)
> >> +		level = max(level, vote->level);
> >> +
> >> +	return max(level, rail_voter->safety_floor_level);
> > 
> > I guess you want to avoid having too many voters, but would it be
> > possible to have one voter per 'signficant' clock and let GenPD itself
> > aggregate all the votes?
> 
> What does "significant" mean here?

I'd define it as "using a different power domain or requiring a
different corner".

-- 
With best wishes
Dmitry
