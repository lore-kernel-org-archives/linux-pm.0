From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC v4 1/8] PM / Domains: structure changes for multiple states
Date: Wed, 22 Apr 2015 15:57:23 +0200
Message-ID: <CAMuHMdU2nfmJsoRwAWs+Lxfv22fWVGSBVw6SHOe6BE4yWWJoxw@mail.gmail.com>
References: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
	<1429695935-15815-2-git-send-email-ahaslam@baylibre.com>
	<CAMuHMdXs_Wytg7xwyQP=+L8enzoT2JBg78YTFe59Zp5K8vbq_A@mail.gmail.com>
	<5537A0B5.5000507@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34067 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280AbbDVN5Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 09:57:24 -0400
Received: by oiko83 with SMTP id o83so179587477oik.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 06:57:24 -0700 (PDT)
In-Reply-To: <5537A0B5.5000507@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>

Hi Axel,

On Wed, Apr 22, 2015 at 3:23 PM, Axel Haslam <ahaslam@baylibre.com> wrote:
>>> if the genpd is initially off, the user should set the
>>> .init_state field when registering the genpd,
>>> so that genpd knows which callbacks to call to set the
>>> domain to on.
>>
>> The initial state may depend on various factors (hardware default,
>> boot loader, previously loaded kernel, ...). This is even true with the
>> current binary states.
>
> This would mean that the inital state of the genpd cannot be
> hardcoded right?

Indeed. And it should be filled in by the platform code before registration.

>> What about keeping the .power_o{ff,n}() callbacks in struct
>> generic_pm_domain,
>> but adding a state index parameter to the callbacks?
>> That would save even more memory on systems where all callbacks are
>> identical.
>
> makes sense.

It will complicate compilability/bisectability, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
