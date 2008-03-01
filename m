From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [RFC][PATCH] cpuidle: avoid singing capacitors
Date: Sat, 1 Mar 2008 14:40:01 +0100
Message-ID: <20080301144001.771fa29c__6898.00914046845$1204379128$gmane$org@mjolnir.drzeus.cx>
References: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Adam Belay <abelay@novell.com>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 29 Feb 2008 19:38:12 +0100
Pierre Ossman <drzeus-list@drzeus.cx> wrote:

> @@ -50,9 +58,16 @@ static int menu_select(struct cpuidle_device *dev)
>                         break;
>                 if (s->exit_latency > pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY))
>                         break;
> +               if ((dev->states[i].flags & CPUIDLE_FLAG_DEEP) &&
> +                       time_before_eq(jiffies, data->last_deep_jif + MIN_DEEP_INTERVAL))
> +                       break;
>         }
>  

I guess another approach would be to refuse to enter deep sleep if the sleep time is less than 2 ms. That would mean we would not lose the long sleeps, but if it is just doing short sleeps then we would never enter C3...

Is there a decent way of testing which approach is actually doing the least damage?

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
