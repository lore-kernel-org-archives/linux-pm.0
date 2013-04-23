From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 07/18] cpufreq: s3c24xx: move cpufreq driver to drivers/cpufreq
Date: Wed, 24 Apr 2013 00:59:26 +0200
Message-ID: <2264237.NUtkmvZG3W@vostro.rjw.lan>
References: <cover.1365079581.git.viresh.kumar@linaro.org> <1769336.FkfMpuXqqb@vostro.rjw.lan> <5176A807.2090005@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5176A807.2090005@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, robin.randhawa@arm.com, Ben Dooks <ben-linux@fluff.org>, linux-pm@vger.kernel.org, patches@linaro.org, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve.Bannister@arm.com, arvind.chauhan@arm.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 24, 2013 12:25:59 AM Kukjin Kim wrote:
> On 04/05/13 20:36, Rafael J. Wysocki wrote:
> > On Friday, April 05, 2013 12:36:34 PM Viresh Kumar wrote:
> >> On 5 April 2013 12:18, Kukjin Kim<kgene.kim@samsung.com>  wrote:
> >>> Basically, this moving looks good to me, but should be re-worked based on
> >>> for-next of samsung tree because this touches too many samsung stuff so this
> >>> should be sent to upstream via samsung tree.
> >>
> >> Hmm... Its already applied in Rafael's tree. But it doesn't mean that
> >> it can't be
> >> moved to your tree if there is a issue.
> >
> > Well, I'm dropping it.  Please merge via the Samsung tree.
> >
> 
> Oops, I missed, maybe I have no more chance to send this to upstream for 
> upcoming merge window :-(
> 
> Rafael, please take this patch with my ack in your tree, sorry for noise.
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> If any problems, please kindly let me know.

Well, I suppose I can take the original patch, but then it will conflict with
your tree during merge.  Is that not a problem?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
