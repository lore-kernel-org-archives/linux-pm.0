From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: unicore2: Staticize local symbol
Date: Tue, 13 Aug 2013 15:23:05 +0200
Message-ID: <1498761.g2kRkhGIXC@vostro.rjw.lan>
References: <000701ce94d0$240949e0$6c1bdda0$@samsung.com> <CAOh2x=nOToVvWVm9=ZF9p4J_HOEJXJZWz--WdH+tKpk2voVsAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41061 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757529Ab3HMNMl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Aug 2013 09:12:41 -0400
In-Reply-To: <CAOh2x=nOToVvWVm9=ZF9p4J_HOEJXJZWz--WdH+tKpk2voVsAA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jingoo Han <jg1.han@samsung.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>

On Friday, August 09, 2013 10:14:08 PM Viresh Kumar wrote:
> On Fri, Aug 9, 2013 at 12:44 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> > This local symbol is used only in this file.
> > Fix the following sparse warnings:
> >
> > drivers/cpufreq/unicore2-cpufreq.c:27:5: warning: symbol 'ucv2_verify_speed' was not declared. Should it be static?
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/cpufreq/unicore2-cpufreq.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 3.12.

Thanks,
Rafael

