From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [RFC v4 1/8] PM / Domains: structure changes for multiple states
Date: Wed, 22 Apr 2015 18:26:23 +0200
Message-ID: <5537CBAF.8050009@baylibre.com>
References: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>	<1429695935-15815-2-git-send-email-ahaslam@baylibre.com>	<CAMuHMdXs_Wytg7xwyQP=+L8enzoT2JBg78YTFe59Zp5K8vbq_A@mail.gmail.com>	<5537A0B5.5000507@baylibre.com> <CAMuHMdU2nfmJsoRwAWs+Lxfv22fWVGSBVw6SHOe6BE4yWWJoxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33542 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964807AbbDVQ00 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 12:26:26 -0400
Received: by wiax7 with SMTP id x7so134113780wia.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 09:26:25 -0700 (PDT)
In-Reply-To: <CAMuHMdU2nfmJsoRwAWs+Lxfv22fWVGSBVw6SHOe6BE4yWWJoxw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>

Hi Geert,

On 22/04/2015 15:57, Geert Uytterhoeven wrote:
> Hi Axel,
>
> On Wed, Apr 22, 2015 at 3:23 PM, Axel Haslam <ahaslam@baylibre.com> wrote:
>>>> if the genpd is initially off, the user should set the
>>>> .init_state field when registering the genpd,
>>>> so that genpd knows which callbacks to call to set the
>>>> domain to on.
>>>
>>> The initial state may depend on various factors (hardware default,
>>> boot loader, previously loaded kernel, ...). This is even true with the
>>> current binary states.
>>
>> This would mean that the inital state of the genpd cannot be
>> hardcoded right?
>
> Indeed. And it should be filled in by the platform code before registration.
>
>>> What about keeping the .power_o{ff,n}() callbacks in struct
>>> generic_pm_domain,
>>> but adding a state index parameter to the callbacks?
>>> That would save even more memory on systems where all callbacks are
>>> identical.
>>
>> makes sense.
>
> It will complicate compilability/bisectability, though.
>

since the genpd pointer is allready an argument to the .power_o{ff,n}() 
callbacks, it would be simpler if the platform could check 
genpd->target_state to know what state is powering on/off to, instead of 
adding a new argument.

That way i can remove the power on/off callbacks from the state array,
and there are no big issues with bisectability.

regards,
Axel

> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
