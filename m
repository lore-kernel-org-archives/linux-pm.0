Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23441837E
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165727; cv=pass; b=WiUpkwFlTNx8PyfRrkgbV09bELuuvQLGQknjDfBna4A/O84V0RXq6HVbN9best/isO8qKvM/77Dsip7B91/tSyP1NBB5giMZNi+g8QY5r+voOr6kBTIak6GzXH/UNQq6+UqRy4lSNnP8DvHG7OaAD0bXNiLBZZeOXdQxcG9EWz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165727; c=relaxed/simple;
	bh=d9LZcickXFLWLLIsYy2cdluHvFFTFr7ZSmT4GmRoZnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud1gx/jxI3ijM3aHkCZPdfL2QTColxK0o8PyBx1AnE/i65cnYU+avi38SRUdKT7gnS+vvkUYHrVWNUDN8Atyqg+Nty/7mHqRgcWI2BOz/BeRnSgUHn6TGdT4OaPngkVFeLjoEoRHGVQNCVJag1wwOfKw4PCisPzPdcE1zK/QKS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maPiW759; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A1edauYG; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maPiW759";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A1edauYG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbTfP2466532
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lUmDDWZK3rMPUgUEQOwwdE/8Cn8EPco7KHNc8Hry+5A=; b=maPiW759OLPqwFnm
	rgKFC2fZdUAWP+Ph+dcaVvKLIbdMUF6nH6PNJ12PrxUR5gGzTjBKq961SGsumfcV
	3vc8ep4kZG/Nd/5KfofJhZ4iXDaySDasw++0GxYZdW8FQAvyBuFw2wCo+i66h+tV
	dS58l1OfoZf0JaHQC/sorWCffZIRVrdYLZmLhqyT9V/Ql1XzLnyXYWrlIE0Eh+Wb
	8aB07/9Yk6UPT5TXlpbg5If3AgP6Wr2w77KzF89c06/fXDrgMAyhxBLR+vH/WwhE
	rYQPcLW7m3SibC6vAuYm8nMIjQxetSio/sr4MDE4VH9WR3lvUzudeaAJuYDaSAts
	UwcLyg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guy2c3x45-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:15:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cec4226c70so7693095ad.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 05:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790165722; cv=none;
        d=google.com; s=arc-20260327;
        b=Wdnj+IviFiI51wBP/7Nnv9eckXkzOj6/dDYfw7O/bzVFJo63BPKcgQMH/R3z2H/wRi
         WIdOPQhXm9XEaTQI1rCxTsg9uj48w1E3efCXE6bqFiDfPI4gdRDMb+PYzFqpYqYkEObA
         G6qqVTMAccom0beNumbc2ELN7lFqi2Dl4/NQGfmDeuQ2wX7jMgceG9BtFakzH3NbvNQc
         BuRMgpLNZpgNNSGOA2Ruqi27Oby2xJJ50vUaaC7DwKcHVhW85JM12QoxhYU3qT5m91ov
         79AB8Rs67LYD/RvbCUjk24mkkyWAOIn/fnUKfOGK4Of6OK/jc9ttE0HVhsqGslexjTdA
         d1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lUmDDWZK3rMPUgUEQOwwdE/8Cn8EPco7KHNc8Hry+5A=;
        fh=pORcmIlPPNVVJTTc6P87UzpkS+RvS70MyOJgnpmD2h0=;
        b=LVFwIYfsiUJstpeP8BW5LpzxQhshHh6gLgzz+p+bRAUx0HSYVXwSoCY4vmLJNKrvnw
         LQWzD21KMQajLSFCSbdSpQx+ndVB6AxdVdl63QkmZ0vgF7JtTPVWhUnpMgvFDs0WiIm2
         GAqYZ6Uux+307Y6EVAHB4zkOFZEc4vOXOY+4TGa5hwC8C8EWkHyJ2p0dYSRaBZdf0E9v
         dThE9oarvygpoPlDAmTeSzAHLDPo2xkAkHfReeMgHQaC8ntPHftiM6k7AmNwhsCm10pz
         GxXlqSV9Oww8aFp7haGitbXXHZORS0ko7/yhp6z+idwzCC0cCrLQUbq9ScZjU5hYL+Yf
         V+4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790165722; x=1790770522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lUmDDWZK3rMPUgUEQOwwdE/8Cn8EPco7KHNc8Hry+5A=;
        b=A1edauYGdFWARak1hd9xHkul6+ETbDfW//ulMrE8fCpo5vorgV4VXUBgx+Ygk/QSyY
         mnRQnzIcOiGkyhZur47aW1SynUnUfpKNLFMUlqBIW/UNm/C+40hsvBh4GFA0DadOy833
         Ka5PW+NKHn7sMbVU0KT9EmAcciCXo5SpCHIKEbf86dPK/UjBRZDeDgv84IiUnx4PgQgM
         8hhDCMCU1BCOT7b5HDX2EoEXys05rSzWLRgvw4PzT7k94L57O5WXpu81Ir3+8TyUHP29
         H1eBaXEuMfIkRHH/iIubFPJmxRzo7Y0nT6os73lZKCjNnSgZvm9ApU3iKp+RFmI0keA3
         8cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790165722; x=1790770522;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUmDDWZK3rMPUgUEQOwwdE/8Cn8EPco7KHNc8Hry+5A=;
        b=SX1dwkPc94n9WEGnZKyECLNDcv4bbJCzZ3RzdIRfkJ/KL9GWk0Aq3ST3cpmu6wUqWD
         XjJy8rK7yY6FzyLDnl+w+nS48wSAocBrkZKoUKqR34K1S6KCsEOgPAGDvN3bmG/M9gUu
         NxNd3PeufPkQ1saPOHBCt7J6jVIgqnoIr9unJmUaLciJ2pUrBRJ7FKfPkBl071I+5zGw
         nGQrWNfMwrbBhj4kp31CtCjSBYNAD5qTeqMuewkGDw9YSMSjF0gOXFNv+fM77eZ967YH
         Q/VRe7S9IOJzcRHhJL86vr7Wg52vCZK9ZYtN1v39Pf2EWgbaa0Ge//yljH1hSClAqfqG
         +ZwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQS8jKCjJ4jTTV3OxvSV2aXpRrBy1s5ZcvO/nsIpE2cCl83fzDvH/nslGtJYgW1nJ8BnZ0CQgLwA==@vger.kernel.org
