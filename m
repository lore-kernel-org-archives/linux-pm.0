From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: Add sfi based cpufreq driver support
Date: Fri, 17 Oct 2014 11:43:47 +0530
Message-ID: <CAKohpom9Vp1MFsXcPbpQ_YZ69YbGUzCs3mk2W45xp=csTQQ=WA@mail.gmail.com>
References: <20141017054353.GA515@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:52279 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaJQGNs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Oct 2014 02:13:48 -0400
Received: by mail-ob0-f169.google.com with SMTP id m8so125264obr.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2014 23:13:47 -0700 (PDT)
In-Reply-To: <20141017054353.GA515@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>

On 17 October 2014 11:14, Srinidhi Kasagar <srinidhi.kasagar@intel.com> wrote:
> This adds the sfi based cpu freq driver for some of the
> Intel's Silver Mont based atom architectures like
> Merrifield and Moorfield (intel-mid)
>
> Signed-off-by: Rudramuni, Vishwesh M <vishwesh.m.rudramuni@intel.com>
> Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> ---
> v2:
> * rephrase the Kconfig text
> * merge the header file as its not being shared with anyone
> * remove the unnecessary checks in sfi_cpufreq_target
> * style changes in kzalloc
> * fix the potential memory leak sfi_cpufreq_cpu_init
> * move the cpufreq driver flag to the structure definition
> * remove the redundant init of policy->cpu and policy->cur
> * remove the unnecessary check while init the freq table
> * merge the for loops in cpu_init
> * use cpufreq_generic_attr rather than the custom one
>
> v3:
> * Add this change log
> * remove the left over not used cached_freq var
> * merge yet another for loop in cpu_init
>
>  drivers/cpufreq/Kconfig.x86   |   10 ++
>  drivers/cpufreq/Makefile      |    1 +
>  drivers/cpufreq/sfi-cpufreq.c |  326 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 337 insertions(+)
>  create mode 100644 drivers/cpufreq/sfi-cpufreq.c

>From coding perspective:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

>From X86 working aspect would be good if Rafael or Dirk also
review it :)
