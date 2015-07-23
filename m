From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/3] cpufreq: Create links for offline CPUs that got added earlier
Date: Thu, 23 Jul 2015 21:28:06 +0200
Message-ID: <CAJZ5v0ghdYavo6AQvga65w+8FMvm+8cx0C4-_xvF=a6gtPOuYQ@mail.gmail.com>
References: <20150723060938.GD5322@linux>
	<e6d358cd9a19b6da6326deb05f9be2594904fad2.1437639021.git.viresh.kumar@linaro.org>
	<7e3b8b132812be7d8b80b065517d115a121b3c48.1437639021.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35804 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbbGWT2I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 15:28:08 -0400
In-Reply-To: <7e3b8b132812be7d8b80b065517d115a121b3c48.1437639021.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, open list <linux-kernel@vger.kernel.org>

Hi Viresh,

On Thu, Jul 23, 2015 at 10:13 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> If subsys callback ->add_dev() is called for an offline CPU, before its
> policy is allocated, we will miss adding its sysfs symlink.
>
> Fix this by tracking such CPUs in a separate mask.
>
> Fixes: 9b07109f06a1 ("cpufreq: Fix double addition of sysfs links")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

No, we need to go to back to square one.

No fixes of fixes of fixes etc please.

Let me prepare a patch for -rc that won't introduce *new* problems and
we can make major changes as 4.3 material, OK?

Thanks,
Rafael
