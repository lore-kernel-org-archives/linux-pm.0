From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Tue, 1 Mar 2016 12:15:48 +0530
Message-ID: <CAKohpo=fcab=eisbwMw=wvbmuXVY5iw_CSe3QK1Ax_i-56JAzA@mail.gmail.com>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
	<2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
	<55F72C97.2030306@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:36287 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbcCAGpu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 01:45:50 -0500
Received: by mail-io0-f181.google.com with SMTP id l127so212734278iof.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 22:45:50 -0800 (PST)
In-Reply-To: <55F72C97.2030306@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Dave Gerlach <d-gerlach@ti.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <rob.herring@linaro.org>, Mark Brown <broonie@kernel.org>

[Removed few people and LKML from CC as its not really about DT
change anymore but OPP]

Hi Guys,

On 15 September 2015 at 01:52, Rob Herring <robh@kernel.org> wrote:

> Remind me of when do we have multiple regulators for a cpu? The number
> of supplies should be defined by the cpu binding as function of how many
> supply rails a cpu has.

This thread died long back and we never worked out support for multiple
regulators into the OPP core.

But, Dave and Nishanth (from TI) pinged me last week about it. According
to them, their platform has got two regulators for the CPU device and they
want OPP layer to have this support.

I was expecting them to reignite this thread, but don't know what happened.

And so, I am starting it here.

@Dave/Nishanth: Can you please explain the use-case here please? So
that we can get convinced that you really need OPP-core to support multiple
regulators..

--
viresh
