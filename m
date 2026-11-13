Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794583297;
	b=BKpLCkK5BNjoQel1BbZ6nGBIo8Kkw13sT+h2wzr0hOG8OQsdGtaoZOUbiCbxFz1X58iH
	 DM9vkBSkBjZ04qA4+t176bvPikbYD2qlCTJ8PEja/79UuoGKLZQ6da4T9/JH2fk9rd/5e
	 KGa//jR0Ux8gdCDvZ6tAOZrrIpdtIEsF3/oRYmAGZH9kriRJvPrJvsBiNfUGYTmOfK+aT
	 mSSLVKGdYR4IQY89PoBPQclmIvDXdkcUzhHpcJZ1K7njZhctWxlr9eUedPOxsHAyPrEKi
	 4jTqRw+BSekbD4S5AvgKLlRWKONuOWqDC4Y7REHJk8CVtOWRwu9VF8AMJQogIK0Zz+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583297;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=geT328QAyYnNeInrNQH4r++C+G0uRe3jXa85r1YPDYE=;
	b=X+nHqFhLs2HdvuZdkByHeJoL9uLAmKHZkkoUMN0sFRREsrcXCb1cyaEt4zgQW5fTuo++
	 E7ghSkcI4GHv91oAO8Kfa0p7B3iuA2ta0M0ZiIaX0mtUEAlyA0flnjT7Gxy7VuX2jLXy1
	 wNRy5tzO+0r8bflqUKzsPGhl5s0vhEC2rTzvs0jzSDDomU9CiROk7EjPOG7J/yIekbS/y
	 oNAu5+UY1CgOr6xFpuftsUthWlwumk5qvvnLpPMv8whJoQE2z7flFHNL4R5pKpthKxqPV
	 uNo8pVXM41mWNx3qFfRQ2S+h5bKT+Bjp7WRHEsB5hF84JbzPzu3IKyOFfXgfH/0Np5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R62GvGOb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UkOTVwaR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDC606A32D
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55FDC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R62GvGOb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UkOTVwaR
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCJQAh1226975
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	geT328QAyYnNeInrNQH4r++C+G0uRe3jXa85r1YPDYE=; b=R62GvGObSKKij8es
	xl0IUxjIKVy5igLKNQ7usayh1NReBI4OWX0viyH1+kH13L9yKg1IA3OAQPlo53x/
	rqGPkv71NGhjv8qSAMxMo+Kl2ur1YKXTA5ZrjfNFOFH/oc98my+xU1YdEW4fwBd1
	1kZW5pEfcqO0SleqqdzRp9I6uMq/geWcCuMduJgss58viE8w3YvqGrpktJc7MwkZ
	BZeFkNeNq0ZgWiYOGzUv5DbMw3/OBIaq0au3hU7aGswJdUg+Dd7U5jKUMUZHv8Et
	EBmbzo6E4QHsCl2QIs48gJphtp/d1Aq62HC0XmJwlhO2551YhIG5w1dxmPLT5hJl
	fxD14A==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx1bp8wmc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:21:35 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b26d8d2498so1333838b6e.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 07:21:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794583295; cv=none;
        d=google.com; s=arc-20260327;
        b=J7V9N/kqz/+kT0HYnk70HDpJHEi/e5EGxFaE9wGAbyuqzSEbOYaIJU/3QFGAJFkalJ
         zmvHOFanyljW2OloSUvviUP0o739yAacXPjNPsCyiBOfsyCVamFgvm1+MEour8BQlSGj
         CbR0uA06unu9Nf739eSk0gFx7xwX63f+/rqC/65L/L0I8966aMUYZptXxWAPgC9ZNzO1
         pe+f0t6cLRODc8TJ0WOaDUoGVrFtsZ5u9kTS9Sai1/1PDfMPPMPVPuo4v0cBzWd9SIjI
         UmaeyVf+FozfJsReoeyixwpG1gjdGtoG15SIsOrTc2T+QZnm/+CsGktZjxCkiOZQ2C52
         jPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=geT328QAyYnNeInrNQH4r++C+G0uRe3jXa85r1YPDYE=;
        fh=rbEYY6CHp0jF2R8UCkNPO2dbTfSjr33t6YfBUfapHmU=;
        b=GNzDJJMLchwIzXpCHK8vIBsKPouHeSS6xPb4X3+m8kJe8LCF4rGX7lJCNgN7ihw07h
         71qbUsjdr2qYANSpZrCSwFboZghhUJs2LO5L6G8JHFGcezjKOWfWavcNPUupoKf9uy4k
         NITD9et+EXTDHKJ7eroRulsWuDg8gURPXKNvfOCWtE+8nVAwP5x+NGMLqFZ3QGj/mRPq
         zJOTIryoJqww55UB2EJUwiCcHiLlVtL+rtpK5sfM7XKlIgrlxoBEDaM7Ht/ZpXD6X/mL
         oC2MoHS1R8IP4hO6n2r1ekXEtaL6InU8OzjuRIu37y3TbJt+cgpCzoGdUPNGZGIDDBv/
         IQaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794583295; x=1795188095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=geT328QAyYnNeInrNQH4r++C+G0uRe3jXa85r1YPDYE=;
        b=UkOTVwaRqjQexOK/FiK7pfYqfvQgJ/O4aY3Kw5OXKpN/RKi+euUk7iWlb3mttKse0w
         njSUi28QXXuWPsvSGhOmb0gKvz3hiXwl1vaeffXdEtwsKmWeR/TlY1nwDAf+DryJEJxc
         VWnYXozwOB7dLYeRuW53dJBDwukMs+0/PL52BL6ZYtRWm8TBdUC90I5Auh1h1EeKy8Hq
         EyI6JWZR8jxAgEhBW79Ekyhk1EUgFhRsEAzUgKREHtdzb5szlkNsTigcJyEXqGdeHk/f
         qO3TuhMLxrfy3MGEnPKXY884olpOIRaD8FXbDHZfRPCG+KZIN42DzygS+dYChhNsxZM8
         fC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583295; x=1795188095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=geT328QAyYnNeInrNQH4r++C+G0uRe3jXa85r1YPDYE=;
        b=jVovUhD8aWcMZwaEGLk6p84mBZF98le/HNRb4Gdl7LCXTqThbw4nsbU0S4LB+qmw/1
         EKpap2BAETiky1ZQN8JM6Dgrl5md/CJZJxCEB1jqmsnkl3sFvLaHCCpi4qbwTiZXukBl
         IE+xus8Dm9imSFP8NRwjG9Kl26XpfnFK3fE6NErEeYXB5BG2TmFWDerA7X2yRmz17I2U
         YM/jzVq41upWNGQqr7eik9uE/hdeKKgGs9woaqAwPh+9e05a2v3D2gxcvAU5XH2anp8D
         waSU/6RlfPG6C38kZ3EmKlYvQ5MPO2hWR7FJFrHQRHfQv2sCEQDzjRJQgkvUF9FaEVeF
         Ix6g==
