Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795777092;
	b=oHzGC3ahwMD/c1f3UvdL76rgP4NkZVPtOwZoGcK8HcdJJBJxko3tjBypLZyNlENhf8ZA
	 XN4wC0m3AtjymDwmMVC5vTfmZ8bxx//Lngs1GRV+gXDYgYthRQo9nLR2tWzaADAb0rzZt
	 P7N/YiNdBpiXSf8+Pl8WWCdZRuZK6X9Wft/9kK2gqiLk/VX0EPedi5LdJmw4CghccYflM
	 AT0ulEcIduHgEKMHRFqREPU1pu5EzbiTI9uNMTK3ub+0mu21IR6k5YgAFCrRNRbWUsMQ+
	 s4fGSuS9m0QPa1IjJ/rkxjcgZpH2yvqqa0R6xeBJrEwUzidCKJll0QIR+ikRn2qWxBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777092;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MUEQYRgAV1pWb9tB5vVjEtsA48/NCfRo+KnanIYJmp0=;
	b=kjSh0sbh9Cqh6X92F8ZyAHuGkYZO3xWXSPhQCAycTNfGJluG28PWuyg91MqEKjuhD7Pb
	 mRA2yrHrlynWC5cWfGrjuLuwce8mhNPz9pcJUgd+7bExjLau1LfAeL2HYay0CQ1NicxG8
	 LgzT74lOvgbKcjCSWYnn5GUGJRyVLvJBt+X2+AVlQF11wSK6L605yD0HK5ushuKw4DPN4
	 2oL6SLZC/WGatGEClMGPSbKnag8x36Kv/wx9zDSLBomv6k37qsgw4nWf435IyIIGAQ3DK
	 AxtrE0QQzal85MEr+j/dC8o3ArgSxZrGbGaEO2hDQlumRaCcoblh+dutX5oxygOV+yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EIPwdzux;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QnwHWYlf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3492606A31E
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 10:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3492606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EIPwdzux;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QnwHWYlf
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApA9R2906419
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 10:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MUEQYRgAV1pWb9tB5vVjEtsA48/NCfRo+KnanIYJmp0=; b=EIPwdzuxLiV7wGp0
	Vgw4XBiF3kMikABCrnfoXg7XheZJ4Y+85ejcIObB+lz8TROUr3Wadey9HK6LpdoI
	WnVXI3YD/3mGnl8+NFIqcjdd8MXZBF3girBvmO2rszREoJVGhkvtn6ZaMTOti/Dg
	GoHHK/lPYwxY1jOIM+65tDCsuuFXykBSSgiDO/bhBJKxEM3MlVx9MSivxUxXQLxC
	UsDUHWfqn3SVqnWR5jGhq8Kyt55HuQmZkl2K0oz1NdcRYQd3Sk2ibGw3iCC/mXxr
	EZsVbggGtqPv9xc/CE4TMjV22/6We47cmcez88zjMPXVBInxDUYGCYBZYB7QHBYv
	nGNeBQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf9367x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 10:58:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cddf142187aso4087042a12.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 02:58:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795777090; cv=none;
        d=google.com; s=arc-20260327;
        b=WJz4JfkXHtl8IXQcwAKnY9w4koadRTLib9phNVkUatnxChGnczPHKF0HXMLnyd6z5c
         aCt0GzYR29zKkuwVnojQQw5ecxyjAPrg9XnQqzOu+pITh9y1VUi1oMoeYF/ilv5nNKPv
         NeFgd3JJfgCgsARz5YsES67eEpXsrh4KnOHrhLDqB+PlADtBzHVLakjCEGZNnipliIc9
         EbsNOoM1NwbEFH/FjECaebI/VkX9BjDChFc9we7hvnZwrfOSY07Q9UcANxKxlDA6APRK
         2jHcvNoh9SewFx5mSo3umZ2Bgfg2M7WN44yM8bvEoBOrgQrYT1+LYbEaPC+rP9zyUeTN
         Df8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MUEQYRgAV1pWb9tB5vVjEtsA48/NCfRo+KnanIYJmp0=;
        fh=cZN8QEF7Bjt3Rdrr883A0x2d2RsNwRelAHj/7X6BGo0=;
        b=WgK0r9k1+mc/hkxgFDaXNj0qCBOOzZSqwetNdpnin5JmU+dSSBWJP7mn5LQnKZf0ze
         nRtvyRMeQyInLxINg9CQkjbDkseGZaJdvrxb99sEjtAd5m5NJ1Qypvz1zwcC2UgwRHJ4
         qv9XcH5hk3ehOzuWnJYSCTmXoYMUIDxE0xkGhX06WfVugxluMtFWb66CIjQLL4Q8dgMi
         a9S0o4irUSmZk6bxF9LDneuDdr+Faqx/f4LNciXjHeE3WFIlkKdcRfX7CPyPTHmLpkBE
         sIufuR0haCJaTu0IVCGhocpqcmrWqrigEwjKQY3mtLR/KMHJsHfu66aXtoFV26Ytx6GG
         COgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795777090; x=1796381890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MUEQYRgAV1pWb9tB5vVjEtsA48/NCfRo+KnanIYJmp0=;
        b=QnwHWYlf8S8LugAhpln/KMek0evLWT/iAaWxgJOomU14KCSFDovTBqVjF0nbQ4IVRQ
         Xq8YTKybyjFsJ8U601dDSybMnZeSIVZ25l3OxRAOX8WVUhE7AnMtcVpPTrRpgcdu4o7N
         cwVL+Jcki3P8BRXgJSgbgScEvUzR0XSvAOjx+RsT4beGL/V6DxOYvAkRvsN1oNuMsDZz
         eR0DBW2zeVcraGeE5T6shfc9/d1Q1oJEYQuFVFkqLX2SNWb/5YphZwTE9fZ4NQsgNzvZ
         Tt7VA1GKp3jWYUz+N5+DiVN4iGCh4jxdRF/fus7ZKP0F4/79dQc9tCXeEwqx8rp75zl0
         3iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795777090; x=1796381890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MUEQYRgAV1pWb9tB5vVjEtsA48/NCfRo+KnanIYJmp0=;
        b=yoGv+yqoI3wQTyO7fCJmRMUtJFMZLIQLsvWbwi9EK9OYEUywvgCCGPpOxiinIo8ZXf
         x4e0xvywhRVVtdYMDsSuEkHJ6SqMb+yW6ATJlZ0xOoGQnWJFidYXvALl4kGKIaxjvN/3
         r+v0fTQG5K++4foJk7PR1e7qeGBAGSKpo3a7WQmhxwrezzh8ptMvP/XPljtjuoDnmgp0
         fGmsmxg+kjJtAWXJpQLMsGfTHRBHQ/7Ln5Y3LOTLITg0w3rtBepi1i0YsfCAyR7QyHD4
         sz420BoK4xYVG3hzH4dMHxGmysTc51eZrj9+aVP9e4YQ63p4pu15iNc15cX3X4EMlspO
         M43A==
