From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v3 0/8] PM / Domains: DT support for domain idle states &
 atomic PM domains
Date: Thu, 20 Oct 2016 16:44:32 -0600
Message-ID: <20161020224432.GB72940@linaro.org>
References: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFpQwOkXUk8wT6sZ-Ad4XpTnyodK5m24fYJ3P+1QtS0XOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpQwOkXUk8wT6sZ-Ad4XpTnyodK5m24fYJ3P+1QtS0XOA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 17 2016 at 01:30 -0600, Ulf Hansson wrote:
>On 14 October 2016 at 19:47, Lina Iyer <lina.iyer@linaro.org> wrote:
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
>Rafael, Lina,
>
>This looks good to me! Unless any other objections, I suggest to apply
>this to get it tested in linux-next.
>
>Kind regards
>Uffe
>
Rafael,

If there are no objections, could you pick this patch for linux-next?

Thanks,
Lina
>> --
>> 2.7.4
>>
>> [1]. https://www.spinics.net/lists/arm-kernel/msg526814.html
>> [2]. http://www.spinics.net/lists/arm-kernel/msg535106.html
>> [3]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-v2
>> [4]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-v3
