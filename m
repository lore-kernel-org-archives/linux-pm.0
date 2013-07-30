From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 7/7] cpufreq: Perform light-weight init/teardown during suspend/resume
Date: Tue, 30 Jul 2013 14:39:58 +0530
Message-ID: <CAKohpokQB9T2CPzgMEiPrAuZvCMf9srWsdGmtKtkDgz52YoihA@mail.gmail.com>
References: <20130729225213.20863.56722.stgit@srivatsabhat.in.ibm.com>
	<20130729225519.20863.61030.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:60840 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758381Ab3G3JJ7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2013 05:09:59 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so2579711obc.24
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2013 02:09:58 -0700 (PDT)
In-Reply-To: <20130729225519.20863.61030.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 30 July 2013 04:25, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Now that we have the infrastructure to perform a light-weight init/tear-down,
> use that in the cpufreq CPU hotplug notifier when invoked from the
> suspend/resume path.
>
> This also ensures that the file permissions of the cpufreq sysfs files are
> preserved across suspend/resume, something which commit a66b2e (cpufreq:
> Preserve sysfs files across suspend/resume) originally intended to do, but
> had to be reverted due to other problems.
>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
