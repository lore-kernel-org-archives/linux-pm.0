Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0809437BE70
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258475; cv=pass; b=tcZTaVa/ZiFrV/X+M249pg/pPUxCs+sKV6NrxJWgNHRodm+OuJGgj4DoNoiY6L+2Ha1rn1t2XMCnyYO1YaimEYX8MykAvsK5sdoI7tlMs45rjrcJb59lKN3jH7Dn5TC39X89ihn3eOiS4IjisWomfQn2BYJ7YZXSH/NCDTQsDwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258475; c=relaxed/simple;
	bh=I3C8+LJfgclA827uj4Soi1Cyi3ZxJhmbO0Ll3OMgiP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRKMV2JBTXYEWy7gioByF2dLUnTX4PHYNhLlgSBLL6keaeMerK01k8RlSbxPxBqy3JWALua+bIP6Xg11DI6xpMeq+H03frmx8KiUzXwI2M/4OoHyPp2BhhxLjugagR2SF+i+HPTo3C3B5OoiEOrxxF4v9G4QdBNnJuKPYxG26cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J/qih16h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+GEsJXD; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J/qih16h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+GEsJXD"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC521V1631047
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 14:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K9BiUjTBG1aiuSWd/O3sMeTOxrUy8pb7N4MCcYUpZCs=; b=J/qih16hvmWr/aDJ
	iFkMZA8r4dRevB2A12ZnmJByLJBKINDtIxv4oWsM05cb/HhtslyZ5djQPl+XngT+
	nM1zH47Hu9OtCV6qNTU/eAzAB9Vr2MPqqqX/19Ec6/mwSfpC7c8EqHoWUCsglvsO
	GpPOgY2f7r0o2/uys27jhFEK19uzrFfLCm8Ri1exIBGPhdrrKbEF67+SK0kS5RMd
	OpRldW0hkaSOee9uuYohBdNW1FhUz8iuldXx45dQJO1+zIOUynCnpbZehbvMX98e
	odTZP0rfk5hymgd2T4PWuK2FY4SJePCYZMtMM1oyzI3sBiR9XFGHK12mjyi8Swfd
	o27FvQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr90bd84-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 14:01:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc72777faa2so1454806a12.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 07:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790258472; cv=none;
        d=google.com; s=arc-20260327;
        b=Swmgu5iGd1FoLs3q3Ep687KrP9YP+elmVCXwRDhDXRJh5uqBR7escieaR/KEE9q3tg
         dm1kSdjxigsD4uwqycCKOjvhWlYj6fSk/kVDKvV0cydRi21PmeYc0YVIHnlRT8sEj7h1
         SOq7QQMZiVko9RxWrw1+OZQc9Ut52Scpd5ms0RhrYkBQsG3N/cA4zOY39wpnN5Dp4Ksk
         ljKjAZeY/00XGjJ8b9JgMWjzqj0c+JB0zlnbSlKS5+OH2wB1my5BHmfKzTaO3CDNXjEP
         mXifHobyBhhPiKL05dq0l2MmwVp/PJGoGLHlP6t8wSNxtLy5LfkQNfZStvKGZEfESyJP
         d6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K9BiUjTBG1aiuSWd/O3sMeTOxrUy8pb7N4MCcYUpZCs=;
        fh=ltZMOpuxLskg0GeoqCPlPvwVP/LjvWro/KcF0sNGxPg=;
        b=IsQ0YvRdFv5o8xTinWHe/6QWkLiChQ8zNr+/rH4Wh8PtunihfjiHbHNUYIcuAIMh51
         9zH2+JdWzc7dZIP6R6bI2YvJYuK5u8dsgpJvAy7ZEkE/69RSVY6LKE7rSGAYK5cciYJk
         sWden677Dxy/GmG12aKT0nWWLclK2kMCAM8XlwzAV2JlndT8Onlgcb3cS9IebRY2C2ro
         CgNNNyt4VSbj44twE0QrYSMI8EGumMGG8kxYr6EXgIjct78ilrlceDcltrpCVdr91pjb
         fJFfGpNCBvBgGITE9EM9phBv1u7Nh4wTQ1GnUCONh8rZCqEkRyEOV8re+RCMq/BdMQtW
         D2cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790258472; x=1790863272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K9BiUjTBG1aiuSWd/O3sMeTOxrUy8pb7N4MCcYUpZCs=;
        b=K+GEsJXDfnXz7xu17h9nCACljjB+7WOrw90y6LrbUS12FTUp7ujDM1i/775n5Z5ie4
         OP0shQX9IFaxx8j2a8WV5kG6/mI6wyLhAfvb0VFp7f2L0QYECalG1AapIDxBzNaV3uSu
         6MX3DiFRDrZ/5BRHUuzcdVcV/RJwJvBsd+U+HPshIOmbu88IBWFd/DiiPytpuNwxPq/7
         y/eysp2CqCbvvh5X79Nr3fjeg9JBP3sbO0hHhzmUG1g37cyTtGMS6cJE2n8vjeZ0rTMn
         zbrdoKqlEPN8AmPirvRxjVHKSH5qT43aD0l7MxUM1H1SkfMbR4VoxwxHXue8btwoWo7L
         43ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258472; x=1790863272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9BiUjTBG1aiuSWd/O3sMeTOxrUy8pb7N4MCcYUpZCs=;
        b=1K1ijgMriW/wm2GFdbRCslAaIo+W+QpBKqSk4dFqjXlwL7c8h+pWuJCoMnf/m03snx
         8ERGRFnjhgZtqS3UvyzmZu6zO1VJHKHGMa9v2M7yt4TqiSQrvELqAdfixGclcwVzA/3k
         eMmbrJZEyFZFnnKT+Tty3LEJZl4IUI1BeBxDU3bO9nSVXmURUYCAuOdJHNIhBzl7sMyU
         JoR0Jh8/Sjgk1sL/857EHl0FB03Ms3Qbi+gR/mtlXRwNEQJ3roT3fT9QfJj3mLIKkAWq
         Ih15W4wNNWhKcfyqbYF0oA+RCniRnDOk4WVpFFGUrEDp8KIIEXDSiTEEUfHP0xZugYp+
         MOCA==
