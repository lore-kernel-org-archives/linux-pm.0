From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Move the OPP directory out of power/
Date: Tue, 26 Sep 2017 15:02:53 -0700
Message-ID: <CAKohpokHnJkLiO5ZdmfgLjWhB-Ay-C6NCqzsq0ohhK=zonr4Lg@mail.gmail.com>
References: <2767b448493ca16f064618d36387ac56dfec0e56.1506384278.git.viresh.kumar@linaro.org>
 <2cdd51f6-c5ac-9fe3-60df-d83a06ec85d0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:55988 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934122AbdIZWCy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2017 18:02:54 -0400
Received: by mail-io0-f181.google.com with SMTP id z187so14036791ioz.12
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2017 15:02:54 -0700 (PDT)
In-Reply-To: <2cdd51f6-c5ac-9fe3-60df-d83a06ec85d0@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 25 September 2017 at 22:11, Sekhar Nori <nsekhar@ti.com> wrote:
> On Tuesday 26 September 2017 05:35 AM, Viresh Kumar wrote:

> MAINTAINERS needs update too.

Right and that's where it all started to begin with :)

> Also, shouldn't PM_OPP now find a home in
> drivers/opp/Kconfig?

Yeah, I wasn't sure if I should create a Kconfig to just keep that, but perhaps
that is the only sane thing we can do.

--
viresh
