Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592111;
	b=LAGNp0Dd2kLgl0PjrjHV+vbdPULN9hPHzeNje+4ganpWBc8WyQXdXQYTu7CAnzF8WoN4
	 KPPw0cyKZbvfvdNne1mst/lfw1jnuLeEwRVslBUF/lB4kY4vscA2xqgKMJUad0PQ4rbwX
	 xRHsi/y4ONlRV6sxT1ilOVAf41B4jZ2MqmoLVaTpzLNRMl/CZhgV7xeTOS4k+fshEQQPx
	 X4GjmqYujyOU0zpEb64/9t9EU7ny6FVRd+DubCSZDPw75ltYRP/qjh4S2VJDas0lvcrNS
	 GgY8BZG+rDT/hkxp286wSVoaMTrbeR9VC4Qs4L6p6TNWOtMEEpjt5feuiQuXEzWKJ/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592111;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OXFTYTHJxfVh03mXC0hFzyo52/qWvEBt2PQzkOclsuU=;
	b=yemUwkFtYn0NjYe9zxM0TqJrfuEotTMxsbKnXNpDM/56GD1gYBZoIgIH9lGbHQISVdOp
	 qpyqxi6CqiLAjI78/Tky6SJGTe+zcRoCycmcCl6NNdI9yH4Ogu4cvL43inLEUtEBm7oGq
	 53go3YoeJ2WSCsu37pXCWiP4Ug6gmtpvroO26wwfb1+ENI5CjoPXiTzdTKqDBucQTeSfn
	 0yYFR6o7uovev/OVOvTp5Hqme9biIMfEPtoEdePmYyESOlDEDGjLjgfaPd90ikvmblP9w
	 B/5Xo3xG9ZWuIhwmAPoHOf0ygMhpIap0uqRLVd4A1cxO/JnjnN2QxnGTv64gkYN0y5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KkfEYeTI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ar6jBOV3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002F606B23D
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A002F606B23D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KkfEYeTI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ar6jBOV3
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFRZQH552551
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OXFTYTHJxfVh03mXC0hFzyo52/qWvEBt2PQzkOclsuU=; b=KkfEYeTI9lRmQdLe
	fqlpoX65pQrVvp9pbgz/9IcgLUM7nN14d9AkwYPEi5PpQKUoSZNODD7Tm3HpEFAH
	2PgmaV4ipL/vczkEMqV6E2lXPISjloHIcJ2JNdt1IODzvMRzVjvtGf/sLvhtq+R1
	WkFgN13QpDuKn6c/Y7yqxZNdpAYHmrfJ3hzVrXxl6ehpMJvw7OjyLua1/SAAMYCY
	9tVGYPeV7d2pgKeKaT+f33fb6aSh4gHP5zyLnpjtPjOYxo6b3U4bA1AHy9unJg+G
	KIcLkqD850a4nhIsk8xGv2p97sO7YbW9UL6VZGgT2mgbJcK5fCvFrcj6Cu/ChQpX
	vumXrw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwc42q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:48:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed08904845so20134985ad.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592109; cv=none;
        d=google.com; s=arc-20260327;
        b=aZZp9EWGkH3eoF+en73rbWatXIwwoXoKSsf5KLFEvG65InT/PWXuyYOl3I01ey4tuX
         iHOWEA4ytR9VsCLHz97U9MoszGRLsBAnBgNHFpq6c9XyHjy5zQVF1JNLI3t5fCAmvIdm
         eksTlq9Id7ByMGYyVzksm/iz1liXb7a9f9g517kpguTRXZhNTP1Ru23NEGjN1iulnhMR
         y3onSgJH3diYsvFx6nko7cRrVVV+sG3Yu2XpqDpS8oWIkr4tFDOvUo6N0A2W4BxAGha0
         iuxbKsIs0jfazvmxUI+7SkBnzcKMln+uc+2mJzoWLa/QT4VCWR06CIlgvvAT8NMKhwQJ
         BeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OXFTYTHJxfVh03mXC0hFzyo52/qWvEBt2PQzkOclsuU=;
        fh=3kYbA0Fe0V3IK/91RgOYZUfC4QcWe9VCNpTSxFNLAaQ=;
        b=Bn/IyUlF4i6zIBhTwBKsqY0A1ZhVBBYmBr+av0ZZayC8BZ/pDHGJJbGQ4AAyciajlb
         I7l+iglA2mXP0G5q9TDGxUM+l5owlyfdBS8T6rsRyZHIFnvv+E0yO3FQtwEaFA5J8P5T
         hIY3wry7BgVG1Nomj4Ivpc4qMmo6o4Vhw/1YrEZSfIWJ2fyVSVNlu9LTcRujA8v61Wf3
         tA1LDg/piwJ6egL4HHzDA8xMkPqKsDPaopMZXikGXn+JsAAF3hif4YS62dJxxCm9Qrrd
         eFDScx8XA74P/cNuVIuMaoil4x/MyJ9G4CsC6AyzlxXyzuCgVc1Wrty1Gy/7lwm0AEVQ
         3cAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794592109; x=1795196909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OXFTYTHJxfVh03mXC0hFzyo52/qWvEBt2PQzkOclsuU=;
        b=ar6jBOV331Na1F2iVPRwYG+AiuPeMzoq+rRt5hIsizZCkTbMo2rShbCbSIShF1u5oo
         6fX6SPIHbJmatJ3lcHGZeRyAU8EQA/WZM7YRiIEVxHqEfUK0bEEArApuaurB+9SyJoxR
         S0Z6/xZxqqSRhA66Juysw+trgEdlBLEZ+Lfilv8UfyNggRsXuN7yPuihZn1rC5fI5px6
         6GjSP/9l5hfSwJm6mj6Sghg3g4cMMry4c+CNQawySDk5tHD0H+GCw0hsHXpcywXk5YaP
         tU05T2hvLDk15M0dSfn+KxNLldy35T9/e1knaw+zBXGDdsFiFtusZ3ueLxxfMuoCW+Ct
         RB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592109; x=1795196909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OXFTYTHJxfVh03mXC0hFzyo52/qWvEBt2PQzkOclsuU=;
        b=MWGGiy9jFANpom+gTpQi+CfCghr0/g60Oe0D0/6BygYAciZu+MBFOyw7R2t6jHnVFH
         qwaHUvqtUBhhBh0vgEzigwBKzscVjPr3SIL3X1KXA2GVVhW1q9FzZRxrjyNcKvb7Q4Sq
         VvwuD5ptYyDFhmIIA6bbaxoVM97U7F6yLyMzQshWdABL6SYdL4JJco7YIOUc7nh1RP6D
         PkOPQh4c2Pw6xjK+CVz/HcAjGwtfjm7VQz3FbxfxF6fgU9e6fvZ4ynpJyusei29IrxLZ
         1atJp4nvquxMLzWY9QwMUyPX8LeOC8ClIWZM2j4NaBZJayKtmZEoXkLfXGcwj9vejds9
         Gdkw==
