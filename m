From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: merge maple cpufreq driver to pmac64
Date: Mon, 16 Sep 2013 11:57:14 +0530
Message-ID: <CAKohpomAXXHN_w_RtQC4niyP1_FVB75b-cSvmexRmnmgnNPs8w@mail.gmail.com>
References: <1379071806-17453-1-git-send-email-dmitry_eremin@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35680 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab3IPG1P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 02:27:15 -0400
Received: by mail-ob0-f178.google.com with SMTP id uy5so3335624obc.23
        for <linux-pm@vger.kernel.org>; Sun, 15 Sep 2013 23:27:14 -0700 (PDT)
In-Reply-To: <1379071806-17453-1-git-send-email-dmitry_eremin@mentor.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 13 September 2013 17:00, Dmitry Eremin-Solenikov
<dmitry_eremin@mentor.com> wrote:
> Maple boards use the same frequency changing mechanism, as do newer
> PowerMacs (write to SCOM). Thus maple-cpufreq.c is a reduced version
> of pmac64 driver. Merge it back to pmac64-cpufreq.c
>
> Signed-off-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> ---
>  drivers/cpufreq/Kconfig.powerpc  |  10 +-
>  drivers/cpufreq/Makefile         |   1 -
>  drivers/cpufreq/maple-cpufreq.c  | 308 ---------------------------------------
>  drivers/cpufreq/pmac64-cpufreq.c |  58 +++++---
>  4 files changed, 40 insertions(+), 337 deletions(-)
>  delete mode 100644 drivers/cpufreq/maple-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I couldn't figure out any obvious bug in this patch, but its more for driver's
maintainer and so probably they need to go through this patch..
