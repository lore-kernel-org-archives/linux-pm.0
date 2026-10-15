Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE351B18C
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061857; cv=none; b=pozG76prKo/kFcwCDr4C2IquWD7yAYMGLoDtlPij1J+0E5iqBKWmnvrOFrdsQJ8gF3oKmpSRGV9c8DYiVWgUpAa7vyJKGFJTgyD4fZ+ZXwr7EIua3dI6gcFcf6IOWibW+bNadGdS5dHmi3itIZ+nkZI+LZljP8gn89YZJR3xnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061857; c=relaxed/simple;
	bh=AcPfRM3vZkDZSubbc522Lfk5YywwxyJuwTjFzMcnOSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRMmDfZbRHkxGflRzvDItpw+VWd3eIgIVVyPpflbagF6Nu4zUI2h3RxNF5ind/knF835HKveRElFzKkxOik3lfXL1tgzzvbyq5ev4nh4qTuXzXykgAtlO7n73LXZGCBbtkwnDLc/j9Ux0avz1rBGQ4YIS8jKA176kPQ4mgsd6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gTUKceUM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P66Y7DbR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTUKceUM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P66Y7DbR"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jZvT2966421
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 10:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AnVt82VPabbk8HOMdt4DGD6AAgX9o61Mi1c5nLHpoog=; b=gTUKceUMhWcfc8fE
	BlcOXVx/ZDYgahxFheSA5e6dVwFgLe9Otetf3dLDZK94B5z2u5d5e+A2f/a4cxWM
	xKp23yDqg71w/+AwRJKpC/mDuoV2fiRfdWAtT/f+NKYZ5NQYI6u/MaIuiYckr9AX
	Y3hb6eLK5cFqdmiCbRSwP7b/Ct2MEOQu7JcYkVtzPx/XuyvgPvSkLKWYe4nX14Rg
	XKmwiEe+lSxcUdVW+UvIsS44IXmU51N/FC2q+bB1hRbhlHmE/unKQqdmNqr/R0ia
	29O+aHfvNo1VTn2QnpC7ex7/Lsc5p83v7b8lb0M+Ik5ZfZ6fOyoNxqXUkXeVGOvR
	UXVL9Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wup7b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 10:57:31 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso3538358a12.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792061850; x=1792666650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AnVt82VPabbk8HOMdt4DGD6AAgX9o61Mi1c5nLHpoog=;
        b=P66Y7DbRmGnbMxBYEaJFcQsTwZbFy3zSmUe80Oo4ARV48dTlmC5MvNuBzoEbn2hEJI
         76L9tub4IoPidmi3TKVVjyxtn09Kba5yoveZ1x0s5mctkD2j/5pErNXTlLnMbn9TppCl
         etnYRHMMwQrYk6QE25p1rEEglOqS7fu2MjXPeEHMAwWtjIVORJGFDI7jqFrmP8LluYdS
         JhkhmqU83sia/lOUgM8gdc6awXs+ZQL3fH/ys9KKwLSQgslfmWZKWNLZ4mgpYje/j+Zj
         /IV1BhKIHDtJMhlDt7aVFbH9t9Q5Ao5QUiB9aN3gd4Siys81AuN1vzhKlApHxVBPd/rD
         Cuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061850; x=1792666650;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AnVt82VPabbk8HOMdt4DGD6AAgX9o61Mi1c5nLHpoog=;
        b=JFNIRqyATDkDynEYGLGHz7+HPji1zR+R8yBiP0m0QZbmyUMyqS3H604CR3e1cFESZq
         ZlWV4Z614eKlmkc1X43rg9x6DhlcWP/7MqjjOolMXmvUoPpkdiuHBri1d9K3LXwntoOS
         +FmJbI67wDSYrLGaDax6LD1SfCJ68CnPs2pD+4Bb+7tYQN9dW+hvRzyFoP6AnI4sWRrg
         3MXunNOfxqnTy7IkloA56fCkBz11/ME2qsTRf9b8fKM/fQb3GdHB7cN/EV1M+AADXtTK
         RSxVW6M0CQqft4xsaz+7q/cxViS7XIxnXRzOXGh2YZT3zPMbjYdwo5pjZNt0khdsHE+D
         gjDw==
X-Forwarded-Encrypted: i=1; AKwUvBytUeRP8jVud4u8rlHBMI8y44Ao58wHk52wjadkJcMfesuMxjXl56rvDQF0OotHoHdfDXK4lG3A1A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5pmiQgPIPwTj/FTdAQqoiSfcSzfwGpoAK8b9ZcthSygt+G/1/
	ID65BxKEA37tWNlkW04Urje9lcydm2otdEgV4volobpq5BIcoE1G52CdaDueMdbJRhapczUAjuq
	Ao0Wvp4RGiu8BxO8evfHpCo5agI90tpT2f8McHQ7GGN6RgnhctMk8tmcNc8vdHA==