X-Gm-Message-State: AFuF++nAZF3pAQJ77Oa3WJjK7oE6upg1mI6X5itAHXNsDqgGtYlMVnc2
	GbC75WF91xpBxnCc/ncT5IysgX5rYHLJv1xikDcjSn7jKQ/KlL0y5WryUm/4rtpNU0Q8lg99ReN
	8zg90Zef01Xmjn2YinpjIpCNmQpI2+ATUs8Hie0jh+HpGJ2xVO5pw0zqgkTadq33We4+MrKbHaH
	mUwUr77JhdolVNNOGvufKYOF1nFcuPtjKfWFig
X-Gm-Gg: AYBFou3B7FFbgzRwsFKYNX8lTfSGbKk4GH9ZP5sr/hJCJzM78f25yIPhzqyvks1HtvY
	otpKbxnBBJbbHUuze5e06PpPGY6xXuGEw/CoviutsUD938CYvVN+eco61V0uQe6nIklEPgz3MOK
	3CpfypGLupMlnQHZAWDv97Fubr83+fcJyez7zBioOlRD/kkKheTGkSr3Lv/Nv52GAANyv5
X-Received: by 2002:a17:902:d592:b0:2dd:c0ff:e728 with SMTP id d9443c01a7336-2df69de4665mr19057435ad.58.1790165722057;
        Wed, 23 Sep 2026 05:15:22 -0700 (PDT)
X-Received: by 2002:a17:902:d592:b0:2dd:c0ff:e728 with SMTP id
 d9443c01a7336-2df69de4665mr19055275ad.58.1790165716824; Wed, 23 Sep 2026
 05:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-imx8mp-blk-ctrl-v3-1-c86b0a9d4781@oss.nxp.com>
In-Reply-To: <20260921-imx8mp-blk-ctrl-v3-1-c86b0a9d4781@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:15:04 +0200
X-Gm-Features: AcwNN1UBYWIvEZGdzMW9jD4AZ2JktIkSu9xe9i_PSGoqpxzPUfaA-MSKhDFG4Xg
Message-ID: <CAPx+jO_kZp5tRknB6xB5v3Prv=xLU0x=H8VBy9uTdarGHmxgoQ@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: imx8m-blk-ctrl: Serialize power on/off
 across sibling domains
