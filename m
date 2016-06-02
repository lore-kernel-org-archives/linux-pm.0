From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/8] cpufreq: s3c24xx: Remove useless checks
Date: Thu, 2 Jun 2016 12:22:00 +0530
Message-ID: <20160602065200.GB3725@vireshk-i7>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
 <59631fdb5720381c8831ab90c0b6d05e7bcacc0c.1464776797.git.viresh.kumar@linaro.org>
 <574FD715.3000106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <574FD715.3000106@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02-06-16, 08:49, Krzysztof Kozlowski wrote:
> On 06/01/2016 12:34 PM, Viresh Kumar wrote:
> > These aren't required at all, remove them.
> > 
> > Cc: Kukjin Kim <kgene@kernel.org>
> > Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/s3c24xx-cpufreq.c | 4 ----
> >  1 file changed, 4 deletions(-)
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Do you wish me to take it through samsung-soc tree?

Better to let this go via PM tree as there are more patches for this
file in the same patchset that have to go via PM tree.

Thanks.

-- 
viresh
