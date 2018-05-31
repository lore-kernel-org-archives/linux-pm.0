From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/9] PM / Domains: Drop extern declarations of
 functions in pm_domain.h
Date: Thu, 31 May 2018 11:42:26 +0530
Message-ID: <20180531061226.r3zrwypmiud2ksef@vireshk-i7>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-2-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180529100421.31022-2-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Todor Tomov <todor.tomov@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29-05-18, 12:04, Ulf Hansson wrote:
> Using "extern" to declare a function in a public header file is somewhat
> pointless, but also doesn't hurt. However, to make all the function
> declarations in pm_domain.h to be consistent, let's drop the use of
> "extern".
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  include/linux/pm_domain.h | 51 ++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 28 deletions(-)

Finally.

I wanted to do that earlier as checkpatch complained non stop about
such declarations :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
