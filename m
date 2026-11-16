Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794861195;
	b=0VUomL1SEcrgZmNeUsT6HUYQmmJg7efKU6OnGOzbZYINifWO4uDvNNudQA5WY8e5RTrf
	 L3D5K5KZyK3OwBsHntUZQ7jFLafRH6QLmEPb3M/V+8Wj6pUbH8ks1/RNKTgE2m4Nnxn55
	 jlIqMKUXM59zjPcL1RJeajpaXFjpKd8kwDxUSZwd9QlEEV18Z4ey7amLBqbWMayROxjal
	 oU3H3hctwbvefubwQNLcUGmkSoi+XOxaNIY79XpcyxUNB0oro8fWevxy4PdHVKKLb/rhe
	 q7WbgpuO+TCZisXpmYRx3TeRYeT5tUPRHKluu+6fVzoclMF+NwSvN3BkwSwW7ya+R5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861195;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=y+SUElrzxvUX/tlMt9vFq6/5XavJz4wfY7YhEZN5OZE=;
	b=A4x0NkhVPAXRl7lnGSpbtuiu+uTao7aYwiZInoPhgBjBnm1rB661Il2eDqQVRYPi/lxL
	 Ji27vWlZqxelmOUD6puEM74gWLjuqoWc6wwE5aaO97Qlsb/8f9BplNi3NBRv6sgWtpC+u
	 50fCrN1IAwEOY+g7Mk6yFykswVcfOme+QL2elZKT0BvQGkI+d/eXCcZ0sG4mLrjPObwjp
	 tKHtBW3jY7/NBigqgJ6KcT68F0KZvSy/5uorAcWyR0ruxlQO90xtgO1HXFIKDVJ6vJbdB
	 b5jb0/Whu8OMz8ljGZuR7DYx0yIcM6Pn1rrA0hHznLxLrnct8VRpO4va0wMJWM562ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="SkSD/q+f";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ozdro5XA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04742606A322
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 20:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04742606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SkSD/q+f;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ozdro5XA
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJfJin3248636
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 20:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y+SUElrzxvUX/tlMt9vFq6/5XavJz4wfY7YhEZN5OZE=; b=SkSD/q+fupfJ4Ppw
	YRw6HQraaNMZjkAZ69W1OtzvlaXezRYxYZsCDMuPfUDIbsRytrO3YGWkenWQ03aM
	fatWX2ccU5R4eimHEDCSv8hpj65njnQibChz2M7ANvLJlzsg9kYwVRzSnux7aNUB
	mOpokAedWv3Wa8LGpSJQS2jsuulxjqvG9+pryw8BsUa4552n3H6b9NF9gZ6yfSDq
	/6rmJdHMe2nkstOw1XBn0AdRPPBDhiwPGEFcs+JeHLo142u0901OazFwERSaih6p
	iBwK5ixLc8x++NETpfUa3Tcdai2TKHssIZ5xYG657BomyQNT+sunB+0rZcAVJvo7
	5UFX0A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j00nfj83p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 20:33:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f33438950so307945685a.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 12:33:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794861193; cv=none;
        d=google.com; s=arc-20260327;
        b=sXDkvH7IE+wCRRdXlSMeQNRWWKCAiFqATzDTMvY6nDysJyF2Kk+dM4cMSrFuGvluUt
         bBwCANQtl8J0Pf2TYIJLAAGpQst/9eoUhVrGMCXFRV4dT5+9r96nrjPcSEmVB8em2aTl
         C3JJpN5nDkZbgMu7m6V+NcgnY1pV9dEmz3qccNXQA+PVyVbYnCwIpPKwHbKUe/I+xSl6
         Xie2oppTO7mSMJkE+2RfYX3DckAIXDQJNzCKBApJJWDkVrizC5SIaKGTgdOUiRDaW3GX
         JefUnSRJknwopoi45MVJ8svJq2U9YFL0J0V+lfkfLi19f9VhFjPwTUnoLA1Km1CJYy96
         1I6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y+SUElrzxvUX/tlMt9vFq6/5XavJz4wfY7YhEZN5OZE=;
        fh=lEF8iI1/brpUvTzoYIUays7GiYuHp32HnIrTKFjvnsU=;
        b=P16NBMYZMXo2zQUonVbCDnG0bUA7JUaOs/4IFjLbNb4xqq5hyMnhk3IQL//9Gc4b12
         5sYFI2UWhIJ/xJMidfcdytdEqqgeR+Lex+ndX/PoWPCIgXh4+CAonq2wCaylmO/zZBpv
         qfvCYkZ/wWxG005+GWGlFll9qzT289h1ZME2ODOocfi+7JVyqMp7x0D/vyYWFB6B3Q5l
         0VarGDCq7q9a9FAF0fePxoceAVMhrvAzcEOlXw1GxeNIFu+wuruAG+L+9HdtvdRh2Eef
         whDq0HtO7dLUF6o7TdZ52YTRlt7zp/mGJZuIbdAfQX5j+pT5WK14HTUDvjalUv2bbCh/
         4McQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794861193; x=1795465993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y+SUElrzxvUX/tlMt9vFq6/5XavJz4wfY7YhEZN5OZE=;
        b=Ozdro5XAR0xy+MdNdyCYVAIStBsCE6zBC+OaH2PMmtyoMhGRzmj1qLcpkor0xM3hbL
         RicGMb/Ht62mhJ89pUquVvnR3HJER9l0XT1fPXCCiTfVzH+sFbh8D4mz7bJiEKjC1u3v
         nlH1oBJOvuSZFX2ptfFtXPEYp/b2MaFM3KKeMhlSNUNKr06A6im5vF64ZKorM8rwU14R
         3t/EqotDGwwQ6XSc447aE3HW4hBuQt+Vq2Ayy6rSViC7MmXmK1eLMvaoOZRM4Xi3Wbo4
         WVvWsvisgCt521EoYlHMS1DH0Huzm4NHk74MY3yfJjxPJAvRrdpYrV9GfclX8kXhUpmc
         vYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794861193; x=1795465993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+SUElrzxvUX/tlMt9vFq6/5XavJz4wfY7YhEZN5OZE=;
        b=EAgMr2p/XplThtD/5X+bGIF5vuXbzxvtvoeNE+UfjinO8e/6wLsymqhrhqNUZwWrpx
         VtS3dFh5AmSJNiwOOP/+L2/gHUQWou7HzcZxCNGxiQyiHRloZu9Cvhr7F2FD1F7WoJKc
         vFC/8BFTa05L7aptDUV4A6EKgRgOCoshuUjMqvq7j67cUgoVKN2Ry0TTmpx77jWK7NA0
         msy3Z3ope4HH0JZ8pISKqPNf84HId/hWSHp1GMTH3EH2XQJJFEKWslC3ZV1zgnyYgzU+
         /hGpDqJLM5VENwR4d4vMaSMGoGhZ+yY0pQ58z6B/g7HuxwQ/Le+/34PZzX2jveJqfzVW
         GYvQ==