To: Ming Qian <ming.qian@oss.nxp.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhou Peng <eagle.zhou@nxp.com>, Xiahong Bao <xiahong.bao@nxp.com>,
        Ming Zhou <ming.zhou@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: RQ-FXU8EXxYeYOJX9ZYnA5nlnJGMki8A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfX/CYsFtlym1Zz
 XEtQep5AaZDlYN12Lm7ldHgL8xuLH/dT4KboJhpFZodCgUzvSCEIYVSsNFGz1OPARVqVnHYPKu3
 g0JdOBT48Q+V65gm2V6nNNCkv7nco/w=
X-Authority-Analysis: v=2.4 cv=Zsh4uN7G c=1 sm=1 tr=0 ts=6ab3c2db cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=bC-a23v3AAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=L-I4Vr5n3LcoRG0ZONIA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=ST-jHhOKWsTCqRlWije3:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: RQ-FXU8EXxYeYOJX9ZYnA5nlnJGMki8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfXxrLxQpyDvdg0
 S0r1byOHm/G9+TTCV5xzYmhNDljaMClHly7HUwcfjt+gd4jr3/eSYxaLjtc3YkNYgD5kHLNoszl
 izsw9zgjpDDMtCZx00/2fsDAvxbSgA6+YQ5nu/qsYdHIkhyWqdMyDQBj2MKoKkg4zc6aZcjDnus
 3aaT/mFkSyvJp87pBEXW4BFl2fIwh0yaxL63RQ8DCG2e4Y9trRz5LHpl/aXwENLZgbt9oNgiXvT
 bSm3Fh700psaKn84vzv6YurtzDqIrwamweX3ZmjmZ3BKPR+MgjP9ihlHE4Y9XxOyPsCAWvyr+hN
 R8l9sQLMReXFXFeK4PlziRnUsnUEIAP8ze1XCoqpbvUwjCNRWivko9YoFW+9kbzmRmFNAqEUKX1
 Sytt70GxXeLn9x0eot7bw9A3PU+HZVaKokn6l9rkxgNywrRCdkyFjZZFVE+0gnKTnkSY79GCq98
 KlwLAgAamNLZHmuiuOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230048

On Mon, Sep 21, 2026 at 12:03=E2=80=AFPM Ming Qian <ming.qian@oss.nxp.com> =
wrote:
>
> On i.MX8MP the VPU blk-ctrl exposes G1, G2 and VC8000E as three separate
> genpds, each serialized only by its own genpd lock, so their power_on and
> power_off callbacks can run concurrently on SMP.
>
> The sequences are not independent: they share the VPUMIX bus domain, the
> VPU_NOC and the ADB400 handshake. On power up the GPC cannot ack-verify
> the ADB400 handshake - the ack only completes once blk-ctrl sets the bus
> clk-en bit - so it just waits a fixed delay instead of polling hskack. A
> sibling transition landing inside another domain's reset window disturbs
> that shared clock and handshake timing, the victim's reset does not take
> effect, and its block registers read back all zeros: the decoder times
> out or the encoder fails its format check.
>
> Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex; the
> driver deliberately avoids a genpd hierarchy, so the genpd core gives no
> cross-sibling serialization.

I recall I had a closer look at the code and the DTSes, trying to
understand why we need to avoid using a hierarchical power-domain
layout, while in fact there is one.

>
> Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl"=
)
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>

As the fix is simple this time, I have applied it for fixes and added
a stable tag, thanks!

Long term wise, I am wondering if we should try to move to a proper
genpd parent/child domain configuration instead.

Kind regards
Uffe


