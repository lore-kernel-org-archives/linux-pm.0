Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46788279DCC
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740675; cv=none; b=DYtWncE+XIqdYX+y6sTeKBm9oHfxPlEPEfWMl6IyfasbPTiko6s5PpV8rd5zwYK1hVk9s/T+PL5mwfPdaXDSgTo02QGi22dpc5T5iGCOFh9498uIBtgO/Q7MwkBTQrkWC8J3aZYOUxFWhaLHstPfcOl/4kgTnPeikXcNgdT3jhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740675; c=relaxed/simple;
	bh=2PcU0CU6jROtev2cX4JA1crRGrmou+RXG2XjGE271yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YApl1UkJrjpo0JSU7gSvPs4KPoBjwelLgdS9IQDiyzhBMT/TIoFrzL9Hy3IsYNLiwMnhoLcrfrmnGr2vndlCDZvQfafwbiEyI+EF/SHPWyeRjjaNzoWpUfg2kY5LEpDkQjnUMaVjY9oR35ZnMdKEn7nknYIkfPEfPZEtaGyB5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HM2ZNCbr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GHFU/p4o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HM2ZNCbr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GHFU/p4o"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TATSQ32579625
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 13:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j32JpAQmHkv5QJI1PXFq4rNAG/oPOASevxwvwkrLR7k=; b=HM2ZNCbrizP+V6rT
	K92ykNusiLrfm8jMZUdZ4JM11auoxkQGBvIu1SEo2sLNp/psnkuby4kpOwahUkTm
	eGOqcehMPCAygafv+mTQb+d25B9YGdodgBQum/e/H3yaXFCGZbGXkWwaohL+TSbZ
	sN0dj+OIWWvWmHuZrw6ort7x6nBNUlTwqnNZEcLOOifwM4MCjF4A1R+25WqMFX8Z
	EnqwXL5mSXXLpyrjUO6DRxuF07QexoG8PXkYZYnxCb3fKIp6RTcM7V0MeNCbSvZ4
	XC2jfH18ABjIKjRmpSaL4cdRh1FEoyTdWzUcKqDiir3OscXsP7Sqeq6E24ah1j5c
	wlTJSw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hkup-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 13:44:33 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9692160501cso91999241.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782740672; x=1783345472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j32JpAQmHkv5QJI1PXFq4rNAG/oPOASevxwvwkrLR7k=;
        b=GHFU/p4oxdmVI26+0YIEUN5vqU+42rEzhjCAVMCn5gULr1whwu8ehRJXg/+RoriRyA
         CVtjkiNKNQFqwmT0mqnNWnxvdbJPUDN5Dqr3HidMunus06CQ9Vp6Z0vGH0iLkczmy0FZ
         XZ3calCb3lD81PIY/Mg2E/MyybhjFGosTmxpGNBjSlOGep6umvsJvke4uYPayz75vYfZ
         hoa+3YnBVA72Lf15BYtVbHymr5tHlinEJrpOSDw3ZhxP6AsA/ChvYmuDgAEuBR9KYYGh
         B7n0fckV0gBH2AaBiRI12VkXnwZvHW6pUb/tlVChi5s563jPmxlAu1SIXqB2G4rJpvhm
         K/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782740672; x=1783345472;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j32JpAQmHkv5QJI1PXFq4rNAG/oPOASevxwvwkrLR7k=;
        b=qd1LY5tVHUSrZeMKa046JFLi7ZmfZYDgN9GyCnYE43myGAcV31paZcC8ZJbnlUwL6/
         X15IvaHa/Y5Y9MlbfUaUQtQVpYbdNvuO0nWMar0xjOWDai/wcKYkYUB9wolr5DCXqqcC
         Nytf8/XyVNE02kEjEh3RrLQVUFceVOOkWZJGbeMt2A14KRwzBHA0tRp3lv2+c/JwP17/
         gx8AGoNVAV6yrMHa6JRtJYzDE9lSmdhPcjQDwidlOXCPLF+q+LsA1MNdvjwds1DALmqW
         6eC1O4d5+VXeeOYf8NiAoEtGtdsLfB3OwKXacOZjApK6bUwr8xV4/NJq5PK17dIx9pb/
         rEsg==
