Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF441A90B
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528527; cv=none; b=t3l3raj4z66wM5lKNDjIsfSUr+BlwEteT+XQObbq33s1iZkrjklWNDWxpoDAKquKrk8KEq2jQmIMb6c/m8uXJWdJFtvlFJacQZWCSPASyFZAMlEuJXS6jJYTXkUaFsPynL7NVTX4ZtRzm3e4ug5kvk5WInbqLJUqFLB0qw9so+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528527; c=relaxed/simple;
	bh=bWURXCZrQDZ0x80rfdOSm1jqz2Xjezk3ZnaVSR44ifs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch9HvnxTxuZghz+HSTjVuRjJTXBbE3KPeWn60zzgf+mHc8DRTQH7QFwdorqU6A7VswErAtRTlzqHwWBWUNA72nXvJbTLaoJrSR7gqFDCjMm64LC4sP7c7ooyr5Hd8o34wczr6wEzZtWDNxRLgm+WReF7diswIBkZJ8g0aeqoK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9ecd7216cso444348a34.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 02:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786528525; x=1787133325;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/axx2TQndZ7l7LrHHfpxsCFqNyyCWsv8j2VxY85Jrxc=;
        b=pmArbq5Eeph6NQWU11sLxGNCEoBPWDKLnJ62AZpUf1mLMI4TfMmhJJ6HJD7Rsw5TY7
         9aBlt3vs2j9LQAs5xf8mL0Vm70IUnBA1RUloAA826vm3wd1/HT6pO77inD3+P6QDbd6/
         xOQq0jbMAA8KJGnfsyjp7mQQ9uu3ibYH+9Tmgm+ZGU9nEMsFCvRL7gZTg9Zz93XLXJV0
         4hM3KjidNtryXBJSH9dEaWClbxCVlpwmrk58hQkjmOGAw5lY2UGKa9dqi9P+yMsgyOvM
         nIa1rkFG+g8Yn8Wse83Sh5DgkCAg1hKqoBwzS3yca1bLDN2CoauxcbNUuwQ1cPwQvg70
         2Tzw==
X-Forwarded-Encrypted: i=1; AHgh+RpknjlymF1ZZvRfk+iF7C5u90ZOayGqNrcWKUZQ1iqM7C9YvnoLeGmsRyR3+4j0Tj2bRD9GMKEDkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOBMDVsyL15I0/i3pb3/x8hoip1xnh/hqgBNUyfEyNFiMIHguC
	PBHQ+VfuLqUZ6T1Kci3acPjkQ69wLjLJOxoC8Y0WNc/pHMPxlG6rJ5ytLs9Bbt2H
X-Gm-Gg: AR+sD126vBW402TcHzPFEwc/jaGnCJCzL3ucUr4jn2M9m5dpABTjYyMECLRLjOfZ7k6
	TevmK9K7gfvYRQY19yFHGpzT/CjI8uhIk4rA7DgsI0OBD0vgJcvCKE/rsEwUREiZNB6hbxm0Xke
	s+NDXsqpLhSe6EQfF7Ng5SHhtIwSX74GRLogp12Pf6U+JNdTSvvpZN1hBTzi6AduK0btZ4ji0/x
	dUgNp96AHY/1jt2Fw9rLjFTsnrLHAqmmynhQdkSL8gT+F3hadTdZIVljhBl/uVmirZ7bzaI6RCM
	a5yrIT82Q8ya6nPlxrNGRUKXdJzeTceL720dmH2+jNkiCBPwoTm2RJZMAowteChkzrlxrk12Tly
	aRPJfDEawOr9/cKlEW0XhAEXpSG1hX/5mFuqy+iUMoJd/YQqjcV3YFmMAzm1ZGONEkwkKediH/F
	Z9MRp/F92UoQKI/oWoj1IIFvtvvIgOH1V09h9FxTE2gDXO7TwtYdaKJ6a8OH1Alye9xbEXenrww
	eP9lXzcSSd8YMAeCkOSa0hjSA==
