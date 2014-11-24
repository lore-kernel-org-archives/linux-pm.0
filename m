From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2] thermal:core:fix: Check return code of the
 ->get_max_state() callback
Date: Mon, 24 Nov 2014 15:24:49 +0100
Message-ID: <20141124152449.595d5d34@amdc2363>
References: <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
 <1416305790-27746-1-git-send-email-l.majewski@samsung.com>
 <20141121180826.GA3331@developer> <20141124113854.36975fb2@amdc2363>
 <CAKohpok3pTEk05L7t+o6BYoODnBboAegg1o9dAj8=VOk8G7odQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKohpok3pTEk05L7t+o6BYoODnBboAegg1o9dAj8=VOk8G7odQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux PM list <linux-pm@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@st.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

> On 24 November 2014 at 16:08, Lukasz Majewski
> <l.majewski@samsung.com> wrote:
> > As I look into the cpufreq-dt.c driver - in the cpufreq_init()
> > function, the call to of_cpufreq_cooling_register() is performed
> > just before cpufreq_table_validate_and_show().
> > It looks like a mistake in the cpufreq-dt.c code.
> 
> Yes. Just fixed it up and sent a patch. Please provide your
> tested-by's..

Thanks for your prompt response. I don't have board which uses both
of-thermal.c and cpufreq-dt.c (exynos uses old approach for cpufreq).

I think that Eduardo may have some boards for testing.

Regarding the patch:
Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
