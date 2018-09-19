From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/11] cpufreq: mvebu: Remove OPPs using
 dev_pm_opp_remove()
Date: Wed, 19 Sep 2018 14:40:58 -0700
Message-ID: <20180919214058.bp325gyowqyveil2@vireshk-mac-ubuntu>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
 <b6e58baec5ee4cf56f82c4b14dad7320cf01ce7f.1536736872.git.viresh.kumar@linaro.org>
 <87o9ctjyz3.fsf@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87o9ctjyz3.fsf@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: niklas.cassel@linaro.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 19-09-18, 17:20, Gregory CLEMENT wrote:
> Hi Viresh,
>  
>  On mer., sept. 12 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > dev_pm_opp_cpumask_remove_table() is going to change in the next commit
> > and will not remove dynamic OPPs automatically. They must be removed
> > with a call to dev_pm_opp_remove().
> 
> So now that mean when adding more than 2 OPPs, we should have the list
> of them available in the driver to be able to remove them, right?

Right. Maybe we will add a separate API to remove all dynamic ones in
one go but I couldn't find any platform which needs to do it right
now.

> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks.

-- 
viresh
