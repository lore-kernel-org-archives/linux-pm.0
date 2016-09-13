From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/4] cpuidle/menu: add per cpu pm_qos_resume_latency consideration
Date: Wed, 14 Sep 2016 00:10:13 +0200
Message-ID: <3288596.DV966QMpDZ@vostro.rjw.lan>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org> <1472114562-2736-4-git-send-email-alex.shi@linaro.org> <57D80709.4040500@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64185 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755281AbcIMWEG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 18:04:06 -0400
In-Reply-To: <57D80709.4040500@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Tuesday, September 13, 2016 10:02:49 PM Alex Shi wrote:
> Hi Daniel & Rafael,
> 
> Any comments on this patch?

I actually am not sure about the whole series.

I know your motivation, but honestly the changes here may not be the best way
to achieve what you need.

You may think that the changes are trivial, but in fact they are not.  There
are side effects and I'm not sure about the resulting user space interface
at all.

Thanks,
Rafael

