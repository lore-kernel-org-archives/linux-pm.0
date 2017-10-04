From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: docs: Drop intel_pstate.txt from index.txt
Date: Wed, 4 Oct 2017 12:39:47 +0530
Message-ID: <CAOh2x==Qcg7E2Hwu1-bYua4YOhDR2dBhCQ+=_LkzLNiqdfpcuQ@mail.gmail.com>
References: <2401157.mvXUDI8C0e@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2401157.mvXUDI8C0e@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 28, 2017 at 5:26 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 33fc30b47098 (cpufreq: intel_pstate: Document the current
> behavior and user interface) dropped the intel-pstate.txt file
> from Documentation/cpu-freq/, but it did not update the index.txt
> file in there accordingly, so do that now.
>
> Fixes: 33fc30b47098 (cpufreq: intel_pstate: Document the current behavior and user interface)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/cpu-freq/index.txt |    2 --
>  1 file changed, 2 deletions(-)
>
> Index: linux-pm/Documentation/cpu-freq/index.txt
> ===================================================================
> --- linux-pm.orig/Documentation/cpu-freq/index.txt
> +++ linux-pm/Documentation/cpu-freq/index.txt
> @@ -32,8 +32,6 @@ cpufreq-stats.txt -   General description
>
>  index.txt      -       File index, Mailing list and Links (this document)
>
> -intel-pstate.txt -     Intel pstate cpufreq driver specific file.
> -
>  pcc-cpufreq.txt -      PCC cpufreq driver specific file.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
