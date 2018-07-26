From: Eduardo Valentin <eduval@amazon.com>
Subject: Re: [PATCH v2 0/3] thermal: tsens: bugfixes, cleanups
Date: Thu, 26 Jul 2018 14:03:03 -0700
Message-ID: <20180726210303.GC7708@u40b0340c692b58f6553c.ant.amazon.com>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1532600791.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hey Amit,


On Thu, Jul 26, 2018 at 04:03:07PM +0530, Amit Kucheria wrote:
> Here is another series of tsens-related bugfixes and cleanups to prepare
> for IRQ support, among other things. It applies on top of another series[1]
> that did some code consolidation to add support for sdm845.
> 
> [1] https://lore.kernel.org/lkml/cover.1531895128.git.amit.kucheria@linaro.org/T/#t


Given it is already rc7 time, even if this is fixes series, I will only consider this for the merge window.

> 
> Changes since v1:
> - Fixup a couple of typos
> - Add review tag
> 
> Amit Kucheria (3):
>   thermal: tsens: Rename variable
>   thermal: tsens: switch from of_iomap() to devm_ioremap_resource()
>   thermal: tsens: Fix negative temperature reporting
> 
>  drivers/thermal/qcom/tsens-common.c | 19 ++++++++++---------
>  drivers/thermal/qcom/tsens-v2.c     | 23 ++++++++++-------------
>  2 files changed, 20 insertions(+), 22 deletions(-)
> 
> -- 
> 2.17.GIT
> 

-- 
All the best,
Eduardo Valentin
