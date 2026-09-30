Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CAF4CCDC1
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769536; cv=pass; b=WlT32lzoVARB7aqnxyJw0AiGA+DLrjZOrZ5Y1AfirGkX/D8hJTaisCihBR86y3ak6+tNOCiqwCz9DTkCmVHBZtTR7lyMmJRhhvFLhRDNgQ86Kt7JVZWiWv9z/0n0mwAQ41fBQPdbCmprHTII1Ik20wd99FWjmTbcy0OKBuyU4Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769536; c=relaxed/simple;
	bh=gDDF0XFUuoqlHKuciYsAXxZPSv08MbbVx/bzfReSE8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYC0kPOVLx6wJ7zyVuUnP8ssOyhPLCyGF+yr5o2fUWkePBCr0/lxv2bdFEyEfQ5MaAwsemdJe5L1x2uwyn2+ugXHQInZmsgcJMcqc2AmU0nsXXst7NKCR56Y3R+W/8MN/6OMr1YdHkpLotiz844unbTqWZTCqAvW9NJQYO7tZ3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=I6Ou7jtF; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="I6Ou7jtF"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e17e5de00so128818666b.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 04:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790769533; cv=none;
        d=google.com; s=arc-20260327;
        b=HybEJJB3hpKDMTzi2HHmNjzamvHoKZSXnRg2+u6p+c+ULKCgMy1v7A7RYU2GrAU6nT
         b/xEaLbmndt+vnK/n7mnibbZfIosuHyh13nfCE405aAz40KgjVFNamgz144NwpR403y7
         wEl2YfkHz3DgakbqYalTqbptFRcY2HiadhFVX7XMW42wk2nOyQrjcijYaQmtr/YQbfQ6
         c2HJMzQcv/9hAeSZdTY2+lAkgjrDq5HHoMO8FXsiUaYgVIr5VMMhxTrTtf5+yfYfZR+Y
         XD5yfKgvj292YSOWVpfJd6BPXnxGkaKLJI4TfSlzLOGuD9pT49qJRH5Piug85Ob+bBQS
         950Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6F2ERHZWXw7WA/3EGNJE+vEhgczaBRrblyhbjUi05hs=;
        fh=hOZlxbMSMQWEdGvY8S0FaYWTEuVcJ2j9vcdaPNFFzKo=;
        b=qwu9gz4P9wHoJjFxiWHMazFku9fzRRN3g8haZON8t+wYPVg9dJsuUzsdAJgyIvwhgk
         QQEfc7rAunlYmhgQznAQYJxMoJ/90rQmppdpXKJxiuvfhj5+rF+x2yqF0Qcfmck+fc60
         Xvh5wXElODmlyvPbniDro/hq/UBvxuc5P5oIt576MLR9XBgsRZ+K/9b4dqHWAtNz2cmt
         CLeaqvACVFsKH7k5jRdTEea8R0P7fDmRMVRwJPQB93eTnkt1HkuNuRS+gMiuAB9UMEYU
         4d7rptYOpyxhaD97necZ9C6J9Ryxpe6UrX5n12zOQUuP1lzWcRH5e6ZkcxYRSRwh2EaN
         1wBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790769533; x=1791374333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6F2ERHZWXw7WA/3EGNJE+vEhgczaBRrblyhbjUi05hs=;
        b=I6Ou7jtF3DP4pS402dtNK+2SD6R1BKdYTVSruchFRPXUmAcszzgBp5ws7sA+bY3Zzo
         nKvRl21mTNINsLGVIp17z3PI8aM5mAH4YxlLp2ka9hfRGBqUSDSY347ekDkZNSJ8MMvf
         /+Av059YD6q/04oJaoZ+S01ZjXstAXYxZa/mFrIVnj1C9vxr5jqiZWtFvojuhw8xYIjz
         YcITNQdgSBAheMj+JOR5faow7VYFQGFVDIXFdN45CsI5Y++j0H6eAbkLWzodIwwwCQ37
         e43rJVJEz4BMwQlWb7OfqQr5uQjTa8YpSdndIJAjdCGwkG0kdNk5F+6fhrApZCVr6ooG
         upVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790769533; x=1791374333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6F2ERHZWXw7WA/3EGNJE+vEhgczaBRrblyhbjUi05hs=;
        b=LbbetY5i1oELROvPt4sFAYhfky61U5LVwuEb4jfwmFiSmzo1P2i4FaNNScrSQNKxj2
         HG/20bDluXlSIzpxlZ7+SWmQRM4CULXI5vX7s7ejdHIfVvSisKQn/enK63naX4b5OYsZ
         RIirS8z8mePZj3VC1pfn2VPK63aywwONayWOk7G/ZO0Eer9pJHOWUMPoJANZCiDrlyh5
         MTBRUT6uZda8xBMVogBXHVUuaSYO+oLyK89/3ZF8N/3bbUM18jCq3OWKgKfol/X3jX7C
         xz+cIRvjj7EYw9oJ1ZCqL/tpH5CMBARFQlXbr2Ytt4R3TPtJTqJq7vJtskRZFKxqv8Ig
         9GXw==
