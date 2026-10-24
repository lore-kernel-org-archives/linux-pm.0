Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792807118;
	b=JAyjSLVobxnV7Y6QkkniMM4yUEjnlHqFBrVB+bJhD6zesol/Lsly6Cc/o9Y4+VgH17f6
	 14Q6Zt+JD2g9VWQvfPm0Y3teNPIC7mnKsQwOwjnXP1UPXp4gVWYc09gbjV7SfGU8jN5I8
	 eWcwcLIgFDF7Ng9gwkDbdy7m9RyTf2JUe18i+pCDttNHnGdc2QBcd5VLYqDmNGSgaU50S
	 zXbMjkgne0rD+R6dlKuBD8fbWR7NL7zmLCu8RQIpvjhh4G5f5X7hTUIoDanajep4s6onj
	 nRfUGbJ5JgxmytDJXBIXhLwSuXdzJT0uwQ+wnuVAFmmdcmjipcqcYckJjOSSXifmcPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792807118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ECHij8PdbURaFnqvu+XeUPXdEa8GHm6DzxM6Ksh7jCc=;
	b=zA38Sgl0NclhAVsgk2RwnRX5bWmsh5YyvN3oD9JJx7b+DmJgwJrFu4Ld+NfQtcYr326b
	 zULMmxnyFPdg5mEFxgh67WFM9LPnwIhIez0yjE+6yZPIuhUbZfAt4sQMzR7hM8+ENvlp/
	 fxCmdb/Jzmwckeuxv6eiwJeU+Wv5BjFbqcE6E4fq45bhGI315dmWRUOEleNVYXnLSsd0K
	 kntXuJKeNISUy1lQ2nouwanpcG53864aTFZ/4UZViWzeEOmly9XwJonC41pVtvCTDRRzD
	 HkInzjP9f0oOgRJKYfiWw/TCkg5O9J9Igx3sPQDxaZMKOW7szp1PHapvEZReVifTkfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="C/eJlWo7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B780606A321
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 01:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B780606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C/eJlWo7
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4677aad67bso160057666b.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 18:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792807117; cv=none;
        d=google.com; s=arc-20260327;
        b=oLKFbHinBMYyvRb87HW0R3+MXimUx0kHKz1XOkkHVXWgusRfUKqkyG5Z/bdZxjLJ22
         CLlC88gN64BBRJbCcZjZxkUjb/g7UitnRriJAinuMzsyT/gJsBAZ4FHyqoKz7n4hPt5v
         LrhTmtsn77EWUXXU3/Y9oLlsECHgpsC6euo2WITk3NQZcehaxwqP7QyfF/zg6hgg4Ewq
         wdHxbHnMmZ+NoJ85TACtSaTMIXGCVyt6MWWlslASstdR5XTPP+lYKIqjg0hOTwF0gKli
         IQOaZAYI5Iis94CZ44Lu4OzyfhHEZ0xsxtcpSkqFoRA3+T+PcXZGXOdeFS3dn+sNxTrA
         yd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ECHij8PdbURaFnqvu+XeUPXdEa8GHm6DzxM6Ksh7jCc=;
        fh=ejJovBe/v3llTY/a/outXiBveNDqNEMIGr5F3hZuuCU=;
        b=H9z0M6gOwSwCmn+tqIEFnzy7ziDLv+joOjmg+qmbLWKx8UQVtiNZHYZLsui6PraSd2
         19uuQxPU0Zi0sM9H2jdyVPmAC0Op7vqUnSsYyDdijtFrzlwYr3bMw69hrMrd5XWiz+tG
         V91eowK7XVZvEYDl9hMlI3Hkq23tr4ZFz0Mk5cOwfrVh5QnZYBc/h9twmWIjsT005aXU
         uDCM2YhdTCMxK5qjpQyHKVUYF2s0a8lbfofVzvwttPkVd8cu2aIXstDm+2eCvsXSbs9z
         NjYO677NXK7evXsGjHjgZM+d656I8TociZeRdoBg8AomjVHEz8bP6eXj8XKAT0c+6+s4
         7C/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792807117; x=1793411917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ECHij8PdbURaFnqvu+XeUPXdEa8GHm6DzxM6Ksh7jCc=;
        b=C/eJlWo702NdxfX4/AfNaR3w+0w8J1lGdQi179AJXND78n1ikL9XutvyX59o3EuNy9
         wMK7MGwUFMTkiVUuQ16JOWYX+9uvFGUv9vn+HJ/olaPkNggEmdT99DLWw0LVAxU7fevS
         SUysNNzZUOsM+aZ65wJpwECzGtJtu87BzLvvKNdMpvQhHORryLjI9TihRPZ1K6gBhjaq
         Gi8A/C8tuMn8E4Rvnqr35hMQhg+fYh+J6N2qn2eS98SeNyYxM6TJU5QxzIIzACA4+WTm
         rXSkMnK0PVQG0ZXT6dH1wgfJ1YulLm/UKadhHVLTKEw8VfS/pNlDv2CwAg3c1BHVz1BH
         jZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792807117; x=1793411917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ECHij8PdbURaFnqvu+XeUPXdEa8GHm6DzxM6Ksh7jCc=;
        b=iOvAg4D4bH4bw778YA3BF6L7/3eb7u0b2E8HsrA6/tAo3yPgoTX2Euy7zbbZXhGAv5
         1QTVnMS25pFxQ4Bme6WPUrOne9WzB3esHGa68neIYtUurObbY++lMGPWVg5MAlPxMPtS
         q2UwpSO3lXUj9POKH73eG0Wb/gvxnumh4rCkvECJIhYxC6ZB8Z+/m4yycYPDqOpvD6CA
         J7B4XAOujkwvMwHsVUQrRBCww8USad0tSr/7Z2rrlTEAgkBxLQ+zHAJ8DKswDVgVHILZ
         CsuiNW1ZWEGF+hUHZIo5VYmokwb8aOTRR8opnDbq2X2Acq0bqxBqQws+XcooIXjxv9ko
         mxSQ==
