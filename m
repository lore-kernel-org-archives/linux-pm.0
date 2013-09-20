From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] Skip the driver if ACPI has power mgmt option
Date: Fri, 20 Sep 2013 13:05:08 +0530
Message-ID: <CAKohpokoOHop8AjffafzeAyrgndpPbCXO8c=gCK1tXa6-_Uftg@mail.gmail.com>
References: <1379662368-6580-1-git-send-email-adrian.huang@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:35643 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab3ITHfJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2013 03:35:09 -0400
Received: by mail-qe0-f48.google.com with SMTP id nd7so38339qeb.7
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2013 00:35:08 -0700 (PDT)
In-Reply-To: <1379662368-6580-1-git-send-email-adrian.huang@hp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adrian Huang <adrian.huang@hp.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linda.knippers@hp.com

On 20 September 2013 13:02, Adrian Huang <adrian.huang@hp.com> wrote:
> I re-sent this email becuase my system time was incorrect for my first submission (The sent time of the first submission showed "2012/8/16  08:12PM"). Sorry for any inconvenience.

You should have added this after the "---" available below, so
that it doesn't get commited in the logs..

> Do not load the Intel pstate driver if the platform firmware
> (ACPI BIOS) supports the power management alternatives.
> The ACPI BIOS indicates that the OS control mode can be used
> if the _PSS (Performance Supported States) is defined in ACPI
> table. For the OS control mode, the Intel pstate driver will be
> loaded.
>
> Signed-off-by: Adrian Huang <adrian.huang@hp.com>
> ---

<Here..>

>  drivers/cpufreq/intel_pstate.c | 84 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
