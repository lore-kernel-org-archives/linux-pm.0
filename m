Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C23803D2
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259226; cv=pass; b=ZaStydSLNhAj6cz3j8nsuu3ktELFibS1MVKT5HcFK2nYAeiwb/62shFi6rVAnzBJOMU5sMB02AkfPkmYcgHI9QJ47YGBOvoeTUXl90w+VddmLA4Mpd/TqkyrflTvzy9ZLMMai/Ehv6iksnCyAc2mgodoCNqPyS3Iubm0kKuTBMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259226; c=relaxed/simple;
	bh=TZk4Jmgk/VpnmPm93MEhhUcknbZQodVVcX6bnE4t8DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AY3OkharklCiJc+mFYLea94+ZNAyFM+j3XbCvq/oAKDTwY3bvV7L9I3JmETijxFRMAKbfcqm/czC2rLDnsgiXetP4SxINPxNFOaTBNQNNOs6G3Qtgzr/kuhpG2RHx/YjNXyFv8UsaP1NfkyNg34lIzXl4FwnmzYYbGIb80d7dO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hzm1PgZU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gg0MYv3X; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hzm1PgZU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gg0MYv3X"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC4WdJ2749219
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 14:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oMXvHHJQ4qPRTxyYPNHNX4f3X9Wz6eUX2PD7XhGonoY=; b=Hzm1PgZUzUHKsajD
	PKol7gqODFTA9xR64oCo3cyrBuPhVdgwZReLp0WKEjP/8C55W0uXIUagnKAkWSzT
	VugqebCXeji+q/qabCvayQBkclI51keFHDFv1nElElxDsoj3l4/J+4j8DVXFkI3m
	U243E/yxVJ1wGzfTrI95d7GQ8hds5mJ6ul1on1sD58c2pyNtf42TT5Lidc7um99w
	EIFCzIAfSBzcLtBPpaGvTwsKMN8cPDqm7utoIImynIH+3OtpRnIK0O/bxosHvnrE
	q38jRvVBAL2biWqLve6Afm7o7vDzMdcPZ9+9ZYUUKCUNXdeay7q1ae5mFOgpII2R
	oMRQQQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1s90y8d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 14:13:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so4759755a91.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 07:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790259222; cv=none;
        d=google.com; s=arc-20260327;
        b=hN8ScBRPbxg0KTufqYsLxObKvwi9grnYUfuQZRlIAMMaJb0lgU/qWmPGp1HMFDf4xA
         x1S44jdlt6QlB7b5T590wKkDH12p1xxK2/Yla5Ruuz/EdT5B7PauoWzq52YCApoEIsW1
         hJ8hWs7oP7+Mhz4YiYfO2ITbjA23cVLsbX60SacdOhObVtxOwECV7rJOf3ZaMU4A2pXU
         xBtCBvCc9WuqsN98/gWxvZExz9iE3zPDVU9WOyAaKgxWAVWsBN7AJxCGRaGCBZD96QWs
         tHpLiGV7/Vj//qklG/O6r3EAFkyyC2efn+QG4K/d2rwMIwDQ6dX5T1pqn+ouW85cUwDC
         HQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oMXvHHJQ4qPRTxyYPNHNX4f3X9Wz6eUX2PD7XhGonoY=;
        fh=5jQTyq8+YQStNfBzfCEvHsQxak1javUoosgqQjYS0S4=;
        b=C+AghxCrnLWQi3/LJkGhEnWGV3scDunZrLdNKqFlTeAHDoJBXsNbBVpvNo89yzYFkk
         UbSh7yeLLqoRuB5+ABbjOCwAmJxe2mKc69PVWtkEuAlQSOJyKScH4FA54FdMde4Aryqe
         rTr3FYfTrspA9nxVZG7t2Sx5oG/Eptr5BKmVmuWpcfX4tAgecReZdhPqR4DqlgA30mTF
         1ifm+cVlDDB+OxpZMJr8zxRV5rRtXkt16tcQqAKtJXFBsO1fBTv9P80sTI95j+4wzSGg
         tfo/WGTaxw4zPXNEGyTU9lu7q2qNyHv0GP3fv9+LgCs0pS/1vGMYV+OzDaXBuPyQfEGC
         5CKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790259222; x=1790864022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oMXvHHJQ4qPRTxyYPNHNX4f3X9Wz6eUX2PD7XhGonoY=;
        b=Gg0MYv3XN9stA3bviMfI1XZLDFxBLIy2E+1HmzyMXqTdt51HHSJhItuqb+YxEszPDy
         Gthv+Ho9um2qQVWyRZ6n1STJPByDDLbbEHMiPQEp8H2CJNZTBH1EPuWwPHAlWRfg+CgP
         y4YCPl4rh0EBojsjnh2P9EjWFX0iv37oLNbw5E+xWn3xGKTVvy1HWHCnOqTCdP+yEt/o
         4TSI2qtUrvvb0uuhjzuEc+WPtKkPzuP7flFr87KfihYOh1VkBFa+FwkG+Oyeq/jOfjGL
         gnYppmJ17GCWGzmeN2oqjOb+k3eloVlTuTfNk69kzcBpVZNNVCjsLVPM6ZrPjmVvkgDi
         88DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790259222; x=1790864022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oMXvHHJQ4qPRTxyYPNHNX4f3X9Wz6eUX2PD7XhGonoY=;
        b=Z0RKU1COHe4fuE+qwuXHxw2ymr5EhM89GG/0T/YzqWKCmMTbVUJYaEhRWX9g+UlBRT
         F6fCmkiz4h0w4KAfBXRbuX69dEhryXFA8P8OnT6Ilb2w5LLGnDD80DwFHy3Czv2048e7
         WPwJsPj1t828G2KOmH9YvXNaA/0fw9kjzzS4dqcsOpzM0uj9dP18/+v0fie0waCQzrz/
         5YEA7mlDkvU2HJT7yNJ8AxWagSZZexoGU9YQMaVaEmLTzxI03c6Uy2xFag5efDkYLAOv
         jVFntK1IJ39QPuqvQ8BqAqN8W1mj9TAF+k2ZeSIM+990BPJb8GosBGo4J2KUWD5izJHs
         tSyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjfz0LQBIHeiCpDFWISsuVdq2tdDXCvJQwmx75K5NzqfOnojD7yaRbpwjiuhavT8qhLmbhskU4Wg==@vger.kernel.org
