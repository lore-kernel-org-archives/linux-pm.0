From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/8] clk: ux500: Fixup smp_twd clk for clk notifiers
Date: Fri, 26 Oct 2012 10:57:49 +0200
Message-ID: <CACRpkdYdzvdJc=+gnRDEue1uZApGTc-P2pQfLAJXc_uBZLSPkQ@mail.gmail.com>
References: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
	<20121011134458.GB15428@gmail.com>
	<CACRpkdYEukMzMX1Q8nb5zKPMZEZfttzWVC24aOkv2g8SCQtTnQ@mail.gmail.com>
	<20121011151947.GD15428@gmail.com>
	<CAPDyKFof65xAVyOo3FrdS2uYQwB1Wq3553PKj04FR6JXaJsH6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFof65xAVyOo3FrdS2uYQwB1Wq3553PKj04FR6JXaJsH6Q@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@ti.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Philippe Begnic <philippe.begnic@st.com>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 26, 2012 at 10:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Samuel, a kind reminder on this, trying to collect acks to be able to
> advise Mike to take this series through his clk tree. There are two
> mfd patches.
> [PATCH 2/8] mfd: db8500: Provide cpufreq table as platform data
> [PATCH 5/8] mfd: db8500: Connect ARMSS clk to ARM OPP

Two weeks of slack for review is good enough, involved
subsystem maintainers have been Cc:ed.

Mike T, can you just apply the patches please.

Yours,
Linus Walleij
