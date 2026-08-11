Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380A636215A
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456356; cv=pass; b=snVhj//0jt7XPJPoYffKsoxNMOzkOwBH3xNllt8gKY9RVJob1x/FINfUIcvTETI9DCnAqxhegtJnIr+vMWjTfgTOa9hJH8i1ivIPgbt2t6e6AhkUV5yYFGpdCVphhQe99YfKHg/Qi41BZpjdedNSlMZxmGkIUsqMGHavmFwiG4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456356; c=relaxed/simple;
	bh=jh0MoDST7A/sQpwYirQA6u5olw91Tkfk1DW6apY+ZaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJQFXVc0cZmqXba4poV/q2f/nri2f7a7wVBkKVCMaAn7GszkZ7UvtNxdWdu46mn7KBt8Sq2zRaqgy75QOLrRCRGaU4U7zpsbvOdSHjd9PYHAmO4CNXjyUlGsbIavakWv/lD/pVUoSK12I8NOp1L35qACDa5P7cto+Vm+FhZ9zFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U+ZHdORD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=idwr/e/h; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U+ZHdORD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idwr/e/h"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWtHb693942
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 13:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BkjMWmR1feHU62qjWV8aoheeQpabWNWyYsd2BQUC7H4=; b=U+ZHdORDy7jxTXWB
	olzmdDXClopXlhDRVV0CDWyBbhjsux2QuSvyc/WhRMK8bIWaOTgQVy8mBbkaOyr4
	el0+MqGf7c6hNht9+j5PX+2/9VBqr1xdctKEB/MlB7BVPVsl9l4Bm5FD0aG3uqCl
	86W5ssFkfM+WElcNDRQRjLUeXj1yk7q3Rjf4NgaaHq1WoIPpRIlM9PR8YVv/hwd6
	tRHP+BAMmvucH99F6wfj4qfen6PWVHCVh0XhQSDBw8vkXQ19G44jMCoU0aXcEpoS
	rs5G4NLoJyUF+p3+mJI+wP9T1xvket3gOr0Ml82SJw9KJLXGO9PieqptrnY3eJSq
	NHTFAw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049gr84s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 13:52:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso5749178a91.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 06:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786456349; cv=none;
        d=google.com; s=arc-20260327;
        b=fXfq3X4Hf6V7khuInSRsCBdBSdF2grO73eN3fgx3Ti3PQaF95rIGLdMbZQWhGLfNyY
         3Hhx//nLH5a8AIDsIy9Mxq60X31OBdtlBHQTG2FTcm/mHyUDcZMhDnazSxOXenVwF9vx
         1RUC9rPqtMSf7nghNWulJROAbG0GkK5pyW4s7NM140bJVxajf4KUse/j7oynW352BnmS
         vX+6gZk94KWTu0ynG94/fqcZyjBJndA985Y0o7FerIfexlPlq5K5E9sglDhl2i8Yk8Dr
         3H4pfJ3JE+RGMZSWis01Kwv5Z2LWeC3czjfK3/h0ZUR+NC9pXCViufhM/2JVdGHOxElv
         rA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BkjMWmR1feHU62qjWV8aoheeQpabWNWyYsd2BQUC7H4=;
        fh=Y7z6TXpBxUbHNH3b1ZXoEze5BRQXu/hYr6d5bSLtaa4=;
        b=dNsRF1tK6GlG9O+9t0a70QoE4DGxO6/Yr5paDBxpCx7s5P6mWfX/uMkMD9X/ki/Z/H
         o6b/MHwmo6bifAik/fX3M8nhdOi802D3UJVwSmc1WT/jdlqS/FAYjy9geHQsoFLcyHXf
         wcICy5VeJ2uTLaaiaPwHsLjAj1LZteFKSn5N82QpreKSaaSiBSEZSjErevTwA9s1v9ue
         FOQLBV6D0n64SQCqMCuLxeBCcMhxM3VzsZV2yu7f+akdP1sYqNxeBDbp+lFWKClwIpcO
         aQ4VQ4/Lpg16ia48EMLYgMiXUsgEdmPJqO3q9qAJ8vMalzR3MasG3KgDGntw6xTVwEnX
         J5Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786456349; x=1787061149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BkjMWmR1feHU62qjWV8aoheeQpabWNWyYsd2BQUC7H4=;
        b=idwr/e/hQW4C4TjzDo1wfLs1LvQTrlhZicFCfpUhuqZmHepZDPuirHHW6PwJhcseDy
         ZsDfbzkVPat1YKpfTc+ldiQYPmJZs1cfBrfhtMAwZpMvACJUkD3cHONh+c04AsNxt5qy
         qj2HyJ9YPiv7gSmr3mq4uRmhLSfS802X00qoJsJEAmDnpzH+b2zt09SWtuzzGF8MNSaZ
         QTh3xbwf+cpBzcTxClI8LOHoWYgGsDh3VcK2E3o3ZIVzbJBkSA1S3Q24YwXy941a/LtO
         TB24M3un72zZ9X8sGH9waoGEsXRAAnQnm9AkOF2o8r/S2QON1B/UOGThWkPTAjmcPNyJ
         Fxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786456349; x=1787061149;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkjMWmR1feHU62qjWV8aoheeQpabWNWyYsd2BQUC7H4=;
        b=YM9K+xI/GAALV/1yxntazxX/mjrXs1tONE9PPoNi/N12BXe49fj7Aje6HJM/3j/POd
         foX99Fhy9iMvAjy5y7UOFDAgeLUsW1eAYrSJvXhcZ6e9nS8hMkbCiaj7xvf4Fz77ZvPA
         zmiyqRZuAtVDdNpuWYY7m5bXZA2jnMqNEX+VD5OUk0Q0jJD/UqcFhbpHVZAnqp0TVYjD
         rzr/sIU+2FzyS2Hi8zNuB+8azrLVIjpOIefwYaTdSKYkyMtm4V7xALdND9BEc4Hk/37H
         hfeA9veh6TPQTLZTZJOq5ZD8o5U3Mvd/FYv3PJ1529OdhvvDoBGSRGzMvLAYj3XcIGFg
         a1qg==
