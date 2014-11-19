From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v11 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Wed, 19 Nov 2014 09:30:32 -0800
Message-ID: <CAMAWPa_V2rO9Ymezf0xPqeQNykCFq9QwLsNOG3EgPZfP-8MRBQ@mail.gmail.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-2-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-3-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-4-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Thomas,

On Mon, Oct 20, 2014 at 4:41 AM, Thomas Abraham <thomas.ab@samsung.com> wrote:
> The new CPU clock type allows the use of generic CPUfreq drivers. So for
> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
> which did not have CPUfreq driver support, enable the use of generic
> CPUfreq driver.
>
> Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Chander Kashyap <k.chander@samsung.com>

What's the status of the exynos5 CPUfreq support for upstream?  This
was pretty broadly reviewed and tested, but I still don't see this
either in linux-next or Kukjin's for-next.

Kevin
