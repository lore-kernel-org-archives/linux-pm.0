Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09047885C
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789011; cv=pass; b=aPTkEew0zyCd5xOtGCcRpdRMKzQKYvOMuJ5tilM5CJIKU8N/kVLANDXN34iNCq58EDJzJdG4D6YeHf4ZTn4F30ozLSfr4aC8RYvC0ygkI7e6lvB8kUm95hr5zAtuZ5WeY8G1IuuJVDEAGWyS5Qr9xlCNFyYssmG6LdmVonXJI0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789011; c=relaxed/simple;
	bh=jNZHF0WExlWBrCI69A25zEKjol7bW38px42D/CWs3WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oggTRwPkP+D5DIxpq2TitcE2v/h5WYfbRLZ1AFjw0rWQ8NqVmyhPQdzd0xvVRmfsXZWYGD0wC/cvwtwDDUsSggQjOGTNc/XQIRMvEMGDoC96wyAzxPjssboPMN9ojUe9770sqB606wIDqIOf7PFMocEsFdQtWApN5a/wJpnjmys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=BzDMlpEE; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="BzDMlpEE"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2544ff970dso480886466b.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 06:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788789006; cv=none;
        d=google.com; s=arc-20260327;
        b=qmMTZ/aoM4lliZtnIGUw80UOIlnfFEKgV34Xyd5Vzi7GGk0onwrHj21O+ycz0MIAt+
         lkAs5cDicG9xMxPuthAL9eKvb4UJ8v9SS6Hr1MBO+OW3AqBt6+oOdIyZ0pPbXHm4EGD5
         WqnTe8F0zs8ihP9jdQTa3mbhewCLH3/RK8eE5l1ZQ+T933tdmO5EgJSwKhYMJUM1nUwK
         s3oR69wwquH12MJhOMo4GNNLlSDoWZeXLi31GPDhhf0BZ6YuyJ2gcSQ0m4Gqll2cosF3
         I/Osyt8lYw2UmvEtsNjRcBUqyx+kfC83s65fUlsmZx4oBqxrO8UbA7yIJHtQntsuxmnD
         1KIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jNZHF0WExlWBrCI69A25zEKjol7bW38px42D/CWs3WQ=;
        fh=SozgZcjrPkXUGIE84Vq1mG00qnEJp1QFPuP3lGXDe7k=;
        b=BbHfWCR7HuVcCEMDlGMFE87fzLu4SUGiP9NKaajv5ZlRh0VRMjNsgBSvIr9KSE4GxK
         ckbssYncessPoOuWSkxP0njzQJSzZHJCxMhgyQrpqTEl5UEycahSwOGWb/4iaSvDNEwg
         iKMFHJxrxpVW/nbX/BeT0buSDy38FgawOrpJPH7UuV9FLwN6AlXw3h+izFi7VpI+4o3/
         590QKJLCPI0AOkqlH8YggLsEBkApfkG3z68eRMQeQTteih4K3hZj0DYxr//UmRFgqxG7
         MWp3I4c0RF0C08Mq7EfPpDRFjjk4NTKWR0BkroZlzD2n8u8Gv1fIz/Utw882P8aICsUa
         XYXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788789006; x=1789393806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jNZHF0WExlWBrCI69A25zEKjol7bW38px42D/CWs3WQ=;
        b=BzDMlpEEyDA68Vcdw424iusj1WGxx07AJcywrv5qJa+33uA6SNCUcmToGcpF3yU1j2
         pW4Ja45T/BvSLfRepA/6VxLSA7oQsip2A2pzTXorfCNabQsvbOx3/UWrZNlz42cVqF79
         9kzeowKN0hQOEv5t6q6gVkccEuErarH8MFYGgCltvJ1lbz5/BQxvI/AwevM9Ko4KbAKI
         uOEPR6KmeS3hl6OKa2USNQUzhnAW2IQ2tbne0V3oX9gLUKh8ZLBLkagNiDlhBNgmL+zW
         k9gyTYnCPlnxhmja9fm6Xq2EUCcVYy+UABJ4WNiYGZLWml89VTP1RBM/GwutCRAZzpsO
         7gSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788789006; x=1789393806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jNZHF0WExlWBrCI69A25zEKjol7bW38px42D/CWs3WQ=;
        b=puVzUUAsFj0wPrjQ74yCMcCVGp3+xJj4+8Tqrit2S3vnbP7gCVyOP5kBDa5p17UZ5p
         uJzmTdxe7+IBUuTzDutlAekIlhYVCfuAjr/nrQUElvrivrQ/2WZOwOmEypVakhWjOGUG
         2b6CJQI64hOJy3BRGWPYnV2dmu1vPZNudJ0wwepvkHW9fQOC8X7/qdn4XjbCxsRkUgId
         XLoGbJwe74CJAZ8gvY4uiMEmtZiHTMuEaZeMTwNbgmHSHpUcjhq9i/72nE04brlW2huc
         65bo7Y1IIYikTnWDdj3Imw2TexEJ4/Ey5nYCM5NMInMSZ9XEyhPksAbUoEUYeYK3ukFY
         HINA==
