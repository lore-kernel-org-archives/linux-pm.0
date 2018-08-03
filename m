From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v8 05/26] PM / Domains: Add helper functions to
 attach/detach CPUs to/from genpd
Date: Fri, 3 Aug 2018 13:44:08 +0200
Message-ID: <CAPDyKFrteziAy==C+-mEiV-404--qwBu8JLoSAHYJjb8p1a+Ag@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-6-ulf.hansson@linaro.org> <3889041.sTGkQNs1Ck@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3889041.sTGkQNs1Ck@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 19 July 2018 at 12:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, June 20, 2018 7:22:05 PM CEST Ulf Hansson wrote:
>> Introduce two new genpd helper functions, of_genpd_attach|detach_cpu(),
>> which takes the CPU-number as an in-parameter.
>>
>> To attach a CPU to a genpd, of_genpd_attach_cpu() starts by fetching the
>> struct device belonging to the CPU. Then it calls genpd_dev_pm_attach(),
>> which via DT tries to hook up the CPU device to its corresponding PM
>> domain. If it succeeds, of_genpd_attach_cpu() continues to prepare/enable
>> runtime PM of the device.
>>
>> To detach a CPU from its PM domain, of_genpd_attach_cpu() reverse the
>> operations made from of_genpd_attach_cpu(). However, first it checks that
>> the CPU device has a valid PM domain pointer assigned, as to make sure it
>> belongs to genpd.
>>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 69 +++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h   |  9 +++++
>>  2 files changed, 78 insertions(+)

[...]

> I'd combine this with patch [04/26].  The split here is somewhat artificial IMO.

I wanted to keep one change per patch, hence the split.

$subject patch introduces helpers to add CPU devices to genpd and
isn't really part of making genpd to cope with CPU devices. So
$subject patch is about avoiding open coding.

Are you still sure you want me to squash the changes?

Kind regards
Uffe
