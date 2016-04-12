From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V1 1/5] cpufreq: Loongson1: Rename the file to
 loongson1-cpufreq.c
Date: Tue, 12 Apr 2016 14:32:32 +0200
Message-ID: <20160412123232.GA17598@linux-mips.org>
References: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
 <20160412104319.GA17650@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:59288 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932392AbcDLMcm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 08:32:42 -0400
Content-Disposition: inline
In-Reply-To: <20160412104319.GA17650@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Keguang Zhang <keguang.zhang@gmail.com>, linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, Apr 12, 2016 at 04:13:19PM +0530, Viresh Kumar wrote:

> On 12-04-16, 18:40, Keguang Zhang wrote:
> > From: Kelvin Cheung <keguang.zhang@gmail.com>
> > 
> > This patch renames the file to loongson1-cpufreq.c,
> > and also includes some minor updates.
> > 
> > Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> > 
> > ---
> > V1:
> >    Merge the minor updates into this patch.
> > ---
> >  drivers/cpufreq/Makefile                                |  2 +-
> >  drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} | 10 +++++-----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >  rename drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} (96%)
> 
> For the entire series.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!  Whole series queued for 4.7.

  Ralf
