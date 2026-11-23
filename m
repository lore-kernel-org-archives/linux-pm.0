Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795448490;
	b=HpB5GYE5p4MB/mXZLW1+SkDUB9Jm3tBlsC03JKgqXZfK5fFHMJqoZI+/K4r0RxozWXcN
	 /ArB7CLySdFHbVSlak6a/Tx8DGnHtur8HH48Bbng3DIZkKGNq+iDQmjMpfFFVIdk7AG7l
	 7DWyTWSwoaN1x9XcqRhdlrCd/nh9j3Am1bAX+n0d9FER5XjqfTIDDOkw9TUe3hWU9IqiL
	 R0l1qX/IGqjOax4O91hxImihAomVMDYT3CBfAoLYvawR2cNLuMAqgwspi89ANftIJs8DT
	 O5DHekZsyuinBXyjyvWrk/ThCydMmK5dI6GFadNWMM0l7Q0D0hP0oydSYx8hmgIp+4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448490;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=z3+fJWbbn5rdv4kmKoNvOMPabAV1A1JXWBTP9UFe4rc=;
	b=WXbqj5sjdDrfpt42cVp0e8LCJ7yaj2KKKRJiLdTMiCGTvTW3qUV4rqvWE/7+HhOu3CyY
	 H4IDrnQ6lpRkZd/aIS8LBLMqYNFUZ7oHZvRubKRajC8mYr9PBS8xVjh3KnUl6aTQTTqZ6
	 uAGSS07N7xw3YAvhTIofIvrt0KN9N3AGfUuZE1LLyMprTiDYxHS2hrccpj6RT52NMIcUE
	 IlJHyWInTNNDgRvNi11OqUk8gUKaLam/IGo3wn1a3IX3SHbj/CY4i73ZfVKxMNHsonYjX
	 Zpt3357Le6MK4iVKToHyO1T1IM5ZcCLDncVmETJ522JBxXdFJR241e7yxKmQKdaP0Qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LwBhVoQf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YovjALme;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902A606A33A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 15:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6902A606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LwBhVoQf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YovjALme
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDLRxp446153
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 15:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z3+fJWbbn5rdv4kmKoNvOMPabAV1A1JXWBTP9UFe4rc=; b=LwBhVoQfmO7nyyPU
	r5bsBeMa6Peu7P6rSM/a9L5o+d3aAwm+4L9YCl3loUnC0DfiFhNwZ/a4b/s264Db
	/l1dcntdLgZqpVpzviRzEmUoVwx2ApQ/gfMm6JwtVOty0GQaO7/CxwIEtfNLtNYJ
	mqfqciSqZ6nM7bUS+/p8Vxzie965+E+9T1cvkZFbdcabIOQbq+d78jZI6V28qdsf
	8JBRvt5VNc6LnKIqF0Aw0HByxpbSTvy5flDEx3rLS9tiOTIpvFboh4K1yhSelgRs
	DdhB/aLFETqykxZ9r+MSCwJ5/307y/WLdrR11vir7cXmBFoN7g7/dtW5vSIVOmbN
	3T2CAg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g7424kx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 15:41:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ee04c49451so43669475ad.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 07:41:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795448488; cv=none;
        d=google.com; s=arc-20260327;
        b=fhbBpqrb5Nay8C+DRES4R/ZiGIWj72Ji2KbUajU4HAHB+B8wgVMpi8oI8cniCVKZ0l
         CTkreycupeX0eSIwwGjaVDI3rxW6cC4tR79K+MEI+Ubkbwy9cHrB7xkG68ZgQJHWNYYb
         122WHLquK15JP8jwul9mLOvGW/MEfJ3aciTHMkcSHfs2iFxVNNtLF1FXhg31+YMy0I6R
         +cM4miMNfTI1St7FsLxMwQGblRq0YUMOs9ltcxwLmCnBjUNTuJqjlA4+xXBRKbajQynV
         3st6EXnUjrqTffn4uUM/IzCyiO9IQN/19BNJ6hAVREVYpx6zgP1iZOvQChAw5b2Kyk7i
         e2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z3+fJWbbn5rdv4kmKoNvOMPabAV1A1JXWBTP9UFe4rc=;
        fh=qYIvgGdQOgvBG8vBSkE2scrIBr4rmrDeWmTaDEn6bLg=;
        b=nCHt0LOlCJTD1mlXjU4eu9G0RfxXT0cFFZFThuVR2YPa7Qpdh23mzqB39Ug/kjSj/F
         woycw14VnO0xew+HzabXOEpXA1KvxvjZ1N9uSJ5p4n6sQhcNxOBbTMEja6Odc13sWi5J
         s7yAz0rzKGOx+ebVZd4rNQIM1XUHIx4Sqqo8iDKtBG1G5RVvaZGA6INF86o67QAEttuz
         x2RSIgHpBZ8zUi2l8++8tplwYOSEsFICfpIIhw65NQuZ/aUrgbjmt7iVoagrDYISzSy1
         sKQaVBYOBEIWWntBJP0iubGSd7x3V/pIPdXi1KUHQqGZr2sO7C7h2a80j+V1w8vDTe8/
         TYVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795448488; x=1796053288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z3+fJWbbn5rdv4kmKoNvOMPabAV1A1JXWBTP9UFe4rc=;
        b=YovjALmetAX7HUOPkKpItRhKgIqbfeFcf+ZiUwFRGY1xQ7dpkr140HcyL4r8Qhsbzj
         +JCCN4If/g/IdAn18FqHETPDo12tZWm4kVD7j6RqnehnmQDMJf2cCcr0SzZBPA/hBWN4
         PBdvBLxbzxylkiCgGm9VKsIOUBWlbLW55EqtM/1/Lt2cbqJTZ7TjKozu/kZrN5FZ69X6
         y+niynSJGpNsOtwhfA0Cz9n+llN6xrfziqUW+eUEP5Dl225nyLUdsHWF17IIt1O53nGE
         vkkaWLursvzCAiKzkofSIiVtcaJDu3BvmygfYoCykVOQPoeWOI3UXrUKSDGWoaKz18TP
         +Ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448488; x=1796053288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z3+fJWbbn5rdv4kmKoNvOMPabAV1A1JXWBTP9UFe4rc=;
        b=qG0y3S2WxuTPm0jtzmdByGymvyKB6Wid/oFcYh7TOKB1dBpsgG0NFmK2jrPEOfvR7B
         /Nfyc+98ah/F7VkBGQtsvSh/eqh7VP7GP8zmyVTbsa58hofCcKSf4gYqu82HSBscOP+d
         jCzJqtdiFDOFSSz99h//PO6COea7WGpdqY5sRZ/k5c4pSDH6IQLNRj+kyZLl9B+HyuYE
         PZNNLxFC0xIAOqAPXlrmk3vJccErh4lez68iq/tc9n/6I5GVlULm+fg3Hfp8Q8510xyL
         AthKaMWoWsrY2vjYVfTYGI5DUAET74k8UN7pbiLcBXZ97lI90BGMzKwdmsSeYicc5im1
         tPFQ==
