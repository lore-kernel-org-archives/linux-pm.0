From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 linux-next] cpufreq: pxa: replace typedef pxa_freqs_t
 by structure
Date: Thu, 30 Apr 2015 08:17:52 +0530
Message-ID: <CAKohpomAbQNRghTX7_KQ4A7-O2=ee78U+3+DkjFcuQ9S7CdTvw@mail.gmail.com>
References: <1430335980-9765-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36113 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbbD3Crx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2015 22:47:53 -0400
Received: by oift201 with SMTP id t201so37736660oif.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2015 19:47:52 -0700 (PDT)
In-Reply-To: <1430335980-9765-1-git-send-email-fabf@skynet.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 30 April 2015 at 01:02, Fabian Frederick <fabf@skynet.be> wrote:
> typedef is not really useful here. Replace it by structure
> to improve readability.typedef should only be used in some cases.

Space after full stop. (Maybe Rafael can fix that while applying)..

> (See Documentation/CodingStyle Chapter 5 for details).
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
> V2: verbose changelog.
>
>  drivers/cpufreq/pxa2xx-cpufreq.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
