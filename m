From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v5 2/6] ACPI: Make ACPI processor driver more extensible
Date: Fri, 12 Jun 2015 13:53:36 -0400
Message-ID: <CAJ5Y-eZDmfhRpzeEv_+oxEc8L2EvqPiJRJG455tW8D9a1TgV2g@mail.gmail.com>
References: <1432590659-9016-1-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34524 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbbFLRxh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2015 13:53:37 -0400
Received: by obbsn1 with SMTP id sn1so28049854obb.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2015 10:53:36 -0700 (PDT)
In-Reply-To: <1432590659-9016-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>

On 25 May 2015 at 17:50, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> The ACPI processor driver is currently tied too closely
> to the ACPI C-states (CST), P-states (PSS) and other related
> constructs for controlling CPU idle and CPU performance.
>
> The newer ACPI specification (v5.1 onwards) introduces
> alternative methods to CST and PSS. These new mechanisms
> are described within each ACPI Processor object and so they
> need to be scanned whenever a new Processor object is detected.
> This patch introduces two new Kconfig symbols to allow for
> finer configurability among the various options for controlling
> CPU idle and performance states. There is no change in functionality
> and these options are defaulted to enabled to maintain previous
> behaviour.
>
> The following patchwork introduces CPPC: A newer method of
> controlling CPU performance. The OS is not expected to support CPPC
> and PSS at runtime. So the kconfig option lets us make these two
> mutually exclusive at compile time.
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/acpi/Kconfig            |  41 +++++++++++----
>  drivers/acpi/Makefile           |   7 +--
>  drivers/acpi/processor_driver.c |  85 ++++++++++++++++++++-----------
>  drivers/cpufreq/Kconfig         |   2 +-
>  drivers/cpufreq/Kconfig.x86     |   2 +
>  include/acpi/processor.h        | 109 ++++++++++++++++++++++++++++++++++------
>  6 files changed, 187 insertions(+), 59 deletions(-)


Gentle reminder.. I'll address the function name as Srinivas
suggested. Any other comments here and the other patches in this
series?

Regards,
Ashwin.
