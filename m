From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/6] cpufreq: Remove cpufreq_frequency_get_table()
Date: Thu, 2 Jun 2016 21:06:26 +0530
Message-ID: <CAKohponBAEZMhiVPNKqbY3nHAT9uB=7rK=SvVaf4jfgMPPft9w@mail.gmail.com>
References: <cover.1464876229.git.viresh.kumar@linaro.org>
	<13d43ddfe208a9b387fe0fd247de069ba0332308.1464876229.git.viresh.kumar@linaro.org>
	<20160602145903.GA2966@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602145903.GA2966@e104805>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2 June 2016 at 20:29, Javi Merino <javi.merino@arm.com> wrote:
> In 5a31d594a973 ("cpufreq: Allow freq_table to be obtained for offline
> CPUs") you did the opposite: don't use cpufreq_cpu_get_raw() because
> it won't give you the policy of a cpu that is offline.  Now you are
> arguing that we should go back to cpufreq_cpu_get() which implicitly
> calls cpufreq_cpu_get_raw().  Won't we hit the same issue that
> 5a31d594a973 was trying to prevent: that we can't get a freq_table for
> a cpu that is offline?

Yes, that should be fixed. Thanks for letting me know about it :)
