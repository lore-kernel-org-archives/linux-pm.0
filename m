From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: skip invalid entries when searching the
 frequency
Date: Wed, 12 Oct 2016 08:46:53 +0530
Message-ID: <20161012031653.GD19385@vireshk-i7>
References: <20161007225925.GI15204@raspberrypi.musicnaut.iki.fi>
 <20161010213813.22087-1-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161010213813.22087-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11-10-16, 00:38, Aaro Koskinen wrote:
> Skip invalid entries when searching the frequency. This fixes cpufreq
> at least on loongson2 MIPS board.
> 
> Fixes: da0c6dc00c69 ("cpufreq: Handle sorted frequency tables more efficiently")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  include/linux/cpufreq.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Hi Aaro,

I have sent a new version of this patch, but screwed up the
--in-reply-to somehow.. Can you please give that a try?

-- 
viresh
