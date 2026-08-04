Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CB3B47C4
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853883; cv=pass; b=ou2dUHj+MuVQS6gh+JZNzp3b9IwzB3umwJF/mONX983ZyFnKT1GG2OumiLTFH0fNgV4Rki5p/9+kDW3ybsa7LDdDqTJHjMrIjqRB/2EM9kMTJ5BYCBpKVghOU5xw/+whsmK1JpLD+U1KOrc4SLG2CRtd6UtlBrTOrLVndAyvmPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853883; c=relaxed/simple;
	bh=5mCmR/6RUjKq6DEM2vGmt/KL+t14Bd5bccAfyxQBxCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOcoebdo5bzk7u/XDzvQhYScCKN+nO1/ZPf8Bpwi6WEV5jGsJPGVWlhc1fR40ZpEejyLI5MZ8Fy8gg9IkcT2TTijHe1S29/T+lL1ZWOWx+mcNv18LPLNoVHRM709bVhABDtVy4lf1cH98L2vY+vnhN16uzgNbwNM0aV3DI9HvX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nQE+Atnl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Emm1Aj0F; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nQE+Atnl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Emm1Aj0F"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CWwJJ3211649
	for <linux-pm@vger.kernel.org>; Tue, 4 Aug 2026 14:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cg6rAo/MJYlbCvgNVBkuRq80ZlIkgToqz32zBTLhVSg=; b=nQE+AtnlVP1fUw77
	L1Amwx9hTTIRUxtU69jv2ipTe0oLZs76ubHtqVbhaABic/DOTFTjCZW2Pyf2wBON
	0N4iD0wfDbONJCGJ8mFP2aT+y6B6YIr8SuX5XMBNaL4N/fMlMW8cDSZPa4Fg0aU2
	HXT8ikgCCUqFtZIN7O0toIE2FXuJDApEvheHtUhW1BQyPKPXyjJ8irn86G5UJWx6
	ZqF+/qZVVfLU1Sl9jT7GDy+26BuMXGN16MZkweuYTEKGpfrxoAyaQ9QCUta2MdDW
	kOShYYbYXRjSokV3WoAi1SE3IccyPjrAIrG+Q2hbJepxm3qCUaB429RS/rHsVB9G
	gqqnKQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fud23hawv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 14:30:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f45dde7595so54247466d6.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 07:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785853858; cv=none;
        d=google.com; s=arc-20260327;
        b=TbwpBWQ+VLG94aN2y59YTg5+K3llZSCUOolAmLQObBbAfIFvvHhh2ghB4W5G4Pnxmk
         J4+JSzkxnF0ix08tFPnFC7sJu7j2BlUUUK7hl3dVx0NxGHKu6LIbAj2K6G1h4mXZ+kvM
         JxpJnUxf4WxqwSXl853T9UGj6ROTah+8+tzZVTskDIdkrFoegiQg0S7K7pS22jmnpkfx
         8vEpPoOGt8BiBKz89hZOc0dAYSFMc4vOlzMnnAz9A6P7kn3L4689r86NgQu5IRkkULbY
         jBuuuXVWzvZaC5B8Q2QddL1oP8LzWYid9/3zsGk4vJAAE7rNP11cGNozksEQUt+sQIA5
         TF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cg6rAo/MJYlbCvgNVBkuRq80ZlIkgToqz32zBTLhVSg=;
        fh=KcqAww1AOC1mVLBmVJvh6di4pCtsNVJ/yLoWmhpXFCw=;
        b=DwXUsORt6Dn+A24uwAfb71H2iASnnSOw1kMnSrK0WE85sROmzWQHL3ZgY1+ZVa6LpY
         +P2GywPBW8UgMFj3QBdREI8Jb0bY/ae8Bnw6VhwMr7z6hy3gFRTJQgdtPlTfO5TGC8+Y
         Pl1uw2s3xZvlGVUBBfaZ8rNSfeBbnZ+495AM2X8BsDBHlN+2+krbcHM77PPwQtkxnBUm
         o8fyRUljb17PT7WK+7SCKRtI3ymNZSQYkDLFfCydMd3oUw6KVW4QFDpNYeNWx0jaYtzi
         fNVo5wLrWfGPpld6Y4cglDWSrNN8ZyM8/XHbuXyubAH+3ESG3JcP2qj7+mZK9M91juLU
         O+XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785853858; x=1786458658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cg6rAo/MJYlbCvgNVBkuRq80ZlIkgToqz32zBTLhVSg=;
        b=Emm1Aj0Fgv6sNDYK5t0S38AU29p0v6h7i25XYm/kDi6+m6vm8WdJr0oqg3kZyrzioj
         0KHxlRPAmTdmsHa6ouJnN9krP0cTs9/CyNQ297wPPOEte1ID6GExYIEgJ7gagkbzjWR5
         RD6kztkzcKCmJJdlWejJ9GJSqSc646xQplMIDRrTRCflAU4p8wCGx2OI27DkOgoyp+Kf
         1TnbhK6BTpO6BSjigoLn02/lbs2H78He+vJHqW0+8f34BxWXJjM8pGpxCYrjVVacVix8
         bWza/8wjDwoVixaW+VGnJgsurQIAfQOUGPjoSwPcLS6dbLn1hvJBiZUWVgVSck6l2Abi
         C6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785853858; x=1786458658;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cg6rAo/MJYlbCvgNVBkuRq80ZlIkgToqz32zBTLhVSg=;
        b=lgACpffhf9BgQA/EyGT4nvHhTezYrsU/8tbKGSHAwmYd7zwKm/1/3nuH+SWlYqvoQ+
         YaCjsK9P/mqB+Mrc7EmLfPNMNMexRLLcBFwkUXRSk7E1ipXt+GUaSuRRRnyt5HNGictF
         l6kK1ZspbZWTfkcJyE8EXCoPZd0U2d/Kxr3fwgz9Kly3s6lrFgVBnFjhgJosHae5K019
         pxayyH344aUYANKAiV3nQmGt7PrgFKezJhjAr4csvmVPhtRRvfAuDfyeZNL8twiFrRQx
         7JZ1EDVS5mY8K2W/sXbYwW4RTwfZ16m1GuFLDIh+6d3KrO29khTyIKEqJfykl2eZXN/3
         oR5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rri/Mlyg4o6jyiPH/QslNxDcl1BeXNZ04TpsVGVN+3dfply6mFqtvYLlHOXQqCVsM03aFkTIo34jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhp4+5asyoaCCRHKuexGtnXzlqnXRY71lUQLGPLObB77HsVyl
	vROibOg/PuQ8yq/Vy0/rNeeNDUbTxdi28ASrxVNmJHdsxR+q5g0TU8/0iL9ipUUGw3d3/+LUmmt
	s7y94A88+uztZOctuGNMagptwngPbJoZ+qlHnyIlONdl4irofdAVKzusNCMgCrVdWE7mhE/util
	4NPb3twU5XROnBgg1JR73HcewGSm0PWsH+uRa0
