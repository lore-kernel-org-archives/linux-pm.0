From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/2] cpufreq: Mark x86 drivers with CPUFREQ_SKIP_INITIAL_FREQ_CHECK
 flag
Date: Fri, 29 Nov 2013 19:45:11 +0530
Message-ID: <CAOh2x=mqY5V2SyxmwQ-NePpQaAnpq_hKadNqaNKQQd+zxPL-0w@mail.gmail.com>
References: <0596aca2267741a8be74db4d19a191c417779629.1385698209.git.viresh.kumar@linaro.org>
	<697e564b93d1662514ac69e9c926904d3ff4f206.1385698209.git.viresh.kumar@linaro.org>
	<2707481.i2fpomAdZe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2707481.i2fpomAdZe@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, patches@linaro.org, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, ceh@ti.com
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 29, 2013 at 7:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> I think you haven't missed any of them.
>
> That said, you need to do this in patch [1/2], or the kernel between
> patches [1/2] and [2/2] may be broken on some systems.
>
> If you want to do that in separate patches, the current [2/2] should be
> [1/2] and vice versa.
>
> I guess they will apply in the reverse order?

No, definition of CPUFREQ_SKIP_INITIAL_FREQ_CHECK would be
missing then after the first patch..

Anyway, I have fixed that and resent them now..
