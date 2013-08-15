From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 09/31] cpufreq: dbx500: Covert to light weight ->target() routine
Date: Thu, 15 Aug 2013 21:52:34 +0200
Message-ID: <CACRpkdZbTw9CstP=gWRFA=M3fENcRcXWgAnWoTCM5dYZfBxQbw@mail.gmail.com>
References: <cover.1376329128.git.viresh.kumar@linaro.org>
	<e0c5392750876a08efea5db45eb13ece144fab55.1376329128.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <e0c5392750876a08efea5db45eb13ece144fab55.1376329128.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, cpufreq@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 12, 2013 at 7:48 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> This patch converts existing .target_old() to newly defined light weight
> .target() routine for this driver.
>
> CPUFreq core will call cpufreq_frequency_table_target() before calling this
> routine and will pass index to it.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Given that the concept is accepted:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