X-Forwarded-Encrypted: i=1; AL+hErFjNEVW20fhnN2Uu3vsUm93k4A/TF6atnJCGGhj0Z0cyP3jIhJJqpeT+Ck9wzsHMZ7cR60BpbRWOg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Fz1x+Hq3+e1Ms8glA9bOhDENCtqXJs35Wfv8UX5tFaAWCCHo0
	cKdEPlEnPr3alHBgEjWQLM7wSj6FSjtOF9Iz19oaREF7z87xjGqSIURbgnzOGPfMstczeU3SRpV
	rJkAG6DX7nT6P4JF4uUoNfdjBh8VbMi4PGGbOAShla0CTRYLBzsfNpeyWE5XKem5Vn7OV9wWdcR
	t8gCmE7Tw9TNwaUkkyUt9t44oW1k7zaXaYIZZn
X-Gm-Gg: AZFdTZcjI0b5K68yXCnWCKfXvnZAY94G7t2z8TjEo7VuXUk5x4M+5ASamQJFuc9aygo
	QXXxFTNMpKyTbhaYQbbq4UBqZbDi5IJYQCPBagFFqsGPrtRK18YU0qxQrGNe9flvUta7/sHmTQ/
	1HaXVjQxxRL9PmeoFLDgXKz5ZsrRq4H3erAGAE1YN5R/bmtcKhI7OFHc5piw==
X-Received: by 2002:a05:6a21:32a2:b0:3e2:7a40:a566 with SMTP id adf61e73a8af0-4014d360163mr23482421637.45.1795777090208;
        Fri, 27 Nov 2026 02:58:10 -0800 (PST)
X-Received: by 2002:a05:6a21:32a2:b0:3e2:7a40:a566 with SMTP id
 adf61e73a8af0-4014d360163mr23482388637.45.1795777089644; Fri, 27 Nov 2026
 02:58:09 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-pm_attach_by_node-v1-1-4dbaccdf8b0e@ideasonboard.com>
 <CAPx+jO_FC1t_UaDfQDPOCy+V-Zdc1b5h5krrppGvYiW-LsD3LQ@mail.gmail.com> <4fbeef8c-1dc8-4cac-a4af-835037c3dc4b@ideasonboard.com>
