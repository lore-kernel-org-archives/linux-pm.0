From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Make sure CPU is running on a freq from freq-table
Date: Thu, 28 Nov 2013 19:44:02 +0530
Message-ID: <CAKohpomDu0Xh8Q1PEo3n+JwE26GkJTxhdezGPs7aJwJXjaTvLQ@mail.gmail.com>
References: <046513da96dfec919a1a41d270c167147d4a9c8d.1385353358.git.viresh.kumar@linaro.org>
	<14305907.pSqK27Oikr@vostro.rjw.lan>
	<CAKohpokyY0ueNXBQn+Vt5A9V65_ko7D5R=iruUzi6cD9YuXOig@mail.gmail.com>
	<2065797.S0ijuuXCoe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2065797.S0ijuuXCoe@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Carlos Hernandez <ceh@ti.com>
List-Id: linux-pm@vger.kernel.org

On 28 November 2013 19:42, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, November 28, 2013 07:11:17 PM Viresh Kumar wrote:
>> Okay.. So wouldn't it be better that we add this special flag only when we
>> face a real problem? Otherwise this flag might stay unused for long time
>> and then we might end up removing it..

What about this one?

> SKIP_INITIAL_FREQUENCY_CHECK ?

Looks fine.. In case this is required, you want this to be set initially for any
driver?