X-Forwarded-Encrypted: i=1; AKwUvBxvq2bL6zzrPSC8NlkDA2AGvAk3DVUcDxe9aHFDYHReoRQ06wkhTFbMTpoNO44msWEpo/jGa+If2Q==@vger.kernel.org
X-Gm-Message-State: AFuF++l0HHwMqICNMxZAus6ZYgykdkO41eDWAl8jj0BaTo2VAtoIiZSd
	TuO2uRU1kEjHEr9jqEA5fqQjfU0fN8ZVCWILPQGIGJHxy5LEzj9yLtsfYNoNbkR/Deby7SCyZpH
	MvxQlOCbBSz5EZShlhoTVB+WO3YfGx/K/uZDwWA97Zg==
X-Gm-Gg: AYBFou0KCgpTVtPzsS0BWbnboTlzek7HZO/FI8XQLjFv3RlM8r3nbCKVXMImdH6JGQL
	/vdSwNiPheWcQmFUHgPoUGr/av5i5QPxATkyePZBW8eFcO49Vu9hb2Ul/5/RGytEw9rp42XPpkL
	SQQUkIhlAHGEZ8ZTUyGn71GmfINixT+gc0oYHRG4KiO8WriE4KhEBlPoYmYEFYwjhXPzXxFfMq+
	2GYi+Vt7SUzEmpxqG29qW3Qeq/ba4LMpqQXNnS0hyV3Xe6ohZvBxkOLFHBYeclxlSu9Tus6/TSW
	zbspSgwdAGaqPWGlrJ0RQ/WUjybSTF23eAi6DU74I2kVUfPbvxi9NFEiF57wJ4RdGX2cunlK11I
	0sTTwsDPerjAisg==
X-Received: by 2002:a17:907:9708:b0:c26:19de:913a with SMTP id
 a640c23a62f3a-c2e23e58df9mr108073466b.45.1790769533085; Wed, 30 Sep 2026
 04:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-b4-rk3576-reboot-mode-v2-0-5a34ca72065a@flipper.net>
 <20260929-b4-rk3576-reboot-mode-v2-2-5a34ca72065a@flipper.net>
 <20260930-fascinating-cheetah-of-speed-7cccd0@quoll> <eb2d513b-3c7b-4298-932f-8e7cc8d9c08b@kernel.org>
In-Reply-To: <eb2d513b-3c7b-4298-932f-8e7cc8d9c08b@kernel.org>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 30 Sep 2026 15:58:45 +0400
X-Gm-Features: AclHuK9WjZS6N6YQrXd5XAL-P_3Z00CVqfe-4TuT9v8_bFTVQ6par63t-_u8TFM
Message-ID: <CAKTNdwHy41vh_Hp1zOnOtK-v7LvpvH0tgjP0MrMXdtZUqwubnQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: power: reset: syscon-reboot-mode:
 allow supplies
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:50=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 30/09/2026 13:47, Krzysztof Kozlowski wrote:
> > On Tue, Sep 29, 2026 at 02:28:19PM +0400, Alexey Charkov wrote:
> >> Whatever program that acts on a reboot mode runs before a full OS, so =
it
> >> may lack the capability to enable the regulators it depends on, and a
> >> reset that preserves the mode register generally leaves the regulators=
 as
> >> the previously running system left them.
> >>
> >> Allow a reboot mode node to name such supplies, so that they can be
> >> turned on while the mode is being requested.
> >>
> >> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
> >
> > Again fake tag.
> >
> >> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >> ---
> >>  .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml       | 8=
 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-rebo=
ot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-=
mode.yaml
> >> index 79ffc78b23ea..5ed70c87269e 100644
> >> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode=
.yaml
> >> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode=
.yaml
> >> @@ -36,6 +36,14 @@ patternProperties:
> >>    "^mode-.*$":
> >>      maxItems: 1
> >>
> >> +  "^[a-z0-9]+(-[a-z0-9]+)*-supply$":
> >> +    description:
> >> +      Supply that has to be powered for whatever program acts on the =
mode.
> >> +      That could be a boot ROM with no access to regulators, and a wa=
rm reset
> >> +      leaves them as the previously running system left them and not =
necessarily
> >> +      what their expected out-of-reboot state is. Any supply describe=
d here is
> >> +      enabled when a mode is requested, and stays enabled.
> >
> > This looks like workaround for missing supply handling in actual
> > consumers. Fix your devices instead.
>
> Heh, I misread - you need to power this on? Then how does your board
> powers itself in the first place? And how do you even solve the
> incorrect - e.g. too low - voltage on these regulators?

When the PMIC comes out of a cold reset it has all the needed rails
enabled by its power-on default state, which the DDR trainer relies
on. But the OS will normally disable the rails it knows it doesn't use
itself, so a _warm_ reset which keeps the boot mode argument live and
keeps the PMIC running would leave those rails disabled, unless the OS
put them back as it found them.

So to make warm resets work one would have to either ignore unused
regulators in the OS to keep it from powering them down (ugly), or
mark them "always-on" in DT (also ugly), or state that they are needed
for the reboot mode feature, as done here (which is least ugly IMO).

The DDR trainer unfortunately cannot access the PMIC at all, so it
won't be able to enable the supplies it needs.

Best regards,
Alexey
