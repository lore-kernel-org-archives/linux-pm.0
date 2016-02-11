From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / OPP: Fix NULL pointer dereference crash when
 disabling OPPs
Date: Thu, 11 Feb 2016 22:16:28 +0100
Message-ID: <CAJZ5v0j1sTZd-YTNfFmRwtmsN8AniaCsKM_aUJ7ka8VJjwK5Qw@mail.gmail.com>
References: <1455189959-27944-1-git-send-email-jonathanh@nvidia.com>
	<20160211113409.GA28558@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36600 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbcBKVQa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 16:16:30 -0500
In-Reply-To: <20160211113409.GA28558@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org

On Thu, Feb 11, 2016 at 12:34 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 11-02-16, 11:25, Jon Hunter wrote:
>> Commit 7d34d56ef334 ("PM / OPP: Disable OPPs that aren't supported by
>> the regulator") disables OPPs that are not supported by the regulator.
>> This is causes a crash on Tegra124 Jetson TK1 when using the DFLL clock
>> source for the CPU. The DFLL manages the voltage itself and so there is
>> no regulator specified for the OPPs and so we get a crash when we try to
>> dereference the regulator pointer. Fix this by checking to see if the
>> regulator IS_ERR_OR_NULL before dereferencing it.
>>
>> Fixes: 7d34d56ef334 ("PM / OPP: Disable OPPs that aren't supported by the
>> regulator")
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/base/power/opp/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Sorry about that :(
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael
