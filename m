From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] PM-runtime: fix and clean up of time accounting
Date: Wed, 06 Feb 2019 11:27:30 +0100
Message-ID: <30395680.vVXis5MGQY@aspire.rjw.lan>
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, biju.das@bp.renesas.com, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, thara.gopinath@linaro.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, February 4, 2019 5:25:51 PM CET Vincent Guittot wrote:
> Fix time accounting which has the same lock contraint as for using hrtimer
> and update accounting_timestamp only when useful.
> 
> Vincent Guittot (2):
>   PM-runtime: move runtime accounting on ktime_get_mono_fast_ns()
>   PM-runtime: update time accounting only when enabled
> 
>  drivers/base/power/runtime.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> 

Both applied, thanks!
