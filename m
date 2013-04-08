From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 07/18] cpufreq: s3c24xx: move cpufreq driver to drivers/cpufreq
Date: Mon, 08 Apr 2013 12:46:38 +0200
Message-ID: <2166815.0SZ6SYhSDN@vostro.rjw.lan>
References: <cover.1365079581.git.viresh.kumar@linaro.org> <1769336.FkfMpuXqqb@vostro.rjw.lan> <2ccd01ce3439$911b51b0$b351f510$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2ccd01ce3439$911b51b0$b351f510$%kim@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, 'Ben Dooks' <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 08, 2013 06:15:09 PM Kukjin Kim wrote:
> Rafael J. Wysocki wrote:
> > 
> > On Friday, April 05, 2013 12:36:34 PM Viresh Kumar wrote:
> > > On 5 April 2013 12:18, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > > > Basically, this moving looks good to me, but should be re-worked based
> > on
> > > > for-next of samsung tree because this touches too many samsung stuff
> > so this
> > > > should be sent to upstream via samsung tree.
> > >
> > > Hmm... Its already applied in Rafael's tree. But it doesn't mean that
> > > it can't be
> > > moved to your tree if there is a issue.
> > 
> > Well, I'm dropping it.  Please merge via the Samsung tree.
> > 
> OK, I will.
> 
> I got patch file from Viresh, and there is a sign from Rafael,
> but it should be ack. So Rafael, let me use your ack on this patch when
> I apply. If any problems, please let me know.

Since it was signed-off by me before, you can assume it's been ACKed as well.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
