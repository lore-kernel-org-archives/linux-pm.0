From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH/RFC v6 5/5] PM / Domains: remove old power on/off callbacks.
Date: Thu, 30 Apr 2015 10:27:57 +0200
Message-ID: <CAKXjFTOcijw5iJgqX31m7ugp4Qabwxw4vPNCWn6H8bxX5b-tEg@mail.gmail.com>
References: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
	<1430334615-1161-6-git-send-email-ahaslam@baylibre.com>
	<CAMuHMdX2ThcBd1rfpbLEdfjYZJG7zKQ8F7xJfBDCo=gR6SQ9bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35824 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbbD3I16 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 04:27:58 -0400
Received: by oign205 with SMTP id n205so42229674oig.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2015 01:27:57 -0700 (PDT)
In-Reply-To: <CAMuHMdX2ThcBd1rfpbLEdfjYZJG7zKQ8F7xJfBDCo=gR6SQ9bg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>, Axel Haslam <ahaslam+renesas@baylibre.com>

On Thu, Apr 30, 2015 at 9:21 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Apr 29, 2015 at 9:10 PM,  <ahaslam@baylibre.com> wrote:
>> Now that all known users have been converted to use the state
>> version of the callbacks, we can remove the default callbacks
>> without breaking compilation.
>
> You forgot to update the one-line summary and the full description:
> the callbacks are no longer removed, only the latencies.

right, i will  update the comment.

thanks,
Axel

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
