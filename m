Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795699941;
	b=2leXN0vaBNXA6oFOreVrMRxJ+2WR67HHvOukbWcMSJSmBJzmGnA8UcqXY8mdQ1EpnSCy
	 VP+6+rekO81uvS8N6tzGkKNQPuP9zGTfRN5K3kff0mIdA6KPQ87zXE42irA6GVq6S+X51
	 juuv53CtYfJTFnweUFvmS+GTWsgcJWE4bLQjVIaFr/2LOL7T0Ia0QEOhSpaTOqphV89qO
	 IZ2clX94F7TqHgDA9jasdSnCS4Mb1qt0Ji2ES06yflay4R9Ma8RcbrVf5Fa/zP0g01oMC
	 a/b9Tcyedfh+5zLck28Vm30N07xPdwDhyRKPLOxPTYBPoskUY9qioJca0vJx5mqzMnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699941;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qEA5KXj0f3ThiS06ddbyc/0mjBi0i81V2WjSLw3INmY=;
	b=HELgSSVHBKzORpjDH+uH8abJtscI3TkJJRBJb8r6qdg9nGdAmTyC0JhRLDrMgkMUaoCV
	 7aaMQl1ftDok/wpsd4bNnc19mas80cn5TFl9dpfpZwWiEzDaKf7Mo7kEpV0JCeP/fmwOg
	 Y/Ci2J1bHm8QxSsOAiZXrsExXcIks9bLnVbLaJT1eifC9jGtQYQ9pL9LKIwRJ0nZSYXS5
	 jTRmGmy5mCZt80tK3oetSPz8GtIl/VjtYI/BqhxNYoaLKEPU+doY2JD+xEmXX/zFnhenx
	 0098enhPrXwGRxHe0FLJTsHZ1NjVsPzZWtbDukodKNxxT1qA5+7oMkrU0UsqJJfiNtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OjIFWy9q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="g/shpMxu";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F0606A323
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F1F0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OjIFWy9q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g/shpMxu
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVV5Z4128754
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qEA5KXj0f3ThiS06ddbyc/0mjBi0i81V2WjSLw3INmY=; b=OjIFWy9qimT+503d
	yjZC74sVEqO+182EJOCu4552hHfsFtFXTMmzq9aJqOrKx/i6BgN+19SDK6ikqTaN
	zf7KyH15lAvrtPoRhLzPhasxY8iBonsOvtKazucRlDJYFKwjKpzlNo+gepWHOxDy
	z04mvMH32ubMgi8Z7b6AWz9qH66NC62BaHxZUYrw0MMgt8oYUI6wo+EtbZbahp47
	nPd9kQx4DeqYZP6NfHmDRu745AICYva4WymUPZ+zTvMzLBwhIjipLw0mOe6JquA5
	XTJDr8bCHon82OJ3zZvXF0ggfRIi/XGnCBWQuUf4G4NypeKbRkUtIsG3iKMXyZge
	Ul7NuQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62vav3xa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:32:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb90a6230cso3443925a12.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 05:32:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795699939; cv=none;
        d=google.com; s=arc-20260327;
        b=S8wXtTBAJVNYtjpoDRRG/vu13/qbJmbg0MN545HvAS3gyP0XB5VBQ7CyG0ADa3TPcD
         i9tg0e32MVBM84STSRRf5FDfYIaD/vNYRknyQ8hg3Clxy/D1X7V8fZSe4z3gQ5zAzUGw
         OqMRZo30vknX70Ua4cBarrbnF6Q7T4fX4YlVotwjUQZmN30L1XhY9b1YyaC9biPfoLD+
         FDx/HJrs47/nUpLZSSTrgrRKM9dERGvw/a+XD8wXqUmYos8uoSciLs/8KpO2SNw8jPas
         6P52ZjyMXcbDNLI57pyiDZPsxHXRWHIFSU/jaMfs34vO5INRJ5zP8kcTHUfgeB+HHgpq
         OhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qEA5KXj0f3ThiS06ddbyc/0mjBi0i81V2WjSLw3INmY=;
        fh=axFAoMdrIycgnlhPFHX+2VmpjOAsm1ffvP+MhQPZbVg=;
        b=K38wsFQ/Pm8YLJ4veWhfLYdaCkV0e6dlchM+vny+zeBBaL2fuYIkzPxo0jSIDSfBWO
         yp8/YjqV8RaAnrD8/cQ+fMx3SIuJ8fGGhDmB265v86AJ6lq9Cc0WjPdTlnF0tJH0AoA6
         QApaVySvnnpivlm+CXD/k3BVWfba5nXqysJ9hoiJWFp05dIlZ5kco7dEe2d+6KsLDmrA
         avsHF6cKeqLNAbW0Nb1Hur4OLbE1RAnjCsLx5Bc8pLRkQaxDOtwGCc5YFr3VqMVjUqih
         9BJWGEY64+dpAxFmuEZAsEZ7exhKSpGcWN8ncBkrkX+CVSBo+uy5RQsO/ZNAlpq8bdYJ
         u8iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795699939; x=1796304739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qEA5KXj0f3ThiS06ddbyc/0mjBi0i81V2WjSLw3INmY=;
        b=g/shpMxuZF4LM7sEkbK6bpgBNcK8mKb7OdeHSC6Fn6N7aSXoasTMUV1gnl8SwfJQ9i
         xfjv+DDQg6Q/7RDXNnjfHxlQQfNZZLmAiHonXNzg1zpn2rnirhIeagADZ/YZ7ibrnFMt
         GraIJC6mcJ5MzfBjfyJh1+ChT8wJG5gsoBvMCZX0RyjFcToPF6qk3q1b7fkVuKpHIM34
         fuaubOD4NsExeNlYKDG/FQ6bY8kVrAoAzxjGAT1HS0V1rcpRG1DXndKil8zV0zOAabZF
         d4TBZFuFVaNHM+A8UrLIhauTRxoQxK5C8ji6YXNNqqNboeqM/VSa7Rlh8H6O2HncAdMP
         CBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699939; x=1796304739;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qEA5KXj0f3ThiS06ddbyc/0mjBi0i81V2WjSLw3INmY=;
        b=apzdJ19Nlip1CR7JvAaJztBSbT8Cluih9Dg+R7sve71yfBnqF1cD4hzqa+E0zqDkOK
         +dVd02GAcIjgt1XO0pibgmHT2Ewj4Vpvnc3YcZxqPXIEM1DI2vXu9SSK6V5d9kK4UoMX
         AeqHOwiq/SURTI0NADnVP5q1S8wF7UfJaLZu0Xh5HWqrhacpqBQ2FnCHQ4dIgIw1zVX7
         sO9J/iwW8jTANVopbTvaHMBN++md62RMDK/lwQjol53Un3i+XzQbEQPTba7zyUwT5UHp
         dqO+pGxuNEqRyoCx1wuTlcILsy85UN4U5CoeJZmdB4I7q47tpipnvuIlRpHjyin0dB1U
         xp3Q==
