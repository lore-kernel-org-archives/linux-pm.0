Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF537A83B
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940803; cv=pass; b=UOf4C6rcze/f5nOkKVsiQ6lfv7P34lndm1TXbW89PLZ2AeFok7o4OfyzEnUczz67XUbazklxGb3On8HWrErI4/rQIC2foHkg3XT6TKhLNgQScNzqlkXM5WekbMTvd2YMNGSJZSmHUlhkJHgv4VLG7kb50r80wYxDD4tLA9GPOow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940803; c=relaxed/simple;
	bh=KO/zBTNh5ocUqwGqELQr7gjJafYvxtj0nAW0zFpegvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AauScOFISXPa+NcEGzDqVvKJcdvcN40KOWOkADfN45emByUxgpdoLLpbf9nRVTFI512YtTwtvzUu76EotyHlbWXwJz6cROOuJX2wg8NcXM42jhKfcSIPScRIfLDBwccEgP5MTHu30jUry5T3HJh0SGGRVvs0FJhVwpwUa/u78Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MA3mSI7l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XOS5ams2; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MA3mSI7l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XOS5ams2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D9M4Y11090535
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xk40p3spSA7Dl+t/EMDWt78ol/53BabP80E+M7SNBGM=; b=MA3mSI7lKin5G10x
	e2TdGUkqWxoxp6e7KjC3pfkH64B638tSUZru0ZFhLPUE4iT2e92yQwLqt7P/GFVl
	NffKvMPDecUSBU0cE0e1jjPlMUH4jDen+MJAqhR4mqWImokjkc23eXIsLfgcamzv
	NWM2hPEkvXYA0oB6lzHWK/JONgL6VhFy1NQn1Gp+UcJtdzr2EKZNyZhKLGRShdiY
	Irtm96aloGOQS6EvuTLgHQNwTx53ZOcn33ON3q+b1B9Zw05H7QLOY102z/EOgnwt
	w7tAC793qPmH5ixhsdbiR9mRddl7Y2rIooiUx7o1F5VGZtvGa6lQJMYIDabOa/qF
	ilV4/A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavrc2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:41 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8fdace20927so29896046d6.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 04:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783940800; cv=none;
        d=google.com; s=arc-20260327;
        b=lKV8/DDsmlSAOmNh5i/EtpZ8ZdsrR8O8/cxwN5nPz7OtXae049dyG5B/vBAVa3O5Rs
         wThsZP7xUuO5fSOhPBIX86fkdCK7Ur/EOlXvHlNOM+fB3U0z1plr0+ReHywf+0UaOhvo
         mujGfm2xaW6/YNsaVKYkUwbcZZCmh/kbyYkBESCXTppQug0gpxgvpmvPOmJ0vo7Aq+rv
         47KG0SIWVCYuw512oPyr41dJRdkxt/PmP7CbUemnSW++87X3LHvB41Y6IAHNZ/Gr5Dt+
         HTxRxWLKJgEalh3/SH308lpJqPWdGI7dm55fiI9MmbvDDypOlxx4voNYESAJrGgB44PO
         InPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xk40p3spSA7Dl+t/EMDWt78ol/53BabP80E+M7SNBGM=;
        fh=zdRdgRVRFw1qIrobyp59C4p7zoDwLU1qxFAUN0MwHgU=;
        b=U29SKDU2HG5pahnn5djmcZtmUErzUCa6N+vULEPdAuOAHllp4lrp8TczRPpJCf28a+
         Y9uGJzgtdsJ76QFotTpJkHxuPoq+5nUqYoVcizyjucIr90ugHRNuCEgaHN6LsDZypgj8
         sitzAJ71q36zJE4ugwg9dkHsS6OWXvxntfELvUj3nwG9scYYeSsQYfg+D8l+Nc4FYlsi
         FptRNQSOTBWA/fOEpPlHwjXimPFLyJSe0vqSver/rqWmXx0gqLAnzKcrDEsktcQiBSvd
         q6PsTzY1UzMhP+qDBYDsZ+//59pfR4cOKzb1XD4BkQuQRc61tJdGVOyFhVbmkVeMC5MZ
         TDxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783940800; x=1784545600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xk40p3spSA7Dl+t/EMDWt78ol/53BabP80E+M7SNBGM=;
        b=XOS5ams2RCZKkVsUIwqmFFPipsl62dBqPVbFjUanOba93Do2NVgWmWsapl1A0yZ/yY
         9GtjzdqlwEg6YkR4I9dh2qoEQe3v53H5PqXmEwcAL2/6G+gWioN1hGthwiBokZUV2LSL
         3mZVKGDJQfHUJ8vFVv/Y7l3U1ygAUxnzYGECgICvW/uxRQzmjnEE/kmaG4eMe2laDrJ3
         43jtoN+gQ8FHdzo5aw1QRutPU+MBnW4aCfYJwoLbffF1f6QM2aDwzh7hjJcB29DH2sgC
         vKcrlfjUagjRVhGMxc1UADTuUwSGSmCorE0RWQqXyX1nv9p5Yju6f1KXocHhgdq1HVMU
         jsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783940800; x=1784545600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xk40p3spSA7Dl+t/EMDWt78ol/53BabP80E+M7SNBGM=;
        b=qz4LKmUxxp5b4v/RrepZXtrNSRzmUPEZb09DrJIcWgsXw91ieQuDWs8yV/ER+gA4tS
         IcvNJT9A6J7HZxUYHGSghLuFJJO/QHsFkEgvjP7j6Pzn0EFIABlxGjfSnO4ppkqvbTyO
         rHJGCGi1RTwx/jNRjx/A1SPWmRsKKupSUH20eKTBoJ8sHf52y+p8bETxpMSrKWJpnOMT
         ziu/1ltS0ra9SKR5pjlxV3uptT8dvU7kX89MCgFZjunvJfs/tY/2/JVYBPVwIAd9ljWW
         D4yBVFkNe3RCWmQGvZd0J+y0BhSDgZc9czBNVx9bpXEdRYz7qD2seFvkWSoDjg94QQ0N
         hh3Q==
