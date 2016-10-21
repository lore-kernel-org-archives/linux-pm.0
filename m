From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 0/8] PM / Domains: DT support for domain idle states & atomic PM domains
Date: Fri, 21 Oct 2016 11:35:01 -0700
Message-ID: <7hmvhxpn3e.fsf@baylibre.com>
References: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
        <CAPDyKFpQwOkXUk8wT6sZ-Ad4XpTnyodK5m24fYJ3P+1QtS0XOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36396 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934610AbcJUSfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 14:35:04 -0400
Received: by mail-pf0-f179.google.com with SMTP id e6so61071891pfk.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2016 11:35:04 -0700 (PDT)
In-Reply-To: <CAPDyKFpQwOkXUk8wT6sZ-Ad4XpTnyodK5m24fYJ3P+1QtS0XOA@mail.gmail.com>
        (Ulf Hansson's message of "Mon, 17 Oct 2016 09:30:53 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lina Iyer <lina.iyer@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 14 October 2016 at 19:47, Lina Iyer <lina.iyer@linaro.org> wrote:
>> Hi all,
>>
>> Changes since v2 [3] -
>> - Addressed review comments from v2.
>>         - domain-idle-states documentation updated
>>         - fixed compiler issues with imx driver
>>         - minor code change in pm_domains.c
>> - The series is available at [4].
>>
>> Changes since v1 [2] -
>> - Addressed review comments from v1.
>>         - Fixes around dynamic allocation of genpd states
>>         - Used OF method for iterating phandles
>>         - Updated documentation, examples
>>         - Rename state variable (provider -> fwnode)
>> - The series is available at [3].
>>
>> The changes from [1] are -
>> - Allocating memory for domain idle states dynamically
>> - Conform to naming conventions for internal and exported genpd functions
>> - DT binding example for domain-idle-state
>> - Use fwnode instead of of_node
>> - Handle atomic case for removal of PM Domain
>> - Rebase on top of Rafael's pm/genpd tree
>>
>> Thanks,
>> Lina
>>
>> Lina Iyer (8):
>>   PM / Domains: Make genpd state allocation dynamic
>>   PM / Domain: Add residency property to genpd states
>>   PM / Domains: Allow domain power states to be read from DT
>>   PM / Domains: Save the fwnode in genpd_power_state
>>   dt/bindings: Update binding for PM domain idle states
>>   PM / Domains: Abstract genpd locking
>>   PM / Domains: Support IRQ safe PM domains
>>   PM / doc: Update device documentation for devices in IRQ safe PM
>>     domains
>>
>>  .../devicetree/bindings/power/power_domain.txt     |  43 +++
>>  Documentation/power/devices.txt                    |   9 +-
>>  arch/arm/mach-imx/gpc.c                            |  17 +-
>>  drivers/base/power/domain.c                        | 358 +++++++++++++++++----
>>  include/linux/pm_domain.h                          |  28 +-
>>  5 files changed, 383 insertions(+), 72 deletions(-)
>>
>
> Rafael, Lina,
>
> This looks good to me! Unless any other objections, I suggest to apply
> this to get it tested in linux-next.

Looks like it might be a little late now, but anyways

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
