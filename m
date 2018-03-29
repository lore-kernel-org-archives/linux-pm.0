From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [kbuild-all] [PATCH] OPTIONAL: cpufreq/intel_pstate: fix
 debugfs_simple_attr.cocci warnings
Date: Thu, 29 Mar 2018 21:44:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1803292140340.2750@hadrien>
References: <alpine.DEB.2.20.1803292109180.2750@hadrien> <CAOMZO5CLpW+2yCYRwAJTPWtXgXkaPGyPQrB3cbBGYvV1fryUQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5CLpW+2yCYRwAJTPWtXgXkaPGyPQrB3cbBGYvV1fryUQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Francisco Jerez <currojerez@riseup.net>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, kbuild-all@01.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 0day robot <fengguang.wu@intel.com>, Len Brown <lenb@kernel.org>, Nicolai Stange <nstange@suse.de>
List-Id: linux-pm@vger.kernel.org



On Thu, 29 Mar 2018, Fabio Estevam wrote:

> Hi Julia,
>
> On Thu, Mar 29, 2018 at 4:12 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >  Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
> >  for debugfs files.
> >
> > Semantic patch information:
> >  Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
> >  imposes some significant overhead as compared to
> >  DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
>
> Just curious: could you please expand on what "imposes some
> significant overhead" means?

I don't know.  I didn't write this rule.  Nicolai, can you explain?

thanks,
julia