X-Forwarded-Encrypted: i=1; AL+hErE+WibnogZbNQd55ubCCV0V5RyqMWKBIfNnw1YTJHcgXg9GG541pgcEThqn2nYQUhyTng2S4qMQZw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/5RrcjTMJar78NOlInZJ5wI7Zv6u5XOB0YXgd1SFGLxsSb5s24
	pcKF04UlrZ5Fk5g2Ko59lQmltzZyHuH8o3iUl0mLM7hcQpc5F2clyhwetuIn9j9jLjEheTmJmIs
	h111c3r3IAvUexqbFkq4rsUaaJUF3YpTqCtNKyxGO2T8VL/S+oHM7eN060PDuZ4ay/qSfGuweJB
	t3IROysMoJdJ/X87DBNZmebCvnesO74hzXs21B
X-Gm-Gg: AZFdTZfZF91yONXBeMOoXeOGyxqVr/0Fs1v1ltTDEC7a3lpNfxnpP5fcoBdHLu1Sh4B
	PWSbeDk/iN3SULbht7KIATQtOdf8+ksCKAsaCg+SiFudAa7OMSLpWW4rKwfEco5D0xw81U+ksh0
	UHjFt0Xx7K5lxAB4mSKDfAC6dZySzSVJTPB3dFd9W589IiJVBORM9qg2OPOMLKErLKBkCdYa3cT
	aiVdizjgXouZifj
