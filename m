From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] PM / Domains: Extend generic power domain debugfs.
Date: Wed, 7 Jun 2017 15:51:09 +0200
Message-ID: <CAPDyKFpfXqPc2fjHkJVmUP8kmwE4Ec-bcs_Fk=t0F1sSnfWRVQ@mail.gmail.com>
References: <1495756293-29534-1-git-send-email-thara.gopinath@linaro.org> <1495756293-29534-3-git-send-email-thara.gopinath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33909 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbdFGNvK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 09:51:10 -0400
Received: by mail-qk0-f170.google.com with SMTP id d14so7762434qkb.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2017 06:51:10 -0700 (PDT)
In-Reply-To: <1495756293-29534-3-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>

On 26 May 2017 at 01:51, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> This patch extends the existing generic power domain debugfs.
> Changes involve the following
> - Remove the current flat format of displaying generic power domain
>   summary.
> - Introduce a unique debugfs entry for each generic power domain with the
>   following attributes
>         - current_state - Displays current state of the domain.
>         - devices - Displays the devices associated with this domain.
>         - slaves - Displays the sub power domains.

Maybe "sub_domains" is a better name for the node then?

>         - on_time - Displays the time the domain was in on state in ms.

/s/on_time/active_time

>         - idle_time - Displays the time the domain was in any of the idle
>                         states in ms.

/s/idle_time/total_idle_time

>         - idle_states - Displays the various idle states and the time
>                         spent in each idle state in ms.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Besides the nitpicks above, this looks okay to me, however please
address Geerts comments as well.

[...]

Kind regards
Uffe