X-Forwarded-Encrypted: i=1; AL+hErGc+RkDUwQh0XItUQsyyXmnY/BLO//X/IRgZixVpSsKgFBpdMMtuZRpkoLJJsf7J6zbYwIsRi4CIA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9gC5GU2d9PeI9kR/5QrYPMrRAoSRnUf3meHO8HJUDakVkaHtUV
	l8V0ucH4MRVdxi6OIDGY6DhYBToiEcDCqQnrZl1gGsUp2ovirbJiHjFfx4ExpcWsspXh4OzDTuy
	Bjtqg8SiRE4XOJv/JE+Z50bY6R0tcVkwbuvZbDHfxNYsChmsCeiulWzjHQ9nFriLJn92GFwOyJA
	sc+ABI726f2FffIH6bgJ325xj007hYgxRc6OGe
X-Gm-Gg: AYBFou2H+0lTzAfowJw7QEuDeZX3jkxIIPFN1miNQoo+7ApDrMCOyLY2fbcrqdeL6u0
	saO2MjY2ELnWW2wYT1yZB2JbhE30y0WV2tA4bvcMlogo3qCXQysK/WWBrlGNGYUEq3NU2PpPO7J
	8+XFPRaOxmgisbolBLNORTg6bHaEri4Qi4La8X/anuavt1WDvRa7uWT80LgxXlYtRXp7KBRFKpk
	T6f1MxYTXFIo8SaClcoy/8Sd1jhfaUFfYdiYLq9eC/EnQkoV29SWyW/aa/R2N8o/tLftQBXcco=
X-Received: by 2002:a05:6808:181d:b0:4f4:73a9:f853 with SMTP id 5614622812f47-56e611df811mr2085684b6e.1.1794583294391;
        Fri, 13 Nov 2026 07:21:34 -0800 (PST)
X-Received: by 2002:a05:6808:181d:b0:4f4:73a9:f853 with SMTP id
 5614622812f47-56e611df811mr2085665b6e.1.1794583293886; Fri, 13 Nov 2026
 07:21:33 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113151940.2922539-1-lenb@kernel.org> <7ce7895da501c3204416b69b0049ff488904f6a5.1794582108.git.len.brown@intel.com>
