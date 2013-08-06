From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] cpufreq: loongson2: fix broken cpufreq
Date: Tue, 6 Aug 2013 16:40:12 +0200
Message-ID: <20130806144012.GB17633@linux-mips.org>
References: <1375727232-17796-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1375727232-17796-1-git-send-email-aaro.koskinen@iki.fi>
Sender: cpufreq-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Julia Lawall <Julia.Lawall@lip6.fr>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 05, 2013 at 09:27:12PM +0300, Aaro Koskinen wrote:

> Commit 42913c799 (MIPS: Loongson2: Use clk API instead of direct
> dereferences) broke the cpufreq functionality on Loongson2 boards:
> clk_set_rate() is called before the CPU frequency table is initialized,
> and therefore will always fail.
> 
> Fix by moving the clk_set_rate() after the table initialization.
> Tested on Lemote FuLoong mini-PC.

Seems to make sense.

Rafael or Virish, this should go to Linus for 3.11.  Do you want to funnel
this through the cpufreq tree or shall I send this to Linus with the
next batch of MIPS stuff?

  Ralf
