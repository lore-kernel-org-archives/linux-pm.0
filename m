From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: ondemand: Set MIN_FREQUENCY_UP_THRESHOLD to 1
Date: Tue, 05 Jan 2016 14:02:56 +0100
Message-ID: <24213887.mlBXLjjmuO@vostro.rjw.lan>
References: <9645d54c1bc65ce69ecfd5e92259ead7699afc82.1451880670.git.yu.c.chen@intel.com> <20160104055651.GB27177@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60840 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751590AbcAEMcQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2016 07:32:16 -0500
In-Reply-To: <20160104055651.GB27177@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sworddragon2@aol.com

On Monday, January 04, 2016 11:26:51 AM Viresh Kumar wrote:
> On 04-01-16, 12:14, Chen Yu wrote:
> > Currently the minimal up_threshold is 11, and user may want to
> > use a smaller minimal up_threshold for performance tuning,
> > so MIN_FREQUENCY_UP_THRESHOLD could be set to 1 because:
> > 
> > 1. Current systems wouldn't be affected as they have already
> >    a value >= 11.
> > 2. New systems with a default kernel would keep still the default
> >    value that is >= 11.
> > 
> > Users now have the advantage that they can make their own decisions
> > and customize the 'trip point' to switch to the max frequency.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=65501
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq_ondemand.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> > index 03ac6ce..2a093b5 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -24,7 +24,7 @@
> >  #define MAX_SAMPLING_DOWN_FACTOR		(100000)
> >  #define MICRO_FREQUENCY_UP_THRESHOLD		(95)
> >  #define MICRO_FREQUENCY_MIN_SAMPLE_RATE		(10000)
> > -#define MIN_FREQUENCY_UP_THRESHOLD		(11)
> > +#define MIN_FREQUENCY_UP_THRESHOLD		(1)
> >  #define MAX_FREQUENCY_UP_THRESHOLD		(100)
> >  
> >  static DEFINE_PER_CPU(struct od_cpu_dbs_info_s, od_cpu_dbs_info);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael

