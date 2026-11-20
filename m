Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202668;
	b=UsY38i2kH+1bMc5FTVrRjfNTba6Md6iqdSES/s0qSNv01kiocj2qAW8Fw4D6QYJ50YGQ
	 wdBIMjt9QGTerPUcGR6XSUxSdjIIPzj4n7Lv4+Y2fDRl6Tu/WFDQZYFA3UNxKUPQb5v6q
	 1zQg96kYzjBAll0xwBNPLf/u7d6fYHtFkMd/Ag1F3U3vg4SXDwp/cb00/8g4+z/oIpDVR
	 B5wPB2t1sJ45yvd4tj/E5QWyVxpukZsgEpokUwhR8aHDYe8uQn5w6894nA4j79d3jq+zB
	 dB8Y9CladXIxHGzJim5EBV4jsZZnW+XlAdulQlW/3gjT+eFnchHg8u5yysve2HcUEyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202668;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gqjx8VuTlp9BpCZdD+GzvYoIV1KePYvGyOIPvNNne5c=;
	b=narCPACBEY2QOopt1P9n+XfDvKFaKMVDIGCXyY4nRqzEycwowRHV0jdEEunWqup2vkIA
	 Jil5+K25aZTG54pYi4X8xGeKOr/Fw9T+c2HEzs1zbPl+QRxdDDKo6XAtG9L21cjDRsCK1
	 izujx2ktFZSe0skg07xcNzFVprjqn1d/3Dod8wYbrR/X+ePraSKfr4DHYfFAJxd72o8d+
	 nGCJ3USiUTjNBRaxGKHOhXmF1OwknO7wBG3E6pDctgyKxBzOjcE/xvTO5sD69o+O+Z276
	 SWYB8cmtGf0Ng+h5MUgKiYZRbMrq/X3K9UJ23gbfe5jjfVcnAEIkvd1+p5/maSfYPIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D07H/xX2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1B2606A6DA
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D07H/xX2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BA91F000EB
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 19:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202668;
	bh=gqjx8VuTlp9BpCZdD+GzvYoIV1KePYvGyOIPvNNne5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=D07H/xX2v8H9gCNfRdoSfz4y21pFbUlzcyGFDGo16blCP+4zhNJ4fiVy4U1xcM5xM
	 ccLq7KBNRwk42uVXl/fbgaCazA0KXWrenRHL3IvR3QJv4qwFfEr+Fnq9XEh6zsjmCq
	 l9o8reC17EZSvHRkOC1PbINoX0LkOe1xoGrevdiYLZK5v8KDgrOR+7uSfpWrjl6E/R
	 DNarPe5AqeLyNBTP7HWJxKSj5EOkJ1sFWueh5AHW0EGlzGiW8ECWEJXNF1Jqb7H73p
	 yDEFcxDKGP++rrVl/yOX6bhfv5gSHGwEehVHO0CK4voLgVtJtZNGPrPLdTKhnAN9aB
	 6Hof9blTQU/Aw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ae22dcfdc3so10184841fa.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 11:24:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH4VK/gnxPNLfpejX+jhQcoG2jEDFzQyS4O/4+2reL0teg+BgvR5Ijfst3VABBtoqGqmNIZkOk/gg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8rXh90OlEe6W6enaXmptSlyPrmK13rq4mqbuBhCFvlOcvIEB+M
	cxMyplUb8zZLKgsGEtOm7k9/ydITS4gefCEJiPz42n1fAZ2YhiAu9W3PMDuk4UnTWiOgY/Z1EXl
	Lk6gVHs43XOP3dwKIvPl94qvFBLlIXIo=
X-Received: by 2002:a2e:be8d:0:b0:3ac:d0dc:ac69 with SMTP id
 38308e7fff4ca-3ae7fa6cfd4mr13923211fa.29.1795202667100; Fri, 20 Nov 2026
 11:24:27 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118155313.2067857-1-magnusleatti@kernelriot.com>
