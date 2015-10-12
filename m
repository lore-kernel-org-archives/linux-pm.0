From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] PM / Domains: Trivial clean-up for power on/off functions
Date: Tue, 13 Oct 2015 00:00:14 +0200
Message-ID: <3086541.eBEMbFN4Tk@vostro.rjw.lan>
References: <1444134389-17851-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44767 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751640AbbJLVbf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2015 17:31:35 -0400
In-Reply-To: <1444134389-17851-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On Tuesday, October 06, 2015 02:26:29 PM Ulf Hansson wrote:
> This patchset aims to reduce some code for the generic PM domain and to improve
> consistency around function names - all related to power on/off functions.
> 
> Regarding patch1, I am requesting an ack from some of the dove SoC maintainers,
> as this needs to go together via Rafael's linux-pm tree.
> 
> Ulf Hansson (4):
>   soc: dove: Let genpd deal with disabling of unused PM domains
>   PM / Domains: Remove pm_genpd_poweroff_unused() API
>   PM / Domains: Remove pm_genpd_poweron() API
>   PM / Domains: Rename *pm_genpd_poweron|poweroff()
> 
>  drivers/base/power/domain.c | 48 ++++++++++++++++++++++-----------------------
>  drivers/soc/dove/pmu.c      |  1 -
>  include/linux/pm_domain.h   |  8 --------
>  3 files changed, 23 insertions(+), 34 deletions(-)

I've queued up [1-3/4] for v4.4, but the [4/4] doesn't apply for me (seems to
be based on a patch that's not present in my tree).

Thanks,
Rafael

