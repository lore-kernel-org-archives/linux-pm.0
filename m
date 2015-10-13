From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] PM / Domains: Trivial clean-up for power on/off functions
Date: Tue, 13 Oct 2015 09:36:19 +0200
Message-ID: <CAPDyKFqBKYnSGoijFEhTgEUNHLuqugpGN9WEER_GqLviwAE58Q@mail.gmail.com>
References: <1444134389-17851-1-git-send-email-ulf.hansson@linaro.org>
	<3086541.eBEMbFN4Tk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34239 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbJMHgU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 03:36:20 -0400
Received: by wicgb1 with SMTP id gb1so77050000wic.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 00:36:19 -0700 (PDT)
In-Reply-To: <3086541.eBEMbFN4Tk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On 13 October 2015 at 00:00, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, October 06, 2015 02:26:29 PM Ulf Hansson wrote:
>> This patchset aims to reduce some code for the generic PM domain and to improve
>> consistency around function names - all related to power on/off functions.
>>
>> Regarding patch1, I am requesting an ack from some of the dove SoC maintainers,
>> as this needs to go together via Rafael's linux-pm tree.
>>
>> Ulf Hansson (4):
>>   soc: dove: Let genpd deal with disabling of unused PM domains
>>   PM / Domains: Remove pm_genpd_poweroff_unused() API
>>   PM / Domains: Remove pm_genpd_poweron() API
>>   PM / Domains: Rename *pm_genpd_poweron|poweroff()
>>
>>  drivers/base/power/domain.c | 48 ++++++++++++++++++++++-----------------------
>>  drivers/soc/dove/pmu.c      |  1 -
>>  include/linux/pm_domain.h   |  8 --------
>>  3 files changed, 23 insertions(+), 34 deletions(-)
>
> I've queued up [1-3/4] for v4.4, but the [4/4] doesn't apply for me (seems to
> be based on a patch that's not present in my tree).

Thanks!

Patch4 needs a re-base, since you applied below patch as well.
http://comments.gmane.org/gmane.linux.power-management.general/66230

I send a v2 of patch4.

Kind regards
Uffe