X-Forwarded-Encrypted: i=1; AHgh+RoD6aA6pEEEpLZo181I8/aF6TBg/AuPLvYWcr5eCZFaqcvYmDF89GDEludVQmIxaLt+yIEtNZI9jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2IXT65yYLObzigoR8QdO7ORbAwSW4PulIm3NOZPdoMvmWGN1
	UnHH46dXxGVrgbedIl/gKfhFeqdE+YgyxOyPe9fYHjjy2drpphhGwDGno/73jAhso15yxFINUEA
	wDqC+4nHMZrA8Zixy7Pya8Le3aDnfB33WhyAzTwBeytnQIxwwo8C9jV0ed5pppGyN9EGnHwHZeL
	mnCALtrdsrvg0Qie0dpaKLZtaYeaEHhxtXj92L
X-Gm-Gg: AfdE7clDAHYL/WyWaSC0ICdX0WNcNnhkkbEEweG+Wz8o5L+jN0GVvWKbIGJGX//J8J3
	10XCoRWKuI4Bm/I2DySRbYbGWYHckeRh+Ec7WZHPh8dIZ+QRQ3kQKbrijWB3Yq1fDhSTXrDmJe8
	sQ43dhf8+9UCHi8pOUC+YuEJb6HyuV1BK5Ksqqr8ggexnJ++KYYVzEgg6hI/7097xIs8bT
X-Received: by 2002:a05:6214:3104:b0:8ec:26a9:17d3 with SMTP id 6a1803df08f44-90400b8c041mr92851756d6.41.1783940800187;
        Mon, 13 Jul 2026 04:06:40 -0700 (PDT)
X-Received: by 2002:a05:6214:3104:b0:8ec:26a9:17d3 with SMTP id
 6a1803df08f44-90400b8c041mr92851416d6.41.1783940799744; Mon, 13 Jul 2026
 04:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602193248.443101-1-jonathanh@nvidia.com>