X-Gm-Message-State: AFq9FYKOBzN0dhIBYrD1QTmiFXCb0m0G1RtIwkbPUgopKMqXyFrA7uxY
	Wbv6ZsAGDDg8m/XGO61styUAq2wkps/J9vssYjvTOpgh/CGmsD2D6rg3UEBUOFPo+EnE5wFpaaC
	A3ch+lqT0g0fU9rCKbDvLYa4nDx9ul2RbB3lSUVVK
X-Gm-Gg: AYBFou1XCCe6mRgXO8c9YCNmpQeyZMwFjwCCRzJH0amSoIb/JsGRju1LXdSSSwATNPB
	1zFlw2sJBf3KonWjSx0Fte0K2nYWLSnTv6WjgRtW8b4CEyCnuOJH5GQuI+qVYDQj8XA0QlyxqIG
	Fd/XFhV5654VjjrIPnDezTAbfuxbi893ZE1PlyI/yom+1l7eNqwaYWjWCogDiXXWtRAtk3zWX6n
	06/vbulDY4IBxj44rJusE7ja/aApGTdoizHIQjQECt6HgkJ7935tSaZyK5wuvbehDdUmearK1YF
	DrcxMBGKs0iXvfSr4SBqsSdaGwbTd+PX3IYVQMlCp/IbHQwOH8b5/ZfEDt5KeaDEh0V7B7aynBb
	rIh9bFvSlDnA8RmjXrMsRxOnr5FuYzdkeY7THAcbQ9FqMM7Xhu+ccGmTlU5I6z0t4d6iaPwrD7p
	B+FEd17RjMDA01OnVDOPOB7dOEc5Y0JZaSVqxLmSD5Sz0nS6Jqrw==
X-Received: by 2002:a17:907:3d86:b0:c46:b9b0:8e81 with SMTP id
 a640c23a62f3a-c46bde6432dmr71858566b.32.1792807116388; Fri, 23 Oct 2026
 18:58:36 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018020357.3845586-1-mhun512@gmail.com> <atSacKtZ3e4YtVBy@venus>
In-Reply-To: <atSacKtZ3e4YtVBy@venus>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 23 Oct 2026 21:58:24 -0400
X-Gm-Features: AclHuK8Ag7gTxqfkD21gDaNpDDuyN6cwNOPCWb1MKdVXj4liu7mcdeQKwDbPgu0
Message-ID: <CAGEsz8E+=f5Tx-Nx6OLEMJF24S8LV2oEz4zAssXysvgDU+kpUQ@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: act8945a: Disable status work on removal
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Thanks for the suggestion. I'll follow this approach in v3 and add a
shared mutex to preserve the serialization previously provided by the
work item, since the two IRQ threads can run concurrently.

Best regards,
Myeonghun

