From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 11/35] cpufreq: dbx500: use cpufreq_table_validate_and_show()
Date: Wed, 14 Aug 2013 21:36:40 +0200
Message-ID: <CACRpkda29WcHePh00w_7N3B1OtGh=-i=1_PyB4MNhy=YJ-nxyg@mail.gmail.com>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
	<e343e827df7be24f11ecdaf849f2874bf1ba4b24.1375964117.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <e343e827df7be24f11ecdaf849f2874bf1ba4b24.1375964117.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, cpufreq@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 8, 2013 at 3:48 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Lets use cpufreq_table_validate_and_show() instead of calling
> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
