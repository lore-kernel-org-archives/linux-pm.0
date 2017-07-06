From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v3 2/2] thermal: uniphier: add UniPhier thermal driver
Date: Thu, 06 Jul 2017 09:42:06 +0900
Message-ID: <20170706094205.1DAF.4A936039@socionext.com>
References: <CAK7LNASfco5oj8pLDykqq_xFsx4P0qjR1CuXsbF0n-1v0PBGKg@mail.gmail.com> <CAK7LNAQgPEoNDTL-Er0bKSVwmNmjyvwz2BcVSvNONFj9-6499Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx.socionext.com ([202.248.49.38]:17464 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752479AbdGFAmI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jul 2017 20:42:08 -0400
In-Reply-To: <CAK7LNAQgPEoNDTL-Er0bKSVwmNmjyvwz2BcVSvNONFj9-6499Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>

On Wed, 5 Jul 2017 21:27:57 +0900 <yamada.masahiro@socionext.com> wrote:

> 2017-07-05 21:20 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > 2017-07-05 20:50 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> >
> >> +
> >> +#define TMOD                           0x0928
> >> +#define TMOD_MASK                      GENMASK(9, 0)
> >> +
> >  [ snip ]
> >> +
> >> +       /*
> >> +        * The bit[8:0] of TMOD register represents 2's complement value
> >> +        * of temperature in Celsius. Since bit8 of TMOD shows a sign bit,
> >> +        * 32bit temperature value is obtained by sign extension.
> >> +        */
> >
> >
> > Apparently, this comment does not match your code:
> >
> >      #define TMOD_MASK                      GENMASK(9, 0)
> >
> >
> > TMOD_MASK is indicating bit[9:0].
> >
> >
> >
> > Digging into the patch history, now I understood what happened.
> >
> >
> >
> > In v1, you described
> > #define TMOD_MASK         0x1ff
> >
> > This was correct.
> >
> >
> > In v2, you converted it into
> > #define TMOD_MASK          GENMASK(9, 0)
> >
> > This was misconversion.  It should be GENMASK(8, 0)
> >
> >
> >
> > Anyway, TMOD_MASK is not used any more.

That's true.
TMOD_MASK in v2/v3 is wrong, and not used no longer.

> >> +       *out_temp = sign_extend32(temp, 8) * 1000;
> >
> >
> > Why magic number here?
> >
> >    /* MSB of the TMOD field is a sign bit */
> >    *out_temp = sign_extend32(temp, TMOD_WIDTH) * 1000;
> 
> No.    sign_extend32(temp, TMOD_WIDTH - 1) or
>        sign_extend32(temp, TMOD_MSB)  or whatever.

I see. I'll replace with the macro.

Best Regards,
Kunihiko Hayashi
