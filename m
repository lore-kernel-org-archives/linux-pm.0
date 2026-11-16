Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794854268;
	b=qiBKcMnC7l9sLgfoAbGEzzU5VBLrbCybPVJa/GGoroUICKauQ9YbXCCXt02iX+9axbNb
	 BUA6mxQbBIVY7FBkfRKN2B/+rr1072kWxfWlGvR9vabvO4hZru2b6r9TxL4yOr320nJJm
	 DRIxsp01mrkrMVSI4peCtcSAbllXt9llKTogr9y/sdZB5RRoGjSzic0fDTzDU5A/7KDbV
	 FaH+GJCL59tO2UIOvd9T/+B1sc1Lq1sf6E3ur5hZ17lARt0WTmAG5SwHv6AtdcOibymUC
	 zZj8QINANJG59dYryzb3TcpB9a4MJy0gJ61CmvHOVph2nzM7TOsEp9ORJfU5XdJjlKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854268;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ly0wSpOqETq67pj9QgQqaNP7QubSpXxkzzUxAFz3ui8=;
	b=QfG3Tfzl6ga2kU6pWFNLGjKPBqoWzeLUXx7hV+n3X680G9zfhGMW70NHz8dEtUKpjwf6
	 QPUkpriEcJEGNsaR1v1/GnnkaABPrm/9800RHy3j7LFGBNXMJ2rEfSgurvK4mQdZkjaQQ
	 0hjnMuCovPR47RRO+jBv+Yx62mMAv+sIigrWJNKSS2IUFu7BUWlM34wcslGBl1q5slVkF
	 GVsZfDcXObrWItZbs4LQ24zjQnUqWjxAt1b7EUUkxO2/OVVQDonsH4oXhO95cvd06nd6P
	 VOARjS7TR65tTqhP6Br5hQpIfe54YJ2OluZGaCtLbWr9br2siz9LLtHJaU4M2csonyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OqT3NYpP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FGHtMx61;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE95606A322
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 18:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AE95606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OqT3NYpP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FGHtMx61
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIeEX2055797
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 18:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ly0wSpOqETq67pj9QgQqaNP7QubSpXxkzzUxAFz3ui8=; b=OqT3NYpPMSWyNkoC
	T0jU1MWCwoayrXSsHrUPBONXfgqAYtHpimmXXc8u1ZVZdF548egHztbTNmT85olL
	2T/sThe5L7xH4V5dFkizBXkH0f32jZ1egUeaMGiHqXqS2zfgpiCopGrOmPm5Bz7r
	tlIWpaai/x4fvD0utZIEYuJVungkk8BPlrSPvchKJrplzwjYFkeoGUieZRQIBI9Q
	40KsMkT4PGroZwzOQZlbI58vK2HMhcQojkLzDr40iZ+GEP0h7oD6rmwAC2mfpGUq
	rtTuPNtRLW6i9e+1QoEzwxHF+XadsCGLPTluN0ttmkZGKyM/Oh1ZJvOKzvbEztlg
	l5hrWw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqhyct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 18:37:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-944138ed63fso579415685a.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:37:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794854265; cv=none;
        d=google.com; s=arc-20260327;
        b=iouuoTo8uVlU/Cr/uwhugsXklvvL7JlNXSYIXrE5xjpZYMUGAyv0HnBebZWCP2350r
         Dj8LD8u80yRFN9F5gul1mwTPKjWAjYrgus7VS7einaf6A66Kz9SA0ah5M+rsC7PKE1Vn
         8Um2DzIPmFOInTdHdQjZQhuW5zgXWeAAznG2+Dt6ZA4/uehnF65BF339gQ/tooK2WtD+
         6fsB5+MTddeorJXooaCpJXtGyTY9qy5iTvSh6boiSOIMjIvO1y0If+WSrC/S3fiyS9yA
         oNxttEes4ppim8OfuSDKXzKySLK8BEbASRP3Ah4WTGIrB9LrQ16dBQQv5wU4F/DAqxTa
         njkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ly0wSpOqETq67pj9QgQqaNP7QubSpXxkzzUxAFz3ui8=;
        fh=z2EuP4nOMcIRdv3gDNWZaqTG1cA2hUjmF9FTALNeLzo=;
        b=PXtucTr4gCrrUxw9V9USftf4tkkp+QtjOHTQzNT1gL0Fkh7lr7QEgz+UWSEZUsXac5
         sZ54gIaBKP4+l179GcsRQCz2QkVM4b4gbTe8zAQ/nMemuQ32pDqkm/OjnboJEaBpJGBn
         yqWd5dux8WITL/t/zp5ODNe5UxNBWHqswMqIwIgXHER+JaIJkB1NaN3WvwyrCflPIDSF
         FFdqeRY8xl9lSaYL5tGa9EE6Xf/SrFA483f7sODL4f6L4rYLj4tIlmD/eDprjdPFI1Zg
         a++tCl9G0uRjmdJtqva6Xi6Y0cnvO1T9iQrfhGu8otZXgsvNucgTyXW0s3lanWp4WwGO
         z9+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794854265; x=1795459065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ly0wSpOqETq67pj9QgQqaNP7QubSpXxkzzUxAFz3ui8=;
        b=FGHtMx615S6WKXiU0sxjpk3GpFHkE+SxjYQmKQRpwu0wiYtIPHAVWaTcmTWnNoS9nk
         4AF+fCD5GubW4ayYURUBZGVXNAzjAOMlSK3odHhsjfUb4XyjsGKHlWHMRHMvYyLquGSg
         P617WGvbukts6GcMuFR1ZRZM3fbSipeM8MKlPRy/mXFfxUhWqBZpt1oeqrZPwsG7o6+i
         Tvp01JTRjjRtdJmvMp0O4w+3NAaBIL6uSGyvDCSo0p4/c3b8lFz9mUwXyZo6SJm/iTx8
         zmMrInOQXr9toZhPav/kUAw+BlVe307j64uVR6RlqVnnGc/wYyF2C3iTGNiZRQB8jLg3
         4LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854265; x=1795459065;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ly0wSpOqETq67pj9QgQqaNP7QubSpXxkzzUxAFz3ui8=;
        b=1BCWpWSoMk3JFWnz/ulIddYFdJqNNiXwdwLrngCQaVIDcdxJ5PJOV6FWuAyjQRv9PO
         3PrdAeZV4FK7V06VMRxBxKTRBrE3HktupyToGtQrAypF4QK2cWd0KZcQD1y1tyKBUSQ3
         VEXGk4lug7R+xvbhqDBYDDD0MY1WspHbS4ac9IfHSUfE0IWxemylmeSbuH0kT7jifkhl
         ouI2vnX/fVO5Lm8iGmTz7b4Q5H8OIbb3L0+hMBNdBJZmXc+XC1DlfhCIce68p4YNAncy
         poIoM86OZtXEsRy4BUhCRUP9xVg5d06MOFLzTIDUwJsXvfLuJ6Rym6FvFx+66baFWoYr
         hmYw==
