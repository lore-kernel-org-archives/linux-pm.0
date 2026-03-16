Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964C372EE2
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700523; cv=pass; b=F3FC+Dfy+UHLFx3vPOWv6oq+buAHjVckZMJ5ySRZhocU//HXeEk8WFtFv+Sbn/kGogCfm63ZfkPWPGiHyo/+yyN5yiPaf7AfeZG/LfH38bCiXL/1lHxriXfqYjtdyHzsqFCkTR76G2D64v5SKC0O3zvisdcVRf+hXL5ycBNjIvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700523; c=relaxed/simple;
	bh=X8mio8kNECrnD7g8Wvz7SSendh1SQnLSxQ5Izt0e38I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epNYwtHidGw4AY2oOal08pgcui+v84wzbmmkSO1SD3XsGqdoWjM2OONAJb+v1K05zeTAb3SWcyIcTYMbjp/VRUqqlBLSNtODe0GgS38hwKuF1N+S+9f8Er+zHztn7vS5Wra5bDxuhDLC6EPrj0py1K/K/7/hOWvY6Pfy9zuC3Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3dgDwtL; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3dgDwtL"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4042fe53946so1954849fac.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773700521; cv=none;
        d=google.com; s=arc-20240605;
        b=BG0PJKCIJpfBYMUDioywkz9TtHe2wLKZaxwW7BE9Ply8xJF9vEkxQUZ+ewhBlFoBYo
         gW91sz0mj6YY6tXXf15/9144Xw8n+sEkI0HEvH9OG3fAvHaYxzxBEBHedQBhuUMlQZyc
         KypsSEcFmTGZfudlP2NfzpCn8OvmtFr8Pku+mDEJ98CIeks8DxKUoe4oViNL5iiCUdef
         RBUvDCmmM/xnXzB09n3koMvDRJ8VxpKZlOeHKcKqCgH/f6gSKqQHW2zY3x0ISduBWwMi
         SHmtwfbjc/D0+IYYIyHKhPTNe+fzXvIhdEXb6lL0l3OXwBm3hVxW8nkH5hqfZBuN6N49
         /ksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xXJC7zDdC8S8kCMXP3Y8fcS1OYO4pKzMyEbES776Ceo=;
        fh=xX/UowSm/Jhww7ZBUjD3QwZdXyIWUOubF194cy+uQYc=;
        b=KSyXe0xOHs/uqi3b4hlmv9RdsIBNy8e996MhREQxQeVSjIZr+R2krdlhQS4n0UOhYd
         cHD6WTGhVp3SW+qRXYydDfOdVcoOJs6+Atv1Exm6UOrLiw7eR0iZqrx34WLho2H5ITzR
         zkWqtNF43ltW+KXYb4SXwZ22Vw0KlG7kaq1X/hJl7RoeaY5mby5UWpTS3ZRjO00uGheD
         SpO/qtU+b0K/3TGRydxlo/mOIBy+GlAt+Lyzc0oMhfCUfOuoqVX/CI/JqTcyelYAA67H
         cb3abgNwb4l20t3F6H3/FJz/or8fnJpPpcgt5DkavbfGCozNaGhQgoa0y3rXjRuiaO4F
         dvUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773700521; x=1774305321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXJC7zDdC8S8kCMXP3Y8fcS1OYO4pKzMyEbES776Ceo=;
        b=F3dgDwtLrnBAuyqB8yb9KL3kqzWbSjfs9g29LwQ6O5YktcSMOYgKeUdkiKqAxBeQVL
         TVn39mOjDeRcP5Zrv7fk5eGziRdgKBzjVmMITHG+xMVKYJPy3HVqiD03QFKJRlifKCk5
         4Yif3Kgan7odzZigeapq4ta/VCz0M7ZpT3BhznmXggO8ZNZtRWJlK86VC0tm7tbzPm9z
         VCSVdvO57jz9x8W/43+CF/2feJSouVQAGFz6bv1mGBY4uu6WAPkEYn9hDL47T6zHNX59
         3KFxi9evdTpiOYN38Yaa/r0AdV+nBChUbK8I1cUPkqzDaanN8VLJNPDOA08TkSw22yiL
         Jkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700521; x=1774305321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xXJC7zDdC8S8kCMXP3Y8fcS1OYO4pKzMyEbES776Ceo=;
        b=PywIXWQ2wvw2ElfKRvxWr+4tWuwOLEX3hW7XOUfJXY39jq986j9f0GzgGa+Lbd9smW
         qngnWOgDVr2xsxvZ0t6JC8Or00OWpbZz//yx/oJlCrYyVPVKBUvvgvJgpQohItdIr1XB
         zpcCWqPtXEtqAd8+iFrWC17ijSlmCkeyMzHd/XE46jefIP8WCSgLj4AXnHFurt3G0c2w
         fZ2LDn0c8YX9FbqVMi3LsHJlHmGR0qunbgKH2aLFI/dNEF5Fb/Wi2lwySjM3hVWXnw5X
         rV9Cx/imlp6U9ahhMJuXrOPWhOWioUxfLBqnMDd7euuIuHUiXmb0Z86AfvZsTRqmfhwk
         5JBw==
