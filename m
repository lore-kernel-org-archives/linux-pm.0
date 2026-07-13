Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F8384CD6
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940799; cv=pass; b=Zq2ZDo5FTR9UGhdo1VcDxPPAo8XDyb368doZgvAwu/fDTTNBevJicyr+wPO+Yh9hbTPmuvEVaGv6mhw+qbW58ryiQz1MpyPtj5kN4xl/iPwasb6G9NOGXEhk7ZktH+9j9o8I3lxdttwaucTvyREFsoz4ix7e0pkY5vCMCtb/Zbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940799; c=relaxed/simple;
	bh=eXEreop2tRXVvzShMuZyqFcJeoalfpXNQ7N+QnwuNZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aj87QTNkLrLZRpnf4uRih8js0K15US0wj///ZCwOdXxESMWHNP5FEFsL7hWRgvpuhZ2dfNTFR294cg6+98NQ7e6swAX68oiuTh5XDCG0uDY7M3e1rLs6DOTy9VmMGzfKpCLGPPaaHTYejjsSbvmvBs49J8pZacjgvp0ZjbgfMpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EDAGdw3e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i6sNI5YT; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EDAGdw3e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i6sNI5YT"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D9M1GH1090406
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ubat+z5QjnYmtaLIKT2fPs8gd+++aNLEi8AJBYOnLcY=; b=EDAGdw3eJHavUZd4
	kZEDTL4iHaq956dBAgvXAkkiWWOfRTEYZ+FAshmpXc1eIm4/MG6nHfwS1irzRFCQ
	XAlX0DO6j1gg+fsdnfV2ZCraIX9IuXIppNMmnlNmVZfk03YA08Io1PJulFnwrxTS
	R0hNBpY6h2O/0ael8DW5XFNoYbxlIXdh+oOCjrMzw1sTjtQiXTERcoQj/K/AW05N
	zP/EFXz244kR8ZGYLOSMc6tmv/2KGfrus7tsCXOuHhC4YP1hGFV/6sM2yzDv9Wdu
	vCHIKnso674+9ma/jZt0QnqfS6kmM95v3AIogQ3v5Xg9UAN8RF0JNPUU9Z3o2Zpq
	4swpYw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavrc2e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:37 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f39a46efd9so45570406d6.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 04:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783940796; cv=none;
        d=google.com; s=arc-20260327;
        b=Aq7YuJ5uBlDzVyNrEb1/fQ+0SWn/94gDbjDlGCbI5UfMTsQRVetCtXvnGB0rJ5u4xu
         nrZr0hFbGctkMhiYetnmNnSe/Ot5WyRZ6sceXXEBwFo0B6dqpmiyiprcwpHI2UH1nqAP
         q3b0hImumGHjrF2d5GFu1/bHQ6O/O04QZ5viRkaC/hB6C0LEb2mytYwSf4pQRBpU35f9
         cEd8z9AB2s0yKbdbpmmIscAQumoqQrf8NblYiBoj99owPzJ9gzya7uoOPW9QK3GaUFWf
         Hdn5Jjuii0tHzrvQwf2plK1iiKx6zfrzjFTfN39t5b2Pv4aYGfG6GycmUbUzRhtuD69P
         DV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ubat+z5QjnYmtaLIKT2fPs8gd+++aNLEi8AJBYOnLcY=;
        fh=rvQbiow6nrycDaoqVeulgAsf+PrVR0CRG/KpBc1+eLY=;
        b=k/Esg9El8U91JqqLw31+ZWmjwvfOeS8+fj4xnBL9+KCAm0EPyXYuJoz4rm1V//4UVG
         zfr3kTMD722KO9qCROZ2QVI5Pvy5OY0w6p+3D73b5K1rL9EoBF6X1oquTeNbW8mC6d63
         JNEjbhwq945v9hxgBqmuSZgzYEVHmFhEO+cuaIfousGqUvfTxqU8W2nUXmKHwCe/8+7E
         TLZCZKsEd25GzAh1/zZR05qQRMZb84+K7JCQiSk48TgbUg8L5OfOP1ak+agwX8qGZxot
         ymhK4j4o3pgiDXOrGmnZy/rIj2wPQXymvK7V6b7Hc2V+o+KSBK/xr/TOY6Lkt4ckTMQ+
         I3dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783940796; x=1784545596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ubat+z5QjnYmtaLIKT2fPs8gd+++aNLEi8AJBYOnLcY=;
        b=i6sNI5YTYxqyKFgZXq62GQN7/HRD2RtqxOeWUBw0TeULLdTP8MBgGcVSdIQAVponeK
         lvlXD2g/RJcijMliA32DXX5mfQAhZBufXAUjsp4im0U5jlHYOc0cwj/59yi/ARLhCqEs
         VbJ9/G/5he7w5VCU3GAUdJt0nrYbVP6LgFcllHatcYEAKEXWLbQUZGft5XAhTZtafV+u
         WaIvR3eUd8cksDAWtN8UUmRgifYEigrKxGsNF23zBikpsgxGUu4yoFUY3POxIWfih/d5
         k7R4ROz5EJfcNXP6izBXcqV1lHo8oSZAkNxpKyJXNt8KdpEj8Lzs7ZW+QctYeRjpdVi4
         Vzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783940796; x=1784545596;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ubat+z5QjnYmtaLIKT2fPs8gd+++aNLEi8AJBYOnLcY=;
        b=mL2jVuQTbRfzDaq4l3vKJZdC9DiITiJb+TcC9P3/fD0wQiJMUdLM3FYaA7cEhyPp8t
         SI3kOdRaInykMNGJrasRe3iWz9yYmJ4s1pGcIs8UouNPLdzPooxNjI1KVEXPUuYtbN0/
         DJ1gQTCni7Q7A/pxm6QdQbps1LnsLCENyZVK8WpXrj6blaJisd5OPAx7Hdajo19wBEdA
         CtI39vuCW+KzWdAdKVdOMNsV8wGtxjQfcM4kndj/hSQU4NBoPzWgkCKXhVTc/2LGNLbJ
         FPiDJtPS9zQOKoJrFMgR+3k2xq655f9CHu8SwMSIoxRsrK4rmmUh+DUsDRSIMp5Y0/2x
         Y4vg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9lMPcM3AqvdMrjeRa+npCDPU4CbenXc1NnkUnpFpKe1rV1G1A9B49yMKYaLAuhSeuoGtcv2s6hA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZfuWzLXCyy5eWqgxjOlMVPzKdYzsEngz4OwD3dVbgN4NWv2F
	hqfARCOhxsgTpV4gBimDES11ekK4C2WQgQ9W5n3sbPFumjnR5v75y9vK2vUEaTZ+ZaMBMgm4XA5
	cDRTKkwt9DtPgvTHjuG2uAlkI//j+0+jTGB7fJVB8HGijDzgffhy9xGpT74aGJemlB3b8PVSvpy
	633+ohv0vdDVC1WEhB7PW277+FVc98AVZWt3Io