In-Reply-To: <20260602193248.443101-1-jonathanh@nvidia.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:06:28 +0200
X-Gm-Features: AUfX_mzZq7FFwaTj94C41S_9CAvUcbYXmH-pUFHdD2R2hW7sOaExdttegTZszMY
Message-ID: <CAPx+jO-cbyeMALMtSSuyQosLdp8yH+-NP7ELTwfhNoeW4CMkkg@mail.gmail.com>
Subject: Re: [PATCH V3] pmdomain: tegra: Add support for multi-socket platforms
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 3LLXZdfr1jths6I3bTy6Y2NBLdCqysus
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNSBTYWx0ZWRfX48WfWJI1XyDO
 UX/bZTBnv68x9bZRrr8NwXNheueqKvO6LwGcdfq26HFKsiY3szTn1DhgenEsp2mUXcbQ425sQ8m
 3D17kMw1mzzo3E0v6bp6KFyr46u3a9E9EjrOJ8kIOU3iAFhdzCWsyutUrhMqi42zVLPk5vvxbC0
 qaScMBZV37/E+8wLk7ZrxtBZYH/ZcCJG1vlXTaM5hchnUB2vPQWyKCzKcGU+CaJfB6DOaA9X0K9
 K9z+MiC1wmUV73uXM33NLzO1XsI+wjQ2MiEpZuwGTAPiB4Y7U1vpbUpCK2pESxm5pYXNNO50zfo
 XYUlg0wWMN5cKhkKWG0A8e3AcrNy7eKU2CddmSA/qTAFC0Y1QYLmofojz1bjo0uTmgLoMeJp945
 O9SZhmjWj/DLgEOgVtHOS3XocMqBsNf0QUyUEhT7TnwgVXIM9jz9yxC7aW0CN0sJj6xxb0G016R
 knXhkMMt9lWKvF6XIdA==
X-Proofpoint-ORIG-GUID: 3LLXZdfr1jths6I3bTy6Y2NBLdCqysus
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a54c6c1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=Ikd4Dj_1AAAA:8 a=mQxNfCW7Vcdlk-GrVDgA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNSBTYWx0ZWRfXz+8d5dg+Mnxo
 tWGxlwYjhQJWJERO/+G+42tanvkR+DEtzsL0TCjVt71bsu9WwSUIENawfDZyslwek1b+ZrAboPI
 8VH8PwzkZ7uSg6kssn6EOQqHV3BMacE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130115

On Tue, Jun 2, 2026 at 9:33=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> wr=
ote:
>
> On multi-socket platforms each socket has its own BPMP that is
> registered with the kernel. For such platforms prefix the NUMA ID for
> each socket to the BPMP powergate name to ensure there is a unique name
> for each power-domain. Note that we only add the NUMA ID for powergates
> that return a valid name because an invalid name indicates that the
> powergate ID is not supported.
>
> Note the check for the NULL string is moved into the function
> tegra_bpmp_powergate_get_name(), because in the multi-socket case we
> must only add the prefix if we receive a valid name. A NULL string
> indicates that there is no valid powergate associated with the ID that
> is being queried.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since V2:
> - Moved the test for a NULL string to a common location that can be
>   used for both single and multi-socket platforms.
> Changes since V1:
> - Use NUMA ID as a prefix and not a suffix for the powergate name.
>
>  drivers/pmdomain/tegra/powergate-bpmp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/t=
egra/powergate-bpmp.c
> index 8cde4f384846..e6a7e025b012 100644
> --- a/drivers/pmdomain/tegra/powergate-bpmp.c
> +++ b/drivers/pmdomain/tegra/powergate-bpmp.c
> @@ -137,6 +137,13 @@ static char *tegra_bpmp_powergate_get_name(struct te=
gra_bpmp *bpmp,
>         if (err < 0 || msg.rx.ret < 0)
>                 return NULL;
>
> +       if (response.get_name.name[0] =3D=3D '\0')
> +               return NULL;
> +
> +       if (dev_to_node(bpmp->dev) !=3D NUMA_NO_NODE)
> +               return kasprintf(GFP_KERNEL, "%d-%s", dev_to_node(bpmp->d=
ev),
> +                                response.get_name.name);
> +
>         return kstrdup(response.get_name.name, GFP_KERNEL);
>  }
>
> @@ -234,7 +241,7 @@ tegra_bpmp_probe_powergates(struct tegra_bpmp *bpmp,
>                 struct tegra_powergate_info *info =3D &powergates[count];
>
>                 info->name =3D tegra_bpmp_powergate_get_name(bpmp, id);
> -               if (!info->name || info->name[0] =3D=3D '\0') {
> +               if (!info->name) {
>                         num_holes++;
>                         continue;
>                 }
> --
> 2.43.0
>
