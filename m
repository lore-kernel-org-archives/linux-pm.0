From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 2/2] soc: mediatek: reuse regmap_read_poll_timeout
 helpers
Date: Fri, 11 May 2018 13:25:02 +0200
Message-ID: <68d230e8-2f9f-ae84-95d0-d8bf22f8f43b@gmail.com>
References: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
 <ed866d3345a27b2c87b570562d9ad9132bca6062.1524465345.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ed866d3345a27b2c87b570562d9ad9132bca6062.1524465345.git.sean.wang@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>
List-Id: linux-pm@vger.kernel.org

Hi Sean,

On 04/23/2018 08:42 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Reuse the common helpers regmap_read_poll_timeout provided by Linux core
> instead of an open-coded handling.
> 
> v1 -> v2:
>  - use macro definitions MTK_POLL_DELAY_US and MTK_POLL_TIMEOUT for
>    arguments sleep_us and timeout_us passing in regmap_read_poll_timeout.
>  - remove unnecessary linux/iopoll.h being included in.
> 

I just realized that you wrote the changelog here, which will make it show up in
the commit log. Thant's not what we want... (see below)

> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-infracfg.c | 46 ++++++++++---------------------------
>  1 file changed, 12 insertions(+), 34 deletions(-)
> 

Please write your changelog here in the future.
I'll fix that up in my tree now, but please remember the next time :)
Thanks
Matthias
