From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: mediatek: add cleanups with the more
 generic naming
Date: Wed, 9 Aug 2017 19:56:05 +0530
Message-ID: <20170809142605.GC29383@vireshk-i7>
References: <cover.1502272372.git.sean.wang@mediatek.com>
 <c658e5aa68d26c645a8ecd58da69576c9fe237c5.1502272372.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c658e5aa68d26c645a8ecd58da69576c9fe237c5.1502272372.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, matthias.bgg@gmail.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09-08-17, 18:12, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Since more MediaTek SoCs can be supported with the cpufreq driver and not
> limited to MT8173, a couple of cleanups are done here with renaming those
> functions and related structures with "mtk" instead of "mt8173".
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