In-Reply-To: <4fbeef8c-1dc8-4cac-a4af-835037c3dc4b@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 11:57:57 +0100
X-Gm-Features: Aa3M54qXtAIHNiGpyOaEyPdRYU5jSSo943VspeWjL8RHDV3sdq5YmHqVLG3NwR0
Message-ID: <CAPx+jO_5OK_9VJo7vh0CP37-fTkd_2j3XtyGkTw3bz4heyYq6Q@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Add genpd_dev_pm_attach_by_node()
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Devarsh Thakkar <devarsht@ti.com>, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 43HMAstG58lAeWWlIL3zHW5Wrqrb0nDx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0MyBTYWx0ZWRfX1KtGDQpd3t5Y
 JbPvhcU/euV4Z3XcInScsgwKDn8NWlS1+qQWesPOlOeqyjyEvKB/2ppUyiY14TiXR5JZTxrcZOu
 mZQcjvWt1S833KNbGIjwldu2Iz5o2Ehre3s6PjfbQCSBfjfkeJzaU3jF+8nTJ91fyWwoPzQbDug
 fqelfPr/s7+M3iIemE6sWJzv/4ZGsLMSTX+M4xVxwxxmAFuBNwMyC/RKT4qdDHyXiw/VMhXk8VF
 wgoHOoNombV/eDhDKdhsNMdQHll3ezsnaIEijwPap5xWFQBwYgNjKkjO3ZZAS8yjBTXPaEVHQmR
 ueHIKZGKC0ALsbyIMtCcTm/uV9gpGBPnlweb84pKQsPSymIIQPS/EnWoRccI3Y0nmJnbbGaYgVR
 UG5PIo+srRNBFIX1WrBBg0JZ89WTgKC7LK4bORVogDD2u7UP5FUwYg1DhSqztqwWw6dGgAF+f1S
 ku4oqgYwRfINMEw692w==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b096242 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=P1BnusSwAAAA:8
 a=U9_UlU1nMNCvezYFiagA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0MyBTYWx0ZWRfXzxsID1iNEm8p
 Uw5Ympod+Cc9Y/fwlwGOClQzUmrLV8Y/Q52Ve+TKhCwt/lKqXUUD7x59F5VfFGSI0wSMjDsZ8/Q
 6khqQViAIPvEjZRGKO2vs8/XgSUrW6Q=
X-Proofpoint-GUID: 43HMAstG58lAeWWlIL3zHW5Wrqrb0nDx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270043

On Fri, Nov 27, 2026 at 10:07=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 25/11/2026 14:50, Ulf Hansson wrote:
> > On Fri, Oct 23, 2026 at 8:17=E2=80=AFPM Tomi Valkeinen
> > <tomi.valkeinen@ideasonboard.com> wrote:
> >>
> >> genpd_dev_pm_attach_by_id() and genpd_dev_pm_attach_by_name() attach a
> >> virtual device to a PM domain listed in the OF node of the passed
> >> device.
> >>
> >> Some hardware blocks are described in a child node of a main device.
> >> They have no device of their own, but they do have a PM domain of thei=
r
> >> own. Neither function can attach that domain, as both parse only the O=
F
> >> node of the device.
> >>
> >> An example case is TI's display subsystem and its OLDI (LVDS)
> >> transmitters:
> >>
> >> dss@30200000 {
> >>      power-domains =3D <...>;
> >>
> >>      oldi-transmitters {
> >>          oldi@0 {
> >>              power-domains =3D <...>;
> >>          };
> >>
> >>          oldi@1 {
> >>              power-domains =3D <...>;
> >>          };
> >>      };
> >> };
> >>
> >> The OLDI TX blocks are not part of the DSS IP, but they are not quite
> >> real devices either as they don't have registers of their own, and are
> >> instead controlled via DSS registers.
> >>
> >> Add genpd_dev_pm_attach_by_node(), which is similar to
> >> genpd_dev_pm_attach_by_id() but instead of looking for the power-domai=
ns
> >> from the passed device's DT node, the DT node is passed explicitly. Al=
so
> >> add a matching wrapper function dev_pm_domain_attach_by_node().
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> >> ---
> >> This is a new try for managing the OLDI power domains. Previously I
> >> tried using auxiliary device/driver for OLDIs, and handling the PDs th=
e
> >> normal way:
> >>
> >> https://lore.kernel.org/all/20260529-beagley-ai-display-v3-12-7fefdc5d=
1adf%40ideasonboard.com/
> >>
> >> Then I realized an issue, mentioned in
> >> Documentation/driver-api/driver-model/driver.rst: "-EPROBE_DEFER must
> >> not be returned if probe() has already created child devices".
> >
> > I don't follow. How is this a problem? Why not create the child
> > devices at a later point?
>
> The problem the above text refers to is (as far as I understand):
>
> The main driver probes, and creates a child device, which probes
> successfully. That causes the flag for "run deferred probes again" to be
> set. The main driver then continues its probe, but, for some reason,
> must return -EPROBE_DEFER. But as the above-mentioned flag is set, so
> probes are ran again, resulting in the same sequence, again and again.
>
> Creating the child device later is difficult. We have display pipelines
> which contain multiple independent devices. All those devices must have
> probed and their bridges/panels registered to the DRM framework so that
> the main DRM driver can finish its probe. If parts of the pipeline are
> missing, we return -EPROBE_DEFER and wait for the missing parts to appear=
.