> ---
> Problem:
> On i.MX8MP, running the VC8000E encoder and the G1/G2 decoders
> concurrently rarely and non-deterministically leaves a VPU stuck in
> reset: its block registers read back all zeros. A decoder then times out
> or the encoder fails its format check.
>
> Root cause:
> The VPU blk-ctrl exposes G1, G2 and VC8000E as three separate genpds,
> serialized only by the per-genpd lock, so on SMP their power_on/power_off
> callbacks can run concurrently. The sequences share the VPUMIX bus
> domain, the VPU_NOC and the ADB400 handshake. On power up the GPC does
> not ack-verify the ADB400 handshake - the ack only completes once
> blk-ctrl sets the bus clk-en bit - so it just waits a fixed delay. A
> sibling transition landing inside another domain's reset window disturbs
> that shared clock and handshake timing, the victim's reset fails to take
> effect, and its block is left in reset with registers reading zero.
>
> Fix:
> Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex, so a
> sibling domain cannot run its sequence while another is inside its reset
> window. The driver deliberately avoids a genpd hierarchy, so the genpd
> core provides no cross-sibling serialization.
>
> Test:
> i.MX8MP, Android 6.18 kernel, concurrent H.264 decode and encode. Without
> this patch the failure reproduces within one to two hours. With it the
> same test ran overnight, over 14 hours, without a single occurrence.
> ---
> Changes in v3:
> - Go back to guard(mutex) in power_on()/power_off(): the goto chain only
>   jumps forward to do tear-down work, so it does not break scope-based
>   cleanup (Frank Li).
> - Link to v2: https://patch.msgid.link/20260917-imx8mp-blk-ctrl-v2-1-81d2=
9e907a5d@oss.nxp.com
>
> Changes in v2:
> - Replace guard(mutex) with explicit mutex_lock()/mutex_unlock():
>   power_on() already unwinds errors with goto, and cleanup.h asks not to
>   mix goto and scope-based cleanup in one function (sashiko-bot).
> - Shorten the commit message to the essentials and move the detailed
>   hardware analysis into this cover letter (Frank Li).
> - Link to v1: https://patch.msgid.link/20260915-imx8mp-blk-ctrl-v1-1-b3b4=
e6e7e676@oss.nxp.com
>
> To: Ulf Hansson <ulfh@kernel.org>
> To: Frank Li <Frank.Li@nxp.com>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Peng Fan <peng.fan@nxp.com>
> Cc: linux-pm@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx=
/imx8m-blk-ctrl.c
> index 479789009c7f..f8105e87ea3c 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -15,6 +15,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/clk.h>
> +#include <linux/mutex.h>
>
>  #include <dt-bindings/power/imx8mm-power.h>
>  #include <dt-bindings/power/imx8mn-power.h>
> @@ -34,6 +35,12 @@ struct imx8m_blk_ctrl {
>         struct regmap *regmap;
>         struct imx8m_blk_ctrl_domain *domains;
>         struct genpd_onecell_data onecell_data;
> +       /*
> +        * Serializes the blk-ctrl reset/clock sequence across sibling do=
mains;
> +        * their transitions interact through the shared VPUMIX bus domai=
n,
> +        * VPU_NOC and the not-ack-verified ADB400 handshake (ERR050531).
> +        */
> +       struct mutex power_lock;
>  };
>
>  struct imx8m_blk_ctrl_domain_data {
> @@ -98,6 +105,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_d=
omain *genpd)
>         struct imx8m_blk_ctrl *bc =3D domain->bc;
>         int ret;
>
> +       guard(mutex)(&bc->power_lock);
> +
>         /* make sure bus domain is awake */
>         ret =3D pm_runtime_get_sync(bc->bus_power_dev);
>         if (ret < 0) {
> @@ -164,6 +173,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm=
_domain *genpd)
>         const struct imx8m_blk_ctrl_domain_data *data =3D domain->data;
>         struct imx8m_blk_ctrl *bc =3D domain->bc;
>
> +       guard(mutex)(&bc->power_lock);
> +
>         /* put devices into reset and disable clocks */
>         if (data->mipi_phy_rst_mask)
>                 regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->m=
ipi_phy_rst_mask);
> @@ -202,6 +213,10 @@ static int imx8m_blk_ctrl_probe(struct platform_devi=
ce *pdev)
>
>         bc->dev =3D dev;
>
> +       ret =3D devm_mutex_init(dev, &bc->power_lock);
> +       if (ret)
> +               return ret;
> +
>         bc_data =3D of_device_get_match_data(dev);
>
>         base =3D devm_platform_ioremap_resource(pdev, 0);
>
> ---
> base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> change-id: 20260911-imx8mp-blk-ctrl-c46f26783073
>
