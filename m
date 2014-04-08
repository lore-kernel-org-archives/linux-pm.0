From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: ppc: Remove duplicate inclusion of fsl_soc.h
Date: Tue, 8 Apr 2014 10:38:49 +0530
Message-ID: <CAOh2x==GArYBWdLN2ZMeTABGqu0Ag8A-+gcuaJ1bzhY92HtH7g@mail.gmail.com>
References: <1396933078-11438-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1396933078-11438-1-git-send-email-sachin.kamat@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 8, 2014 at 10:27 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> fsl_soc.h was included twice.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/cpufreq/ppc-corenet-cpufreq.c |    1 -
>  1 file changed, 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