X-Gm-Gg: AR+sD11xVnw9jTR0OMvovZXVjcgudDLLgrrt2QwXgMYsbnjstVr1IMKqh9h56DvWkJI
	gx1AChczY1YdTUdtoe7afLn4VAEMB+A6Io81ER2ogYksUGyYK/xb2zlXM1aHPmzJddwD4xxRELv
	qDfTykNvsnjRjVbSDYgneyk1RmSh83Ng4QvBM1PgLeQYvmSzCPEESlgS1RVw==
X-Received: by 2002:a05:6214:3286:b0:8ee:b05c:596d with SMTP id 6a1803df08f44-9084967def8mr342440196d6.22.1785853857788;
        Tue, 04 Aug 2026 07:30:57 -0700 (PDT)
X-Received: by 2002:a05:6214:3286:b0:8ee:b05c:596d with SMTP id
 6a1803df08f44-9084967def8mr342438776d6.22.1785853857275; Tue, 04 Aug 2026
 07:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731102147.127082-1-git@jaseg.de>
In-Reply-To: <20260731102147.127082-1-git@jaseg.de>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 16:30:45 +0200
X-Gm-Features: AUfX_mzgivo-E3HGpQ3QfM9X418W4Z9nE91hXAlBr_4P1WkYtGn-e3ZUQvB34SE
Message-ID: <CAPx+jO_dACmFfdy6v32=V31HYiBFeU0NpnvhVuFWvLQ0Ls845g@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Wait for device link removals before
 dropping genpd->dev
To: jaseg <git@jaseg.de>, Saravana Kannan <saravanak@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: yUbY_rbt_j54E9X0iIX4M_tSj-hPCqTN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExNyBTYWx0ZWRfX+tzrNh3S77d1
 eFm2LmjemFhnaDbrKzVK7WaYxxK1f0S1cwds6YG0xYyftmjBNWDr5rB90axHzhlKb8i3xLpP8Wc
 DTLdM8KfblgUH/P8yfngEPHlDAKikg0=