X-Gm-Message-State: AFuF++nw5e1DCzP6y0kZylTtjIUkJN+AE/PJI+CtFrJgON1mCgH+bqFA
	QX/h0UrQsGMnmAoQpk4L6OsqGZZT+n/652k6lRfVaXbLiWj0Ujm6qWfTZi60hXWnQi1hVb60LXI
	jUYxYE10bnucVDKr272772bQByTin93wCOOPA9HJgUnu7vgYFEgz63Q7QC0J/PGHhjdn4LnFUOZ
	L98tFDYJ11dlD08lmsJ+ByulqYCcZPBEZCNY7I
X-Gm-Gg: AYBFou2yQvg0KTqrHACxxjqo0FGdb+QXjrBnIYoyrQmZwADWcypOvj5TcvjMJroQFIB
	hsJOQTS0VZSkWUmYfUR2lT4D5JjEPwz6H9/+T+QnpHEIKvAWYfhJbzcL97NVJyV1P4u+41bhuXO
	Xdkv2SxPX8qagV0xBUbubS2oJYiMwals6+Nf1IsLL6UTC2zIflg1deRJS+5w==
X-Received: by 2002:a17:90b:2b46:b0:39e:6c69:9b94 with SMTP id 98e67ed59e1d1-3a09924dbc9mr2318894a91.57.1790259221733;
        Thu, 24 Sep 2026 07:13:41 -0700 (PDT)
X-Received: by 2002:a17:90b:2b46:b0:39e:6c69:9b94 with SMTP id
 98e67ed59e1d1-3a09924dbc9mr2318859a91.57.1790259221076; Thu, 24 Sep 2026
 07:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923174711.1283986-1-briannorris@chromium.org> <20260923104031.v2.8.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
In-Reply-To: <20260923104031.v2.8.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 16:13:30 +0200
X-Gm-Features: AclHuK-tonoW4ObXIcyadoslI1M0Aw12A9Em35d3sj-cyYhDBVuUQ6rDDffvSOw
Message-ID: <CAPx+jO843h9bOeWNATHm8D2afbniQsX7WECJzCxmfi9ZcH9+5w@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] PM: runtime: Add Example Driver Patterns section
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1OCBTYWx0ZWRfXyRtnkBGXzE7W
 EDcPKuWB6dbPX5WFUcoU9lStOD9fgUEWlaILLQGRD0dJFYdKim42mPDf0KqsG4uLjmYjTDaAmqF
 60bD8vA5hcG6eB+ruYFH8eC5OiV6vXGY9alE/nR4A5Icsw5mnDdkANGinMPQSfQ7XVMwzUx6BVP
 /Mz/518O7d058aqKpFm7cRL2TGSVIVTudXcSwSW/L9gKujBSkEAdAxYlySOn82EUqtxKVi62Ri1
 JHoxdLXPaAR4m0KrvfhRYk9WvL6rI74ojL+hJ5rXBlH85/Nh7mNol8DCBwyGS/0ZOkbAqLA/dv7
 yJahSTbMzDWXb6/gC9SoF5tVMuitlLOZhCSsn9alweHSRHK7P6eR1hpRgrMqXgOKngSFwEYbrz/
 jwzucBXX04WVD6QoCZYCZUBiZkKqTr9+QQLjWwIEAtKr6QTRz2FCIDOyhPRW2mIhN3/jBrQJVYg
 iVkzIXSo/zYjMPCN0Kw==
