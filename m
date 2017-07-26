From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4 0/2] PM / Domains: Expand generic power domain debugfs.
Date: Wed, 26 Jul 2017 20:38:33 +0200
Message-ID: <2371398.9SIGdC6dIE@aspire.rjw.lan>
References: <1500052216-22252-1-git-send-email-thara.gopinath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46373 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751022AbdGZSqd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 14:46:33 -0400
In-Reply-To: <1500052216-22252-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org

On Friday, July 14, 2017 01:10:14 PM Thara Gopinath wrote:
> This patch set attempts to improve the existing generic power domain
> debugfs capabilities. The first  patch adds various accounting and
> other bits needed to expose out the generic power domain statistics.
> The second patch introduces new debugfs entries and attributes.
> 
> V3->V4:
> - Renamed the newly defined static functions in domain.c to adhere
>   to existing naming convention.
> V2->V3:
> - Changed the order of calling genpd_update_accounting and genpd->status
>   getting updated in power on and power off apis.
> - Minor fixes from review comments on the list.
> V1->V2:
> - Removed calling of update accounting from suspend resume context
>   where time keeping can be disabled.
> - Added back the pm_genpd_summary which was removed by the first version
>   of this patchset.
> - Renamed a few debugfs parameters. 
> 
> Thara Gopinath (2):
>   PM / Domains: Add time accounting to various genpd states.
>   PM / Domains: Extend generic power domain debugfs.

Both patches applied, thanks!
