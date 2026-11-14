Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794654467;
	b=CwWcihYkSYUzyzWaXSGJIUPNPCh3LWD8j5p5CkkahxaIPYSkGg5aJTcKP99fJU7YpTo2
	 zgcLgn2iWkHKMrPwHj7Lbw8/qH37Q+iR96r4O91dowu7CFIQPCNfXmZKYNWRY/3V7rasc
	 5XoYWiBy1VKeZ1XJAYfjSMi9oWeNpNFw1UapqioceWe9+lOOTb75Gc2lAO3P0qZu9JBrS
	 t+z7FA9Z/HwXxJkPOq7hl3uY5XFQNz/B/nSDkStY5DpxdCvqsPA6lthyBYdEEBUILLBJG
	 H3OWgebnxiQdoO1vWg3vFR0bf45+WIWpEWOaXgkYztBC9zPUYRmtQUFG4AU1DUOQc7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794654467;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UVfNvKBdxDPPJH0BjX4OHy6Qsn77O+8cL2ijW2kdhNU=;
	b=Rzn7SeqrT0ETGm4+WpC3w/LwXIlGPS4PfrTuFhCN5KPS8xfdLFyGmpao6D/2xVoXtGoG
	 uB1IF/60doOL+XQGbEidMfCDHDDr3Yi2Z4IoyGxCU1zf8GlMSj0oZk0IMNJLGlgw0ut92
	 Rc6SGG/u5uY+vGRk9MZW8RbkYWiqzl9dbq4MSufZAmcjmaBnzK8UTgjUnTwXc963uczEl
	 NoxkWWtuOnPUisY6tlVz8w6qZU1ufSAAxFYs29SETYU5+58z4OZfESPvmg5E6L5qYy713
	 +/lPiSDIc9ahlTF3MEiM3yoZ1bgdNLkSb9sZ06A1zRZWEt6J7KxJZ40hYQnM47YrCbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=niDEQGd5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hfGN+MPq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B4606A32D
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 323B4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=niDEQGd5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hfGN+MPq
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wRMC174086
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UVfNvKBdxDPPJH0BjX4OHy6Qsn77O+8cL2ijW2kdhNU=; b=niDEQGd5PZhYeZFh
	1uUzYfbg0VXJH5BvxhuNU55IX1CEOha4v2ME7Eq0ogAnhhsWJqbV3pqxOcYKgCvB
	h9pvA0eUguvGoYikeDR9N7XbcXoWhwLy/J2CW48rkWy3AGOKcgg1BOAC9xU+nVZa
	wT2BvIvcHWDME8uXeS67PQqEJYu7vZlODSpuwSzWTnnweLqKcNiLzEYOEkskCVBM
	pLVM6WmA+4TrmQqtUrGrc15B8pUhCFF7VffQ+pjuuCp8mnfSpTgJt4hGpa4bWq60
	U8XIdN4Z+RG4W+wlQ0DesmgmO85o6mxjDgQaF+hGd6zM6vfsTFNbWdGnAkuqpKeU
	TtpE0A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmagj80-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:07:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so3270878a91.2
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 03:07:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794654465; cv=none;
        d=google.com; s=arc-20260327;
        b=JCNc4H/6Unq8sgpWWYspiODx03zKtCCIAiZ6QbVwuReY13aKFcBjNItgNhFTWKz2y4
         PF9Z3vBe6TryjYQlQEcL7Fwu6RV6WGptmdp6u7SvTAhiNUYLITmT2lbK8omyOHTbonQ+
         +16Z7W7Qrg6Cg6Xf+ob4Eh34oW1/w5zklmQi+Ruf7UtSyXb+2IxH+UtRiSHH7PbaF/Yi
         MOs8yzhqBUBwk21G86z+SF5XOxnbqkMv77Hwi7Detd7pAYpnKC1czshhQ8wSeaze8rXu
         lTf7/JFu5Hh6j77rVsxedQEb0RJBPA+KLLxZpc34UJU9p+L2ALTOUCyo7AHxgdIfQ+w7
         gVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UVfNvKBdxDPPJH0BjX4OHy6Qsn77O+8cL2ijW2kdhNU=;
        fh=UStzdD3P9OuR5oS6tpR7r56AD+DeDYYmru7cUaU6Iw4=;
        b=FO9JRO5UF2tGlMKw18uTWjsjhh4YiLfRkqDt8ZzqWr3liaTahzm/LgHvthU2nXYanH
         ePgDq/2B6Bm7ZhrREr77XOv9Kp2XWbjwnPajeoXDqww9W+TjQKjUnIlLxSdX7LaHgFRm
         9yfXyU92PuRTbKI0pDIvRn1B/FpPzP4Xvk7xydhCWd3zzeBdjmBQhEHshsefoqQMssfr
         U8ie2lmYSHfHA2wIeohRz9G7rXsOMp//cX7BtCJ36itkT1JmfMtb5GyOqfGVXckuZGJv
         utpV1cdYCSXoQeL/m8M16p8yMotl3LUpYWinyKSbCxNIAwfW68djlBUtQ67vtYe3sQMX
         DjlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794654465; x=1795259265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UVfNvKBdxDPPJH0BjX4OHy6Qsn77O+8cL2ijW2kdhNU=;
        b=hfGN+MPqb4B65rbaZHbUiDiXutjaINoAmZpxfADUnqrShdQHJnytLxyzjUoIhOy/nQ
         S7qc95PhcyoUr6/EGKNnxTtQxu4PMpM+xMJwDpX33ES4CC3L9mBMAHSg38JI/T2S44qV
         gpmhbm74eot4xj3BVBkE95vL80cojX7EAmzy1aR6TTBiUqIRq7XMrg2EyWUOZBiY9KvO
         Ryh4szhAU0vBNLGhvAew+u3SfI9h3pBKAxr4aectWE7bgaT26TdmDKMWDjnb+L2XWHcU
         78caOiTM5Rs6U0Xe1tSlU1KxLD0Jx4Q5VyCZXVO5Vcl3jWXf0ehdMygJ5WINxXNPeTia
         fWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794654465; x=1795259265;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UVfNvKBdxDPPJH0BjX4OHy6Qsn77O+8cL2ijW2kdhNU=;
        b=cJ0aeuKRB+W72ahElz6Rc7Ri4wm2jv5uTn8OQYEJZ2B8Rl6Xh8aRvc+/WESQh2iBII
         m659BawfW8qoGz/u9tnUAYuMdKzR3tYAz1Af+CWTsd4am4fLV6NKWuAmNWSmVt3G/IYL
         AU7rwzaksbCqxnlGvpPXdYj3+TGymkNEosu099+U8VwHX1M9cPpgSB1j154AnJtX39qk
         Qw0bGrnUZNtvZ98EW/RbMLp1iLrnXqdXn/3osSDv6hsW96qmk2KTKdHj3DZrE6JfQCEC
         F2799Bg7vSVaBNBlpuQp8CDZVw4W6rsxvJrMKamWx8Vw1gT92CsrnpyIpKJ5JVVO4/hX
         oeIQ==
