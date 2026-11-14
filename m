Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794643090;
	b=JEWOv5SIgZvPzrP5WSuhM81cUs4R1yPq5N3xs1BdKtSosm64x/J/Z2Hn8iFeQ1Y8eGy0
	 sVDXGCiWRdNOtAvbKDGtIBzfkyPErqAcqtSvZPSV3YJlM8yIsSPZCIO5Yp7ltdLitpi45
	 7VL7GR056ncc1LuGSt2HJMtlf5gdn7lY/ulvu91KBNGfKJpfx5BP51VTbB/rRft+sNvOZ
	 AcTOQOw7p9lTw53mNy0UsNiQCThj919N9Nd2raHy9m1OvqUAh2Vsdq5RS3u4wT7d5oV3K
	 pnSnDK3Q9j1ltd6ALZoX2WqNCdfy9EVFBgWnsj166irXOkejJBZ8KjEiZxyAN4zyYhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794643090;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NvR4HAZI4Lo8OnjwPJkf1d43cAiNZeVPyKEYxNFDU+E=;
	b=2Bbh7QEJEtE7vgPrdk3g5rj5PyJAEWMyvaCyJ+VYIO3yF3kfGlXUo2HzkpuKLIxqzE1M
	 pxoCEztBp6T93G7zj5RDgo0G092tnu5BS+GhXbdeQQD/FvGIw0wG15ZeLwQ73ROT6zM3z
	 SOYd0W0XQYvGj6sd8guC68g7PzLjllf9B3Zw1s4FAe/rhWq3n/XwV7S2Z6kOHuD0m5bY0
	 yqBQnJhsL6uobhAVlF0tfUw/okU77x69vW3wMC6qxUVCDIwFVd6Milae3Kns/37heqnO7
	 A8j7qugvRwm7f16rSeaOJoiLK2croxMXiWWYV9qALkY8mvcy7SQNfQomecEkc8XZ8KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mDbj3AGu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kM+cAsxx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD79606A334
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD79606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mDbj3AGu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kM+cAsxx
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE61PCI2892103
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NvR4HAZI4Lo8OnjwPJkf1d43cAiNZeVPyKEYxNFDU+E=; b=mDbj3AGu0zCqBixU
	ed6/Z9VsJsU/6V05b8gXxPGWdS+KOHeBjEEPVZ+rp95A8EJdnQXf6kqhqn2hH2Xo
	J79XEez7guii1GNtci361IDUFJKwRe5D3EKrZylXaKpxNegjecfFRuTbyF3jGxdj
	QS7s9M+ZxZejdwzwDvD2JFAtMaw1SeyjCTw5XcnT22fMNGC/HlHXg1ufB0OQDQ13
	GjlFPexOgwdPdeO8pf/1oaQcu1QrM8vOvVIXuSO9beR1C7uL/aua+TcjchX6P77H
	72VZAb0UXUZIsYmTN5X+d5Goce8XgR2XPK0IZrJOesLcmNzvgQ4XtWaC/nlxSFeQ
	e80VJA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhnx08w2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:58:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b18165dc53so2573279a91.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:58:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794643087; cv=none;
        d=google.com; s=arc-20260327;
        b=B32nHJCVX1SjWG9nlnGMjh18uC32Uzih9YhyS0WhT1wZoCJqSt8n8cbc9NPwoHg+M4
         DbKb/cKvcmfw2VkLMscBwyOl+m3Pymea7Tki2XfDb0+82+cSnDaCN0ME7K2mfUw5MkN4
         tkgDbm0/2A9rtdWG2q4CjGy62L6S6sb/R/kPDi2umlT30bHMw/j6XBso4OInssDCcBPf
         c54yErGunmpWgyxFXOEKFr7EucLNMZKA/ZvLCrxL1HPagbC0GH5c4kY6/qmTVQ+hrRXo
         igiJXhBn9GyVoOqCiq/vuV0bL2W3eNQ9u0LChp7U6HLcjVq6PJMzVdm21NSMWRNVSslR
         Rjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NvR4HAZI4Lo8OnjwPJkf1d43cAiNZeVPyKEYxNFDU+E=;
        fh=+quRVFv/yNDUHQc7Gywb6b7+oMqzoAM9mrIAYrtjH4I=;
        b=E+oU7EiJR/Fc6+4Adl9oE28mKgJ4/3WQZiJE1eFXbFoVGJfsl1ZjkVfucFE/Zx/ATP
         qFZBcM8KRtLTgDPXfCmEEq8Ygl+qDAaI2eazHOO5mFw2ZH4ZQjZLD3kWZdULqOu4dsl2
         ORL3olwvm79rFnR6WomnwvPZbsjjZRRrDF6XB0UkUGsOpJtMlIczSe2lrRywPQM9Ov7K
         XmINL9obT2Y8Sz7EY5/GihqlGRt6N+d9XqqBLXidwQySvnh1mZgCbrOK84qpOBHsdbs4
         aZxOk8svPEgM1dD7HxJkZztggZAHt9v/0x4Ew4turuokIaYZXYlr//H6RS97LfqFb6Ep
         wJcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794643087; x=1795247887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NvR4HAZI4Lo8OnjwPJkf1d43cAiNZeVPyKEYxNFDU+E=;
        b=kM+cAsxxSq1pB1Atd0ps2twaygl6dAXRFyc03Qeh4kXgVyF/pV1U/A0UlygVPozXCn
         Xn3BL3Qu+aZtrd0zIaavPrvZbQc569Xk8IudJkaHUa9JUwP3whY63IY2KK5yKrSHWDLe
         F84uKccXxmpsfEd0He+jhXruDgwwx/VqNpqi56Z1Q87LdM4WPzvDKlmTJDI1YbXMGMZn
         /30746FQ29A9Z3VIEIlzvhxKA54V1Ukc50tnTzipIHXi81Pyyp1MqhdvKdsCasqayUrT
         oQNM2DydxRJ6tmcAWaHFFZ6HrlPkAmByZQyhRMVlXTymXUV/w0vkj1ECnXDWOPuQvWhk
         U6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794643087; x=1795247887;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NvR4HAZI4Lo8OnjwPJkf1d43cAiNZeVPyKEYxNFDU+E=;
        b=M5qHKc3ZfbtTlyOGwtCFROJBh1wt8uOnHjqwohBShBb5qEx0rjUXuhIlL0od9IDHHZ
         nFFFfbB4qZS3WRAbo5Hiz4oPAflBqnP9cP/B8DRg74J05CL5AhFhm/XBxK8o8U3M60rp
         2UthxnMcl4YkYW4y3yWiVYI7L7mzDDgLYG+YXwH/V6KPuRt6oktHr3UgJl1vdwE4zuD0
         hZlEP1jFYsxtuF8eCBQzLlc2LLWg4xu87w7YbHcfvFhRXMKFVo3JMDnbkydAjAOTzByI
         Av9EJRGlQ7pb3RWtKiQW4rwz5MuEz8v5sMpZBC2BRpsblg8s2v3LoBJfOzt4WJsttlmd
         ohCA==