X-Forwarded-Encrypted: i=1; AL+hErFJxbTV+AznIlXgFUl1kBdyg472oQ/ngYyyH8EdTRb+ILxRLB0v87G/rjoJKtFbbIQHr2Eaa17VUQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Lp9AfFlST6fzVJ+GAcOTwcER4HTqW2jdbNbnvfMolcmhPbkNU
	U+/P61+ZHrPxoRrFknOCBQfz+Yyh1XcX0+zXNox0MK5WEyLCqsAie+cB6BhS25PzwCuLmbGRrCQ
	frGSc/OWcCp9GJUwOu1T4ItxtcLcCFgtV1s3fEPiVZZchR+LJvdftkyIONf98XWAH4MyvbFk/1u
	ums/5QehlX6SIpd6smtLR0tNuPD588ujhei/hM9nVDqjuUbmM=
X-Gm-Gg: AYBFou16+GqjodViRFCmeLks7r00w+Mo2rQZ5kD9asN+XmRD93XkquFgKVzUYFNHj58
	18Ma9BLN4lfxbB4DjD0djZlhFe11ialvC7b6NR3S8CsyLnCfu2BF+/31hxbIKrWTWoB7JLbxhrO
	buH5N4PabVcFeqaI2D/WoJgZ6Qfe3WPGy6XlY9KWil9idgtXhA7zpokzmW/eMCEmy7haJvFN10a
	KVF6Ap1wSCu3HUz2ft1KLGwiETbPMrWI0b5RzZ3/6WrX8rYjygD60oPrBklINTazrnDt/mQynlq
X-Received: by 2002:a05:620a:6910:b0:949:6476:91df with SMTP id af79cd13be357-94964769908mr1306133985a.27.1794854265120;
        Mon, 16 Nov 2026 10:37:45 -0800 (PST)