X-Forwarded-Encrypted: i=1; AL+hErFtMEenz5kd03cCApAx5r7WXFEBY5AKnQB/daREo3rdZsef9oUP6butMAp9Bycf3snBE9PnedffEg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/aEi+6IrIJLrWhkGawp7BcoFY7UGuxKE1anZqAIAKszdQsGtnq
	xD9HlUGG2A6PQ8S6jPZb9cdbPrU+imvcGPeBSdeCWnGRclqIH2qboZ6XTqMNu826KcJtk6LLxj+
	5p8A4BHAzz/uxppN9aOaY7NgfW0Hav6fLtaIsw52e4+5hBCz8LxCMKr/IJ2oKfk7n2CpPWCQVpq
	zK5IR1Mk2aE7d6GvS+XRWjDCez630HEU2ghcg+
X-Gm-Gg: AYBFou2KorcI6fkJImoJylNsCHkFn05Ru/P+wNZ/sRjvSL2rVD71okrLiB/TwmaFNtw
	7uiSsmq7OFRgGlYabZgxJUOqnFLO7l8VwGARuCENLghFQF5LEiZ9mH9k06Vm8gmhHrxjeTntNIG
	o2WHHBCmPoZexyAY2E5AvPCdLnjkomuxMMajOkEX78ItIE/ohnPty6QmJrkQ==
