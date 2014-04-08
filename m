From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] cpufreq: ppc: Remove duplicate inclusion of fsl_soc.h
Date: Tue, 08 Apr 2014 14:07:32 +0200
Message-ID: <1960961.9QF06mGrKJ@vostro.rjw.lan>
References: <1396933078-11438-1-git-send-email-sachin.kamat@linaro.org> <CAOh2x==GArYBWdLN2ZMeTABGqu0Ag8A-+gcuaJ1bzhY92HtH7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62057 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756435AbaDHLvd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Apr 2014 07:51:33 -0400
In-Reply-To: <CAOh2x==GArYBWdLN2ZMeTABGqu0Ag8A-+gcuaJ1bzhY92HtH7g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, April 08, 2014 10:38:49 AM Viresh Kumar wrote:
> On Tue, Apr 8, 2014 at 10:27 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> > fsl_soc.h was included twice.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > ---
> >  drivers/cpufreq/ppc-corenet-cpufreq.c |    1 -
> >  1 file changed, 1 deletion(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for the next pull request, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