X-Forwarded-Encrypted: i=1; AHgh+RrKXXbWuG5nh5sHfzk1vS+HhBJJai7T35TLOGf3aH+L7LnK71prtJIZ+UOzqo+PvNhXoM5N9nNFfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWKYq3PEhZpZ0w6q7oiLcfUgYr70JG6WENsVPWNHb+H+Pul1d/
	YnOmaB6Twwmqr6uYrIgV3ucrlRhv7MN/KDN+OPaDFBDwiEjU2cmXMoi6jHB99UEf0CHaEkMLEaV
	NlKldbQWtHsUiUWCkeqKy/JhpPRhgW0yGqBq6xZeHYvTj6JwJD0VAq8Nh4RmW2ShIohIvpGSWXb
	OWk6PbqE64QTICN+8eTpmPKCg6jL6zBN+SthBb
X-Gm-Gg: AR+sD12/ctFtxAHGn30ZfXl6h9foVRvfm2cmpzVRHGlYmbgAxR5UN6LDwpbXsOAQ6XA
	wBNIDdFwGO0RStsSPqP0POZbxxRbw5MaZQ1WdLgycuJHOjWYbLmRFdVsXQfJLPsZhCp/24DPh6a
	uMTbVfuN7KyU+CH2N7PPibNQKL5f0QONgFQREzHSN+J+TD2b7pS+A2bf2i+w==
X-Received: by 2002:a17:90b:1b03:b0:381:11eb:d78e with SMTP id 98e67ed59e1d1-392ec5dc6d9mr3652676a91.14.1786456349058;
        Tue, 11 Aug 2026 06:52:29 -0700 (PDT)
X-Received: by 2002:a17:90b:1b03:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-392ec5dc6d9mr3652627a91.14.1786456348543; Tue, 11 Aug 2026
 06:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d4bd0cc7f26c1bcdc260edb994b4971cb5dd3a10.1786438424.git.geert+renesas@glider.be>
 <CAPx+jO-uXbNpFPzbAbDkBQh2-xf4r1NXk2PdQvOh9ZOfEQ71gQ@mail.gmail.com> <CAMuHMdXLsMfGEz5s9s3voZGbQL90hRYCxsfC==xsGs315XOHWA@mail.gmail.com>
In-Reply-To: <CAMuHMdXLsMfGEz5s9s3voZGbQL90hRYCxsfC==xsGs315XOHWA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 15:52:16 +0200
X-Gm-Features: AUfX_mybzQZwwCvQgA0yM2mL5trwMTqnwsNDzaQ5rlRRNSZcoScwQKtQyyGjVEk
Message-ID: <CAPx+jO9BAScZwWuxPUKr-hqGamGbjzQRjX9nHGXzXe2XCLugZA@mail.gmail.com>
Subject: Re: [PATCH v4] pmdomain: renesas: Add R-Car X5H MDLC driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExNiBTYWx0ZWRfX685SGpkkynRO
 87rHD4jau+++6Ffw04sFghrAyzGNxf5Y3ir31pkh6Fhemz0iBaOZCmbzW0kdL82EMpKZPsW9lMi
 xnn/T2vyalbY56IOx/veiPq2FF7d3Fo=
