From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 0/2][RFC] ACPI / PM: Disable MSR T-state after resumed
Date: Fri, 25 Aug 2017 14:40:19 -0700
Message-ID: <001b01d31dea$c116dc50$434494f0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta16.telus.net ([209.171.16.89]:60346 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933269AbdHYVkY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Aug 2017 17:40:24 -0400
References: lHgGdsvEp8Qk9lHgId179V
In-Reply-To: lHgGdsvEp8Qk9lHgId179V
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Chen Yu' <yu.c.chen@intel.com>, linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Len Brown' <lenb@kernel.org>

On 2017.08.25 09:43 Chen Yu wrote:

> There is a growing number of reports that the MSR throttling has
> been enabled after resumed back from suspend to ram, which impacts
> the system performance. This patchset tries to address this issue
> by turning off the T-state after resumed back.
>
> Chen Yu (2):
>  ACPI / PM: Reuse the acpi_sleep_syscore_ops for future requirement
>  ACPI / PM: Disable the MSR T-state during CPU online
>
> drivers/acpi/sleep.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 58 insertions(+), 2 deletions(-)

Hi Chen,

I'll just copy and paste what I wrote in a couple of the bug reports ([1] for example) a couple of days ago:

> I believe that pending changes to the intel-pstate CPU frequency scaling driver,
> proposed by Rafael, I think for kernel 4.14-rc1, will eliminate the ongoing
> troubles with Clock Modulation and the driver.
>
> I'm saying that the issue will no longer exist, and that the intel_pstate
> CPU frequency scaling driver will respond "properly" to Clock Modulation events.
> Of course, I'll check when kernel 4.14-rc1 becomes available, or before if I can
> apply all the patches.
>
> For reference see the patch set related to:
>
> [PATCH 0/2] cpufreq: intel_pstate: Eliminate the PID controller
> 2017.07.24 03:22 (or 10:22 UTC, I think)
>
> https://marc.info/?l=linux-pm&m=150093486908759&w=2
> https://marc.info/?l=linux-pm&m=150093484308751&w=2
> https://marc.info/?l=linux-pm&m=150093486808758&w=2

[1] https://bugzilla.kernel.org/show_bug.cgi?id=189861
