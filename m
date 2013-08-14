From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: sa11x0: cleanups for 3.13
Date: Wed, 14 Aug 2013 07:56:44 +0530
Message-ID: <CAKohpokOmv+CcL61dzkMgTNxY5rKb4A863CUAX_Jav4KyHF3DA@mail.gmail.com>
References: <cover.1376392060.git.viresh.kumar@linaro.org>
	<1437762.edDpfxPldn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33564 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758878Ab3HNC0p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2013 22:26:45 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so11178555obb.23
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2013 19:26:44 -0700 (PDT)
In-Reply-To: <1437762.edDpfxPldn@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 14 August 2013 01:31, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, August 13, 2013 07:01:04 PM Viresh Kumar wrote:

> Are the three patches in this series prerequisite for the big target_index
> one?  If so, I think they can go into 3.12 actually, if they are ACKed by the
> appropriate platform maintainers.

Yes, but they depend on cpufreq_table_validate_and_show() which
will also go in 3.13 and so these will be made part of that series in
future..
