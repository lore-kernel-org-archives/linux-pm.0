Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D53A2576
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558299; cv=none; b=CKhTVdc9oYdHxNfxOjw9elA2igAqfORq49/tRiCjUWddWERDOaUPH5IkBIfP8TglfYILk7085MpFu7AwXqOjE9l+GW8d/ZgihP9uTr9XEeiUOoBcM+jJC8OMwI4ECwUlQYP0xHNlv8J5xlq6S+5Ui2dEUTps/Db3zVoLh8dQRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558299; c=relaxed/simple;
	bh=7w/Cop/8rNMh5YXb1tw3zR8IZlpF/K6B4/PsyH/OZpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqBNc7A/Z+mw2lpKz0SWX7Sn/UsMEEkcjYEfdf3G9l9SQ34QcOM3jM7LFx3KAcTKKM5bP946Fv7JwH45a9O8ilFprtZlS0I6B6unRBL5/WR6h3TeCVmaH5fyNAOmvfWmSOkgaQ9X6pwQQfpfHCysaTVBcwB7kEzK9HDEEQmUjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YaoAd8OC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Thj9u5oc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YaoAd8OC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Thj9u5oc"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5RJhP3067035
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p3JASRzJPlo+L0XP2XXFPrSY
	1nf08xrvhVUiRcRtrM0=; b=YaoAd8OCi9DqGPBxfZmdQzFZTBGOTh05ZV4pMxUQ
	nBWSDydWpm9WYRA2YudNwG8ywZuOH4YfoTvOG1jlIK+/o/t9gRzlBCXH9tfrcQpc
	ZjpCTSribdeK46rPIgTh70Slq3s/zGsFnQhzFfWIXXTRB6deKvvzUPuS1YQmpaTn
	LhtposxvL6rY6AqzNsz2NyZ8IVrgugMYY4eyLs/t1E3olgJQShZ1hooGalPc6lBQ
	XOmJdT2atBWdyZR+Efg+HEm96e8f0MLW2ORq+WFiWXTcg+k2xt+UlbrOXukSvPFj
	Ph4EmJYaGZvoy3iHFC7Vkb0UyUleXSQsSIdeeb5tvK2Xhg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88jphj1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:58:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52d33c89a29so42253361cf.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787558292; x=1788163092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p3JASRzJPlo+L0XP2XXFPrSY1nf08xrvhVUiRcRtrM0=;
        b=Thj9u5ocLYZGOM8MC6Ktckc0QqgVlRDS2E5lBLVHEEtZy+ebyx/sfHVZP9k76BQRbb
         3O5CK/QhurC0lo5s0o5VOBvBWvRogfq4RHUvyyuSee0ir4LUTOKJT/o1TSgSbPMEUjHp
         oHdcyHD1lEFUs9Z71PN+5WhT3s9brG4luR+DcKwPAdUVZ3qU8u5bTZ7rn5c/o0mxKtTm
         p42ahpckshIXhIAkTKf5Q+17kVGq9LcxtIqxybp3nWd3OUEdc1E1SdGk0QumuF7+Eb1F
         8A9HxDyJd4ONf3EGYEuLW1WiGO1BJS4WrmNtVyHqC+yuocGSPgFBeqT/ZWf4MSJDZnwR
         4LCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787558292; x=1788163092;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p3JASRzJPlo+L0XP2XXFPrSY1nf08xrvhVUiRcRtrM0=;
        b=BWBR32v2OexsC7rVDekpBSkiRlTmS496OUBN0wV59iJeTBz6AnU5XCnwh7QNglLgOn
         SbIfeAlMjnVZfDvSSHMRFhaqVpQsoP2YVBzb/GcuYv7y2UfBPlvbsL7coFTmTGYXo7tW
         q6EKSt/0jwXICa1/H1NR+/uQv8R4mcB2FxG4y/nuvYzIYfYn4sihpjaERIs2tWtk9q/n
         YacqUGGtTsckohL0dRY4FskZUjEYEwFP2756umFS/J+RmsDqa6CZybYp2ykJI+kfri/o
         BsgMvUIcofEpzMm6AABpIr7O1t1IuDZD7AP8gh4F+4ymOLNyvhRWa/XygWySDudK5n/r
         gNXg==
