From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [problem on 32-bit systems] changing the type of clk_rate to "long long"?
Date: Sat, 15 Oct 2016 11:55:38 +0900
Message-ID: <CAK7LNAQL=G7hkVDgcGCM60Lq4Omx25-qb=TkXUKOO2CzeargTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-clk <linux-clk@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.


When I was testing my clk driver + generic cpufreq driver,
I was hit by a problem.


Everything worked fine on my 64-bit SoCs,
but not on 32-bit SoCs.


I found the cause of the problem was
that the type of clk_rate is "long".

It is long enough on 64-bit systems,
but only 32-bit wide on 32-bit systems.


The CPU clocks on my SoCs
are derived from a 2.4GHz PLL.


The .round_rate() callback tries to return 2400000000,
but it does not fit in a signed 32-bit-wide variable
and it is treated as -1894967296, which is an error.


In order to handle clock frequency safely,
shall we use "long long" instead?
(It is guaranteed to have 64-bit width)



-- 
Best Regards
Masahiro Yamada
