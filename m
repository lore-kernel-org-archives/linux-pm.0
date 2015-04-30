From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 linux-next] cpufreq: pxa: replace typedef pxa_freqs_t by structure
Date: Thu, 30 Apr 2015 22:12:01 +0200
Message-ID: <8968478.AeaVEX5OB0@vostro.rjw.lan>
References: <1430335980-9765-1-git-send-email-fabf@skynet.be> <1430369201.2575.10.camel@perches.com> <1161092225.77460.1430418536315.open-xchange@webmail.nmp.proximus.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54863 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752410AbbD3TrH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 15:47:07 -0400
In-Reply-To: <1161092225.77460.1430418536315.open-xchange@webmail.nmp.proximus.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

On Thursday, April 30, 2015 08:28:56 PM Fabian Frederick wrote:
> 
> > On 30 April 2015 at 06:46 Joe Perches <joe@perches.com> wrote:
> >
> >
> > On Wed, 2015-04-29 at 21:32 +0200, Fabian Frederick wrote:
> > > typedef is not really useful here. Replace it by structure
> > > to improve readability.typedef should only be used in some cases.
> > > (See Documentation/CodingStyle Chapter 5 for details).
> >
> > trivia:
> >
> > > diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c
> > > b/drivers/cpufreq/pxa2xx-cpufreq.c
> > []
> > > @@ -86,7 +86,7 @@ static unsigned int sdram_rows;
> > >  /* Use the run mode frequencies for the CPUFREQ_POLICY_PERFORMANCE policy
> > >*/
> > >  #define CCLKCFG                    CCLKCFG_TURBO | CCLKCFG_FCS
> > > 
> > > -static pxa_freqs_t pxa255_run_freqs[] =
> > > +static struct pxa_freqs pxa255_run_freqs[] =
> >
> > Should these be const?
> 
> AFAICS yes but this needs some fixes:
> drivers/cpufreq/pxa2xx-cpufreq.c: In function 'find_freq_tables':
> drivers/cpufreq/pxa2xx-cpufreq.c:218:15: warning: assignment discards 'const'
> qualifier from pointer target type
>     *pxa_freqs = pxa255_run_freqs;
>                ^
> Maybe another patch ?

Yes.  One change at a time pretty please.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
