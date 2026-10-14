Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D390F5448B4
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987799; cv=none; b=Wk+pzYyrcPb4SfpwwWWv9984OCUJKTGPjjum+QxcH87iOU894eXdNtp/OAVta8VYuXMcXE4J1llVYn1d7twp/69UjQ/pTLFUuAzjtkZ04EPrDQJzSKuIdknwOh1Z/acAr3EHm7dnR1iRmr9ygsGapkmlHfup7j2uMRnI6CWbAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987799; c=relaxed/simple;
	bh=tx9Xx/2ujSCsRzYR5b6KO0ZDOUNlLvzT/wn4ry5q0iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eb29FGyAMCwC9scSMaBhd69WQP2WdGgHN6Zd0o7fsuQCbySR09uINkpgSq3kerQRs07kDNdXrJUpckCn1VYEPSidqazsXKkAfkvl93s+YMNc0AXglfMu5yShkNXSAkp5YdCX9xcou7o2Lu9eZPx4SVrMFt2ZWVkBhDmrabHGfjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TF1S2lnZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cbrfGAH9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TF1S2lnZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cbrfGAH9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBFdl23951349
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HxggoZsyGw+wkrlt+cBfpByq
	ki1BnMRvzaCfqLVXJus=; b=TF1S2lnZJFZuQXXKI6RIdo8aRvTUHZAqHZILAp7A
	vJ2B+fI4gARqwq99r+lwNgFGXtMxa93KXML3ETomP5IZuOH5YyJ9gK7/E1fLWQfJ
	Njhz16GL+biCZhSaOBXoGBLhL/5bfaybergcrzyRv0NuEbQRcBAyLPlMXzkhD/DG
	9OycF3LNTiwJaIjlAshxM4dJR6atyZd1AJ9HkeApFQ/JRp7tv4t0zxna/RLE6b8H
	L1HIlqLhhbwbNUZI7Torh5L0QRMvwdjVCChlet1V6h33K1KSTGSJPKmj075LpKce
	AQ7Ywkq6UzDQ7KkM0qmBsK5Fr8fsk5lRYjA4ryHoSkvteQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p210d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:23:16 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b875639ceso52582716d6.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791987796; x=1792592596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HxggoZsyGw+wkrlt+cBfpByqki1BnMRvzaCfqLVXJus=;
        b=cbrfGAH9rzmDWPAfL+lmDcKfacrnNCoWypgH1FU2GuKz0mnHjb6qsuOLP7OYO74nLJ
         ak++vNBXyFpSTSgpzFMSu3597qjTVRvC4owTHKejF/K5U0JaCSxHN64VFO+smXLsYJXE
         eJ+Ee2equMknJhsj8tXnE+SXbWjFLQfV4fDE7LSY1IkVxGQ8oL6kSgAzrUeheHwQve7O
         oyNxVTbljz0iIMMRPlAttPHLlzig9xM71ChArIo3N7Y2EaHfk7M+YzVhGzjPPShM0iLL
         lZdd8OFtYx3V0VWEmgvR5XnjDDRn8GI9VGSuahsgvsMqLIZtPYQIB/7xhwkBQRiT+LGq
         +9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987796; x=1792592596;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HxggoZsyGw+wkrlt+cBfpByqki1BnMRvzaCfqLVXJus=;
        b=in6A0K4RBOjWfnXm8zeaZTsDAHKIQvuZXpj1CVy3uocjuH/v6JwN1rGJTN3xQF3A+6
         UNlYEkcpFhvtHyvU+snaH7d1uSENcC9/MgWx/K2/NUKtuaBIr3D9JhWST8Zxh8at98m9
         BOMDB4wwew/lLWWjamjH4T0XCDXipTUlMVDO/uA45cLBQHVaBQ7dhdoaUX7wKDb72Kvt
         H3e5DPrrVfGaaSwHxdVm/hPXJAkghhwuwSjaPiESAPjUDUc7DDNJ/bkJlux1AUYdKEgD
         e0acO69M1IoaYvO1FyvYevjVlTB74V+JCglHv/PZWYWTCjmedcKHm+VanjyaoemIFva5
         mYgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzX/Maq6XoKiVz6W96pTBRwS6HP0XTGKUK3sMrMSZ4gZ6EFzENWMYG8lXwLYFR2OUHKbZI6fVR7TA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLE2lB1GghYDT+ZzBSibbXM6T431oB07zYGKI9waeSxiRvqfJWK
	zKiyy46H4qipbChB6UPvN5sz9fO9sBjRHNdySTMX6WMltWgd6A9Sy2ppyCenFTeHAtyXfYoPZUL
	DdjlQuso4uRyy82YNFf5qymJApCmQ+Fm3+CgqXHP47TxUpCrU4V1XZI6MybfCIA==
