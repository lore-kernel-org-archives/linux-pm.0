Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794643321;
	b=MnlJL49UMzlAs0PtdPiBD4YndPeTfbCRh04d0LaHu7R2PaLR75RhDlv+sAOwo3YGhOZp
	 bSEOnefB8yfNhwRc+WVc0iN5mpgc5OqIWuyTY5lxUDAmtSPwGhx3Zv18tNz57Uc7OIK9e
	 y2n6TUDtEMT3dWbh6/eyy/EVahQmjV7r3Mg5bayhcnLb7QjWyYyq+5abb/dtyYLR7LRso
	 5C61qZm0Ld3sCwjpet7hKZe3TrN9UZEHfExBZEewBy2VQXztIB7IwmFburtBwJluVc4o3
	 YkPdocDfI6qHHsjJL+DDbpPIxsyX7dEtct9V4vrP7y04T7uBVy/qNXzFbOJPS7QKVSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794643321;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=eOs0wo+AEMTo528QIknBptEx/0/lGfoY+hjXbdqJYG8=;
	b=bx6lklaJhQKEJWD+WPsLsKt15ozyfQp6/rXtxWDgPiA4gfzjkGKglg5w0qhJn/KbwpXH
	 N8pUJwUJiaJuz3fVm3hfUNfMxajpQItNnflTqJg5Mq+8gnHa3rA+xJ9XQwxyOx/FN+YZo
	 8cWj2z1GN22JbfMtJ5vHFCzZRBu8hAlsSizDerQ6VxiZfwjQ/3gi3gpuJChHpz8cpLwgO
	 zB/wIixyGkyQ/0Xf5mL5SyihvqHLnucrsqUpxgmzfTt5yvrsyvxj04GspVZ5NZBLgvdii
	 EuuNfyn6K/KzKFzRzUOQSzHt28TmXPOGMDBCnzgrVrKWAXLVGS4uzT5sGrudoLmafKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ka0mouk5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WOj2XRtu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB95606A327
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 08:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB95606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ka0mouk5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WOj2XRtu
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE61HpI4171992
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 08:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eOs0wo+AEMTo528QIknBptEx/0/lGfoY+hjXbdqJYG8=; b=ka0mouk5ouZLMSl3
	fJprxz1uhjURWYyDMH9fRBpK6r7r9UbqVFE63k309g4z3M5i7awraJ2E45FjQ87s
	/zAomF4KXGGOLau3HafyP+2W2F6AmGZK39oTfSo3HXu1K061ldl3SSdW9hkOBImB
	W+tttiHc+QHz1cZqHsQiIeo2hjZRKTFkjHQQIJn3hjGH9FK+4FcaeuLLXhqO0W6F
	VdH5KrWl2l5/BcwsANUGWJNpRNheBT17DpJ+MXNrmyMEGBAdFWlOO6ZTAdnLpgr4
	of2H/izbsOP/RBcEAHInGcQiErCi2JDFHfshCOw/d6vC92E1u4T+Wp7Vmu2gLTtZ
	4ESjqA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdr991-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 08:01:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaf3f829b3so14688515ad.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 00:01:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794643319; cv=none;
        d=google.com; s=arc-20260327;
        b=FRABmWBaLbvQqokBc3uHx1y/Z5p1p/ZqJlYpwAa7slAlsqH8+IDAhKR7Egx+kr5RXn
         ErWAxIyRwaVJVyna0ioZ0Q3SmRJxYK2mWlbTmUrbxroX6RhiD7iWc0hEi4jYa3KvHgPQ
         RnQelWFngdRXscbAH8UasvHP+Wx2/dZ3fyMJIJWcsr6wLiXnyuYsp2inQr8awo5+3sIR
         sQa4KY4jAsXlO52zZTZbtZb9nWFJ59Td2wAbYwcXYT69H5KihaPzyQZ1+KEcXOZ0+p3E
         4X2Boji9MX0XnhhDot57+JC8Jjtg3rRO23QI4J7nxn5+RIb3mquk1Z3K+I5BZAgqBB54
         piDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eOs0wo+AEMTo528QIknBptEx/0/lGfoY+hjXbdqJYG8=;
        fh=buNIlXtHwRy8KCXRlKUQ1dOMrJa8YBXa1IaKTp38DSQ=;
        b=bJzIhcompMnM49hvYN52CLKWAPEwJtWz0z/Dg9V9PM/kL9xdmGupsoD6Ih8/ctfH2O
         xr9gSLyNbGmnZphEL01WXuXikVn1WmvvQVuYAX8R5pawnh4AfLH5YNrqknQeXQheQALs
         ut7lMEuQH7X2ahtEnPcVbn1i0e4zCDvPzCRMZhOBiasrk9WeSDDV3xGucdor1ht+aST3
         1Bj5me8kPneNAz7CNleWSzpenAnLqzDEUkbYhlsJVM5YpWs9aV/suhoUvJdgSl5edwKe
         3P5WrvX9MH4aR5gZu3xZImUB/vK9QkqlexopzRiDSqZNnXFn8ipwoUKwALWNqRowBzww
         yxMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794643319; x=1795248119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eOs0wo+AEMTo528QIknBptEx/0/lGfoY+hjXbdqJYG8=;
        b=WOj2XRtuGRgdVZQXWmRquYQtJc29mbImiwoE+nrhOdkJrq1aTFJxCuPAFtuR41m9FF
         JQaP/07lSeby6tObWTEfZAyeDAOb+CQobMcAyNksPbuFGsgWPvpzGDJ80bJlKK5V+PGI
         gLPIfCUXS2oYQp87fRpaunOd4+Rj0H9XU9LIDmI/r0Sw+OjUbpBaRRXzGExS4r0h4La4
         V+m/d6Kf9brciFnjQaASTvXpSXiNwD6FjQCjXeGsH/ct3SxtrYlSb71MfGa90a2xmME3
         GKQ2t1NZ/R8kLAASOgwoe3qlG9i+eX9h26q9xLf+HXWOjWakUvJLbXEVpTKFlrAhpH0F
         8DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794643319; x=1795248119;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOs0wo+AEMTo528QIknBptEx/0/lGfoY+hjXbdqJYG8=;
        b=zKfft4r3mepcOLuUb3bgFczAI58YqeHA8yIFAFcSUtTLMlPFZFyJGm2hbBFgWRr6pF
         yTmQL8vsv+NOuj+eAag67TU+BQXmXfd0BYAgozUC4MnAPIi8K0FS5I7dR2dTSRsAhX14
         F0PIi8lRhFTyJdMt0lmU7gEvx+nyCoBoQL/KcZditTfO2gFLmK6HXdecRkXkrMy1KORa
         lkNf1TJSjxQWyymrW4AC6d/TXnw7Sm6If77/oloa35+JhafJQ20Lg7l4YHWSVqIaplMK
         SfLx6coRkAVsZNDtXzgNygSyHBz9xmwVVEoDuS0QACEjFoIjxINzirOg7wBKhlO9JzV4
         ISwg==
