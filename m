Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958D41BA72
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239708; cv=pass; b=rZ4d8a+ryd42+PLZ63NWw2tDBGs3+W+CSjaYafmRzLGkYifliVMXOC7wNRV5k7qmJzFXvwneBPcguxkWUeMVVnvvJErNMtbW46UbVaORNQdJHrprq97QEeXm1KGmykaex94+9dJ1ynmeJWUHelvpRUn09MONRZG6GzGi2eDuyVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239708; c=relaxed/simple;
	bh=a6RMuJQJVgcmdo2FqqcPGGlaqz+fzXXQLNDe+wtIF20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GF467lyizfVW5UyCgQdDFfGmjQJee5iykw471Py6u+nDuIa2C4bWHQz3R2g6O3k7gLQwyzIMjY+CmDF02VuNg6JbCBzveWc3Zk47rxxGcBukRdnLkMQy5YiWcMosGTeQ0u+s7ez9cu4QeSHk9K2pKICRgWZrz1u3Di5iVc5gGnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UN94VWfF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mxk77SGP; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UN94VWfF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mxk77SGP"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eLNd1278331
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 08:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QknsdGv7tMuii6XXd1cgWwDNDr2xK8Jt/GMeIq+snas=; b=UN94VWfFCpWeeKgy
	OU62S9mvL7Zq/yMvALPyLzwyGxlf9AWoAZ4ggWl2keo+hEG8mUFHMJrFwJGYizXh
	Z1XpG7q39jMmxqybXtGM5xAEvAuSbkLJT9QPHNcfUiyUa7PdLzBTgV/3wO+6enDl
	aJdFfIFXddLX5conuM5JpXFzZieHf0UbvR6iK5II/WZu6O/gZgcQPaZvp4I4Tys7
	Dp/itSLyVeZOQCxblW/qFDjgZQrOE7LQSmP4OWMiDn2uUjkpEQWZv5fk2PL45WUw
	/9rbbA75soYkShhap0pXQ/Tm7Cbd6DNk6yJ/1BZS6R2sS4bEhJ5AdNhj18OCvQaw
	wGOn+g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvhsb3gg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 08:48:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8632fdf67dfso717972b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 01:48:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790239704; cv=none;
        d=google.com; s=arc-20260327;
        b=Erls8CPm19P6G1QMcsCJ9QKMBgrrVxUM4Auoj+FDOkVxTgC9XPwFBYH74x7gA7eEiu
         RRZPXbMMGvcQsZOmw7f6yfkn78b90tnHVUUDHs9mcgqekgSYoOenvYazTHLi31EVP3bd
         UgnL8CF+P3dLl5jjRRViGqcp1495Bn49kAeCe+POHi46Pd4DMRgN8kCohjpdkzC+FLub
         d4lvm/BzhVyPMDNYTUtyhCuw5xsBnGkl7lj5pATnH9uyvcGMw9CZ9rM5HyOlnm8cbosj
         oh8iLFRZZ97no8tyz1KiapjfpmG4ud0SKUMYE/0s/jHM9xpl5g9XkDVlqWpekj6RfXha
         YFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QknsdGv7tMuii6XXd1cgWwDNDr2xK8Jt/GMeIq+snas=;
        fh=zDNYC9QUoDlWjXEs4Tg5K247qLu61pgihSoLb98YbEY=;
        b=ILzSmiL5RT2vv+7KhRLzoHk/Zr2tZR2XAPOdQw1SoHELjla7jFB64lOga37p5NEVx1
         Ya6A4YbCoI7rE/DaPnwle72c6FaEvW12DixdMwjKDGeMQJKfGbH9jzfpYoEMRo+pH9j8
         wtWwdB6/cKDvZP5o3bjYPE1mA2VN/UzOsPx37hWUTW2OWyHe1VPyNOcJKLhoQ20Y7t3T
         F3TQNeGK+Vt+5V55obaGucTo4/v0uJ7lqkY32OuEDjuSo0TwOavS6DK+ogrRPyl95jsc
         TIN0PEoCXLqDnc9sCXomC8qrRwsn+lMtBby7XYnvFbD+NyY4QXVI6/iQlCfrOmQzg35m
         2TtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790239704; x=1790844504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QknsdGv7tMuii6XXd1cgWwDNDr2xK8Jt/GMeIq+snas=;
        b=Mxk77SGPH1xZgW0MvvYzLb3PCAlcAzAe0hKzeFGDjJTKsve11Sp6r6I8u0HrVZl4Rl
         JQo4YJoBQJsjQjIv0Pv90H3Hm3T68TmUvgMJGu1KNVKz2+bt9e0GfWHdzhEdoWIXfjLl
         u/SsU7ZvUiwKJqq1RzoPeze461m2Cj8Ff6BVqVplTExd3JRQ42awwNsm8HWnlRa/83tN
         m5amWgtX2T8c6G+LcjlyFj2NXND7Pt6mAXFrAhnCGv2MsWeO0Bvy+44EZLFOvPrW26xe
         ScvT9SMSzmPfNtVbkvJY/pKUBQlJHJrHAjbdrdR2TMO+1APq4kRT7C3+cNP8A4LFV7Jz
         a3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790239704; x=1790844504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QknsdGv7tMuii6XXd1cgWwDNDr2xK8Jt/GMeIq+snas=;
        b=yCx4CGM6tcq+BIZzdn5PoGUZONWyKEbU+G60ehvbqAr3xzXmeqLhqClvrLl5Pt3MEQ
         twazTr3CoNxxDOMNRmvp/gwqQ/QKSJ75iCwQyU72CzzRZ5sK4beNrIK/r/hLg/j8dz4j
         rjXiJVuzmbZqakmRiYbjx2EBbmZW7GuPt0qaifI4qJoY5hSUvWZc+b0Bayi8pB7+jM9G
         2xIitrKXVf0XTOG1S4JZ6FC0LkLMOyM092t5RPFsCbOOVOm70qrvynTS2PpunjmkcPue
         Hx25EI17wGLKjRBVKGv2kk99GC7AcDBCVud8dmj2Ffs28LWz8gsu3cTjq57RNSrNURbk
         qIyQ==