X-Gm-Message-State: APuU4Z9KJlAgxlJzXnrVpmz6baM7YPnrcED1c/OUATmUurQQkLY5n8fJ
	vL7SHvMzoWq+Y3PQSnleCjnLUv1QSkmbWRNEm1ZyJzK4LKbTxxZTpdKPTOnCbBlZk2bROxi0XC8
	wQylHsweyMHjhgD5Fz8bsJ3pB+Xgb2b2R3rTYwKXC/3e+9zmlN9xurVtf+nC/ZzcxiNEC9kT3/J
	U9ZOp48B1My1uOQbZef4hVZh3n9O6VtQfhU6WW
X-Gm-Gg: AYBFou11gR52C6S4QG0R4ZwKVtgfehvm3kzpz5vee7UX8OBsNktA8sHWOgMRPdvcmFr
	xScm06fHvrQW00/GkXiNrJwvjQ7c4/0cS0h9H7ZQQxUpMWKK3CyuZNLwv8iFH3ahVhRysVfhkVD
	PIpzGK5fTh/nxk3rodUEmWnIybSjV/bMeuM3NHLpSqurs94VK4tQIPIEltBg==
X-Received: by 2002:a17:90b:3c8e:b0:3ac:9176:e83c with SMTP id 98e67ed59e1d1-3b1b09e5ee5mr4952053a91.12.1794643086751;
        Fri, 13 Nov 2026 23:58:06 -0800 (PST)
X-Received: by 2002:a17:90b:3c8e:b0:3ac:9176:e83c with SMTP id
 98e67ed59e1d1-3b1b09e5ee5mr4952038a91.12.1794643086266; Fri, 13 Nov 2026
 23:58:06 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <13032301.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <13032301.O9o76ZdvQC@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 08:57:55 +0100
