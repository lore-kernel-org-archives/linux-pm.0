From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 07/11] cpufreq: Use cpufreq_policy_list for iterating
 over policies
Date: Tue, 20 Aug 2013 12:03:17 +0530
Message-ID: <CAKohpo=cnq_heq7RtPqbA5sSB_OWiNcFnXA_E4VfZn-6Ur=ThA@mail.gmail.com>
References: <cover.1375809311.git.viresh.kumar@linaro.org>
	<1582060.zfvsylJcxu@vostro.rjw.lan>
	<CAKohponkLac2GzZ5-PRoTzdx8EhuCWT-eafRtYhkJ6cN_WrXSA@mail.gmail.com>
	<6607838.UAT3ZUDseh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <6607838.UAT3ZUDseh@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 20 August 2013 04:52, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From my experience, however, it is good to figure out what needs to be included
> into your test kernel and configure away everything else.  Also, I'd recommend
> to build as much as possible into the kernel image and avoid compiling too many
> modules, because installing modules takes time too (ideally, if you can get
> away without any modules at all, that's the best option timing-wise).  Just
> select only the drivers that you're going to use and unset all of the options
> that don't apply to your test machine.

I haven't done this exercise yet but I have a workable solution with default
.config as suggested by Amit :)
