From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
Date: Sun, 3 Mar 2019 23:42:01 +0100
Message-ID: <CABFtUbT6gRQETzZqR7QY6WYDKzF2ZVZ-Y2XQ-bOZnrmBZSnPvQ@mail.gmail.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9956076.F4luUDm1Dq@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

I applied these patches on top of 4.20. The max frequency of all the
cores now reflects the actual value and it's updated whenever I
change the power source.

Regards,
Gabriele

On Fri, 1 Mar 2019 at 13:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> This is how I would fix the issue reported in BZ 200759 (see this patch series
> from Yu too: https://marc.info/?l=linux-pm&m=155137672924029&w=2).
>
> Patch [1/2] causes intel_pstate to update all policies if it gets a _PPC change
> notification and sees a global turbo disable/enable change.
>
> Patch [2/2] makes it update cpuinfo.max_freq for all policies in those cases.
>
> The patches here have not been tested yet, so testing would be much appreciated.
>
> Of course, comments are welcome too!
>
> Thanks,
> Rafael
>
