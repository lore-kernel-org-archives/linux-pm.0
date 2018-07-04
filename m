From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 10/21] cpufreq: intel_pstate: use match_string() helper
Date: Wed, 04 Jul 2018 12:52:06 +0200
Message-ID: <1610915.y2K1qFKfud@aspire.rjw.lan>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com> <1633797.WhvbXNE1Nx@aspire.rjw.lan> <9ae4955e8026e1ddf0567e5cc210c5713668b631.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9ae4955e8026e1ddf0567e5cc210c5713668b631.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 27, 2018 1:56:30 AM CEST Srinivas Pandruvada wrote:
> On Tue, 2018-06-26 at 17:23 +0200, Rafael J. Wysocki wrote:
> > On Thursday, May 31, 2018 1:11:15 PM CEST Yisheng Xie wrote:
> > > match_string() returns the index of an array for a matching string,
> > > which can be used instead of open coded variant.
> > > 
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Patch applied, thanks!
