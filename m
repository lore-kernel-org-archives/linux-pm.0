From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: governors: implement generic policy_is_shared
Date: Thu, 31 Jan 2013 15:23:02 +0530
Message-ID: <CAKohpom5L01eqpW_T+BkpmfR2DgfoP3b+wsAbrEZ9==_kekeyw@mail.gmail.com>
References: <CAOh2x==1ru3bddHnJOge=1rbpc6xwzKV5F5isJhAgwX_R=2TCw@mail.gmail.com>
	<1359625480-16688-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1359625480-16688-1-git-send-email-fabio.baltieri@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 31 January 2013 15:14, Fabio Baltieri <fabio.baltieri@linaro.org> wrote:
> Implement a generic helper function policy_is_shared() to replace the
> current dbs_sw_coordinated_cpus() at cpufreq level, so that it can be
> used by code other than cpufreq governors.
>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
>
> Changes from v1:
> - replaced cpumask_weight in acpi-cpufreq.c and cpufreq_stats.c, through the
>   actual check is different the semantic should be the same.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