X-Forwarded-Encrypted: i=1; AKwUvBymH+5WGAW9+nLl1MsaIIfz+N1H1lMKjMQ25bH+2k0wrcIipA8YPPrMFf1EdtshEQZfmXox4Lv9MQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kpD80rA0xyT+cU80WrfQLR4FI2O1oE+I1+DTXQQevQwCgdLSF2
	z6XwmKPalCv2XdZ11xO4qEUtHjFlUhPtY2RKzOPAWJY1UvEvFI+zDcheP7ZrK6mF96ThvR6XDcX
	PWnxHe8nswD1+GkJDqFieexz8q9Rfm5PKxe8AME0xK8vyGVX49SF61VCx1iFDhKv6ue6I5OOf6j
	EfEuZmw9Jx7wgLVOvNZ+R2a/nXD93qXTYZXU/uaVqeVLTKGbs=
X-Gm-Gg: AYBFou2a3RSLa58Te1ImhRlq1z0zE9DZbI+locVijK0K8Tn9Z861qbC4ZmH/gkha9rF
	E6hMLMZHWvIaBzJyZGDeEhsH0lwuB7gXXqmCFOISzDrci7ntw7wTQIAQISFFuUOO/VWbXKR/UD/
	EEKnQn15AKm0JSIoBnbgvElwasWP/bm6k/mWuI6HzcU8uvO6iFdnGyNqxFvw==
X-Received: by 2002:a05:6a00:3e16:b0:874:72b6:7daa with SMTP id d2e1a72fcca58-87ea07d0ad5mr1069234b3a.37.1790239703773;
        Thu, 24 Sep 2026 01:48:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e16:b0:874:72b6:7daa with SMTP id
 d2e1a72fcca58-87ea07d0ad5mr1069219b3a.37.1790239703328; Thu, 24 Sep 2026
 01:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920175928.42566-1-s.shtylyov@auroraos.dev>
 <CAPx+jO-Ph038WJQ4gMH93XzoMC09+meht=yT9JQBAnTD6HzGEg@mail.gmail.com> <d07cb609-ca44-46aa-bd56-2554846399f6@auroraos.dev>