Well, I still don't see why creating the child devices later is a
problem. In fact, the opposite seems to be the reason for these
churns.

Usually what we do to solve this kind of problem is to make sure the
main driver for the parent device has completed its operations for the
probe and then it populates the child devices. If that doesn't work
for some reason, the main driver simply needs to remove the child
devices in the error path in the probe.

If the main driver requires the child devices to complete their probe,
an additional synchronization mechanism needs to be added to allow
them to inform the parent.

>
> And the OLDIs here are not really independent devices. They don't have
> register space, and OLDI configuration is done via DSS registers. Yet
> they don't fit very well inside the DSS either, as they are clearly an
> outside IP, an external encoder. So the aim has been to represent them
> as separates child DT nodes, which allows setting OLDI properties and
> the media graph, but there's no compatible string and it's the tidss
> driver that fully manages the creation/cleanup.

I don't see how this is a problem. It's perfectly fine at ->remove()
that the parent should be responsible for removing its children,
right?

>
> Here a simple pipeline could be:
>
> DSS -> OLDI -> panel
>
> If the panel hasn't been registered, tidss will defer. But tidss needs
> OLDI to be there too, when it binds the display pipeline, otherwise it
> could never finish.

I guess "finish" is the important word here. Finish doesn't
necessarily need to be the same thing as that probe completed. This is
what it seems to boil down to.

>
> It is possible to create the DRM bridge entity for the OLDI without any
> OLDI device/driver, which allows creating the display pipeline. But the
> OLDI bridge code has to be able to enable the OLDI power domain, and I
> think the only way to use PDs currently is via devices.

Correct and there are good reasons for that.

>
> So if we created the OLDI DRM bridge as mentioned above, then later in
> tidss probe we could create a device for OLDI, which probes and binds.
> That can then be used to control the PD, but there would be no other use
> for it. And the sequence feels like doing it backwards.

I am not sure this is backwards, at least if we compare with how many
other subsystems/drivers are doing it.

>
> >> The PD virtual devices used in this patch's approach do not hit the
> >> issue as they don't get a driver, so they are not probed. The tidss
> >> driver's OLDI part can then use normal pm_runtime_get/put functions to
> >> manage the OLDI PDs.
> >
> > Sorry, but this makes no sense to me. Considering the above statement
> > about -EPROBE_DEFER and child devices, it sounds like we need to
> > manage some kind of cleanup in both solutions, right?
>
> Yes, but with PD virtual devices there's no probe, so they don't cause
> the "do deferred probes again" flag to be set. It's not the cleanup as
> such that causes the problem.
>
> In some ways this does feel a bit like a work-around to the framework
> limitation. Representing OLDI with the aux-bus feels quite correct, I
> think. But then, all that plumbing just to enable/disable the PD...

Right, but the plumbing sounds quite straightforward, especially since
the auxiliary bus would solve most of the problem for us.

More importantly, I really want to avoid introducing another API for
attaching to power domains.

To solve this I suggest to re-visit the auxiliary device/driver. It's
also important that the created auxiliary device gets its fwnode
assigned to the corresponding child node as in this way, the child
node will also be properly considered for "sync_state" for the
power-domain provider. In regards to the synchronization with the
parent, I suggest providing a platform data for the auxiliary device,
that the auxiliary driver can use to notify the driver for the parent
that it's ready.

>
> So, what I'm basically trying to do in this patch is to provide an API
> that allows enabling/disabling a PD that's not in a DT node managed by a
> Linux device.
>
> > Perhaps if you provide a user of dev_pm_domain_attach_by_node() this
> > becomes more clear.
> I have pushed my branch to korg:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git/log/?h=3D=
b4/beagley-ai-display
>
> The commit that uses this patch is:
>
> "drm/tidss: oldi: Add power domain support"
>
> And the dts file that has the OLDI nodes is:
>
> "arm64: dts: ti: k3-am62p-j722s-common-main: Add support for DSS"
>
>   Tomi
>

Kind regards
Uffe