X-Forwarded-Encrypted: i=1; AJvYcCVCvFuk36PdI0PuGTeQu0yx/DbQvDBwKfpOfj70/wC7hPnv+AGKZMK8ru+LBD8I+5sk0uv9Lr6h+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUjKXL1kV4mZ14zoB+uJy4GE/qCC444Kwt8lfH4pWL/WqSDyd
	aK5H9Cm4qkBtZMrLIjfiRXSI5V3IUrLRQ7ZF6D+WrJRm8JjdL8bYf8I7NGt3WAMWlDaILHcJNke
	ZZDA3c+tFEylGWUQ6mcWSIIADFDCSnTh9aenMx01z
X-Gm-Gg: ATEYQzxmxw/q3yoiASKsRyaXuTwgo9gXsqbD5rH61thY20Mir194vGGpNciIgGmF0CB
	//VngN4HNJTrOl0llwaUMwTKxc5Lb/kkhm3aCRlPS1w/Wn8Y7e46B0hxSkSYwzPdUwQ2ASqWs69
	gezgaCXOuwceGNaUwxcLa94N85t38wWInoOThTeXTZqu8hWK3rfFmCyKnoune+Iid+B8gvrqTIw
	ZRwUIsMl8pPsf6YtmJ/jihwBYD/D91VCViyEww1QuXOwVo+uZmS8v5jbMMIZ5C+xQ/5Xq7rFhhj
	O2o0Z1xZczCfJh4SHGNmCCUIHqVBFPseTYNsi/8H
X-Received: by 2002:a05:6870:d8d2:b0:417:6997:3884 with SMTP id
 586e51a60fabf-417b937a5b8mr8480876fac.35.1773700520937; Mon, 16 Mar 2026
 15:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226055311.2591357-1-badhri@google.com> <20260226055311.2591357-3-badhri@google.com>
 <aa7lRufFIdqHTOMg@venus>
In-Reply-To: <aa7lRufFIdqHTOMg@venus>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Mon, 16 Mar 2026 15:34:44 -0700
X-Gm-Features: AaiRm50O1kImotm_0hiwHA_K6T-xNXS2cyWuaCIPk5eUa8UfYxwzoDudvzje3U4
Message-ID: <CAPTae5LyH1c380+Se16XJ6btysjJnBTFWR-Gw_kHX-T-x6NRZw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] power: supply: Add PD SPR AVS support to USB type enum
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Sunil Dhamne <amitsd@google.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:22=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Thu, Feb 26, 2026 at 05:53:10AM +0000, Badhri Jagan Sridharan wrote:
> > Add two new members to the power_supply_usb_type to represent the
> > USB Power Delivery (PD) Standard Power Range (SPR) Adjustable Voltage
> > Supply (AVS) charging types:
> >
> > POWER_SUPPLY_USB_TYPE_PD_SPR_AVS: For devices supporting only the
> > PD SPR AVS type.
> >
> > POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS: For devices that support both
> > PD Programmable Power Supply (PPS) and PD SPR AVS.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  drivers/power/supply/power_supply_sysfs.c | 2 ++
> >  include/linux/power_supply.h              | 3 +++
> >  2 files changed, 5 insertions(+)
>
> This is missing an update to Documentation/ABI/testing/sysfs-class-power =
.

Apologies, my bad, sent out a v2:
https://lore.kernel.org/lkml/20260316150301.3892223-1-badhri@google.com/

Thanks Sebastian for taking a look.

Regards,
Badhri

>
> Greetings,
>
> -- Sebastian
>
> >
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/=
supply/power_supply_sysfs.c
> > index dd3a48d72d2b..f30a7b9ccd5e 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -70,6 +70,8 @@ static const char * const POWER_SUPPLY_USB_TYPE_TEXT[=
] =3D {
> >       [POWER_SUPPLY_USB_TYPE_PD]              =3D "PD",
> >       [POWER_SUPPLY_USB_TYPE_PD_DRP]          =3D "PD_DRP",
> >       [POWER_SUPPLY_USB_TYPE_PD_PPS]          =3D "PD_PPS",
> > +     [POWER_SUPPLY_USB_TYPE_PD_SPR_AVS]      =3D "PD_SPR_AVS",
> > +     [POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS]  =3D "PD_PPS_SPR_AVS",
> >       [POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID]  =3D "BrickID",
> >  };
> >
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.=
h
> > index 360ffdf272da..7a5e4c3242a0 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -210,6 +210,9 @@ enum power_supply_usb_type {
> >       POWER_SUPPLY_USB_TYPE_PD,               /* Power Delivery Port */
> >       POWER_SUPPLY_USB_TYPE_PD_DRP,           /* PD Dual Role Port */
> >       POWER_SUPPLY_USB_TYPE_PD_PPS,           /* PD Programmable Power =
Supply */
> > +     /* PD Standard Power Range Adjustable Voltage Supply */
> > +     POWER_SUPPLY_USB_TYPE_PD_SPR_AVS,
> > +     POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS,   /* Supports both PD PPS +=
 SPR AVS */
> >       POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,   /* Apple Charging Method =
*/
> >  };
> >
> > --
> > 2.53.0.414.gf7e9f6c205-goog
> >
