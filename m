From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/8] cpufreq: Introduce a flag ('frozen') to separate full
 vs temporary init/teardown
Date: Fri, 12 Jul 2013 13:01:19 +0530
Message-ID: <CAKohpokfvdX41XGmTY0bxKUJ5adx3Hu6gESJ+Xq+gEuRYrjBgw@mail.gmail.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com>
	<20130711221657.547.2293.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:44945 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757211Ab3GLHbU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jul 2013 03:31:20 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so11052068obq.35
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2013 00:31:19 -0700 (PDT)
In-Reply-To: <20130711221657.547.2293.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12 July 2013 03:46, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> During suspend/resume we would like to do a light-weight init/teardown of
> CPUs in the cpufreq subsystem and preserve certain things such as sysfs files
> etc across suspend/resume transitions. Add a flag called 'frozen' to help
> distinguish the full init/teardown sequence from the light-weight one.
>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
>
>  drivers/cpufreq/cpufreq.c |   66 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 25 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