X-Forwarded-Encrypted: i=1; AHgh+RpH+HVta6Lc4uUNY/+sWKctcc/9B9DsRq7w3Ho6DCbXBROoh6FYV1Nfiy/s+5qXR0ikRlEMJmZfyg==@vger.kernel.org
X-Gm-Message-State: AFuF++mMEsWe7qDvx75XX25vMc6UIeGZa9OnG/QgB0I5dQpvng3oO02W
	8DHA1XUk8CYG/a8ZsbrfQJoK0L9bRG8+omt2eeKnJuo0XFbqEOqa9Bhv0J3ej541F9eIKa5NITq
	6BRQNnIbsahnq/6eabHfe+3UfqkfTdFKXch6dvPOs9OVJxseWQJEvBVPP5WV4SQ==
X-Gm-Gg: AR+sD10hBAbZmmdnztBn+HEXI6F6aPXRjalKyEg9rYNS7dea4AgDvY4X8LUuNGehIB3
	8No57wgyaydHYBANE6A3QWiuRfpIcaxQVIfIc2+RmkyWfmaNkOoGn+JqR8NSQRbWDMJcaHDA6cV
	rgAIGjU+RzmYfaWxut3dKZhxIE4uqFosi5bPs8nTQ/ZQY3z7xiBNTvSEcSfKFLVooceROO/cinQ
	4aEyRv5IsGMRJmerN7egyWKIhOWONgg90daCC8lGJeJrbOX1qkKPMqHwoUWgHmR4Ama8pi+XzPT
	CqXSKtdTmfGn+22vf/Vz1bvA2/Z1yRTge40YLaT8MhkdBO1EdLWM3FrcYT2/mhCW9cGbKZdm83T
	x5U9hb7L2XDWexQs=
X-Received: by 2002:a05:622a:5c07:b0:52d:918b:92e5 with SMTP id d75a77b69052e-52df5a54e7amr269752091cf.33.1787558292528;
        Mon, 24 Aug 2026 00:58:12 -0700 (PDT)
X-Received: by 2002:a05:622a:5c07:b0:52d:918b:92e5 with SMTP id d75a77b69052e-52df5a54e7amr269751541cf.33.1787558291971;
        Mon, 24 Aug 2026 00:58:11 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496296aa0sm1198117166b.19.2026.08.24.00.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 00:58:11 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:58:08 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 03/15] pmdomain: qcom: rpmhpd: Add power domains for
 Kuno
Message-ID: <gqmzboqh3njrjgyf3yla7gzmagk73hgeb7qt3qcg3afi64suww@4llrqww5kke7>
References: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
 <20260821-kuno-soc-support-v3-3-196e2b306368@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-kuno-soc-support-v3-3-196e2b306368@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2OSBTYWx0ZWRfX4p4/IoCqs/DP
 ZLZmA4bViRxmZSV8V/PuDZXEr9FTTuvJVNFb8j8F7K74wk7qeGt1LsoyUUVBwcbDmFaNEDX6e7I
 sodq5YFjvce0fMknwaswspooPxMs9751FA8M5b0RpmS2kSBeyFSYgnyzm0cmLdhqo5/ba6fMqFq
 9OFlZRqnG6OlzQmN9CqORCpw+TyZETEsPKYxNiqz5nYTi3HlcUH4Y9txWJVcFtvukRcMZFmsLug
 ZmWIuySj1N/8RbWdnLYvRX+sjJKoONP/lLA7A9riH0dmgN7aRSEm9eTwMztp5ZGghZJpcfve2mH
 yb79hRqKgWeHuE6MwzmmUwht+U2OEaA0/SiJaVMirVbW8SuJgRhDE3XQ4OlaXjkpdTJzwz7qdjY
 e92WMspmY8970ldmqr5OzA+UEyBuOwYLkUR9VvKqcAJ4jqkqq4w+cfw7rqrwVumGXQkgg/MgP+Y
 gIy4w1NWW81G70tPBRA==
X-Proofpoint-GUID: t-BPzmEEJdurZA3L2R16JADh_chcQe6C
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2OSBTYWx0ZWRfXxMY4RrK2AqaG
 hNcoC0ah8Awy5V0XepkeDhk0lGdUKKltlAIfbGyRM0fUhgoHf+9TdrJ4xB2Cznm1vMcX8Hath6K
 FgPrJZusCgVUjgVNCSkVWA3bfCZdi+E=
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6a8bf995 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ugQu5lbr4eJmBGCNh1wA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: t-BPzmEEJdurZA3L2R16JADh_chcQe6C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240069

On 26-08-21 21:38:56, Hardeep Sharma wrote:
> Add the RPMh power-domain data for the Qualcomm Kuno SoC to enable the
> new qcom,kuno-rpmhpd compatible to expose RPMh power domains. Kuno
> exposes CX, MX and MXC domains (including always-on variants).
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