X-Forwarded-Encrypted: i=1; AL+hErHoQ0iq7YbVV0G5yUSFffQDCPV3lstLNl8DDN9xAs3VRJU/HXjlUMIdkpMYQpbTHLx3XaDbshqU2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+aLUGnegBLeYiwolQB95fRdbV0FvTWXfvLdmiY4+0ismEmXfdq
	gT3M4HCjvg0cQW05CCfVAqLDH6AqSKeQywBHSQABMR/+j+1WLiVhApRQ2yGXEh4kNL2x0oMffxE
	RQTGMMXlvo038QOe0lUSjKI7PWlMTX7DsElLKBqOtWNb28n6+eWgxARUX1WRCzaHwPD4qNFRwoK
	j/P0QMz4lsej5XN2U41XFSsk3Z5FvWueF4xJAE
X-Gm-Gg: AYBFou0xIMHZ3MUOzXyFXS/HLRjZEbShE7dcTUwAzsYmKB1aCRB9DCdaI4iCmXr1nKe
	K1toZveH1Tu/YFaKh0DusuXNYjmHa0w0Co98AmUPTMS3mxzjgp/RBn2ybfikK52AoDf9gFU+V7d
	rjCEvkgnN5VKBrjJ4CukrlmHN5WjE3JyVZrVRNjMiRmM8u7C7HDa3jjIm4pfkFA0QscsgUtcSNH
	MQ5mXbnnyc6eiEW+XP4rPKLUw8/B8i5JpYkCoCdyedpfog/1Be0YLPpPxKso4flzaHMUdCcpc7q
X-Received: by 2002:a05:620a:2a06:b0:93e:b0c3:388d with SMTP id af79cd13be357-9494b9432demr1970459085a.11.1794861193135;
        Mon, 16 Nov 2026 12:33:13 -0800 (PST)
X-Received: by 2002:a05:620a:2a06:b0:93e:b0c3:388d with SMTP id
 af79cd13be357-9494b9432demr1970455785a.11.1794861192628; Mon, 16 Nov 2026
 12:33:12 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109051007.371843-1-daniel@quora.org>