In-Reply-To: <20261118155313.2067857-1-magnusleatti@kernelriot.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 20:24:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gvw1jtU09CbHyzgi_BiS7YbCymZFWRvXb2atgAAoZUTA@mail.gmail.com>
X-Gm-Features: Aa3M54oHOW03HAxfEM0USzYyd8xyFa3SW6C6ialjHy4tcBuOJbAilYEjNEboCxk
Message-ID: <CAJZ5v0gvw1jtU09CbHyzgi_BiS7YbCymZFWRvXb2atgAAoZUTA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: intel_pch_thermal: Add 200 series PCH-H
 device ID
To: Magnus Leatti <magnusleatti@kernelriot.com>
Cc: rafael@kernel.org, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Kees Cook <kees+treewide@kernel.org>, 
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>, Jean Delvare <jdelvare@suse.de>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 4:53=E2=80=AFPM Magnus Leatti
<magnusleatti@kernelriot.com> wrote:
>
> The PCH thermal sensor on 200 series boards (Z270, Z370, X299, ...) is
> 8086:a2b1 and it's not in the ID table, so these boards, including mine,
> get no PCH temperature at all. The 100 series (Skylake) and 300 series
> (Cannon Lake) are there, Kaby belongs perfectly in between, I see no
> reason to not have it there.
>
> It's the same sensor. Intel's own datasheet (335193, chapter 21.2) has
> the register layout the driver already uses, so just add the ID and
> point it at PCH_BOARD_SKL like a131.
>
> Tested on an ASRock X299 Taichi, Kernel @ 7.4-rc3 with this patch. The
> driver loads by itself and the BIOS already turns the sensor on, so it
> just reads it. The zone shows 66=C2=B0C / 115=C2=B0C Crit, the readings l=
ook
> correct.
>
> Adding the ID has one more effect. I am not going to call it a side
> effect but more, an intended effect? AFAICS these boards were just
> missing the s2idle cooling delay that the 100 and 300 series already
> have, and now they get it. X299 usually runs above the 50 C threshold,
> it would wait the full 60s. Meaning that the wait *WILL* be present.
>
> The reason I am saying it *WILL* be present, is that I could not put
> this specific box to suspend, due to the GPU not allowing it under Linux
> and X299 not having onboard GPU on the CPU. But I manually followed the
> path (intel_pch_thermal_suspend_noirq()) and it seems to be precisely
> what will happen.
>
> I am not the first to notice this. Henry Bent put a patch in bugzilla
> back in 2024, and Jean Delvare asked about it on linux-pm last year.
>
> Link: https://cdrdv2-public.intel.com/335193/200-series-chipset-pch-datas=
heet-vol-2.pdf
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219197
> Link: https://lore.kernel.org/linux-pm/20251222154444.496284d9@endymion/
> Signed-off-by: Magnus Leatti <magnusleatti@kernelriot.com>
> ---
>
> Thanks,
> Magnus
>
>  drivers/thermal/intel/intel_pch_thermal.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/=
intel/intel_pch_thermal.c
> index 074bc8ca5f0f..7d8803608486 100644
> --- a/drivers/thermal/intel/intel_pch_thermal.c
> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> @@ -24,6 +24,7 @@
>  #define PCH_THERMAL_DID_WPT    0x9CA4 /* Wildcat Point */
>  #define PCH_THERMAL_DID_SKL    0x9D31 /* Skylake PCH */
>  #define PCH_THERMAL_DID_SKL_H  0xA131 /* Skylake PCH 100 series */
> +#define PCH_THERMAL_DID_KBL_H  0xA2B1 /* Kaby Lake PCH 200 series */
>  #define PCH_THERMAL_DID_CNL    0x9Df9 /* CNL PCH */
>  #define PCH_THERMAL_DID_CNL_H  0xA379 /* CNL-H PCH */
>  #define PCH_THERMAL_DID_CNL_LP 0x02F9 /* CNL-LP PCH */
> @@ -372,6 +373,8 @@ static const struct pci_device_id intel_pch_thermal_i=
d[] =3D {
>                 .driver_data =3D PCH_BOARD_SKL, },
>         { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL_H),
>                 .driver_data =3D PCH_BOARD_SKL, },
> +       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_KBL_H),
> +               .driver_data =3D PCH_BOARD_SKL, },
>         { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL),
>                 .driver_data =3D PCH_BOARD_CNL, },
>         { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL_H),
>

Applied as 7.5 material, thanks!