X-Received: by 2002:a17:90b:3c4e:b0:3ac:8ee9:c8ed with SMTP id 98e67ed59e1d1-3b1b0b667b4mr5240176a91.13.1794654464541;
        Sat, 14 Nov 2026 03:07:44 -0800 (PST)
X-Received: by 2002:a17:90b:3c4e:b0:3ac:8ee9:c8ed with SMTP id
 98e67ed59e1d1-3b1b0b667b4mr5240158a91.13.1794654464070; Sat, 14 Nov 2026
 03:07:44 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-logical-ruby-scorpion-29ba7b@sudeepholla> <tencent_E6852D1967C70433E84FE0F8C893BC8CFB0A@qq.com>
In-Reply-To: <tencent_E6852D1967C70433E84FE0F8C893BC8CFB0A@qq.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 12:07:33 +0100
X-Gm-Features: AclHuK_Z0Idkgdpl0mJlsuNoxVXBgHMv_Du-b2AmmytXVjl48G_bPihXtWLJYe0
Message-ID: <CAPx+jO9VgpK1AZokz=auG33dQoCZYDic=pPhd7wx0FbMmHKsig@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fix CPU PM domain state after failed
 runtime PM resume
To: Kaiqian Zhu <362918296@qq.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        rafael@kernel.org, daniel.lezcano@kernel.org, christian.loehle@arm.com,
        linux-pm@vger.kernel.org, Kaiqian Zhu <zhukaiqian@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: h9jDILZjOqTCtZejt1FYdo65iF0Sd9VF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NCBTYWx0ZWRfX//kzDz907cIA
 OU90yDIG9eglHIPw1oqBAZTvJFAW3IcjdytLtSS96UOuRDXLMMrT6c1qXuS8hQJRwMDFQwFIS3I
 GdO2poMabkD6HdvRuERiALL97FNN6qKZZAJQbcgXzzcODsZF3buASTnAbE+7AMTOR4nFUwIr4D8
 B4mfk24VjvT1qdapsqPjrP7xdYxRla1RT6eYR0EXdl8Pjte/8/So4vOS8SlrVOjAwswnpYkbr0c
 tbXg5U1TPlf5MKY3AiqyMPbtB7MqjvDgzLHZibFKSVKqWekMH2pVmO66XgIRcKa2to5s8w1MdJ/
 St1f0JuuxSxeiONIu/nV5S0rf+NCV6JOHT6zgChLS2shBfSo0lWptIpTB3Lv6xtOhmiMR7KD6Vn
 oV5HhiWiYeUnIrURiCRZgCks3txloWSXl2nYyO1tGwyg2ASmm5n6DuOoXyyNNS4epXMooUVE+Ob
 6N7vAYCCCIZF0neKgSw==
X-Authority-Analysis: v=2.4 cv=NdhzRGD4 c=1 sm=1 tr=0 ts=6af84101 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=IeNN-m2dAAAA:8 a=dZbOZ2KzAAAA:8
 a=Lo64oJ-8JDPVp8O0Ss0A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: h9jDILZjOqTCtZejt1FYdo65iF0Sd9VF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NCBTYWx0ZWRfXz/QNZNcBkQGt
 IUuUy7A6j0WzGR2WP70PEu4KI7KrEMrlfXOGz+X/k8rIY80mnFkMDP4Ppb9Q2p8JAmlNgRWLroe
 mL1TYUyMvbOhoo+ddb46TgROUUEV/FQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140044