X-Forwarded-Encrypted: i=1; AHgh+RoZW5LD74+/WnAfCY5Gx7WzeekpJKOpAV+Pv8Se1lyiqOjH/IwhPTjakM/pWz/L+7pI8tKvkGzKpg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxocq9Jrjn9JPG29b1H7J31dYpvuakNVio2tNTbvT5D9EbV55qD
	tK/o6v3zxqNt8iMJroO9HFxyL4ewepklBSKgMbQwR9snzQu199ONrM6IUMxW0nsw5XCS/fwCZVG
	GvQ6YDesTaPr6soW9WxQZfxHL5SAv0JjaU51GOZ/8pAUlHqTCAObTnqtzGk6z7w==
X-Gm-Gg: AfdE7ckzrDWftCfPAIr6ZPgFr+GoVBuy7+WnhIDd/5qVxTVebLP7x7YNO69QnjokndL
	2rtOBZJK3+wMC07xC74r3Yp0YMzkZqg7F3WnWUiAFYQkoE5sZI+tmr65jxDi8H9YsNH3E3sijkX
	/T3MjNKqFNRowvP0Juf2XA23RpxP38O6JNKKd2+xFg6FmtL7GiLC/0S9oZ5/48oQJ3hWHXOQjNn
	BVbAJYmEQprN26SH9reRndhN587j0jg4a692T6IfVZ95I8EEzv3kX9vjd4m+TvgqcQJLFFlzN1g
	ArLnrlXF2OC3pdg2B94fYUc9c4bvBMeg0mCuVGjt34me2qG3r4BdxwQxDS3tAZGIwIQhF6F4Jt9
	oJ/9ttmgvHBuqhHWWb/tvhx58nQ+hbjpJCEc=
X-Received: by 2002:a05:6102:a4a:b0:738:b13a:c810 with SMTP id ada2fe7eead31-738b13af99bmr600892137.2.1782740672388;
        Mon, 29 Jun 2026 06:44:32 -0700 (PDT)
X-Received: by 2002:a05:6102:a4a:b0:738:b13a:c810 with SMTP id ada2fe7eead31-738b13af99bmr600879137.2.1782740671989;
        Mon, 29 Jun 2026 06:44:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm7047887a12.25.2026.06.29.06.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 06:44:30 -0700 (PDT)
Message-ID: <f280150f-f829-4425-a856-9ca9f7aca233@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 15:44:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] clk: implement sync_state support
To: Brian Masney <bmasney@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Xuyang Dong <dongxuyang@eswincomputing.com>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
 <20260626-clk-sync-state-v1-4-4156d8196dc8@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626-clk-sync-state-v1-4-4156d8196dc8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX3azb2beDll+c
 ax2RwhQN4ciSa044Bg6Wo2mu0A1Ux6e5qog6SfJNo4wgZPuhU50awRKO3Txdn0iYKRkdLFGpNn4
 2D8aVn/PHbWjtC/ZQkoW4BZC/epqkC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX9SX41d3ST4By
 2KsoqtuEeTMwLPfBGU+JJmRul3GTJynJG+ndsxP/gvlYndpy6K3uSUR09A1zcTk2XdvpJR3vxtP
 iXrXNXKpUrlE6KJKJcJaYb3OgojrwL0UnQAuOhZaUGCtk2I5y0EMcAmjZw5Y0Pj6KQ8NQFEFHhk
 7BA0VSs8tq5K0VlJFf+dqSVT9NO3T0eGLHj1ugDoiRtTYHEuz621OBzb3Xkq7z559ameJAupEq8
 ZRSdKbOySS0uDcyQ3DgWghWHXkrN5hFb6B/N0Im7dh84WmLWiaHNBCA6QDKH8bUtg7w0HbQ5rj9
 Wyd6d+B1DI6XwePJ2nshd/Xdts4Z0Aa4qwjAW/eFwbTEJxK/lFoqKWEWcXBkJy22lmpAO3uvm7e
 nav1dGxtu/RqN/DY0Jsu4UPZBwnxxbH48ytr87q2g1Eum3ofSq5gP1dYs3u8ZBLuqCOY/5/adGY
 fjU6WZ+7vaSlXPq7JJg==