X-Gm-Gg: AfdE7cl03229la224HsPnPDTajYp+rydOSG1yuM+rNTwMxbRs30RaRym5hyu5rxjbcb
	nL9xFv/W4x3S834+QvIz7HTMU7d9UW7SOnB60HcsrseEyrqHxPXTxgZElEkdTVzIbL6FGeyLYg7
	6dluB50a/sfuF9wu2838YdXda8Fg/yJILFfZF8LdcT/XztmeAbuFkwAxpTFsSvTbDz1IZW
X-Received: by 2002:a05:6214:4c86:b0:8fd:b96d:195b with SMTP id 6a1803df08f44-902360add0amr136214386d6.15.1783940796113;
        Mon, 13 Jul 2026 04:06:36 -0700 (PDT)
X-Received: by 2002:a05:6214:4c86:b0:8fd:b96d:195b with SMTP id
 6a1803df08f44-902360add0amr136214106d6.15.1783940795720; Mon, 13 Jul 2026
 04:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530204636.1115120-1-mcanal@igalia.com>
In-Reply-To: <20260530204636.1115120-1-mcanal@igalia.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:06:24 +0200
X-Gm-Features: AUfX_mzoo_GCCpmgP88Yj3-TYi906i2_TN-ZPhKg0bAnY7K4DQfnPcCJyPkqp1c
Message-ID: <CAPx+jO_oP7HP7bkd5SVmxA3x+ND-mCRT__8ALpy6mhufP8MtGQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: bcm: bcm2835-power: Raise ASB poll timeout to 100us
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: g_IBHgD-tQDT95ReYy93IkIxdF3JxUow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNSBTYWx0ZWRfXzHwBevbtgZBX
 mi8cquZPunZDQ19x0ogjuTZmCbqKIohT964ceOOj4PZjqA+iFhsCiF4ZFXjiEa+DNoxA1oOWfFF
 f4JhLXyDhA13IfzsOzPpwaHil80tU7WZs1dfxvSKvjtSB5SXVRw3asX8l/PF9tdHVDLxD1ZtPT6
 7SJM2LBUM/tosjZ5FNYLcAbaqRrlafnXVvk9uSB3qy3R7u29dZ7wrDp551ME5B+IT3nxmp3YPxb
 6K8z92Q6eRNgEbgzt+fpB/F/cdgRZs6K+Ibf8F0auc4fO+kf29Ng1wTAHg1c3mIaKldJvNMSqx2
 Ad98cKYrr+UUNc9h5ab+7T8lkoeMlzLY+0EH1Z2oIVhYeKYEqahds/UMqFUFFoo3/DwuNyq7kcA
 6Ne/9iMrsTjd9pG88d/4arbqCd9FZfKvoFlj8vn0RCQBh1ZCuS6mk2SgLB/TdCmTIDFseBeYeL8
 G01qxJWQcoJD0BPTJpA==
