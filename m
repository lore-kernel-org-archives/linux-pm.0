Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F490542EE5
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988406; cv=none; b=K/ALhrwnhN9VCEAT3cynbQBG8znF7+2bIueHXGdbB9WUAocpz4d9LusajiZMQDY/fw2FgNZDCVcJjkrZKmMxcgbqHgfWbTO4h+gWy4ZAI99BE4/mU+rTgR3hxzyoD8ncZMxncuvW+tpu3V2PGZSIoDGfADWijzPCFxVwIpdbqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988406; c=relaxed/simple;
	bh=GhAP+Hm1mtY78lJnS460+USnW7WTojwu9rQ00L+MIyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU0HZ6YHJhJ3WuIuIaHi8aHsm7Ul5oNxpbDCfxw034/OzYMThgXZwOj3OmEiOL99a+NSLALyrOQs2FC5sYdgO1OUWZxC5b2F5FNSKBgrjQe1l/5tU//buli+yd5GWOeB/UZfhE03z+fKX8rgG0tb/V1qOZ58R66zSURRnsyUZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o5U3zAgV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QlFN1doC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o5U3zAgV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QlFN1doC"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8vl4c3000860
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=J0wSqsUrhEenMN1GPGlX0XTU
	gQq+Awy3xS3qfY9XCFU=; b=o5U3zAgVZ4lsBCE+vkZEu9eJPIggjjOoB+7zuilZ
	fCrDe7aclAZi3deeEt3ymrtULjxuskB6vC3ZQ1qpS05XyPN9EvCfI3YlKsEBSF8f
	pKXbRe59uMvF9UWwEOqdjrJdStZZq8HV6z32B+nIIgf2xZhHMMiG6dqJX9clzBo6
	0uF7xxCiTNaNiUIMRjjyo+BGOn5ns/0o1Ap0qJf5Z2L0j2P6iZudcNHPPvldJ2cU
	fmzAL2GY12qXqzaW/ezXR6w7HwZUV0ePNu8PFrL/d5yVw1PzDH2yGPsamuhNI2HS
	Hlja0Nj4fDccRGfG2XDku4JwDAP2PFBpQ9xoGgiffJuHBQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbevdnn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:33:22 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9104eedb5b0so14483716d6.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791988401; x=1792593201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J0wSqsUrhEenMN1GPGlX0XTUgQq+Awy3xS3qfY9XCFU=;
        b=QlFN1doC2JmM1xU1D+lEKxYz4maPdB0Ga/eHZCciA2KBqW+h4iLeMtqbolnOxgk1Kj
         pEZFMmv9JWH4d6JT49tAsb6nnpO7UHqbZMZ5unTHlstqqfSapiEMegcfj+cUZt+TdB0z
         3kYgPgNDfVvw/aJm4+w1UJwKNXI0CxZIJaYr50ub32pjCFesx+LWBgqxC3Sxz1sGwRw6
         ReNJcT1hSdKiWocu6q2iVmL54gxeSLdXoQYSs8/f1kxpSHUt2XfGVDVaBmzh0TLgTUhA
         foRJCK8GPItfbOvmLnbKBQJFtMgmk0oXF/DoZXSgIG6rMgXo+YyxAacyYr2xK9pzGpwF
         HNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988401; x=1792593201;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0wSqsUrhEenMN1GPGlX0XTUgQq+Awy3xS3qfY9XCFU=;
        b=jQCG1m2Z7nlYZCFS/JMXjthWXywpyze3uQhoxrQbGL/7JaeWAQFBR9WTpLH84xttvl
         cAH+JhUeUKegSzq6eK26ao05kT+cc0gK6WuOYj9bQkS1HSFDmB9Zv9EkW8ocMrDs2Ifb
         VBwQirst3sPXbk5QgfdikeL2VStwD7/fvlg3jH52s/BoXQuZU4IVIelvI9G8muCJ8CK9
         D36av2CNPFR1sbw/votcMMiy329dx4VBXdrJ4/LDT4dzNdWAxQMrfQzcy4jLbKd8035s
         M2USI+CB1QSCx9jx4RzZnSClxLCY95hS8Zpybok69VR0Jqc2RerUv5ht3x5tkf2FD2XO
         KChw==
X-Forwarded-Encrypted: i=1; AKwUvBwQu4OoqAecNcPLglywGFKWifRYMLoy3NHw/3B8rExarrgKea3uhoF+BYWLI24yD8v1ztDMUGKkPA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK1NF9nFrDtxFgTAUVA/n42uBHuVw4oOIc+7qr+26DUyS9+FCql
	SvRK43EbeNieIXO+j1cI5IFRIh1QXWnmLsAgDjf88afL3hYVhnNvi/vViQIMHhmRQAVZD9j3UJC
	Zc2zUmwm9ADhjfnLN9d8oe3fQuUsSBrVIxKP/y6RTuZkJAVRuZ/uJVcPgmSlLt6dylNpkng==
X-Gm-Gg: AYBFou3mVGwi0++4cEfPZlGLhtnTmkyhf864vgTElrL5w46Btta+KfomMYzTuocSE6D
	i/8Zavg2IXoDJOZklgB518Wu5RN2kLkJ7TxZ1Y0vU6knuNtRaRaKqchLSj3XzCY0gTaPK6Pnk5H
	Bj8YRSIgLj1G9Ith6aN9+1rKnoYhm68E+/EPU2NOMdZww6U4/UnS/CyY/6jx0bZkzpDhUK0QKHK
	k7qroKNX+21Ut4tNTL3FzS7yoiLdtvoIUALykK0P/x0Lh6jr+mWWsKrPVtmH5swM2bHJFk3Tt1N
	eYi6KLz2DmHFauyWgstvFMyMNzIxEIuo/lK0U3RxSkHFGg0dFF4/PHXabT6v1ccliEBPqsVG1+f
	BqIUPE+0rMch6V6nvlgGLe39YKhgwUU6Pa8g2fJ20migXDMhB0rPM9RfiU3HyjK4uuTZ8MbDBAG
	r1lUV1WwfsvSlM