X-Forwarded-Encrypted: i=1; AKwUvBypuG16xKMI2ygN7agBZF4TQIuq8jERzMApbhr7ngE4/P5esmAwyJxdZXOJ32Y672uuRwCU1u1FpQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m7tYo3gCWW6Jm4oieEUgVLwCV3nSNlpwZpyoJNxrbANwETOnoE
	oGKEqS0gGmhlFs5sLhHQoD+INvMn5QdEDyVBTZG6AQ+l7M83aD12fLYhYH/n+3iYqxmlCRbGKcn
	H5D8DEGuN/dHeEqBWOqzKS+tJA2RWYTsMRMLLIWU0WMWjYGcURWY1dhQSKOG5Ur9weKA4kQ2uHS
	0ovAKlEdfyCB6hZ1+7ULjbTOASf4fhULx+burN
X-Gm-Gg: AYBFou2T+sz93ll+TzV+bxZ6qe4IQcUz8jSLq95fy9O3YIoYI2CcmgnyCQbNV9w3xXZ
	puDdVOvZStuae1xgPysUyTE3hW6urXnT1PJho6FYOp/EW6bOsQbrprUt5hQPnsxnsEXtSS+zL+a
	M+BSHP3jXu35btkSRNjOHtTIMXVanOB5PpA3ZA3X6XSnkl9ynbamqeWCN3MA==
X-Received: by 2002:a05:6a21:9211:b0:3dd:a009:317f with SMTP id adf61e73a8af0-3de0e8cf50cmr2292862637.39.1790258472071;
        Thu, 24 Sep 2026 07:01:12 -0700 (PDT)
X-Received: by 2002:a05:6a21:9211:b0:3dd:a009:317f with SMTP id
 adf61e73a8af0-3de0e8cf50cmr2292816637.39.1790258471383; Thu, 24 Sep 2026
 07:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923174711.1283986-1-briannorris@chromium.org> <20260923104031.v2.3.I383681b22c12d7caee976cb91aa90d1a94d4a591@changeid>
In-Reply-To: <20260923104031.v2.3.I383681b22c12d7caee976cb91aa90d1a94d4a591@changeid>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 16:01:00 +0200
X-Gm-Features: AclHuK9_LJN_Pz_e_vxq4yQal5Z7fnTX7prwt3aNxfp-JOq6nVdTbmWlsg1EK9U
Message-ID: <CAPx+jO_1qYnN37diVN1=PA0xGa0iSBfXD_uqgSdFpTn4t0zJiw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] PM: runtime: Misc improvements to runtime_pm.rst
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NyBTYWx0ZWRfX1QQh5nMw30cE
 JMSWhql0dUcSUVv4Jr4pEnz9A8tALnfUS52vVPQZqFIlsHnM8fBuW0jOsKtVLi5OtQ6f36iNSI4
 3FyfrgsVvy8KKFdOjQB8T7l1Igh5fdo=
