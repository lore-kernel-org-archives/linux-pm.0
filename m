From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/2] cpufreq: mediatek: Register an Energy Model
Date: Wed, 6 Feb 2019 10:16:59 -0800
Message-ID: <20190206181659.GI117604@google.com>
References: <20190205175225.25923-1-mka@chromium.org>
 <20190205175225.25923-2-mka@chromium.org>
 <20190206101316.fr7z4ffr4ck4l4aj@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190206101316.fr7z4ffr4ck4l4aj@queper01-lin>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Taniya Das <tdas@codeaurora.org>, Nicolas Boichat <drinkcat@chromium.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Quentin,

On Wed, Feb 06, 2019 at 10:13:18AM +0000, Quentin Perret wrote:
> Hi Matthias,
> 
> On Tuesday 05 Feb 2019 at 09:52:25 (-0800), Matthias Kaehlcke wrote:
> > Try and register an Energy Model from mediatek-cpufreq to allow
> > interested subsystems like the task scheduler to use the provided
> > information.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/cpufreq/mediatek-cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> > index eb8920d398181..e6168ee582783 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -460,6 +460,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
> >  		return ret;
> >  	}
> >  
> > +	dev_pm_opp_of_register_em(policy->cpus);
> 
> I'm not familiar with the mediatek-cpufreq driver so bear with me, but
> the code sets policy->cpus just below here. Is there any particular
> reason for not using that in PM_EM ?

You are prefectly right, I missed the obvious and didn't get my hands
on hardware yet for testing.

So much for screwing up a one-liner ... I'll send a fix.

I thought Viresh already applied the patch, however in opp/linux-next
I currently only see the other one of this series for qcom-hw, so it
seems sending a new version rather than a fix-up patch is the way to
go.

Thanks for the review!

> >  	cpumask_copy(policy->cpus, &info->cpus);
> >  	policy->freq_table = freq_table;
> >  	policy->driver_data = info;
> 
> Thanks,
> Quentin