In-Reply-To: <20261109051007.371843-1-daniel@quora.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 21:33:01 +0100
X-Gm-Features: AclHuK8LqAoYko6jfkEOWyP90pkG5Tye_Ye7sfmCxHmUMdYEwzinH0ptz0c_bbg
Message-ID: <CAFEp6-1zzzaHUL45qr-M+JdjL9rh2Bq5Nb3-GrHhv6kHrk2m2w@mail.gmail.com>
Subject: Re: [PATCH] PM: clk: Fix false-positive recursive PM clock mutex locking
To: Daniel J Blueman <daniel@quora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>,
        Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BrEIUoX5 c=1 sm=1 tr=0 ts=6afb6889 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=t9ty7G3lAAAA:8 a=oDK9j7WA2MVx4Ty_S2oA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MSBTYWx0ZWRfX9Uj5y2AhCiEf
 TSbW1tzdRR1MtDYtvXCpx04srXt760V0X0wM7fwZcYn1hx3728p1mDhI3DPFoWI8RsBCOrAQrv1
 3i0BWHGrvjPUJbPzAoJT6O4oJsd4EFM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MSBTYWx0ZWRfXwEvLyFlxm1kO
 xqEnNltDYNzPuFMnYBKKBvDKRHAMzYUmIDW/hPvFXwPGBiJnanLg312FiSx3b9FURH7lbZoSjf9
 cUfC5V5f+OGfholHlE8GXizi8b2bWkDnA65eOgONhvGYef1Tqbe3jVW9GTVx0RbFr5lxo1QKK4z
 nr8fRKRoliWs25NKjzptePl1W5NGCj6a1mwgeqeMcVkO6qvvBUFAOnsJcugdKk1cA5Z1x9t0Fb9
 buNploJ7ZM4btEyAfA2bXDKBwyAAbgCic1IcK7/uYbFkjdjpbW9NTik9o9AoQtv2r2XRevy71vv
 dQ3GxFxkrrNEUa+Ww9eF42znI/Dl86SoXT0bBYhzAr+VLJB82WzDkAJeChhTeQA2F1NnY9HLxg+
 MRtHz2jjaS/aKU/LEXxZiDiUZm2Y80VyE1B1fxRaHPh1oj3g+CRRkX230uYSgE57ZodltWKtkCf
 hS6nVtwhBY7W3wPuVEw==
X-Proofpoint-ORIG-GUID: WKR2nHeUKN609Cv6YTXeHvc0I6CPHxci
X-Proofpoint-GUID: WKR2nHeUKN609Cv6YTXeHvc0I6CPHxci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160081

