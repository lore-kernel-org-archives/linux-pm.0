From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 6/6 v9] cpufreq, highbank: add support for highbank cpufreq
Date: Thu, 6 Dec 2012 23:04:12 -0800
Message-ID: <CAPtuhTi3Gvb0CQFiAe_bNRQ4k0xfzN9amQvwTeUsaJ7HLJsNHQ@mail.gmail.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354833773-22845-1-git-send-email-mark.langsdorf@calxeda.com> <1354833773-22845-7-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1354833773-22845-7-git-send-email-mark.langsdorf@calxeda.com>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 6, 2012 at 2:42 PM, Mark Langsdorf
<mark.langsdorf@calxeda.com> wrote:
> Highbank processors depend on the external ECME to perform voltage
> management based on a requested frequency. Communication between the
> A9 cores and the ECME happens over the pl320 IPC channel.
>
> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: mturquette@linaro.org

Looks good to me.

Reviewed-by: Mike Turquette <mturquette@linaro.org>

Regards,
Mike