In-Reply-To: <7ce7895da501c3204416b69b0049ff488904f6a5.1794582108.git.len.brown@intel.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:21:18 +0100
X-Gm-Features: AclHuK_0UjCIdqCIyIhd3UJgroX3dB4L8LjioVSu6odip5Gimgv192l9aPp-fJg
Message-ID: <CAFEp6-2sE6bAWRSsjeLJYLawcc=N4DbLZq2JHVtPrunG10j-ZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bus: mhi: pci_generic: Prevent MHI from aborting
 system suspend
To: Len Brown <lenb@kernel.org>
Cc: rafael@kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, mhi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=W9ytxhWk c=1 sm=1 tr=0 ts=6af72aff cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=YEmDlaeyN0JEUVdw9q0A:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: Jku5UAS0VP4Q6OxMcuQzHc0QY7hMSthP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MSBTYWx0ZWRfX4XiqgJElDaeR
 4xN1wmHTlFXjAVBa8k7+fjDHy51OER3teh454HUKrdQNdYTDT/5qBogJDfVOKJXlE2NLaen0O6j
 O6iPvN6EfEi0WtRPMFZINiuU9lmHbQA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MSBTYWx0ZWRfXxL8KgAJthLly
 L2rdnJ5SxLqshKo62mkBOR6eg38qAO6H2ALKa+PkkhTwZXuzHmslzccnQ1VZ8s/EtvF8nU15Vgu
 3MuKRXMukKRJwupk9Z3y2nPqfGNw07p1K9gV3F9wcfZHDdeXEkMQF6umNrK9WOjmrFM0Clzv1JM
 m3dkKtGXHqx3R8NsJLKNlQiqlQIrl6PkzLBe/+w3eFORtBr96w8SSdP9uqJ2ll+7yBWKVjbixH+
 Upv5O1Ai2Lak8sPY6peg8q9aJwJXcoZpF+gpolgdbWnKd5KnuQcjVJ21bYmhT+Hk0BkKQqldjfi
 xs81Ia6iPZmd0+QvgB2jrXMIWHf0pEWW7Q9s+pSIy7GOy/CbRAu6BCURPssCuDi8Iji+YLm+tRK
 qioYCskdnRrcuFPPpwAjvmyJKxLvXqHuP0PvqRVdilclcx1FIhojSKkJAYdkHcKdIJzO4D+d4TE
 sNdMxw8hx0F9fLm+PVg==
X-Proofpoint-ORIG-GUID: Jku5UAS0VP4Q6OxMcuQzHc0QY7hMSthP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130061

On Fri, Nov 13, 2026 at 4:19=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> From: Len Brown <len.brown@intel.com>
>
> mhi sometimes aborts system suspend on the thinkpad T16 gen3:
>
> mhi-pci-generic 0000:08:00.0:
> ... failed to suspend device: -16
> ... PM: pci_pm_suspend(): mhi_pci_suspend [mhi_pci_generic] returns -16
> ... PM: dpm_run_callback(): pci_pm_suspend returns -16
> ... PM: pci_pm_suspend returned -16 after 15145 usecs
> ... PM: failed to suspend async: error -16
>
> Prevent MHI from spreading this device-specific failure
> to the rest of the system.  I.e. "Why is a modem that I don't use
> preventing me from suspending my laptop?"
>
> This change does not comprehend the internal root cause of the
> mhi failure, which should be found and fixed.
>
> There is also a risk that ignoring the MHI error and continuing
> to put the device into PCI D3 will leave it in an error state.
>
> Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
> Signed-off-by: Len Brown <len.brown@intel.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/bus/mhi/host/pci_generic.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pc=
i_generic.c
> index 7193a384cca4..343d1046a25e 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -1727,7 +1727,12 @@ static int __maybe_unused mhi_pci_runtime_resume(s=
truct device *dev)
>  static int  __maybe_unused mhi_pci_suspend(struct device *dev)
>  {
>         pm_runtime_disable(dev);
> -       return mhi_pci_runtime_suspend(dev);
> +
> +       /* Ignore errors (e.g. -EBUSY); a failed modem suspend must not a=
bort system suspend */
> +       mhi_pci_runtime_suspend(dev);
> +
> +       /* Must return 0 to allow system suspend to continue */
> +       return 0;
>  }
>
>  static int __maybe_unused mhi_pci_resume(struct device *dev)
> --
> 2.45.2
>
