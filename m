From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: stats: Use lock by stat to replace global spin
 lock
Date: Mon, 8 Apr 2019 11:09:44 +0530
Message-ID: <20190408053944.wcz2pblevccyftmg@vireshk-i7>
References: <20190325072933.215946-1-linkyle0915@gmail.com>
 <20190326184346.GY112750@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326184346.GY112750@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Kyle Lin <linkyle0915@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 26-03-19, 11:43, Matthias Kaehlcke wrote:
> On Mon, Mar 25, 2019 at 03:29:33PM +0800, Kyle Lin wrote:
> > Stats is updated by each policy, using the lock by stat can
> > reduce the contention.
> > 
> > Signed-off-by: Kyle Lin <linkyle0915@gmail.com>
> > ---
> >  drivers/cpufreq/cpufreq_stats.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > index e2db5581489a..17beb1bc7e16 100644
> > --- a/drivers/cpufreq/cpufreq_stats.c
> > +++ b/drivers/cpufreq/cpufreq_stats.c
> > @@ -14,7 +14,6 @@
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  
> > -static DEFINE_SPINLOCK(cpufreq_stats_lock);
> >  
> >  struct cpufreq_stats {
> >  	unsigned int total_trans;
> > @@ -23,6 +22,7 @@ struct cpufreq_stats {
> >  	unsigned int state_num;
> >  	unsigned int last_index;
> >  	u64 *time_in_state;
> > +	spinlock_t lock;        /*spinlock for stats update*/
> 
> nit: not sure if the comment adds much value. If it stay there it
> needs a blank after '/*' and another before '*/'

Just drop the comment please.

-- 
viresh