X-Forwarded-Encrypted: i=1; AL+hErHlRtWD63EeSDWdWtxhRdG49NnlL1lgxi3DYkKfv3Cnv5T7wRlmZG4GWOGp5QsuxUw3KZPUrgvb2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+M2WPMCoCOK15W9IGlXENuBkbknWPf7ijpFJWkbxMdY8f+soa4
	6r+3BnIbVx57G1xetcfH7wpN0ge1Y1z/+m7wP1igXQMqV7v8Z90oBVFr25qw8YPJHnKrNeGOUOO
	Lp0eZrz79r79HtH8HSWCWa7sYyacfFRMAvcRq2Arwu2nGo3UDBExhP6+S88B90jt41wCyn2Dpie
	BGza3C8oXufruDeJqnXMoM3wuoeV4TfWTt9Xw4
X-Gm-Gg: AYBFou1do3rG6Ew/uYF+06M+HYerzLuZuYm0FwqV+WwRpRTpEu4AKTD+4J1OI4rLrEE
	hz8ux757YCE7w1sT5U2hE8iedZrCzVDwkigD/MTXh6E2d2VyjHHuOTG6uii7iZ/xT7FtDKxbuwN
	eK8GRweqvP+NBtL538n3sSBZNLDUlejI05DbT29/07CmqiecxAbCvUrTmECA==
X-Received: by 2002:a17:90b:48c9:b0:3ab:f2a9:cacd with SMTP id 98e67ed59e1d1-3b1b0cf38ffmr3470953a91.49.1794592108625;
        Fri, 13 Nov 2026 09:48:28 -0800 (PST)
