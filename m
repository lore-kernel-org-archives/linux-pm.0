From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: acpi-cpufreq: Simplify boost-related code
Date: Mon, 28 Dec 2015 08:48:15 +0530
Message-ID: <20151228031815.GF3598@ubuntu>
References: <2196419.fjWAQbI2Nm@vostro.rjw.lan>
 <725597086.REkFdzhlmI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33620 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbbL1DSS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Dec 2015 22:18:18 -0500
Received: by mail-pa0-f54.google.com with SMTP id cy9so103620261pac.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Dec 2015 19:18:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <725597086.REkFdzhlmI@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 27-12-15, 00:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The store_boost() routine is only used by store_cpb(), so move
> the code from it directly to that function and rename _store_boost()
> to set_boost() to make its name reflect the name of the driver
> callback pointing to it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |   21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