X-Received: by 2002:a05:620a:6910:b0:949:6476:91df with SMTP id
 af79cd13be357-94964769908mr1306128585a.27.1794854264515; Mon, 16 Nov 2026
 10:37:44 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-pm-clk-resume-report-errors-v1-1-ba6e1dddd522@oss.qualcomm.com>
In-Reply-To: <20261102-pm-clk-resume-report-errors-v1-1-ba6e1dddd522@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 19:37:33 +0100
X-Gm-Features: AclHuK-5A642jlfrsRiFikZwKptRymZe-s-kt3fOZysrAU132IAw9jKbio5jyXg
Message-ID: <CAFEp6-3GKHmc4y_mTTVMO6iPdnpmxEmRokpki4uVGoBuXTj6Hg@mail.gmail.com>
Subject: Re: [PATCH] PM: clk: Report clock enable failures from pm_clk_resume()
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afb4d7a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=-LQT69PtjwrO-PJxn2MA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: SXKd2aWj1u714GmmIQ3w9Uz8Q_2cCBJ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA3NCBTYWx0ZWRfX9bUb6jYXsCo+
 8nMmKRMlg7aiVDhyCXW1Cxs+eRTD+GiMjDuyPwEc8ryuZGotd9/3nOtJWk13CA+23SR0PgW5+Ft
 ZUhI5gUqxjfMuhUcshKVBkAnDEyWA3wrwbP2HsLhSUizcJgPdACfIBiZ0r3nVcms9sTooXS2oCO
 G5tdPKr619Eq5f1G2URCGtbwmo4uzASEsRkM55nhkj5sraoNWzSdFs5fcB8PzcSH9ph9g6IiO/b
 tInf7bpLfhuW21tI0E/L5xgwx35GSaHiRsHhRjP/1UgZ03U9RNBlpsqdH6b9EoTy8EJ7MN9dgRG
 upPOEYq32oRQh8lkT9WnwQXrJyWks2yBZklM0pId2hVjG+jy9RmWjn2is+ZpKBqthMuNCARlwyZ
 gd+hoROOclh8SCtUsDKNosTXDVYy6TJ9ZBWLT0jzl5gcuyV2QLVVMiY/eiJowhHibCnL0loYBnJ
 YFtQIJRswRXbmVb445A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA3NCBTYWx0ZWRfXwoOT9IbKIKWK
 xygEG/N2O7H1EarcmXeyTDwobpDXDN1U3qmSszVX71BDgdNLREHXktzUbzC71sk3OnC2qrLqshu
 cqXD/g3UfYgZo0IewfZL6cSAPUg6Chc=
X-Proofpoint-GUID: SXKd2aWj1u714GmmIQ3w9Uz8Q_2cCBJ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160074