X-Received: by 2002:a17:90b:4c07:b0:3b4:f92:ade7 with SMTP id 98e67ed59e1d1-3b41cb20eb8mr11284523a91.52.1795448488174;
        Mon, 23 Nov 2026 07:41:28 -0800 (PST)
X-Received: by 2002:a17:90b:4c07:b0:3b4:f92:ade7 with SMTP id
 98e67ed59e1d1-3b41cb20eb8mr11284501a91.52.1795448487659; Mon, 23 Nov 2026
 07:41:27 -0800 (PST)
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
Date: Mon, 23 Nov 2026 16:41:16 +0100
X-Gm-Features: Aa3M54qalvCcel9ratTxu4C81K9v20GE0i5zGvsWcpVJoqcRS7uaGYyVC0U3bsQ
Message-ID: <CAPx+jO9gEkNsqhYiYZg6qqV9eVnCSw35za1aRytAFtMBSFoxCg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fix CPU PM domain state after failed
 runtime PM resume
To: Kaiqian Zhu <362918296@qq.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        rafael@kernel.org, daniel.lezcano@kernel.org, christian.loehle@arm.com,
        linux-pm@vger.kernel.org, Kaiqian Zhu <zhukaiqian@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 1a4wlJ_MFwuu5SRY3v2W4atzBgk0VQaH
X-Proofpoint-ORIG-GUID: 1a4wlJ_MFwuu5SRY3v2W4atzBgk0VQaH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MiBTYWx0ZWRfX8RQFq4vLDYf1
 UXM81RphpbGS7YNDg1CfMwgCs09CsmaG5u9ev2sgGtEE0x/gsvNMmm9RlDivJLcL75XB0ZLk0K6
 8m9ujhwOZsrWtyX62MjulY5JbAgi5Zg=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b045ea9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=IeNN-m2dAAAA:8 a=dZbOZ2KzAAAA:8
 a=Lo64oJ-8JDPVp8O0Ss0A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MiBTYWx0ZWRfXx8mVDvegbVio
 cUNqqo88INm/ZK7Dp1EKknSP21x5CDQYaLQCbkeUwdLFaKis+YdRFVl8c+9bpHV5EoEk6kcC91L
 2qxeiXyFJrv/OLYbcpYH6nMYAh7zEz0eGEsPjegi5Y7RpN4JqW8lubJ0BLjDUT38mon1pL7yYzA
 kq4PqS6u6QXMayHd3vL6U66PhL1Q/s60rF0uM7573WIlGS7NEqZu+s6Tlx+CzbHAl4J1fwtcmHM
 TSS2L9UvlHwBH6Ab14BwdeIyJc+wOeiQbd6Tx/iu6CvV/LeBKmArB3zmWlq3j4YFQUjSbDRf0i4
 hXbe3a2eahSN5YImYduJJQgX8tpyGCy2DaI8gD3tNPfxThTuNcUiDbzsZYCCTIwP32jl9drR65Q
 5yFatUf1THVzk4WHaaooHRLDRBfuims8CtSc1Qu4xNgEf8Lhbs1aPK3riivTGdBuZ67mnHjOOFd
 imy8z9Dhw+hB7SJiSsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230062

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

I don't think this will work.

pm_runtime_enabled() only provides a snapshot of the current state.
For example, if it returned true above, runtime PM may become disabled
at any point later on, causing problems with the calls to
pm_runtime_put_sync_suspend() and pm_runtime_get_sync().

We need another way to deal with this - and I am trying to convince
myself in what direction we should take this. Please allow me a few
more days to think about this.

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

Kind regards
Uffe
