From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix the driver can not be unloaded issue
Date: Wed, 24 Apr 2013 15:44:47 +0530
Message-ID: <CAKohpomcSP4HegdQfJYDe6UHa6CTuV-G9UCb8QFDxfDvcTzsYw@mail.gmail.com>
References: <1366792092-10407-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:63615 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758210Ab3DXKOr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2013 06:14:47 -0400
Received: by mail-oa0-f49.google.com with SMTP id j1so1456584oag.22
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2013 03:14:47 -0700 (PDT)
In-Reply-To: <1366792092-10407-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuantian.Tang@freescale.com
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On 24 April 2013 13:58,  <Yuantian.Tang@freescale.com> wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
>
> The driver compiled as a module can not be unloaded if there
> are more than one cpu in policy->cpus. That's caused by
> cpufreq_cpu_get() in cpufreq_add_dev_symlink(); It keep increasing
> the module reference count.
> This patch splites the module and policy reference count. It keeps
> the module reference count unchanged and uses the policy reference
> count to track the resource.
>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
>  drivers/cpufreq/cpufreq.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)

I didn't quite get the problem you mentioned.. I haven't seen any issues
with the core as of now.

When we unload a module we must call cpufreq_unregister_driver(), which
will eventually call subsys_interface_unregister() and so cpufreq_remove_dev()
will be called for each cpu. And so all the counts should be fine and eventually
module should get unloaded.

--
viresh