X-Received: by 2002:a05:620a:280d:b0:93e:e394:78df with SMTP id af79cd13be357-93ee3948ff4mr1516720785a.58.1791988401021;
        Wed, 14 Oct 2026 07:33:21 -0700 (PDT)
X-Received: by 2002:a05:620a:280d:b0:93e:e394:78df with SMTP id af79cd13be357-93ee3948ff4mr1516712685a.58.1791988400363;
        Wed, 14 Oct 2026 07:33:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be33c12b51sm687593e87.3.2026.10.14.07.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:33:18 -0700 (PDT)
Date: Wed, 14 Oct 2026 17:33:17 +0300
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
Subject: Re: [PATCH DNM RFC 13/16] arm64: dts: qcom: sm8650: Describe clock
 controller power rails
Message-ID: <lyeiklz7kcjhotj43wir7xutru5wmjbrwfwauwbyzx5jcgpito@uyryg2sbmsf6>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
 <20261014-topic-qc_clk_dvfs-v1-13-3041b788e9f7@oss.qualcomm.com>
 <su6pmts36qj4hogxfthkrvjr2aod2r2u33onxifqanbarxk3tc@36qoces4rwor>
 <2ce49c83-b861-4a0d-8412-e8b3ff33bdd5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce49c83-b861-4a0d-8412-e8b3ff33bdd5@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: IKb_Efw20WkIPYijqIDGuDZDaYf1YScU
X-Proofpoint-GUID: IKb_Efw20WkIPYijqIDGuDZDaYf1YScU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NyBTYWx0ZWRfX1HBgFzF9dqim
 8YaixQw5IPpK4hmUa/9AcRo1nOUFxNQBq9nry8eYmDaeKxHc6QgfxrdQuPFRDMHzSupj2fZyIJI
 my6V1gLoXPvCEzb1D7sMfEiHA6ybfs7DLGRrbu3gyLZazeuJ/6ipV6Bzjej2dOHK8awQbzfqAyI
 Vut5TQXmc2a/yObDsJr7BsFH2kTvZQ8vgd5ELCnzZkP07yAiV0iUTgmEcd13Uj4LKMWaL7DYxMC
 GbP8IMp8akJhDXQ/npUF8J1xRuzYMwhw0727mLLgBuUjyIW6St07NX8RVgbVvLxO12sX5+Ux76d
 7y6b3w40qw+n1wlbQHOsL+yDbJwyaFwYCwvgIbqxLs+vWJneevL3wO+tcemnUpNvsgD9fUQvOu5
 w7B9ox8BBmQhjBcduSvMrJ8inR/EhchBTOfEOfPAyxaugTiLduLGrR1cZkfI6pQQv4MQUWuq5wN
 Mcmk2pLZbvZyIw/n8Tw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NyBTYWx0ZWRfX2lBElQfKmOzN
 dPDNKIfFDhqgKkfyUk24kxC+WvWCJEZJc4DWSqLpUHiWZn72rwqy6X4dzcCdKU8pZpQ5TNn5eV9
 FsnmlW+fMwmWeIOPoJ13uQ7RATAxYmk=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6acf92b2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=W8i7BNQISyomCxrj-lQA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140057

On Wed, Oct 14, 2026 at 04:20:08PM +0200, Konrad Dybcio wrote:
> On 10/14/26 4:19 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 14, 2026 at 02:19:13PM +0200, Konrad Dybcio wrote:
> >> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>
> >> The SM8650 clock-controller nodes omit rails needed by their clocks and
> >> PLLs. Without those connections, the clock-owned DVFS implementation
> >> cannot attach its voters to all required domains and controller probe
> >> can fail before any clocks are registered.
> >>
> >> Fixes: d2350377997f ("arm64: dts: qcom: add initial SM8650 dtsi")
> >> Assisted-by: LLM
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 16 +++++++++++-----
> >>  1 file changed, 11 insertions(+), 5 deletions(-)
> >>
> >> @@ -6049,8 +6055,8 @@ dispcc: clock-controller@af00000 {
> >>  				 <0>, /* dp3 */
> >>  				 <0>;
> >>  
> >> -			power-domains = <&rpmhpd RPMHPD_MMCX>;
> >> -			required-opps = <&rpmhpd_opp_low_svs>;
> > 
> > I think this is neccessary (at least on some platforms) to keep MMCX out
> > of retention. Even if we can drop it here, I don't think we can drop it
> > for older platforms.
> 
> MMCX exists precisely to let you turn it off, the clock patches
> retain a way to keep the clock on during the runtime-resume of
> the clock controller driver

Turning off MMCX is possible together with suspending the dispcc. If
dispcc is resumed, MMCX should be at least low_svs. On some platforms
it's handled by the cmd-db, where MMCX has a minimal value of low_svs.
On other platforms MMCX lists 'RET' as a possible value, however it's
not enough for dispcc (or other CCs) to work. In theory, *I think*, it's
exactly what 'GCC_DISP_AHB_CLK' might need to vote, but we don't
represent it.

-- 
With best wishes
Dmitry