X-Gm-Message-State: APuU4Z8JUvAbFh24xBvVLcNvGpESZx1Oe1xn1Li7s/OX1BuGuin0jWpH
	4FrmolkKmY8ukcRiRkV9ZJL6jlofKNUz8XTjnFETUSSvHW/jgL/R6xifVwlFhxuEIGN2GUSL8QU
	lv2iqOw5AxGVW4coEHYCL5bQEFm0A7FfGlbm+QfpagAQpT+XwU43otvsSOTY9N6nGJL85n/Wnz3
	DG9m3GYXef3kJgVK4+GXsaKhIiA82eAsgG0Cm1j7Xivvtq
X-Gm-Gg: AYBFou0w9JIwDfvsJdfI2HoEif2hfatAkpNMUMFCml+Tg7HAN2Pwje8b7PALC3rF3RR
	kFYuHFfdpMkzXv6Q0OsETYLRpsrOiV9BTWWHztidiBO+MhRHNg1Vuhe5prH4nIga9UsfKCvS8fD
	ryXDc/t6lQN756gvRMflra1mQvAM2nMWUzVI6uNb5bBHHgQrj0FVJ+xMCPyg==
X-Received: by 2002:a17:903:184:b0:2e9:3c10:c5f8 with SMTP id d9443c01a7336-2ee0dccd57fmr43606705ad.65.1794643319256;
        Sat, 14 Nov 2026 00:01:59 -0800 (PST)
X-Received: by 2002:a17:903:184:b0:2e9:3c10:c5f8 with SMTP id
 d9443c01a7336-2ee0dccd57fmr43606495ad.65.1794643318783; Sat, 14 Nov 2026
 00:01:58 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <4789427.LvFx2qVVIh@rafael.j.wysocki>
In-Reply-To: <4789427.LvFx2qVVIh@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 09:01:46 +0100
X-Gm-Features: AclHuK-lhZ_smxSVi6yno7pceItwahP6z94N7EeTzslfLh2fUR-EdD7X-VmqxTQ
Message-ID: <CAPx+jO-k5U=Dxqf0kxnZhSQ-+vaTk4_dknag1k7G8JgnPPoxvQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Update last_busy before calling
 rpm_suspend() in rpm_idle()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6af81578 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
 a=spzYhce0c6bss-WC7psA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAzMSBTYWx0ZWRfX6zKEYxke8g2U
 Rp0ZnuilMASuKelqmW8xndPZyk0zK5DVIyxqAngwmxvEUvwH2Q7iB/nmp/rx3ZGzl34YgL68umf
 CCR2uJIiq9PqAG8d4msbAXYSF2j13lk=
