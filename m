From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 2/2] thermal: uniphier: add UniPhier thermal driver
Date: Wed, 5 Jul 2017 21:27:57 +0900
Message-ID: <CAK7LNAQgPEoNDTL-Er0bKSVwmNmjyvwz2BcVSvNONFj9-6499Q@mail.gmail.com>
References: <1499255419-31684-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1499255419-31684-3-git-send-email-hayashi.kunihiko@socionext.com> <CAK7LNASfco5oj8pLDykqq_xFsx4P0qjR1CuXsbF0n-1v0PBGKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:62783 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbdGEM2C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jul 2017 08:28:02 -0400
In-Reply-To: <CAK7LNASfco5oj8pLDykqq_xFsx4P0qjR1CuXsbF0n-1v0PBGKg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>

2017-07-05 21:20 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2017-07-05 20:50 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
>
>> +
>> +#define TMOD                           0x0928
>> +#define TMOD_MASK                      GENMASK(9, 0)
>> +
>  [ snip ]
>> +
>> +       /*
>> +        * The bit[8:0] of TMOD register represents 2's complement value
>> +        * of temperature in Celsius. Since bit8 of TMOD shows a sign bit,
>> +        * 32bit temperature value is obtained by sign extension.
>> +        */
>
>
> Apparently, this comment does not match your code:
>
>      #define TMOD_MASK                      GENMASK(9, 0)
>
>
> TMOD_MASK is indicating bit[9:0].
>
>
>
> Digging into the patch history, now I understood what happened.
>
>
>
> In v1, you described
> #define TMOD_MASK         0x1ff
>
> This was correct.
>
>
> In v2, you converted it into
> #define TMOD_MASK          GENMASK(9, 0)
>
> This was misconversion.  It should be GENMASK(8, 0)
>
>
>
> Anyway, TMOD_MASK is not used any more.
>
>
>> +       *out_temp = sign_extend32(temp, 8) * 1000;
>
>
> Why magic number here?
>
>    /* MSB of the TMOD field is a sign bit */
>    *out_temp = sign_extend32(temp, TMOD_WIDTH) * 1000;

No.    sign_extend32(temp, TMOD_WIDTH - 1) or
       sign_extend32(temp, TMOD_MSB)  or whatever.

-- 
Best Regards
Masahiro Yamada