X-Proofpoint-ORIG-GUID: DTHWBMQp_AMz1V7Q6osGtYvIiu4FwMwx
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a4276c1 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=xfjl8YcHD3-SeSKZoCwA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: DTHWBMQp_AMz1V7Q6osGtYvIiu4FwMwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114

On 6/26/26 6:32 PM, Brian Masney wrote:
> The existing support for disabling unused clks runs in the late initcall
> stage, and it has been known for a long time that this is broken since
> it runs too early in the boot up process. It doesn't work for kernel
> modules, and it also doesn't work if all of the consumers haven't fully
> probed yet. Folks have long recommended to boot certain platforms with
> clk_ignore_unused to work around issues with disabling unused clks.

[...]

>     [    0.366737] clk: Disabling unused clocks not associated with a device
>     [    0.367232] PM: genpd: Disabling unused power domains
>     [    7.791413] qcom-qmp-pcie-phy 1c24000.phy: clk: Disabling unused clocks
>     [    7.799702] qcom_aoss_qmp c300000.power-management: clk: Disabling unused clocks
>     [    8.548820] qcom-qmp-pcie-phy 1c14000.phy: clk: Disabling unused clocks
>     [    9.121849] qcom-qmp-usb-phy 88f1000.phy: clk: Disabling unused clocks
>     [    9.121985] qcom-qmp-usb-phy 88ef000.phy: clk: Disabling unused clocks
>     [    9.122691] qcom-edp-phy aec5a00.phy: clk: Disabling unused clocks

Many of these drivers only register fixed "virtual" clocks that
don't lead to any registers being altered and only exist to convey
what the clocks look like on the hw level.. but I don't think we
have great infra to skip that..

>     [    9.122760] disp_cc-sc8280xp af00000.clock-controller: clk: Disabling unused clocks
>     [    9.142121] qcom-qmp-combo-phy 88eb000.phy: clk: Disabling unused clocks
>     [    9.169149] qcom-qmp-combo-phy 8903000.phy: clk: Disabling unused clocks
>     [   16.057997] qcom-cpufreq-hw 18591000.cpufreq: clk: Disabling unused clocks
>     [   16.058149] clk-rpmh 18200000.rsc:clock-controller: clk: Disabling unused clocks
>     [   16.334879] qcom-qmp-pcie-phy 1c06000.phy: clk: Disabling unused clocks
>     [   16.706113] camcc-sc8280xp ad00000.clock-controller: clk: Disabling unused clocks
>     [   21.565731] q6prm-lpass-clock 3000000.remoteproc:glink-edge:gpr:service@2:clock-controller: clk: Disabling unused clocks
>     [   21.597069] va_macro 3370000.codec: clk: Disabling unused clocks
>     [   21.605039] rx_macro 3200000.rxmacro: clk: Disabling unused clocks
>     [   21.630313] wsa_macro 3240000.codec: clk: Disabling unused clocks
>     [   21.635069] tx_macro 3220000.txmacro: clk: Disabling unused clocks

This is a bit noisy, but then it's necessary for debugging the
related hangs. Maybe if it turns out to be a huge issue, we can
hide it behind a _dbg() in the future.

I was hoping/expecting that sync_state would completely replace the
late initcall (which would also simplify this diff), but I'm surprised
to learn that there's a whole bunch of clk_register(dev=NULL)
calls in the kernel (are most of them doing it for no good reason
by chance?)

Konrad