X-Proofpoint-ORIG-GUID: WMi1ZC5ItpsS56M0EjVV4saZN-iXyl5r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAzMSBTYWx0ZWRfX3Y4vN1C8wB3o
 7Bm5+cxBE3JFp3AyeOV96/Z3Vcttvshh8moC2GXTNu0QoXtrIsu1xRd5b/Kb7Go4r3u83fA6sdk
 MXJ59+E1wc0v9B2hzxjx+2H7LpigP6w+9o3iiDdyzvs7rfQkfoQ1q0hTNYvdRn+Erbkbnizhh9u
 BeZvDoi75D7FoXSpAJn7+A4xqs0cKqH0jAA97G0+iPgNS+Oc0HgIlw0T2NbZ7CPrgsg1U42fXcK
 DqO2sUJOt18XiM6PTWAFGNj93OIBoDykTJFkcddqiRscnQcbLuX3Uok6LHX1gGU9ostWzwJgwBV
 F/emfiUDIV2XlHzfJCELDi89FELHybK69jDdO7mKcAWklnIOT63jHjrhVQdPfjtkNzGv4RKnmy5
 gUaiOZJJa/dtTK/HsE3bYfaVj2aJGWmjfXb8gZ5e3gjdKQwXnZbX8FPpVnF8kFpxn9HVOzmYklQ
 m9JReId7JbUNPMg489g==
X-Proofpoint-GUID: WMi1ZC5ItpsS56M0EjVV4saZN-iXyl5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140031

On Fri, Nov 13, 2026 at 2:27=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> When rpm_idle() is about to call rpm_suspend(), there are no reasons
> preventing the device from being suspended, but if the device uses an
> autosuspend delay, it needs to be taken into account.
>
> For this purpose, rpm_idle() adds RPM_AUTO to the flags passed to
> rpm_suspend(), but doing that alone is insufficient because the point
> in time from which the autosuspend delay is counted may be too early.
>
> For example, if the device has children (or consumers) and the last
> of them goes into runtime suspend, the parent may now become eligible
> for suspending, but it may not be worthwhile for it to suspend until
> a certain time later.
>
> Quoting Alan Stern [1]:
>
>  Let's say the last remaining active child goes into runtime suspend at
>  time T.  Let's also say that the parent expects none of the children
>  will need to resume until time T + D.  Is D sufficiently large to make
>  it worthwhile for the parent to suspend and then resume?  If not, the
>  parent should remain active.  If yes, the parent should autosuspend --
>  and the length of time the parent should wait before autosuspending is
>  on the order of the value of D (let's call it D*) that corresponds to
>  this crossover point.  Thus the parent's autosuspend delay should be
>  set to D*, or something close to it, in order to achieve both
>  objectives.
>
> Moreover, if the parent's autosuspend delay is set to D*, it should be
> counted from time T at which the last child has suspended, but that does
> not happen because the parent's last_busy timestamp is not updated at
> time T.  That leads to undesirable parent suspends occurring between
> child suspend and resume [2].
>
> To address this issue, make rpm_idle() update the last_busy timestamp
> of the device when it is about to call rpm_suspend() which most often
> is right after the device's last child (or consumer) has gone into
> runtime suspend.
>
> Updating the last_busy timestamp when rpm_idle() returns an error
> without calling rpm_suspend() is not useful because the device is then
> going to remain active for an unknown amount of time and its autosuspend
> delay needs to take effect later.
>
> Link: https://lore.kernel.org/linux-pm/fc43eb13-816b-4cd0-9711-848fdab605=
ef@rowland.harvard.edu/ [1]
> Link: https://lore.kernel.org/linux-pm/CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDN=
bp+eQ0S-E52DETWjQ@mail.gmail.com/ [2]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I realized that I have joined these discussions a bit late. Thanks to
all of you for working on this, it's been on my todo list for a long
time! :-)

That said, please add:
Reviewed-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -560,7 +560,11 @@ static int rpm_idle(struct device *dev,
>
>   out:
>         trace_rpm_return_int(dev, _THIS_IP_, retval);
> -       return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
> +       if (retval)
> +               return retval;
> +
> +       pm_runtime_mark_last_busy(dev);
> +       return rpm_suspend(dev, rpmflags | RPM_AUTO);
>  }
>
>  /**
>
>
>
