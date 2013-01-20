From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH V3 2/3] thermal: exynos: Miscellaneous fixes to support
 falling threshold interrupt
Date: Sun, 20 Jan 2013 18:23:57 +0530
Message-ID: <CAM=Q2ctj3-_WZQM9iH==nPvR8hQTG33743+McjrHqzb_FnJsJw@mail.gmail.com>
References: <CADGdYn4CeWB5zHuHrfSLYsyOCA_zcSgm9LHTwtei1zAhfmDJNQ@mail.gmail.com>
	<1358386938-13577-1-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1358386938-13577-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, jonghwa3.lee@samsung.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, durgadoss.r@intel.com, joe@perches.com
List-Id: linux-pm@vger.kernel.org

On 1/17/13, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
> Below fixes are done to support falling threshold interrupt,
> * Falling interrupt status macro corrected according to exynos5 data sheet.
> * The get trend function modified to calculate trip temperature correctly.
> * The clearing of interrupt status in the isr is now done after handling
>   the event that caused the interrupt.
One fix per patch would have been better.

However not particular.

Also are they applicable to older kernels?

>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