X-Gm-Gg: AYBFou05nhaw5uamBGNrIj77JvtNuakBGB7/A1J93GWiWTD3PO1aJrvWdr/9s9i6gMe
	1fKxF9ZQZ6AtT9B1dVihLnXmVyTaIeiTIvWnWaT+1yt54UgQH//29dP1/qO4CAl2m9cqC5EsrmG
	kyERZLpj3gDaSkAWQ718JDD65Q7uKCe5W0+Ru/a7nbDrfYIkHOA3GPX1QG3sEHSuZRWRWUprtmE
	wSp7YMyCvek1PnFu2TSTSdlREm9y0fve4ITEr5aV//igw4Tl0XAisSf9b//9NM1TeFwlwmMTW18
	ALaISyTQ+QN7dhXMpjC4gEv+ePOau90k7nRv0EEvmoP+lYJK5qZbD0jQpP4ZcWHUXcT9AeI0Gum
	A9p7wxQSeNEUpaJOhna77EHhJcXE=
X-Received: by 2002:a05:6a21:4cc2:b0:3de:138f:c86e with SMTP id adf61e73a8af0-3e1d03aa6camr5415511637.3.1792061850016;
        Thu, 15 Oct 2026 03:57:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc2:b0:3de:138f:c86e with SMTP id adf61e73a8af0-3e1d03aa6camr5415480637.3.1792061849512;
        Thu, 15 Oct 2026 03:57:29 -0700 (PDT)
Received: from [10.217.216.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd635b31a50sm1112723a12.2.2026.10.15.03.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 03:57:29 -0700 (PDT)
Message-ID: <187f4cc2-05b3-4c8f-aad8-0d803f2f5b21@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:27:19 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] Centralize the ownership of power rail votes
 for Qualcomm clocks
To: Konrad Dybcio <konradybcio@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MyBTYWx0ZWRfXzPpkMdShjjfP
 Ql2iLfF1RMBGyQtyBs58jg8os2svuIlhRxIbD09Dathjfgm/9P67Un3BQeFOLvCWydY7Xvkw6fG
 JMJB/UiHYjlxyZ8pd99VS5moOZUNyIk=
X-Proofpoint-ORIG-GUID: 0bV3esvQgZK9Zh_1B7SXWaUQ90iXGNb3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MyBTYWx0ZWRfX61ltCIbFgVqP
 WaxPBI91HehoClovksFGqOo2To0OiawMAzS3HwptEZk6M4OVZ3r9i5jBIF11xorF8dhR0U9NXzs
 p72xqNTc1vA+21yfeHi0nbZOcytoCJb/ODLJJTAFP6rOtZ0OrIP0VpxRfNo06F53oarKvzIdL9b
 yfnXPz0tWSQQivj7I25IracJl/NLrD1+tmfzF15VRRUzzI057YfNFhnIReQbPXJWIIcxg46vpZq
 u7shG8Cvm2MJ3Iwode31iiY7zpp7wyWTP/cZwqSRDCKhOV6ITEnvHH22Xab3IkwBEdYeJ8Iq7t8
 KvoyxhilXm9/tweSiHrh2L3nMne5N/171gjr+6QiCpJ0tdD3bIfs/8eSI+0hyoFVoQxctGk/KGB
 WaFwJX3pNBQcYWssKfY6/pLUJHuXUCyGPrxFoukLhkF6XlGooHRGsm5DzEH3K6yRdMQue9tgN5c
 j1vZcLYA4zjMfwsgvwg==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad0b19b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=LpQP-O61AAAA:8 a=EUspDBNiAAAA:8 a=iEdp9f2tR9rxy83nKJ4A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-GUID: 0bV3esvQgZK9Zh_1B7SXWaUQ90iXGNb3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150043