X-Gm-Features: AclHuK_pb1NVwWbh0QLiYOd4IdBJz6ttWXlwHm-S_h6PQMwai5uFseqDu76GcSM
Message-ID: <CAPx+jO-GAkn2Xw1i_foav6q+9UyS58MyBJ72CmsdP-9ry2CfOg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Update last_busy in rpm_resume() for
 active devices
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAzMSBTYWx0ZWRfX/niq/j7oPOAo
 0D3oAbJpn2CG1DcRK7JOtk4fmWM1aCkigSVBxcvPv1qqVEFFEbS+a4WqkO9cvrq0PcG5c3zny0a
 9KKyOHzyauAfFSngUWs6P17OuskiwbQUyY/qq+9aZhcyxCTWswDnl4zQZ0MdUFxSp1UeaQEwtre
 FbfZ0Q/OB8qGHyUpCBD6m+tkCBo/j4BP6iQ+FtiPtOmTXy2AkTN/LxAPoSXnhmyNQCxDg8b7/FY
 w/PAqCmgqO7OHUi1xJMBWTd0bxAnmsZKQB3zwDsgAadE+tKuLcKTyMjAm+QiltN9qGiiuZ1qa6V
 g/i/xiRsQ2mNDtNfcfB7A2V9buyG+nfeJviAhcsAK/n3c3dZozp85bZkFWPEGkzi/l4wf+y+ByH
 ioNuByYgTIYPi3kAm5Llevqo7aCvqutS79g+U3bxkbhHa8A+W06NRLbERhWkF7RQYiiD/Xb7p17
 numGAdkgSqJfr6IwVgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAzMSBTYWx0ZWRfXy/QJSuDMXFLz
 qZCX+EcBgv5Ubly4+SV2MA2Y84b4KyqJ52wQj5yJejuloSYZEQ6b5RF1as3QVr22Ur9PL1Sd+C+
 PXUQubLejB8S/3lEAFK4Ry3SRuq4mbo=
X-Proofpoint-ORIG-GUID: igulpoCO6pQ_J1v0-pc6yzqzczYIHtDX
X-Proofpoint-GUID: igulpoCO6pQ_J1v0-pc6yzqzczYIHtDX
X-Authority-Analysis: v=2.4 cv=Jr5kP84C c=1 sm=1 tr=0 ts=6af8148f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
 a=cm27Pg_UAAAA:8 a=gZt39-j6hBPzH54buqsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140031

On Fri, Nov 6, 2026 at 12:31=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Setting an autosuspend delay for a device can be expected to cause a
> runtime suspend of the device after calling, say, pm_runtime_put() to
> be deferred, so the time between the last successful attempt to resume
> the device and its subsequent suspend is at least equal to the
> autosuspend delay.
>
> However, that expectation is only met after the device has been actually
> resumed in rpm_resume() by invoking its runtime resume callback.  If the
> runtime PM status of the device is already "active" when rpm_resume()
> runs for it, the device's last_busy timestamp is not updated which may
> allow a subsequent pm_runtime_put() invocation (or similar) to suspend
> it right away.
>
> This is arguably inconsistent and confusing, so make rpm_resume() also
> update the device's last_busy timestamp when it finds that the device is
> already "active" and it is about to return 1 early.
>
> Fixes: 56f487c78015 ("PM / Runtime: Update last_busy in rpm_resume")
> Link: https://lore.kernel.org/linux-pm/CAJZ5v0jTX1FgeS9FCV=3D+V4uacSgLQBV=
sSPnU27ybgUGg57GUOA@mail.gmail.com/
> Reported-by: Brian Norris <briannorris@chromium.org>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I guess I may be too late, but in any case, this makes perfect sense to me!

Reviewed-by: Ulf Hansson <ulfh@kernel.org>

> ---
>  drivers/base/power/runtime.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -819,6 +819,12 @@ static int rpm_resume(struct device *dev
>                 pm_runtime_deactivate_timer(dev);
>
>         if (dev->power.runtime_status =3D=3D RPM_ACTIVE) {
> +               /*
> +                * The attempt to resume the device means that it is need=
ed for
> +                * something, so update its last_busy timestamp as in the=
 case
> +                * in which it actually resumes below.
> +                */
> +               pm_runtime_mark_last_busy(dev);
>                 retval =3D 1;
>                 goto out;
>         }
>
>
>