X-Received: by 2002:a17:90b:48c9:b0:3ab:f2a9:cacd with SMTP id
 98e67ed59e1d1-3b1b0cf38ffmr3470918a91.49.1794592107986; Fri, 13 Nov 2026
 09:48:27 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-cpuidle-defer-v1-1-c86e0d450b4f@oss.qualcomm.com>
In-Reply-To: <20261020-cpuidle-defer-v1-1-c86e0d450b4f@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 18:48:17 +0100
X-Gm-Features: AclHuK9kfYky7mkn_GcNiHozG1zO-1rp4kEjZJ3xhZTmPTd2IODzmeeVV_jJyfg
Message-ID: <CAPx+jO-EkVSELG9L36ZTj6ZdeAJFTiN5L7voxCFrDN-w_GrtSA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Do not log probe deferral as an error
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af74d6d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=g6GHq2a1GYICSwjt_K4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: AdCA_k6kjZGFJOMJr_XKx-9nyCUHipTy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX4Aw8BBYS1adM
 wQR2jSjq7l0Ii8F60PQkGbeybEMWz6XbTkVY8ZgAFHdPjcUt76B/PvN6YNeZ35/fzY8BSfMOCXr
 vG15GE+9IZkedoMez4MKizMRBnPyCBwuY20PgKqimOEStt2lrJ3xBfBERsz5sad+3DKHmKnF41D
 5MsnYxEETB1mtl/svWjGHOzmJ/ijWJHPjqzfF06S1HsXzfl7juU/UkUthB0w7X23TImf4/WF4HJ
 RFjkxkT4jwioRPgFfN9vnH0hCvBu649+UqDVFa9LUpSamX/xFWDN/wPU/7Gbw7I/pKZwvnLH7uU
 5Lphs7lGWuoFzSNA2zUDprD8Zqg1gXtpudqdi+olfJHSgdPDqCTf1y09nfWMTEewQS9jGsqPUUs
 +W3O7JniQgbYWT1Y0Tlis2Yeh/TVyfr9BxhkJEAM0UGF2IBanQ4d+IQKVYOMUX6HmCpq29Xz1gn
 h/qyxGu3Dq7ChsIAtqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX+AE3ykcTGvx1
 4aZ3XS2R40Xorlh6tOZhhqMN8EECAvr0BwnoUtsNsZ1XH9flc2s63SapaG90xq6vBnrOFm7W8M+
 J3Sj/RgD1KymjAK4HtRynV+iyKqBAnk=
X-Proofpoint-GUID: AdCA_k6kjZGFJOMJr_XKx-9nyCUHipTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130070

On Tue, Oct 20, 2026 at 4:27=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> psci_cpuidle_domain_probe() reports every failure with pr_err(),
> including -EPROBE_DEFER. dt_idle_pd_init_topology() returns that
> whenever a parent domain is not registered yet, which is a normal and
> recoverable condition, so an otherwise successful boot still logs an
> error:
>
>   CPUidle PSCI: failed to create CPU PM domains ret=3D-517
>
> Report the failure with dev_err_probe() instead, which downgrade
> -EPROBE_DEFER to a debug message while still logging genuine errors.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpui=
dle-psci-domain.c
> index b9e4ad7d43a3310a76ce62018dff0af1488e33d2..aa73a2fa14b3af4d1e3edd607=
e058ba96132bad7 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -173,8 +173,7 @@ static int psci_cpuidle_domain_probe(struct platform_=
device *pdev)
>         dt_idle_pd_remove_topology(np);
>         psci_pd_remove();
>  exit:
> -       pr_err("failed to create CPU PM domains ret=3D%d\n", ret);
> -       return ret;
> +       return dev_err_probe(&pdev->dev, ret, "failed to create CPU PM do=
mains\n");
>  }
>
>  static struct platform_driver psci_cpuidle_domain_driver =3D {
>
> ---
> base-commit: f49a343b305c0b6c19a3b50c0bbf10bcd0e2e8fd
> change-id: 20261020-cpuidle-defer-4e6184bef223
>
> Best regards,
> --
> Loic Poulain <loic.poulain@oss.qualcomm.com>
>
