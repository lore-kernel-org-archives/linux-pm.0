From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] cpufreq: mediatek: Add mediatek related projects into
 blacklist
Date: Tue, 23 Jan 2018 09:46:51 +0100
Message-ID: <20180123084651.GA26581@kroah.com>
References: <8193c5fd73ee34b59799fdf5c6cc24ca60971d6e.1516693333.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8193c5fd73ee34b59799fdf5c6cc24ca60971d6e.1516693333.git.sean.wang@mediatek.com>
Sender: stable-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: stable@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>, Kevin Hilman <khilman@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 23, 2018 at 04:31:11PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> commit 6066998cbd2b1012a8d5bc9a2957cfd0ad53150e upstream.
> 
> commit edeec420de24 ("cpufreq: dt-platdev: Automatically create cpufreq
> device with OPP v2") not added MediaTek SoCs to the blacklist that would
> lead to cause an occasional hang or unexpected behaviors on related boards
> as kernelci reported and complained on [1] specifically for 4.14 and 4.15
> tree.
> 
> For those reasons, add MediaTek SoCs into cpufreq-dt blacklist and wish
> the patch be applied to 4.14 and 4.15 tree to allow kernelci able to
> complete following automated kernel testing.
> 
> [1] https://kernelci.org/boot/mt7623n-bananapi-bpi-r2/
> 
> Fixes: edeec420de24 (cpufreq: dt-cpufreq: platdev Automatically create device with OPP v2)
> Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

What stable kernel tree(s) are you wanting this backported to?

thanks,

greg k-h