X-Authority-Analysis: v=2.4 cv=XIkAjwhE c=1 sm=1 tr=0 ts=6a71f7a2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=18yQujymN4OLJxJT4uUA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: yUbY_rbt_j54E9X0iIX4M_tSj-hPCqTN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExNyBTYWx0ZWRfXxg6DcGa8APPW
 2cO/9KcmQFU3YXvD45evZ5RdTBCHNe/8XOatLbINdCY9C7hDxDtBRSO2eIm87/9ti6mEqNKkgMR
 GodBue9sBLqgWTyoPxfp1eOTOSy4SclfrvcQlM/Wx2YiIKZlO8sO/l7Y6/h+EByC4vIuQybsTCi
 sV06SCregJLLZ7btwh6z+K+aU2yVCelxGj3OZPMbd3XnYlJtCNbZwUQWmApEudjRD4WsStY8lPX
 hRlIFTolj7mGLFgAcQ5gAYtd37bWRqWcK5HDylu9bQYR2Zj4aQyr9ysJ+7ci+VY4iFY5DL8I0s1
 Ed4Ky8iGD5awIipedJmy+qw5Bp3IT0as17VjByVN2qe6MIXCIEKWC/R4dt7eVPQqeX3AcEUEr+B
 3TGnPAKzx4EX4FBQDyk1L+AYKMYoh/f9lLupQeXoCBx0+c6t+9ZeXTSp3hK/3E8TXFUHBcwHaLr
 yeoiopCwY77UqByZ4nA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040117

+ Saravana, Rafael, Danilo

On Fri, Jul 31, 2026 at 12:21=E2=80=AFPM jaseg <git@jaseg.de> wrote:
>
> From: Jan Sebastian G=C3=B6tte <linux@jaseg.de>
>
> genpd->dev is embedded in struct generic_pm_domain and its release
> function is empty, so providers free the containing genpd with a plain
> kfree() once of_genpd_remove_last() returns, ignoring its refcount.

Yes, there is certainly room for improvements in regards to reference
counting and freeing data in genpd. It's moving slowly in the right
direction though.

Anyway, the release function is actually set to
genpd_provider_release(), which ideally should free the data in the
long run, but we haven't fully reached that point yet.

That said, I guess you actually are referring to the ->remove()
callback for the genpd_provider_drv, right?

>
> Since genpd->dev is registered on the genpd provider bus, fw_devlink
> creates device links to it, and those are torn down asynchronously.
> Nothing made genpd_remove() wait for those teardowns, so the provider
> could free the memory backing genpd->dev while the queued workers still
> used it.
>
> This is reachable at boot on qrb2210, where the firmware rejects PC mode
> and psci_cpuidle_domain_probe() removes all the CPU PM domains before
> returning -EPROBE_DEFER. The bug is asymptomatic on defconfig, but shows
> up when enabling KASAN or INIT_ON_FREE_DEFAULT_ON. In some builds, it
> causes the kernel to crash a few hundred ms into the boot.
>
> Call device_link_wait_removal() before dropping the final reference. All
> link removal work is queued from device_del(), via
> device_links_driver_cleanup() and device_links_purge(), which precedes
> genpd_free_data(), and flush_workqueue() waits for it to complete.
>
> Note: This patch was LLM-assisted. I reproduced the issue and tested
> this patch on hardware, and I did my best to verify it by hand. However,
> I'm far from an expert in pmdomain, so YMMV.
>
> Assisted-by: Claude:claude-5-opus
> Fixes: 18a3a510ecfd ("pmdomain: core: Add the genpd->dev to the genpd pro=
vider bus")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>
> ---
>  drivers/pmdomain/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 842c4169e290..4eeb980e5a40 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2348,6 +2348,9 @@ static int genpd_alloc_data(struct generic_pm_domai=
n *genpd)
>
>  static void genpd_free_data(struct generic_pm_domain *genpd)
>  {
> +       /* Pending device link removals still reference genpd->dev. */
> +       device_link_wait_removal();
> +

Even if this fixes the issue, it looks wrong to me that drivers should
have to deal with this themselves at device removal.

In other words, I was expecting the driver core to deal with this for
everyone, but that seems not to be the case. Hmm.

Note that, the device removal should typically happen when the genpd
provider calls of_genpd_del_provider() and it calls device_del().

>         put_device(&genpd->dev);
>         if (genpd->device_id !=3D -ENXIO)
>                 ida_free(&genpd_ida, genpd->device_id);
> --
> 2.53.0
>

I will have a closer look at the driver core for this. In the
meantime, maybe Saravana, Rafael or Danilo have some ideas already?

Kind regards
Uffe