X-Forwarded-Encrypted: i=1; AL+hErEj/Oi1AOPiLBUSe82LgWZ+NNYbcrLIkbqVVKzovBLNzsdyhVx3TbdJsBHkwEAfLmyD5fOfa0GY9Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+J/ASRrtvCQpLLigBjyb4JC/EdfA6Jn+gVDtaxnRCHmszszRpx
	t4GR6YGoJuMVUlZQURt4swq5ih+F8BAEfLAkcDr4/jAvUoV0V9yNRkcB2E1hQ/+qJyhhfjmwRt8
	HTGkKhxM8bWp4id8Fbonb9gwrGK40XMBhfUwRj8FtG9rD+wEpD9TPpLZJn1dk+A4OsHGOnlgOjm
	Pr7V4H4yhbNCCv76FUp1Ni1GB7lPgP4dm06EEf
X-Gm-Gg: AZFdTZcqGlQOP+BnXvBnkB7+dCWYRlPb+4MjXxCeQBjWJ3o90ElCvrY05qypRoYuCIZ
	BGiOJWZFVqbZo6bqOqi99VJwZ61Fq/Ved1dOcGv9Rlhv2dRU+JhfVtRHCHjZrz9jLLKG4RsWCkG
	ozNVtUIY42B7Zl0dDcc/2vF1TrGaieQjLFtJnCSeZJNxDayBezyJjcHKW93Q==
X-Received: by 2002:a17:90a:e7d0:b0:3ac:929e:691 with SMTP id 98e67ed59e1d1-3b41c8d5a52mr19387635a91.17.1795699939241;
        Thu, 26 Nov 2026 05:32:19 -0800 (PST)
X-Received: by 2002:a17:90a:e7d0:b0:3ac:929e:691 with SMTP id
 98e67ed59e1d1-3b41c8d5a52mr19387591a91.17.1795699938695; Thu, 26 Nov 2026
 05:32:18 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122205136.138173-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20261122205136.138173-1-dario.binacchi@amarulasolutions.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 14:32:06 +0100
