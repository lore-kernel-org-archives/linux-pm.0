From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] ACPI / cpufreq: Add ACPI processor device IDs to acpi-cpufreq
Date: Fri, 7 Jun 2013 09:03:27 +0530
Message-ID: <CAOh2x=nGiTBYr6vzMS+ffeJHWp2RnOyCYP-Lo3kE0Cfnw7jUtw@mail.gmail.com>
References: <1511440.Xd41mcOoEa@vostro.rjw.lan>
	<20130606230947.GA31618@kroah.com>
	<2456209.UJDSHpYIkx@vostro.rjw.lan>
	<2339263.DWrxye4sI1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:41454 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab3FGDd2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2013 23:33:28 -0400
In-Reply-To: <2339263.DWrxye4sI1@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Jun 7, 2013 at 7:38 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After commit ac212b6 (ACPI / processor: Use common hotplug
> infrastructure) the acpi-cpufreq module is not loaded automatically
> by udev which fails to match it against the x86cpu modalias.  Still,
> it can be matched against ACPI processor device IDs, which even
> makes more sense, because it depends on the ACPI processor driver
> that uses those device IDs to bind to processor devices.
>
> For this reason, add ACPI processor device IDs to acpi-cpufreq.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> This patch is against the acpi-hotplug branch of the linux-pm.git tree which
> is part of linux-next.
>
> Thanks,
> Rafael
>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |    7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