On Thu, Nov 5, 2026 at 6:05=E2=80=AFPM Kaiqian Zhu <362918296@qq.com> wrote=
:
>
> In PSCI OSI mode with the hierarchical CPU topology, a CPU can come
> out of idle after dpm_suspend_late() has already disabled runtime PM
> for its device. The idle exit then restores the cluster PM domain through
> the runtime PM path, however, since the runtime PM is disabled, it
> becomes a no-op and the domain stays powered off in software while
> the CPU is running. The CPU then silently stops requesting the cluster/
> system power level in CPU_SUSPEND.
>
> The Race:
> dpm_suspend_late() wakes all idle CPUs first and only then walks the
> device list, disabling runtime PM per device as it goes:
>
>   dpm_suspend_late()
>     wake_up_all_idle_cpus()               <-- asynchronous cpu wakeup
>       device_suspend_late(dev, ...)
>         __pm_runtime_disable(dev,false)    <-- disable_depth++
>
> wake_up_all_idle_cpus() only requests that the idle CPUs leave idle; it
> does not wait for them. A CPU parked in a deep PSCI state can take a long
> time to come back that its idle exit lands after the runtime disable:
>
>   CPU0: dpm_suspend_late()             CPUx: parked in idle
>   ------------------------------       ----------------------------
>   wake_up_all_idle_cpus()
>                                        powering ON
>   device_suspend_late(pd_dev)
>     __pm_runtime_disable(pd_dev)
>       disable_depth++
>                                        powered ON
>                                        __psci_enter_domain_idle_state()
>                                        pm_runtime_get_sync(pd_dev)
>                                        no-op: disable_depth > 0
>
> genpd_runtime_resume() never runs and the domain stays OFF. The next
> idle entry skips the genpd suspend as the state is already OFF.
>
> Fix this by using the genpd interface when the runtime PM is disabled.
> If the runtime resume failed to restore the domain, force it on by
> calling the genpd suspend/resume pair directly.

Thanks for a nice description of the problem!

In regards to the suggested fix for it below, I am not sure it's the
best approach to solve it. Although, I will need some more time to
think about it, please allow me to get back to you.

Kind regards
Uffe

>
> Signed-off-by: Kaiqian Zhu <zhukaiqian@xiaomi.com>
> ---
> Resend note: No code changes. Resent only to remove the automatic
> corporate email disclaimer footer from previous send.
> Link: https://lore.kernel.org/r/20261021031709.42644-1-zhukaiqian@xiaomi.=
com
> Link: https://lore.kernel.org/all/20261105-logical-ruby-scorpion-29ba7b@s=
udeepholla/
>
>  drivers/cpuidle/cpuidle-psci.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psc=
i.c
> index b250d0dde760..5b56f279cc7e 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -70,14 +70,23 @@ static __cpuidle int __psci_enter_domain_idle_state(s=
truct cpuidle_device *dev,
>         struct device *pd_dev =3D data->dev;
>         struct psci_cpuidle_domain_state *ds;
>         u32 state =3D states[idx];
> +       bool use_genpd;
>         int ret;
>
>         ret =3D cpu_pm_enter();
>         if (ret)
>                 return -1;
>
> +       /*
> +        * The PM core disables runtime PM during a system-wide suspend, =
which
> +        * makes the pm_runtime_*() calls below no-ops.  The resume can t=
hen
> +        * no longer set the PM domains back ON, while the CPU is running=
.
> +        * Use the genpd interface directly whenever runtime PM is unavai=
lable.
> +        */
> +       use_genpd =3D s2idle || !pm_runtime_enabled(pd_dev);
> +
>         /* Do runtime PM to manage a hierarchical CPU toplogy. */
> -       if (s2idle)
> +       if (use_genpd)
>                 dev_pm_genpd_suspend(pd_dev);
>         else
>                 pm_runtime_put_sync_suspend(pd_dev);
> @@ -90,11 +99,24 @@ static __cpuidle int __psci_enter_domain_idle_state(s=
truct cpuidle_device *dev,
>         ret =3D psci_cpu_suspend_enter(state) ? -1 : idx;
>         trace_psci_domain_idle_exit(dev->cpu, state, s2idle);
>
> -       if (s2idle)
> +       if (use_genpd) {
>                 dev_pm_genpd_resume(pd_dev);
> -       else
> +       } else {
>                 pm_runtime_get_sync(pd_dev);
>
> +               /*
> +                * Whenever runtime PM is disabled while a CPU was idle (=
in
> +                * the system-wide suspend progress), the resume above be=
came
> +                * a no-op and the domain is still OFF.
> +                * Force the genpd to update power state to ON, so that t=
he next
> +                * suspend can see the correct state.
> +                */
> +               if (!dev_pm_genpd_is_on(pd_dev)) {
> +                       dev_pm_genpd_suspend(pd_dev);
> +                       dev_pm_genpd_resume(pd_dev);
> +               }
> +       }
> +
>         cpu_pm_exit();
>
>         /* Correct domain-idlestate statistics if we failed to enter. */
> --
> 2.53.0