X-Proofpoint-ORIG-GUID: g_IBHgD-tQDT95ReYy93IkIxdF3JxUow
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a54c6bd cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=V2sgnzSHAAAA:8 a=xiSneWFeW3Tcw-NpSFEA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNSBTYWx0ZWRfX7pKu6opz313U
 OScIBokj2gLL2F/VM97qdMF6Qw5eSppCEFM6VOiLDWLKX4iVYjUnYIr/lOZyjBC/2w8yJE9awYA
 DmO61lbwu65MNEmi4g7b4nNR3hvjZTg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130115

On Sat, May 30, 2026 at 10:46=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia.co=
m> wrote:
>
> Commit 18605b1b936b ("pmdomain: bcm: bcm2835-power: Increase ASB control
> timeout") raised the ASB handshake polling budget from 1us to 5us.
> Surveying the pmdomain subsystem, 5us is still one of the smallest pollin=
g
> budgets by a wide margin. Comparable handshakes in other drivers use:
>
>   - 100us : starfive jh71xx-pmu, apple pmgr-pwrstate
>   - 1ms   : renesas rcar-sysc, rmobile-sysc (power-on)
>   - 10ms  : renesas rcar-gen4-sysc, sunxi sun55i-pck600
>   - 1s    : mediatek mtk-pm-domains, mtk-scpsys
>
> Raise the BCM2835 timeout to 100us, matching analogous drivers. 100us is
> still negligible relative to a power-domain transition and gives the V3D
> master ASB substantially more headroom to drain under heavy workloads,
> assuring us that the timeout is enough for any scenario.
>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/bcm/bcm2835-power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/=
bcm2835-power.c
> index b76d74e3849b..d507bb675e29 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct bcm2835_power *=
power, u32 reg, bool enable
>         writel(PM_PASSWORD | val, base + reg);
>
>         if (readl_poll_timeout_atomic(base + reg, val,
> -                                     !!(val & ASB_ACK) !=3D enable, 0, 5=
))
> +                                     !!(val & ASB_ACK) !=3D enable, 0, 1=
00))
>                 return -ETIMEDOUT;
>
>         return 0;
> --
> 2.54.0
>