X-Proofpoint-ORIG-GUID: uu0Rjsk9ep5RLi0KQlbfmh-4B3dM0PKi
X-Proofpoint-GUID: uu0Rjsk9ep5RLi0KQlbfmh-4B3dM0PKi
X-Authority-Analysis: v=2.4 cv=cvarVV4i c=1 sm=1 tr=0 ts=6a7b291e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=tBb2bbeoAAAA:8 a=EUspDBNiAAAA:8
 a=fImYK-f9FuHjHgKINGQA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=Oj-tNtZlA1e06AYgeCfH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExNiBTYWx0ZWRfXzgE1h6p0Vt24
 1gZEw+ud/YVVhN3+YWy2auqufErGAOdIhzHxEG1MKnQAl2EAncXcASp51UQn0vp31rBd1AwlLch
 YefL+PWwPsz4Ew/eBkf7MMrgjxCQDZBI/WdnlAB62FFCUVwi1H3/mIxz5tMrnr25CEAt/X2KE8Q
 d3vFVrAEW1AmPWuNPB+3CFS83lhPiIiSfZ0z0vcvPjLhhufIf8fdUpn/04wEPuKVe+ox9K2RRWp
 vwz8o5I9aq1RuhIfxw14YQae5mTnCYdi85f4J1EEnWp+a2exDj58LHbZjvAB6JDXlc5dycGE1hZ
 9WMsXOVL/mGiFi99eXkYjHUu4TP5OBfuGWoCubuNbatuPqsejue0dt478BHd5czzU0OR6x5GYN7
 gqeTHk8jZRdA9EeOHZ7qv+ESXDQebToa3zuP5jp9So4jXNn17/8AVH8ZVFwyugC64jDI7Nn485w
 QQHNDi7WyaccFYhLdUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110116

On Tue, Aug 11, 2026 at 1:52=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Ulf,
>
> On Tue, 11 Aug 2026 at 12:16, Ulf Hansson <ulf.hansson@oss.qualcomm.com> =
wrote:
> > On Tue, Aug 11, 2026 at 10:58=E2=80=AFAM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Add a minimal Module Controller driver for the R-Car X5H (R8A78000) S=
oC.
> > > For now this just supports the always-on power domains, and dummy mod=
ule
> > > clocks and resets for the serial console (which is enabled by the boo=
t
> > > loader).
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > I had a closer look at the attach part and there is few questions,
> > please see below.
>
> Thanks for your comments!
>
> > > --- /dev/null
> > > +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
>
> > > +static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain=
,
> > > +                                   struct device *dev)
> > > +{
> > > +       struct device_node *np =3D dev->of_node;
> > > +       struct r8a78000_mdlc_priv *priv;
> > > +       struct of_phandle_args pd_spec;
> > > +       const struct mod_map *map;
> > > +       unsigned int id;
> > > +       int ret;
> > > +
> > > +       ret =3D of_parse_phandle_with_args(np, "power-domains",
> > > +                                        "#power-domain-cells", 0, &p=
d_spec);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       if (pd_spec.args_count !=3D 2) {
> > > +               of_node_put(pd_spec.np);
> > > +               return -EINVAL;
> > > +       }
> >
> > Is the above check really needed?
> >
> > Assuming r8a78000_genpd_xlate() is used for attaching, then the
> > args_count must always be 2, otherwise we return an error code when
> > trying to attach the device to its genpd, right?
>
> That is indeed true if power-domains contains a single entry pointing
> to an MDLC domain.
> This check also protects against the (currently unlikely) case where
> there are multiple entries. But for that to work well, it should indeed
> validate pd_spec.np, too.
>
> Is this good enough for now, or do you want me to drop the check?

Let's drop the check then, as it's redundant.

>
> > > +
> > > +       scoped_guard(mutex, &r8a78000_mdlc_lock) {
> > > +               hlist_for_each_entry(priv, &r8a78000_mdlc_list, link)=
 {
> > > +                       if (priv->np =3D=3D pd_spec.np)
> > > +                               break;
> > > +               }
> > > +       }
> > > +
> > > +       if (!priv) {
> > > +               dev_err(dev, "%s: MDLC %pOF not found\n", __func__, p=
d_spec.np);
> > > +               of_node_put(pd_spec.np);
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       id =3D pd_spec.args[1];
> > > +       of_node_put(pd_spec.np);
> > > +
> > > +       map =3D mod_map_find(priv->mod_map, id);
> > > +       if (!map) {
> > > +               dev_err(dev, "Unknown module 0x%x\n", id);
> > > +               return -ENOENT;
> > > +       }
> >
> > Would it not be better (if possible) to do the above verification as a
> > part of the r8a78000_genpd_xlate() instead?
>
> In the current minimal driver, the verification could indeed be done
> in the .xlate() callback.

Okay, thanks for confirming.

> However, subsequent patches will add actual data to the retrieved map
> entry.  As the .xlate() callback cannot pass data for later use by the
> .attach_dev() callback, the latter has to call mod_map_find() anyway.

I see. In that case, let's keep the r8a78000_mdlc_attach_dev().

>
> > > +
> > > +       dev_dbg(dev, "Ignoring HW module 0x%x\n", id);
> > > +       return 0;
> > > +}
>

Kind regards
Uffe
