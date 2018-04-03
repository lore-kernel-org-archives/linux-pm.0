From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Do not include debugfs.h
Date: Tue, 3 Apr 2018 16:07:52 +0530
Message-ID: <CAOh2x=m_QPyCJri9XyM9TYZe10F2mDs6P3uPgerGFM5AxsSo-A@mail.gmail.com>
References: <1679361.0Gr8UWkMAK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1679361.0Gr8UWkMAK@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 30, 2018 at 3:22 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The intel_pstate driver doesn't use debugfs any more, so drop
> linux/debugfs.h from the list of included headers in it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |    1 -
>  1 file changed, 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