X-Authority-Analysis: v=2.4 cv=VPxIDNPX c=1 sm=1 tr=0 ts=6ab53016 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=cm27Pg_UAAAA:8 a=qxAFjvzqHY3AwNVhwX4A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1OCBTYWx0ZWRfXzvJhvst4Jgwl
 k4NXP+T+qUYR/FE76unp/IqBih7siRGAYgLEOk5iC1H48xYEnYYu5E0Cvj6RIHCLJK+rBTUkePo
 HeOe2xiozQtWF8UJeS/VsmKsO+S4HKw=
X-Proofpoint-ORIG-GUID: AchOkWg1rPf_akAze9BHCMAFubrl6VMv
X-Proofpoint-GUID: AchOkWg1rPf_akAze9BHCMAFubrl6VMv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240058

On Wed, Sep 23, 2026 at 7:48=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> The runtime PM API surface is pretty large, but there are a few common
> patterns that many drivers should follow. Add some illustrative
> examples, to help guide the most common audience for runtime PM docs --
> driver writers.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v2:
>  * Add appropriate teardown to "Probe with Hardware Powered Off"
>    Example, as the remove() + power-off behavior is subtle here, and
>    easy to get wrong
>
>  Documentation/power/runtime_pm.rst | 367 ++++++++++++++++++++++++++++-
>  1 file changed, 366 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/run=
time_pm.rst
> index 7bb64d793cdd..3a615d2de103 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -641,7 +641,9 @@ The implementation is well suited for asynchronous us=
e in interrupt contexts.
>  However such use inevitably involves races, because the PM core can't
>  synchronize ->runtime_suspend() callbacks with the arrival of I/O reques=
ts.
>  This synchronization must be handled by the driver, using its private lo=
ck.
> -Here is a schematic pseudo-code example::
> +Here is a schematic pseudo-code example:
> +
> +.. code-block:: c
>
>         foo_read_or_write(struct foo_priv *foo, void *data)
>         {
> @@ -707,3 +709,366 @@ pm_runtime_autosuspend_expiration() from within the=
 ->runtime_suspend()
>  callback while holding its private lock.  If the function returns a nonz=
ero
>  value then the delay has not yet expired and the callback should return
>  -EAGAIN.
> +
> +.. _Section 10:
> +
> +10. Example Driver Patterns
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +The runtime PM API is large and complex, but most device drivers follow =
a small
> +set of canonical patterns when interacting with runtime PM. This section
> +illustrates standard patterns for device probing, performing I/O, and ha=
ndling
> +interrupts.
> +
> +Probe and Initialization
> +------------------------
> +
> +Basic Probe
> +~~~~~~~~~~~
> +
> +A driver that powers on its hardware during probe and does not use autos=
uspend
> +can initialize runtime PM using device-managed helpers:
> +
> +.. code-block:: c
> +
> +       static int foo_probe(struct platform_device *pdev)
> +       {
> +               struct device *dev =3D &pdev->dev;
> +               struct foo_priv *priv;
> +               int ret;
> +
> +               priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +               if (!priv)
> +                       return -ENOMEM;
> +
> +               /* Power on and initialize hardware registers... */
> +
> +               /*
> +                * The code above left hardware powered on and operationa=
l, so
> +                * tell the PM core that the device is active before enab=
ling
> +                * runtime PM.
> +                */
> +               pm_runtime_set_active(dev);
> +
> +               ret =3D devm_pm_runtime_enable(dev);
> +               if (ret)
> +                       return ret;
> +
> +               /*
> +                * Alternatively, the above two calls can be combined int=
o:
> +                * ret =3D devm_pm_runtime_set_active_enabled(dev);
> +                * if (ret)
> +                *     return ret;
> +                */
> +
> +               /*
> +                * Upon successful return from ->probe(), the driver core
> +                * automatically executes pm_request_idle(dev), allowing =
the
> +                * device to suspend asynchronously if its usage counter =
is zero.
> +                */
> +               return 0;

The above looks nice and simple, but what happens in the error path is
equally important.

In principle, nothing prevents the runtime PM callbacks to be invoked
until pm_runtime_disable() has been called at some point *after* the
probe callback has returned. This needs to be taken care of correctly.

Likewise, as it's great with an example for ->probe(), it would be
nice with a corresponding example for ->remove().

I will have to defer reviewing the remaining parts in the $subject
patch, a bit limited bandwidth at the moment.

[...]

Kind regards
Uffe