X-Forwarded-Encrypted: i=1; AKwUvByzTkd55F7B0nWgxCHEM5YZ4yEPSjaeFegapR4MDRaiTC/WYEBgjD6wJhEjRVvB6ZPVbfbir2n76w==@vger.kernel.org
X-Gm-Message-State: AFuF++nr40mU0gQtO+NYumK+7WOTHdXGLOAxIu9BcIoUIICZRteYEHi/
	yVG+sZOPZksib/yBz730nfy/HAPzCayPM43ejPylnro8jvpSfzq8E3UZdSWsVr2sFeaw6TzLii8
	C0cy/Z6NLBGMSjKSetxHnMVQQL9OMvzVYVKrtHTfq9w==
X-Gm-Gg: AYBFou1V9rgd7DTa/i/v6eiUDdgGOlQ3eIV5US9yQs42mg7wqTKK7tlhw7gW+d+GUPW
	dPHNfIlPxebswIKwifTwSAN9M3txhzm1z7uq97Oi8CD71UvVO4C4rj2l8AMp/2ci/yYT9WbfFWX
	3eAiqzaXuSTCBWuaZL9S34O3NTxu2As4HAuo/9Jor2IpqdxbAGoz9HjhPjHLkNIiRbVv/0j6rT0
	zKWNCTC/nQtrzXPSfqfKyecIDuc1aPIoSyoQBK28oqqzFEPiA1CXBEeAoa8pEmSa0q5FZO/wlPJ
	+lV0BnigGVij6OHq9GQtNQf5tPDryJ01LBdS3DoryCtuCKW4xYfhpz1x8gBGJ5YUo+gsTatXqSP
	et5PJZMoYzSLQ
X-Received: by 2002:a17:906:c14a:b0:c26:2151:180a with SMTP id
 a640c23a62f3a-c26215134f7mr635825666b.3.1788789006351; Mon, 07 Sep 2026
 06:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-bq25792-v8-0-c1c70473bbe7@flipper.net> <CAKTNdwF5yW4YFFmsvDFVY+Q+89Uo=YS79nb4qYrT4WyKOszyvw@mail.gmail.com>
In-Reply-To: <CAKTNdwF5yW4YFFmsvDFVY+Q+89Uo=YS79nb4qYrT4WyKOszyvw@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 7 Sep 2026 17:49:55 +0400
X-Gm-Features: AcwNN1ViiR2Nln6q6EquDYeq682N7lzMxojPLLDRGB5jwNk6LcMvHbqWFR0a-zQ
Message-ID: <CAKTNdwGC=AZ9jmD71tz6JqCWk-00QLWCYb9wiG6RRQ0bO=mC4Q@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Add support for the TI BQ25792 battery charger
 (regulator part)
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:21=E2=80=AFPM Alexey Charkov <alchark@flipper.net>=
 wrote:
>
> On Mon, Jul 27, 2026 at 11:52=E2=80=AFAM Alexey Charkov <alchark@flipper.=
net> wrote:
> >
> > This adds support for the TI BQ25792 battery charger, which is similar =
in
> > overall logic to the BQ25703A, but has a different register layout and
> > slightly different lower-level programming logic.
> >
> > Mark, would you mind applying the regulator part, which already carries
> > your Ack, and which is the only part outstanding from this series?
> >
> > No cross-tree dependencies here, as the MFD part is already in master.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> > Changes in v8:
> > - Rebased onto recent -next and dropped patches already applied by Seba=
stian (thanks!)
> > - Link to v7: https://patch.msgid.link/20260603-bq25792-v7-0-d487bed276=
d0@flipper.net
>
> Hi Mark,
>
> Gentle ping. Any chance for this to go into 7.3?

Gentle ping :) This still applies cleanly to -next, so I'd appreciate
it if this could be applied.

Thanks a lot!

Best regards,
Alexey