2026=EB=85=84 10=EC=9B=94 18=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 6:19, =
Sebastian Reichel
<sebastian.reichel@collabora.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi,
>
> On Sat, Oct 17, 2026 at 10:03:57PM -0400, Myeonghun Pak wrote:
> > Clearing init_done does not synchronize with either status interrupt. A
> > handler can observe init_done set, be delayed, and schedule the status
> > work after cancel_work_sync() has returned. The work can then access th=
e
> > power supply after its managed cleanup.
> >
> > Use disable_work_sync() to reject subsequent queueing and drain any
> > existing execution. The charger allocation remains valid until both
> > managed IRQs have been released, so a late handler can safely attempt t=
o
> > queue the disabled work.
> >
> > Replace init_done with the work item's disable state. Initialize and
> > disable the work before act8945a_charger_config(), which registers the
> > LBO interrupt, and enable it only after probe initialization succeeds.
> > This keeps both status IRQs from queueing work before the power supply
> > is ready, including on probe failure.
> >
> > This issue was identified as part of our ongoing research while
> > reviewing kernel code.
> >
> > Fixes: a09209acd6a8 ("power: supply: act8945a_charger: Add status chang=
e update support")
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
>
> Having a closer look at how the work is being used: Instead of doing
> all this complex stuff this should just use a threaded interrupt and
> completley get rid of the worker. I.e.:
>
> 1. get rid of init_done (done in your version)
> 2. switch from devm_request_irq to devm_request_threaded_irq
> 3. move the act8945a_lbo_detect IRQ request after power-supply
>    registration to avoid problems with spurious interrupts
> 4. move act8945a_set_supply_type + power_supply_changed calls from
>    act8945a_work into act8945a_status_changed
> 5. completley remove charger->work
> 6. drop empty act8945a_charger_remove()
>
> It results in less and simpler code.
>
> Greetings,
>
> -- Sebastian
>
> > Changes in v2:
> > - Remove init_done and all accesses to it, as requested by Sebastian
> >   Reichel.
> > - Initialize the work before either IRQ is requested and keep it disabl=
ed
> >   until probe initialization succeeds, preserving the probe-time gate.
> >
> > Compile-tested with GCC 15, W=3D1 (x86_64), with OF, OF_IRQ and
> > GPIOLIB enabled. No runtime testing.
> >
> > v1: https://lore.kernel.org/r/179211805459.3650807.8742309660995961596.=
G171@gmail.com/
> > Review: https://lore.kernel.org/r/atPtc_jKLo8RhAMU@venus/
> >
> >  drivers/power/supply/act8945a_charger.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/su=
pply/act8945a_charger.c
> > index 7e4b087..7d47052 100644
> > --- a/drivers/power/supply/act8945a_charger.c
> > +++ b/drivers/power/supply/act8945a_charger.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/power_supply.h>
> >  #include <linux/regmap.h>
> >  #include <linux/gpio/consumer.h>
> > +#include <linux/workqueue.h>
> >
> >  static const char *act8945a_charger_model =3D "ACT8945A";
> >  static const char *act8945a_charger_manufacturer =3D "Active-semi";
> > @@ -78,7 +79,6 @@ struct act8945a_charger {
> >       struct regmap *regmap;
> >       struct work_struct work;
> >
> > -     bool init_done;
> >       struct gpio_desc *lbo_gpio;
> >       struct gpio_desc *chglev_gpio;
> >  };
> > @@ -444,8 +444,7 @@ static irqreturn_t act8945a_status_changed(int irq,=
 void *dev_id)
> >  {
> >       struct act8945a_charger *charger =3D dev_id;
> >
> > -     if (charger->init_done)
> > -             schedule_work(&charger->work);
> > +     schedule_work(&charger->work);
> >
> >       return IRQ_HANDLED;
> >  }
> > @@ -587,6 +586,10 @@ static int act8945a_charger_probe(struct platform_=
device *pdev)
> >               return -EINVAL;
> >       }
> >
> > +     /* Keep status IRQs from queueing work until probe has completed.=
 */
> > +     INIT_WORK(&charger->work, act8945a_work);
> > +     disable_work(&charger->work);
> > +
> >       ret =3D act8945a_charger_config(&pdev->dev, charger);
> >       if (ret)
> >               return ret;
> > @@ -625,13 +628,11 @@ static int act8945a_charger_probe(struct platform=
_device *pdev)
> >
> >       platform_set_drvdata(pdev, charger);
> >
> > -     INIT_WORK(&charger->work, act8945a_work);
> > -
> >       ret =3D act8945a_enable_interrupt(charger);
> >       if (ret)
> >               return -EIO;
> >
> > -     charger->init_done =3D true;
> > +     enable_work(&charger->work);
> >
> >       return 0;
> >  }
> > @@ -640,8 +641,7 @@ static void act8945a_charger_remove(struct platform=
_device *pdev)
> >  {
> >       struct act8945a_charger *charger =3D platform_get_drvdata(pdev);
> >
> > -     charger->init_done =3D false;
> > -     cancel_work_sync(&charger->work);
> > +     disable_work_sync(&charger->work);
> >  }
> >
> >  static struct platform_driver act8945a_charger_driver =3D {
> >
> > base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
> > --
> > 2.53.0