X-Proofpoint-GUID: E2xME0LJln_v-X6X0nTGtZdz1FdoEDdQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NyBTYWx0ZWRfX58UQBZY1DRgO
 qZWfvPTIw0+8g14SikWtkIbb5p5MoM44urSOCXbj9hWm4darnqgW+Yp0QAjyfBUXByYXNqhK0UJ
 Vf8QDLPbT1fyCiAofcsE48yWQ/hKIULcfosiZBnv7oVf3sI7E4RuyJXRxyPy3YBJHVgkAa4o/xQ
 tslLYH471o8BkxyS3Kzd79XxH3tnWkl9kfVjSQJdImpv7cyjx/DWHYFYyJClgOPYiq0mQ/+TxcH
 35ZI53ZdTitoYBMPPRp7yJW1vpkDgDRXJRCe1UxZjXtU3Zpsbv//Zt1B/dUtituXFFe02hDInOf
 p+sARuFFQzm/roBA1gEuKKNfPOhFBUmpkNG/Rd/sDA0EvAukgf74DnkIQW0WauDuS0clPYVlI4w
 fx2rdLaHsaPpHlSPgZv8jszSV1fpjptzHUu84sIzQCJutAorQhRk1Re1SG7mFQ6VYTMgPKq8DW4
 FOO0fGtI9jJ72uYnwGA==
X-Proofpoint-ORIG-GUID: E2xME0LJln_v-X6X0nTGtZdz1FdoEDdQ
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab52d29 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=cm27Pg_UAAAA:8 a=J8m5VRO1IUQSW3TZF-oA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240057

On Wed, Sep 23, 2026 at 7:47=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> There are several small errors and omissions, as well as new updates
> (pm_runtime_resume_and_get(), devm_pm_runtime_enable()) we should
> incorporate.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> (no changes since v1)
>
>  Documentation/power/runtime_pm.rst | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/run=
time_pm.rst
> index 39fdeeda7a1e..352cdaf0650d 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -238,6 +238,9 @@ It is safe to execute the following helper functions =
from interrupt context:
>  - pm_runtime_set_active()
>  - pm_runtime_set_suspended()
>  - pm_runtime_suspended()
> +- pm_runtime_active()
> +- pm_runtime_status_suspended()
> +- pm_runtime_enabled()
>  - pm_runtime_mark_last_busy()
>  - pm_runtime_autosuspend_expiration()
>
> @@ -249,6 +252,7 @@ functions may also be used in interrupt context:
>  - pm_runtime_autosuspend()
>  - pm_runtime_resume()
>  - pm_runtime_get_sync()
> +- pm_runtime_resume_and_get()
>  - pm_runtime_put_sync()
>  - pm_runtime_put_sync_suspend()
>  - pm_runtime_put_sync_autosuspend()
> @@ -258,7 +262,7 @@ functions may also be used in interrupt context:
>
>  Initially, the runtime PM is disabled for all devices, which means that =
the
>  majority of the runtime PM helper functions described in Section 4 will =
return
> --EAGAIN until pm_runtime_enable() is called for the device.
> +-EACCES until pm_runtime_enable() is called for the device.
>
>  In addition to that, the initial runtime PM status of all devices is
>  'suspended', but it need not reflect the actual physical state of the de=
vice.
> @@ -287,7 +291,7 @@ enabled earlier by calling pm_runtime_enable().
>
>  Note, if the device may execute pm_runtime calls during the probe (such =
as
>  if it is registered with a subsystem that may call back in) then the
> -pm_runtime_get_sync() call paired with a pm_runtime_put() call will be
> +pm_runtime_resume_and_get() call paired with a pm_runtime_put() call wil=
l be
>  appropriate to ensure that the device is not put back to sleep during th=
e
>  probe. This can happen with systems such as the network device layer.
>
> @@ -315,7 +319,10 @@ removal of their drivers.
>
>  Drivers in ->remove() callback should undo the runtime PM changes done
>  in ->probe(). Usually this means calling pm_runtime_disable(),
> -pm_runtime_dont_use_autosuspend() etc.
> +pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can use
> +devm_pm_runtime_enable() during probe, which automatically takes care of
> +calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() upon =
driver
> +detachment.

As I have stated in earlier discussions at LKML, the
devm_pm_runtime_enable() API is not entirely easy to use correctly by
drivers. It means that pm_runtime_disable() gets called at some point
*after* the ->remove() callback has been invoked, which can cause
problems, unless the driver's ->remove() callback has managed things
correctly.

My point is, the above makes it sounds like it's easy to switch to the
devm managed version, while it certainly isn't that straight forward.
Not sure what that means for the documentation though. :-)

[...]

Kind regards
Uffe
