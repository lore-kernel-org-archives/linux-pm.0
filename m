From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 00/24] PM / Domains: Generic OF-based support and cleanups
Date: Wed, 11 Jun 2014 20:32:15 +0200
Message-ID: <CAJZ5v0gcHSGf5DBYC-KLtOCveo---vQdSmdUKCqU7pNMKcXbww@mail.gmail.com>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
	<7hlht3gvas.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:65294 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbaFKScQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 14:32:16 -0400
In-Reply-To: <7hlht3gvas.fsf@paris.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Tomasz Figa <t.figa@samsung.com>

On Wed, Jun 11, 2014 at 8:23 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> Parts of this patchset has been posted earlier. To be able to smoothly continue
>> my work in re-factoring genpd I have collected patches into this patchset.
>>
>> The complete patchset is available at the linux-pm_linux-next_genpd branch at:
>> git.linaro.org/people/ulf.hansson/linux-2.6.git
>> This branch is based upon Rafael's linux-pm tree's linux-next branch.
>>
>> And important note. There are dependencies througout this patchset, which means
>> the all need to go together. I suggest we use Rafael's tree, thus I seek for
>> acks from the affected ARM SoC maintainers.
>
> At least on the surface, there are at least 3 separate series going on
> here
>
> 1) DT support for genpd
> 2) various genpd cleanups
> 3) ux500 support
>
> Clearly they are related, but it would be easier to review if a large
> series like this is broken up into smaller series where the cover
> letters describe the dependencies between them

Agreed.

And if they are sent in such an order that the bits the rest depends on
go first and are settled before the next series is even submitted.

Rafael
