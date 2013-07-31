From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH RFC 3/3] cpufreq: cpufreq-cpu0: clk rate-change notifiers
Date: Tue, 30 Jul 2013 18:43:28 -0700
Message-ID: <20130731014328.5270.4248@quantum>
References: <1373247868-21444-1-git-send-email-mturquette@linaro.org>
 <1373247868-21444-4-git-send-email-mturquette@linaro.org>
 <CAOh2x=kAM98Qta5RquVVByR8jJ3=t+6fNZ4o4WSroVCCZi+0Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOh2x=kAM98Qta5RquVVByR8jJ3=t+6fNZ4o4WSroVCCZi+0Cg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2013-07-07 21:10:54)
> On Mon, Jul 8, 2013 at 7:14 AM, Mike Turquette <mturquette@linaro.org> wrote:
> > Removes direct handling of OPP tables and voltage regulators by calling
> > of_clk_cpufreq_notifier_handler, introduced by commit "clk: cpufreq
> > helper for voltage scaling".
> >
> > In the future this can help consolidate code found across similar
> > CPUfreq drivers.
> >
> > Signed-off-by: Mike Turquette <mturquette@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq-cpu0.c | 125 ++++++++---------------------------------
> >  1 file changed, 22 insertions(+), 103 deletions(-)
> 
> Good patch, really gets lots of stuff out from cpufreq drivers.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Viresh,

Thanks for the Ack. I received no comments on this series besides your
own, so I plan to merge it. Do you want to take patch #3, or do you want
me to take it, or should I give you and Rafael a stable branch instead?

Regards,
Mike
