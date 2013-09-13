From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 099/228] cpufreq: dbx500: don't initialize part of policy
 that is set by core too
Date: Fri, 13 Sep 2013 15:19:20 +0200
Message-ID: <CACRpkda=vzV1k5sJbnZSJHpEuEGwaHN_qi_-QzU79QoyoHse2w@mail.gmail.com>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
	<43f3fedcc13b4cd8a016f2dbbc91936423420cb8.1379063063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <43f3fedcc13b4cd8a016f2dbbc91936423420cb8.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, cpufreq@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 13, 2013 at 3:00 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Many common initializations of struct policy are moved to core now and hence
> this driver doesn't need to do it. This patch removes such code.
>
> Most recent of those changes is to call ->get() in the core after calling
> ->init().
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