In-Reply-To: <d07cb609-ca44-46aa-bd56-2554846399f6@auroraos.dev>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 10:48:11 +0200
X-Gm-Features: AclHuK8KtFrkT0Zvnhed46Hh0nuKWmXhRe39UhgcDjpnRieTa9rTOGP9GA8usM8
Message-ID: <CAPx+jO-c_w55jO9i_Db459Ya+9yV3nT3akQcaPxr0qb7TqSejQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: rockchip: fix domain check in rockchip_pm_add_one_domain()
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Caesar Wang <wxt@rock-chips.com>, Kevin Hilman <khilman@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ACt8EjXkAAORZMTZYS-tP3NeboYhj6Rn
X-Proofpoint-ORIG-GUID: ACt8EjXkAAORZMTZYS-tP3NeboYhj6Rn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX3gfL0api0QYX
 62Lf2Vb0TsVhZO4xg+dxdx3Q0UXFENVyFuLCZnqpzTkjfLDvpY/Xap0uf7frIlVsAoT2zti+Qu0
 tmYMbAAe0pG5gQYnKr6Ccn0ZqJerQHWjrD5+hZV9EHhOPV9dS/g7wphI7XZhGpkOBAuYTTl63/o
 bkTO4ZW1W0toM4rV+88cfzWTYKFPVR4tlPvd90NHy+1stZ5mCpo+u+p5gXdMouOaetFoodTK4Pq
 QXleIRvlS5e4bcn3j+1iFDD70Duk6G47IrxmYlwrn4KWH5MKSo0RJ9d8nswdP7c9kTxlavvNxSr
 QNenb46HwZFVJ91Sn67BZolwturz6q0MRuA5dJa3gGCm25TNPkfE1S6sjTb/ePve8cHoRsHnKhm
 hzsJF42m03S/cmRNP4p+8I1oSDqmiTvZ8TV7aoAKU5Z11QzZ0LjqbaxKIYFMY8FDvyRsBVtYvcp
 5kEhYbUgEOO3epcbjyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX5k8D0Wa6ezZ/
 L5LzpWWGzS3IIMmBJ1MQPrTs9dVvuWLPtzictJUUzVJfZ20eEnV79dBKtj2/nw3tfc/i22KWDHZ
 iGJlgPhNHdRmVOwfS/1pTbub+y9d8So=
X-Authority-Analysis: v=2.4 cv=f7vdl+yM c=1 sm=1 tr=0 ts=6ab4e3d8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=HH5vDtPzAAAA:8 a=kRmKsBWSVBFGW6OGaTAA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240036

On Wed, Sep 23, 2026 at 10:38=E2=80=AFPM Sergey Shtylyov
<s.shtylyov@auroraos.dev> wrote:
>
> On 9/23/26 3:14 PM, Ulf Hansson wrote:
>
> [...]
>
> >> In rockchip_pm_add_one_domain(), there's the check (most probably for
> >> the case where the "reg" prop has an unexpected value?) which doesn't
> >> make much sense as the variable pd_info will be NULL iff pmu->info->
> >> domain_info is NULL and the variable id is 0.  What does make sense
> >> there is checking pd_info->pwr_mask and pd_info->req_mask which (as
> >> seems to follow from the code) can't both be 0 for a valid domain...
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with the Svace
> >> static analysis tool.
> >>
> >> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain dr=
iver")
> >> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> >
> > Applied for next, but without the fixes tag, thanks!
> >
> > Note, that I am dropping the fixes tag because if there was a real
> > problem, we would require yet another fix on top to get the
> > corresponding domain declaration to be correct. Yet, the patch is
> > useful as is!
>
>    I'm not sure I understand you. The patch should hopefully be
> enough to detect the undefined entries (implicitly init'ed with
> all 0s). What fix for the domain definitions do you have in mind,
> turning the arrays into lookup tables by adding a domain ID as a
> field to *struct* rockchip_domain_info?

Apologize if I was vague, but you kind of point out what I just said.

The patch helps us to *detect* incorrect entries. If it turns out we
find one, we need to fix that entry.

Kind regards
Uffe