X-Received: by 2002:a05:6830:67db:b0:7f1:ddf1:c731 with SMTP id 46e09a7af769-7f3b79d7aebmr3379738a34.13.1786528524226;
        Wed, 12 Aug 2026 02:55:24 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b320d5b9sm2455612a34.9.2026.08.12.02.55.23
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:55:24 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso547624a34.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 02:55:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RozcpknvrZ2CDzj+ARDs+Rts8dpc9LDi0iuf7OkuK286uzkYtuuetbAt3CT3yZz2WvE4KzdUhRtVA==@vger.kernel.org
X-Received: by 2002:a05:6102:8020:b0:74c:7fd8:73eb with SMTP id
 ada2fe7eead31-76c87d7044amr1040741137.1.1786528061345; Wed, 12 Aug 2026
 02:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505329.git.geert+renesas@glider.be> <49726acff0fee1c3606e83c4f242ef6aad25b4b8.1783505329.git.geert+renesas@glider.be>
 <20260710-adventurous-burgundy-chimera-b2fff9@quoll> <CAMuHMdV=ckONBbTYELPJU8YWoNzdu3PJ95VR8cz+f_7dUeiPUw@mail.gmail.com>
 <20260716214924.GA1477674-robh@kernel.org> <CAMuHMdU0ss6wUEdjC+OYa3iQS439aJ8b_d9M2ws7Ayn4_kOyMQ@mail.gmail.com>
 <20260811163334.GA2354701-robh@kernel.org>
In-Reply-To: <20260811163334.GA2354701-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Aug 2026 11:47:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWbzg-QpFBzzDa2hC3HzAmWUkerESC5O-cSVxmWX3_PkQ@mail.gmail.com>
X-Gm-Features: AUfX_mxykVa-_GVxsMsY5j-WoXLeEw0hqTlxX_hGEjk_L8dF08TYL9-2xHiMqsc
Message-ID: <CAMuHMdWbzg-QpFBzzDa2hC3HzAmWUkerESC5O-cSVxmWX3_PkQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] dt-bindings: clock: renesas,r8a78000-cpg: Add
 firmware property
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Tue, 11 Aug 2026 at 18:33, Rob Herring <robh@kernel.org> wrote:
> On Mon, Aug 03, 2026 at 02:01:18PM +0200, Geert Uytterhoeven wrote:
> > On Thu, 16 Jul 2026 at 23:49, Rob Herring <robh@kernel.org> wrote:
> > > On Fri, Jul 10, 2026 at 01:02:39PM +0200, Geert Uytterhoeven wrote:
> > > > On Fri, 10 Jul 2026 at 12:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > > On Wed, Jul 08, 2026 at 12:16:23PM +0200, Geert Uytterhoeven wrote:
> > > > > > Add a firmware property, for systems where SCMI must be used instead of
> > > > > > direct hardware access.
> > > > > >
> > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > ---
> > > > > > v2:
> > > > > >   - Spin off from "dt-bindings: clock: Document Renesas R-Car X5H Clock
> > > > > >     Pulse Generator".
> > > > > > ---
> > > > > >  .../devicetree/bindings/clock/renesas,r8a78000-cpg.yaml    | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
> > > > > > index 4e23bba334382346..fc499e7cf52e4f0c 100644
> > > > > > --- a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
> > > > > > @@ -35,6 +35,12 @@ properties:
> > > > > >        <dt-bindings/clock/renesas,r8a78000-cpg.h>.
> > > > > >      const: 1
> > > > > >
> > > > > > +  firmware:
> > > > >
> > > > > RPi is doing similar, but I have doubts. It looks way too close to
> > > > > generic "syscon" which is disallowed.
> > > > >
> > > > > I think this should be vendor+purpose specific, e.g.:
> > > > > "renesas,scmi-transport" or "renesas,scmi-firmware"
> > >
> > > If you can tell me the resource that a 'firmware' provider provides then
> > > it is fine, but you can't.
> >
> > It provides a firmware API, which is not available until the firmware
> > provider is initialized.
>
> I don't know what "a firmware API" is. What does it provide? I know what

It can provide lots of things (everything we are no longer allowed to
touch directly from Linux ;-)

> a clock, GPIO, reset, interrupt, etc. provider is.

A clock is an object you can access through the clock API.
(s/clock/.../ for the other cases).
Firmware is a service (virtual object) you can access through a
firmware API.

In all cases, the consumer of the object or service needs to know
which object or service to use (there can be multiple).

In all cases you cannot access the object or service until it is
available (initialized and registered), for which we have -EPROBE_DEFER,
and/or "[PATCH v2 02/10] of: property: fw_devlink: Add support for
firmware".

Thanks for your understanding ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