On 10/14/2026 5:49 PM, Konrad Dybcio wrote:
> On Qualcomm SoCs, both the PLLs and other types of clocks alike require
> specific voltage rail levels to operate in-spec, but through the
> separation and decentralization of clock and voltage votes, these
> requirements are often not met and are never explicitly stated.
> This results in clocks being undervolted, or at the very least a state
> we're unable to reason about.
> 
> The devices consuming these clocks very rarely have their own
> requirements in that regard. (1)
> 
> This series moves the frequency-power_domain-perf_state mappings inside
> the clock drivers, ensuring a single, trusted source of truth is
> established and that the silicon is no longer driven at out-of-spec
> conditions.
> 
> To illustrate the nuances involved, here's a couple examples of hidden
> dependencies, as found on SM8650:
> * video_cc_mvs0_clk requires LOW_SVS to run at 900 MHz, but the
>   PLL it sources the signal from requires SVS (higher corner) to
>   produce that frequency. Similarly, to produce 1140 MHz, the clock
>   requires SVS, but the PLL then requires SVS_L1.
>   Analogous story for mvs1_clk.
> * gpu_cc_gmu_clk requires MX to be at SVS to output 625 MHz, the PLL
>   requires SVS_L1 to produce that frequency.
> * A number of camera clocks follow the same pattern.
> * Additionally, some clocks like cam_cc_cci_{0,1,2}_clk require
>   MMCX to run at LOW_SVS, but the PLL has the additional requirement
>   of keeping MXC (a wholly different rail) at SVS_L1.
> 
> There's a broad agreement that a consumer should only have to care
> about the clock it consumes, and that configuring its parents is the
> responsibility of the CCF. Requiring the consumers to care about the
> above cases (as is the expectation today) is a clear violation of
> that contract.
> 
> A clock controller may have on the order of hundreds of clocks, each
> one with its own frequency-power map, and potentially all of them
> could be similarly affected.
> 
> Recently, some drivers (Iris, CAMSS) have attempted to circumvent these
> problems by holding a direct reference to the power rails and managing
> the votes manually, through placing direct votes on each rail via an
> OPP table. That however has a number of drawbacks:
> * Because more than just one clock needs to be scaled at runtime, the
>   OPP table either has to contain NUM_CLOCKS * NUM_RATES to handle
>   that (which blows up pretty quickly), assume the worst case (and
>   waste power), or ignore that problem (and undervolt the clock
>   controller), instead of just being able to call set_rate() on each
>   clock as needed
> * The data ends up being dispersed across various consumers, even
>   though it logically belongs to the clock controller, making it
>   absolutely unauditable
> * It's horrendously error-prone because of the number of clocks
>   involved, the depth of the clock tree and the fact that at the end
>   of the day, one still has to consult the clock controller
>   documentation
> 
> The approach proposed here also happens to more naturally fit into the
> process of how an SoC is brought up - clock controllers are always
> the very first pieces that need to be complete before other IP blocks
> can be brought up. And because of (1), enclosing the frequency-corner
> data within the clock drivers takes a weight off of everyone else's
> shoulders.
> 
> On a related topic, the GDSCs are modeled as children of *all* power
> domains consumed by a clock controller at once. GDSCs are on/off switches
> with some fancy logic attached to them and may need some (or none) rails
> enabled to power on or off while meeting the hardware timing
> requirements. Voting on them was never quite right in the first place
> and is once again only a side-effect of the clocks' power requirements
> not being handled centrally.
> 
> This series removes the vote propagation and the overly broad parent-
> child links, resulting in dropping unnecessary/incorrect votes that are
> now encapsulated by the clk-dvfs infrastructure. Big emphasis on (1)
> once again.
> 
> The implementation is as follows:
> 
> Each clock describes the rail levels it needs at each frequency. The
> new clk-dvfs helper combines these requirements and submits the
> resulting votes through GenPD and RPMHPD. Votes remain held while a
> clock is prepared, and rate or parent changes reserve the new
> requirements before any clocks are reprogrammed. This also requires CCF
> to report programming failures and OPP to retry failed transitions
> instead of relying on stale cached state.
> 
>                 Consumer: select rate, prepare clock
>                                    |
>                                    v
>         +------------------------ CCF ----------------------+
>         | Walk the clock tree and reserve resources          |
>         | before programming rates or parents                |
>         +--------------------------------------------------+
>                                    |
>                                    v
>  +------------------------------------------------------------------+
>  |                                                                    |
>  |    GPLL9 ------> SDCC2 RCG -------> SDCC2 apps clock               |
>  |      |               |                                             |
>  |      |               |                         Other GCC clocks    |
>  |      v               v                              |              |
>  |  +------------+  +------------+                     v              |
>  |  | PLL's own  |  | RCG's own  |          Per-clock requirements    |
>  |  | rate table |  | rate table |                         |          |
>  |  +-----+------+  +-----+------+                         |          |
>  |        |               |                                |          |
>  |        | CX            | CX + MX                        |          |
>  |        v               v                                v          |
>  |    +--------------------------------------------------------+      |
>  |    |                  Clock-owned DVFS                        |    |
>  |    |                                                          |    |
>  |    | Prepared votes + temporary transition votes              |    |
>  |    |                          |                               |    |
>  |    |               Maximum requirement per rail               |    |
>  |    +-----------+--------------+--------------+--------------+      |
>  |                |              |              |                     |
>  |            CX voter      CX_AO voter     MX voter                  |
>  +----------------+-------------+-------------+---------------------+
>                    |              |              |
>                    v              v              v
>        +----------------------- GenPD ----------------------+
>        |      Aggregate GCC votes with other consumers       |
>        +---------------------------------------------------+
>                                   |
>                                   v
>                             +-----------+
>                             |   RPMHPD  |
>                             +-----------+
> 
> Straightening out all of the above lets us tackle another problem
> with the upstream description of the power grid - the dependency
> between various rails. Most notably:
> * CX does NOT need to follow the performance state of MMCX
> * MX/MXA/MXC and CX are co-dependent only on some platforms (in coarse
>   terms, SM8350 and before)
> 
> However, the main part of series needs to land first to ensure that
> dropping those relationships doesn't remove some wrongful votes the
> system relied on to stay functional. Resolving that will save power and
> finally ensure total stability as far as the providers are concerned.
> 
> SM8650 is used as an example in this series, but the conversion will
> have to be done for all Qualcomm platforms. That will follow soon
> after the patches are merged. DFS clocks are left out of this RFC to
> reduce noise (the remaining diff is not particularly large but also
> requires boilerplate changes to bus drivers).
> 
> dt-bindings changes are not included since it's an RFC.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Konrad Dybcio (16):
>       clk: Propagate rate programming failures
>       clk: Acquire resources for clock transitions
>       OPP: Retry failed default single-clock transitions
>       pmdomain: core: Support named indexed virtual attachments
>       pmdomain: core: Support subdomains without pstate propagation
>       pmdomain: core: Support indexed power-domain attachment lists
>       clk: qcom: Add clock-owned GenPD DVFS aggregation
>       clk: qcom: dvfs: Add debugfs
>       clk: qcom: clk-alpha-pll: Add DVFS (un)prepare
>       clk: qcom: clk-alpha-pll: Vote for the PLL calibration frequency
>       clk: qcom: gdsc: Make GDSC parenting optional
>       clk: qcom: gdsc: Link required power domains
>       [DNM] arm64: dts: qcom: sm8650: Describe clock controller power rails
>       [DNM] clk: qcom: Enable clk-dvfs on SM8650
>       [DNM] arm64: dts: qcom: sm8650: Drop required-opps
>       [DNM] pmdomain: qcom: rpmhpd: Stop forwarding MMCX pstate to CX
> 
>  arch/arm64/boot/dts/qcom/sm8650.dtsi        |  62 +--
>  drivers/base/power/common.c                 |  24 +-
>  drivers/clk/Makefile                        |   1 +
>  drivers/clk/clk.c                           | 793 +++++++++++++++++++++++-----
>  drivers/clk/clk_resource_test.c             | 376 +++++++++++++
>  drivers/clk/clk_test.c                      | 194 ++++++-
>  drivers/clk/qcom/Makefile                   |   1 +
>  drivers/clk/qcom/camcc-sm8650.c             | 282 ++++++++++
>  drivers/clk/qcom/clk-alpha-pll.c            | 317 ++++++++++-
>  drivers/clk/qcom/clk-dvfs.c                 | 635 ++++++++++++++++++++++
>  drivers/clk/qcom/clk-dvfs.h                 |  41 ++
>  drivers/clk/qcom/clk-rcg2.c                 |  93 +++-
>  drivers/clk/qcom/clk-regmap.h               |   6 +
>  drivers/clk/qcom/common.c                   |  28 +-
>  drivers/clk/qcom/common.h                   |   3 +
>  drivers/clk/qcom/dispcc-sm8550.c            | 328 ++++++++++--
>  drivers/clk/qcom/gcc-sm8650.c               | 261 +++++++++
>  drivers/clk/qcom/gdsc.c                     | 154 +++++-
>  drivers/clk/qcom/gdsc.h                     |   7 +
>  drivers/clk/qcom/gpucc-sm8650.c             | 101 +++-
>  drivers/clk/qcom/videocc-sm8550.c           | 135 ++++-
>  drivers/opp/core.c                          |  72 ++-
>  drivers/opp/opp.h                           |   2 +
>  drivers/pmdomain/core.c                     |  60 ++-
>  drivers/pmdomain/qcom/rpmhpd.c              |  14 +-
>  include/dt-bindings/clock/qcom,sm8650-gcc.h |   2 +
>  include/linux/clk-provider.h                |  39 ++
>  include/linux/pm_domain.h                   |  33 +-
>  28 files changed, 3734 insertions(+), 330 deletions(-)
> ---
> base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
> change-id: 20261001-topic-qc_clk_dvfs-ef907f059611
> 
> Best regards,
> --  
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 


This seems to be similar proposal which was there earlier

https://lore.kernel.org/all/1532196902-28570-5-git-send-email-tdas@codeaurora.org/


-- 
Thanks,
Taniya Das