On Mon, Nov 2, 2026 at 11:23=E2=80=AFAM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> pm_clk_resume() logs a clock that fails to start but always returns
> success, so the runtime resume of a device using the PM clock helpers
> succeeds without its clocks, and its driver goes on and accesses the
> hardware.
>
> This happens to the devices in the Qualcomm LPASS, whose clocks are
> provided by the ADSP: after the ADSP is gone, like right after a
> hibernation image is restored, a sound card opened by user space
> resumes the LPASS LPI pin controller without clocks, and the access to
> its registers then brings the whole machine down:
>
>   qcom-prm gprsvc:service:2:2: CMD timeout for [100100f] opcode
>   qcom-sm8550-lpass-lpi-pinctrl 6e80000.pinctrl: __pm_clk_enable: failed =
to enable clk 00000000b90a5151, error -110
>
> Stop at the first clock that fails to start, stop the ones started
> before it, and return the error, so that the resume fails and the
> device stays suspended with its clocks off.
>
> The callers of pm_clk_resume() check what it returns, including genpd
> and pm_clk_runtime_resume(), except the MMP2 audio clock controller,
> which keeps ignoring it. A device with a clock that fails to start no
> longer resumes though, even if it used to work without that clock.
>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> pm_clk_resume() always returns success, even when a clock fails to
> start, so a device using the PM clock helpers resumes without its clocks
> and its driver goes on accessing the hardware.
>
> I hit this on the Qualcomm Hamoa CRD while working on hibernation: the LP=
ASS
> devices get their clocks from the ADSP, and when the ADSP is gone, like
> right after a hibernation image is restored, a sound card opened by user
> space resumes the LPASS LPI pin controller without clocks and the whole
> machine resets on the first register access. With this patch, the
> resume fails, the open fails, and the machine stays up until the ADSP is
> restarted.
>
> The LPASS macro drivers already check what pm_clk_resume() returns, but
> never saw an error so far.
>
> Prepared with help from an LLM-based assistant.
> ---
>  drivers/base/power/clock_ops.c | 56 ++++++++++++++++++++++++++++++------=
------
>  1 file changed, 40 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_op=
s.c
> index 3b8ba27802a8..a978eb3d5479 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -143,8 +143,10 @@ static void pm_clk_op_unlock(struct pm_subsys_data *=
psd, unsigned long *flags)
>   * __pm_clk_enable - Enable a clock, reporting any errors
>   * @dev: The device for the given clock
>   * @ce: PM clock entry corresponding to the clock.
> + *
> + * Return: 0 on success or the error from enabling the clock.
>   */
> -static inline void __pm_clk_enable(struct device *dev, struct pm_clock_e=
ntry *ce)
> +static inline int __pm_clk_enable(struct device *dev, struct pm_clock_en=
try *ce)
>  {
>         int ret;
>
> @@ -156,13 +158,29 @@ static inline void __pm_clk_enable(struct device *d=
ev, struct pm_clock_entry *ce
>                 ret =3D clk_enable(ce->clk);
>                 break;
>         default:
> -               return;
> +               return 0;
>         }
>         if (!ret)
>                 ce->status =3D PCE_STATUS_ENABLED;
>         else
>                 dev_err(dev, "%s: failed to enable clk %p, error %d\n",
>                         __func__, ce->clk, ret);
> +
> +       return ret;
> +}
> +
> +static inline void __pm_clk_disable(struct pm_clock_entry *ce)
> +{
> +       if (ce->status !=3D PCE_STATUS_ENABLED)
> +               return;
> +
> +       if (ce->enabled_when_prepared) {
> +               clk_disable_unprepare(ce->clk);
> +               ce->status =3D PCE_STATUS_ACQUIRED;
> +       } else {
> +               clk_disable(ce->clk);
> +               ce->status =3D PCE_STATUS_PREPARED;
> +       }
>  }
>
>  /**
> @@ -483,17 +501,8 @@ int pm_clk_suspend(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       list_for_each_entry_reverse(ce, &psd->clock_list, node) {
> -               if (ce->status =3D=3D PCE_STATUS_ENABLED) {
> -                       if (ce->enabled_when_prepared) {
> -                               clk_disable_unprepare(ce->clk);
> -                               ce->status =3D PCE_STATUS_ACQUIRED;
> -                       } else {
> -                               clk_disable(ce->clk);
> -                               ce->status =3D PCE_STATUS_PREPARED;
> -                       }
> -               }
> -       }
> +       list_for_each_entry_reverse(ce, &psd->clock_list, node)
> +               __pm_clk_disable(ce);
>
>         pm_clk_op_unlock(psd, &flags);
>
> @@ -504,6 +513,9 @@ EXPORT_SYMBOL_GPL(pm_clk_suspend);
>  /**
>   * pm_clk_resume - Enable clocks in a device's PM clock list.
>   * @dev: Device to enable the clocks for.
> + *
> + * Return: 0 on success or a negative error code. If a clock fails to st=
art,
> + * the clocks started before it are stopped again.
>   */
>  int pm_clk_resume(struct device *dev)
>  {
> @@ -521,12 +533,24 @@ int pm_clk_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       list_for_each_entry(ce, &psd->clock_list, node)
> -               __pm_clk_enable(dev, ce);
> +       list_for_each_entry(ce, &psd->clock_list, node) {
> +               ret =3D __pm_clk_enable(dev, ce);
> +               if (ret)
> +                       break;
> +       }
> +
> +       /*
> +        * A device whose clocks are not running cannot be accessed. Do n=
ot
> +        * pretend it resumed, and leave its clocks off as it stays suspe=
nded.
> +        */
> +       if (ret) {
> +               list_for_each_entry_continue_reverse(ce, &psd->clock_list=
, node)
> +                       __pm_clk_disable(ce);
> +       }
>
>         pm_clk_op_unlock(psd, &flags);
>
> -       return 0;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(pm_clk_resume);
>
>
> ---
> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
> change-id: 20261029-pm-clk-resume-report-errors-b5d538eb27de
>
> Best regards,
> --
>
> Abel
>
>