X-Gm-Gg: AYBFou0vNJZdH9u5FIOMMry4V4WCt5fc3QFRF2vlzNpeHKJOhUDP1yAdOUO+9XvcdFx
	jt3Cn+PMimB1iQlh/L7hh7fJ/Fj3uVuxqq8+bQu5v7GiYtEkF5nGx1JPmgfa/VIer7ZuTQVwvsV
	DTrk8WGJbpGRuwHfU6ObCQoeIlTJGf4hYMctxfBvJYm6ki87HRojoLDyiC3FmECCGFUEgDPwcZw
	Vaw0X1ZAabz/GmSeiIfYlg08KARL3BRNXvqNmQv/bb/bfZpeyz2y32TwpgwhSm2U7wtZhFW6xDk
	CCyTD+lYgBqAfUI52OnJ9vFfY5LY/CuaioP8kgcHi2gfHwClXxe1rwIXpdaT2dgMUwZBRS0O304
	KzG5TpydQMD4hVP8mM3tw232hc0ZwrWKFo9aU/wD63wbvCS0z89VTUQM82QwDF7oWvorJg2wWPI
	RMCLs/NjpOCXGz
X-Received: by 2002:a05:620a:270d:b0:93b:d79a:c462 with SMTP id af79cd13be357-93ebd26b606mr2563169185a.58.1791987795946;
        Wed, 14 Oct 2026 07:23:15 -0700 (PDT)
X-Received: by 2002:a05:620a:270d:b0:93b:d79a:c462 with SMTP id af79cd13be357-93ebd26b606mr2563163585a.58.1791987795429;
        Wed, 14 Oct 2026 07:23:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9dcdf4545sm28180021fa.25.2026.10.14.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:23:14 -0700 (PDT)
Date: Wed, 14 Oct 2026 17:23:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
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
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH DNM RFC 15/16] arm64: dts: qcom: sm8650: Drop
 required-opps
Message-ID: <r5dc5p4dozb5lkz4yaiv3epp2nskxmgcjjhf7fgoy34vcsspc6@27wzsgsvgspm>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
 <20261014-topic-qc_clk_dvfs-v1-15-3041b788e9f7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-15-3041b788e9f7@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NyBTYWx0ZWRfX2vgyejW4Kphp
 damOWtmG6/T8paYwlbS58SQkTKrJtNtHmRheaPOzUaN/szCRarSoBzxwlMnefXOaSW6HvWUdhKi
 PBPw4VwpsNZh7D5Ncnla2mlmvbiGXxw=
X-Proofpoint-ORIG-GUID: gbOccDb4ID7Wz35T6TZA4HVGRbl88L48
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acf9054 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=ycGoBvuFAn3-dblq1t0A:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NyBTYWx0ZWRfXzqrTVTdLbHV0
 WwM0wUrmwjcxinALpcI/ygtiL/uEZ/HG5KyNkZQV8MGZHTb4PwsLf4H15xfc+n0tD+Y8WarVHiL
 xcqY2qn4EjW6sza5pf8gxqRHpPQejsF4pkkgLVK1sNHDQSyLP8B15yPiXdJj8c8iwaXTB9SqyIv
 yJKQaWW4iUdGFhPzqaqUavOPd6vb4ORcok/TxZrgR5xLyn3V/fkJn3h2CQEUwWB96r7g/eazTjM
 552lZL064IePSUGaRDaDRZjn0n8n1EMGc1toy2Ex9NRvQT6cVlSzgmP0e/lXhG/jCBgpWFQwltN
 nhemR1GvagYDpwrc+hlQtydxXeto9dbD2xhSsxpvOGqJ3bzNKLwKgBpRjnK/7KLvgs+vmwdrjOy
 2YElG3NiTht0z5dPwpmFfLy02BT6MMH+x4B1yVbcSpwNGcxsKrKhv7Dqf/mccDBZw+dpGE0y5Zr
 KdaxHRWbOHYMeH3vb7A==
X-Proofpoint-GUID: gbOccDb4ID7Wz35T6TZA4HVGRbl88L48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140057

On Wed, Oct 14, 2026 at 02:19:15PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Now that the clock controllers take care of their power requirements,
> drop the required-opps that were only there because they previously
> hadn't.
> 
> Assisted-by: LLM
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> DFS clocks (for QUPs) are left out for now, as they need some more
> code changes.
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 46 ------------------------------------
>  1 file changed, 46 deletions(-)
> 
> @@ -5057,22 +5039,18 @@ sdhc2_opp_table: opp-table {
>  
>  				opp-19200000 {
>  					opp-hz = /bits/ 64 <19200000>;
> -					required-opps = <&rpmhpd_opp_min_svs>;
>  				};
>  
>  				opp-50000000 {
>  					opp-hz = /bits/ 64 <50000000>;
> -					required-opps = <&rpmhpd_opp_low_svs>;
>  				};
>  
>  				opp-100000000 {
>  					opp-hz = /bits/ 64 <100000000>;
> -					required-opps = <&rpmhpd_opp_svs>;
>  				};
>  
>  				opp-202000000 {
>  					opp-hz = /bits/ 64 <202000000>;
> -					required-opps = <&rpmhpd_opp_svs_l1>;
>  				};
>  			};
>  		};


Can we then drop these OPP tables, which only have a HZ entry?

> @@ -5200,7 +5178,6 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  			iommus = <&apps_smmu 0x40 0>;
>  
>  			power-domains = <&gcc USB30_PRIM_GDSC>;
> -			required-opps = <&rpmhpd_opp_nom>;

How do we ensure that we can access device registers? Is there a clock
(?) which now casts a vote, letting us access USB regs?

>  
>  			snps,hird-threshold = /bits/ 8 <0x0>;
>  			snps,usb2-gadget-lpm-disable;

-- 
With best wishes
Dmitry
