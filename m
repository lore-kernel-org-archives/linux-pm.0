From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
Date: Mon, 4 Mar 2019 10:58:42 +0100
Message-ID: <CAJZ5v0hoNK5ez8ZqKzuFmBvXwpnB_rKUteRdE31ALWAVUhaKbw@mail.gmail.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <CABFtUbT6gRQETzZqR7QY6WYDKzF2ZVZ-Y2XQ-bOZnrmBZSnPvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABFtUbT6gRQETzZqR7QY6WYDKzF2ZVZ-Y2XQ-bOZnrmBZSnPvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 3, 2019 at 11:42 PM Gabriele Mazzotta
<gabriele.mzt@gmail.com> wrote:
>
> Hi,
>
> I applied these patches on top of 4.20. The max frequency of all the
> cores now reflects the actual value and it's updated whenever I
> change the power source.

Thanks for the confirmation!
