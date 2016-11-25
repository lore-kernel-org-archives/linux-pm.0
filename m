From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: fix intel_pstate_exit_perf_limits prototype
Date: Fri, 25 Nov 2016 22:10:20 +0100
Message-ID: <CAJZ5v0g2dNmZGB+MSatMRYuoqA5PKBrQ5UpBOfCBz92GYM-9zw@mail.gmail.com>
References: <20161125165036.195969-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:32807 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbcKYVLX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2016 16:11:23 -0500
In-Reply-To: <20161125165036.195969-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Nov 25, 2016 at 5:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The addition of the generic governor support marked the
> intel_pstate_exit_perf_limits as inline, which fixed a warning,
> but it introduced another warning:
>
> drivers/cpufreq/intel_pstate.c: In function =E2=80=98intel_pstate_exit_pe=
rf_limits=E2=80=99:
> drivers/cpufreq/intel_pstate.c:483:1: error: no return statement in funct=
ion returning non-void [-Werror=3Dreturn-type]
>
> This changes it back to a 'void' return type, and changes the
> corresponding intel_pstate_init_acpi_perf_limits() function to
> be inline as well for consistency.
>
> Fixes: 001c76f05b01 ("cpufreq: intel_pstate: Generic governors support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!

Rafael
