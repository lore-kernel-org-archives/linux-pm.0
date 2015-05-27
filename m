From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Do not use CPUIDLE_DRIVER_STATE_START in cpuidle.c
Date: Wed, 27 May 2015 10:22:17 +0200
Message-ID: <55657EB9.7050905@linaro.org>
References: <5494512.JcUbNX5Mxs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5494512.JcUbNX5Mxs@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 05/27/2015 03:36 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The CPUIDLE_DRIVER_STATE_START symbol is defined as 1 only if
> CONFIG_ARCH_HAS_CPU_RELAX is set, otherwise it is defined as 0.
> However, if CONFIG_ARCH_HAS_CPU_RELAX is set, the first (index 0)
> entry in the cpuidle driver's table of states is overwritten with
> the default "poll" entry by the core.  The "state" defined by the
> "poll" entry doesn't provide ->enter_dead and ->enter_freeze
> callbacks and its exit_latency is 0.
>
> For this reason, it is not necessary to use CPUIDLE_DRIVER_STATE_STAR=
T
> in cpuidle_play_dead() (->enter_dead is NULL, so the "poll state"
> will be skipped by the loop) and in find_deepest_state() (since
> exit_latency is 0, the "poll state" will become the default if the
> "s->exit_latency <=3D latency_req" check is replaced with
> "s->exit_latency < latency_req" which may only matter for drivers
> providing different states with the same exit_latency).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I was about to send *exactly* the same patch :)

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