On Mon, Nov 9, 2026 at 6:41=E2=80=AFAM Daniel J Blueman <daniel@quora.org> =
wrote:
>
> pm_clk_suspend() and pm_clk_resume() hold psd->clock_mutex across
> clk_prepare() and clk_unprepare() for sleeping clocks, with every instanc=
e
> sharing one lockdep class. If a PM clock is provided by a device that als=
o
> uses PM clocks, clk_prepare() resumes the provider, which takes its own
> clock mutex, triggering a lockdep report.
>
> This shows up on the Qualcomm X1 with the LPASS WSA/RX/TX macros and the
> varargs macro providing the "fsgen" clock:
>
>   WARNING: possible recursive locking detected
>   ...
>    pm_clk_resume
>    va_macro_runtime_resume [snd_soc_lpass_va_macro]
>    ...
>    clk_prepare
>    pm_clk_resume
>    wsa_macro_runtime_resume [snd_soc_lpass_wsa_macro]
>
> Lock ordering is always consumer -> provider, so this is false-positive,
> resulting in lockdep being turned off.
>
> Fix this by giving each pm_clk_create()/devm_pm_clk_create() call site it=
s
> own lock class.
>
> Scenario analysis and patch development was assisted by Claude Opus 5.5
> under my instruction; detection and validation was performed on my Lenovo
> Slim 7x with a X1E80100.
>
> Fixes: eb667d0fbdd3 ("ASoC: codecs: lpass-va-macro: Switch to PM clock fr=
amework for runtime PM")
> Signed-off-by: Daniel J Blueman <daniel@quora.org>

Assuming we agree that using separate lock classes is the right
approach here, and that using nested locking is not practical in this
case, then the overall solution looks reasonable to me. I only have a
few suggestions below:

> ---
>  drivers/base/power/clock_ops.c | 23 ++++++++++++++++-------
>  include/linux/pm_clock.h       | 19 +++++++++++++++++--
>  2 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_op=
s.c
> index 3b8ba27802a8..94f2aa090ce1 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -398,17 +398,26 @@ void pm_clk_init(struct device *dev)
>  EXPORT_SYMBOL_GPL(pm_clk_init);
>
>  /**
> - * pm_clk_create - Create and initialize a device's list of PM clocks.
> + * __pm_clk_create - Create and initialize a device's list of PM clocks.
>   * @dev: Device to create and initialize the list of PM clocks for.
> + * @key: Lockdep class key for the clock mutex.
>   *
>   * Allocate a struct pm_subsys_data object, initialize its lock and cloc=
k_list
>   * members and make the @dev's power.subsys_data field point to it.
>   */
> -int pm_clk_create(struct device *dev)
> +int __pm_clk_create(struct device *dev, struct lock_class_key *key)
>  {
> -       return dev_pm_get_subsys_data(dev);
> +       int ret;
> +
> +       ret =3D dev_pm_get_subsys_data(dev);
> +       if (ret)
> +               return ret;
> +
> +       lockdep_set_class_and_name(&dev_to_psd(dev)->clock_mutex, key,
> +                                  "&psd->clock_mutex");

You could simply use lockdep_set_class() and avoid introducing the
somewhat unusual &psd->clock_mutex name. If a custom name is desired,
something like "pm_clock_mutex" would be more descriptive.

It would also be helpful to add an inline comment explaining why a
per-call-site lock class is required here, and why the
consumer->provider locking order is guaranteed, since the whole
approach relies on that assumption to justify splitting the lock
classes.


> +       return 0;
>  }
> -EXPORT_SYMBOL_GPL(pm_clk_create);
> +EXPORT_SYMBOL_GPL(__pm_clk_create);
>
>  /**
>   * pm_clk_destroy - Destroy a device's list of power management clocks.
> @@ -451,17 +460,17 @@ static void pm_clk_destroy_action(void *data)
>         pm_clk_destroy(data);
>  }
>
> -int devm_pm_clk_create(struct device *dev)
> +int __devm_pm_clk_create(struct device *dev, struct lock_class_key *key)
>  {
>         int ret;
>
> -       ret =3D pm_clk_create(dev);
> +       ret =3D __pm_clk_create(dev, key);
>         if (ret)
>                 return ret;
>
>         return devm_add_action_or_reset(dev, pm_clk_destroy_action, dev);
>  }
> -EXPORT_SYMBOL_GPL(devm_pm_clk_create);
> +EXPORT_SYMBOL_GPL(__devm_pm_clk_create);
>
>  /**
>   * pm_clk_suspend - Disable clocks in a device's PM clock list.
> diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
> index c3b46fa358d3..d54681547f58 100644
> --- a/include/linux/pm_clock.h
> +++ b/include/linux/pm_clock.h
> @@ -37,7 +37,7 @@ static inline bool pm_clk_no_clocks(struct device *dev)
>  }
>
>  extern void pm_clk_init(struct device *dev);
> -extern int pm_clk_create(struct device *dev);
> +extern int __pm_clk_create(struct device *dev, struct lock_class_key *ke=
y);
>  extern void pm_clk_destroy(struct device *dev);
>  extern int pm_clk_add(struct device *dev, const char *con_id);
>  extern int pm_clk_add_clk(struct device *dev, struct clk *clk);
> @@ -45,7 +45,22 @@ extern int of_pm_clk_add_clks(struct device *dev);
>  extern void pm_clk_remove_clk(struct device *dev, struct clk *clk);
>  extern int pm_clk_suspend(struct device *dev);
>  extern int pm_clk_resume(struct device *dev);
> -extern int devm_pm_clk_create(struct device *dev);
> +extern int __devm_pm_clk_create(struct device *dev, struct lock_class_ke=
y *key);
> +
> +/* Per-call-site lockdep class, as clock mutexes of different devices ne=
st */
> +#define pm_clk_create(dev)                                             \
> +({                                                                     \
> +       static struct lock_class_key __key;                             \
> +                                                                       \
> +       __pm_clk_create(dev, &__key);                                   \
> +})
> +
> +#define devm_pm_clk_create(dev)                                         =
       \
> +({                                                                     \
> +       static struct lock_class_key __key;                             \
> +                                                                       \
> +       __devm_pm_clk_create(dev, &__key);                              \
> +})
>  #else
>  static inline bool pm_clk_no_clocks(struct device *dev)
>  {
> --
> 2.55.0
>
>