X-Gm-Features: Aa3M54qyMkmbPaP98YC8FzT7AHfFztRyNksaNUDQLw1O60koDHwGD5wwKboKV-k
Message-ID: <CAPx+jO9kioaEq14zdqVRp--eqvwS87MG7j6Ztg30Xs91wdOEHw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] pmdomain: imx: Keep the domains left on by the bootloader
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
        linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
        Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Kees Cook <kees+treewide@kernel.org>, Marek Vasut <marex@denx.de>,
        Ming Qian <ming.qian@oss.nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Xu Yang <xu.yang_2@nxp.com>, bui duc phuc <phucduc.bui@gmail.com>,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfX+jX4aFo/6jnT
 HrqNcJSuldK2y3bbGYIkXIQu+DZVDDFo6Z/GGJMGqymGHvhaioD0n/kGYVgy2gZp6fkmrW7qB3e
 MettHJ0U9eMVjEMU+uOMTHjLMqTB+IQ=
X-Proofpoint-ORIG-GUID: fzmp7tlKkvWirOSEt76_u0d8IYeOBcBT
X-Proofpoint-GUID: fzmp7tlKkvWirOSEt76_u0d8IYeOBcBT
X-Authority-Analysis: v=2.4 cv=QZPzLcbv c=1 sm=1 tr=0 ts=6b0834e3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=r4OjQRZgDwFT0wjx:21 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=iP-xVBlJAAAA:8
 a=OhlDQ7rSrotYEbIJSlcA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=lHLH-nfn2y1bM_0xSXwp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfX8dtFHeIU9oiD
 MtS5l2mzUHhFK8ZUgzyej49o7s5hXLEyya3c8PqXfoY4A9HPV0CkZkcFyibhhp4aWA1y4fajNai
 u+fh7w8hvf6apF+OJXwa5P4VuWxG4wzxACbk1wEHVMVv04SfXoQ/kAQqKpHr3mb7pmpHQa3R63h
 e61ZsM9iENOhQu+uV1if0PD7p1C5q0dmW8ncDoc6qVm9yLfB41jVyOskZMOqd304wD1yqfT2e/T
 yhXPeu86hnNO381Yna/HsxJhLo38iz7PVg8wGiG7s/e3jBhVY/3VVzkzYhWgN5n5NyVdpw2CI0c
 pG1++4B0kn3KTmGm1gHbIDGHbRHiSwLq/FR9xFND6caCu5KvSzEJ5CNnfOfzWKYRPrK2VdYxNzi
 5C7SqR6djNCOr8bQNCKrpVwkR80Z6kfQUmrmfAB3FAq2A4i/YtlcMdr/U5j9yeoQCEiwRwf22Mi
 rxIwanMDBq+ITTlUXEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260052

On Sun, Nov 22, 2026 at 9:51=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> The i.MX8M power domain drivers register all their domains as off.
> A domain left on by the bootloader, e.g. to show a splash screen, is
> then powered up again by its first consumer, which on the i.MX8MN
> turns the display off and hangs the system.
>
> This series reads the state of the domains from the hardware, so that
> the ones left on are kept on until their consumers have probed.
>
> The first patch fixes an error path of the blk-ctrl probe. The clocks
> held by the last patch are released at sync_state, so they stay on
> until all the consumers of the blk-ctrl have probed.
>
> Tested on i.MX8MN (BSH SMM S2 PRO).
>
> Changes in v4:
> - Register the power notifier before powering up the bus domain
>
> Changes in v3:
> - Add Reported-by and Closes tags
> - Drop the runtime PM reference synchronously in the probe error path
> - Keep the bus domain on while the state of the domains is read
> - Remove the domains before releasing their boot-on references
>
> Changes in v2:
> - New patch
> - Release the resources of the domains left on when the driver is
>   removed
> - Take the references once the probe can no longer be deferred
> - Clear the boot-on state when the domain is powered off
> - Release the references when the driver is removed
> - Rebase on the changes of the previous patch
>
> Dario Binacchi (4):
>   pmdomain: imx8m-blk-ctrl: Remove the power notifier on probe failure
>   pmdomain: imx: gpcv2: Keep the domains left on by the bootloader
>   pmdomain: imx8m-blk-ctrl: Keep the domains left on by the bootloader
>   pmdomain: imx8m-blk-ctrl: Hold boot-on domain clocks until sync_state
>
>  drivers/pmdomain/imx/gpcv2.c          |  77 ++++++++++++-
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 156 ++++++++++++++++++++++++--
>  2 files changed, 223 insertions(+), 10 deletions(-)
>
> ---
> base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
> branch: imx-pmdomain-boot-on-v4
>
> --
> 2.43.0
>

I started by applying patch1 for fixes and by adding a stable tag for
it. Deferring the remaining three to conclude on the reviews.

Kind regards
Uffe
