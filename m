From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Return error if ->get() failed in cpufreq_update_policy()
Date: Tue, 25 Feb 2014 20:12:52 +0530
Message-ID: <CAKohpom+RUAi0jZBVWUEWZh36O4QgoJcK-YrCq6eDnfMVf+GCg@mail.gmail.com>
References: <15ccc0609cb9ee3db0ad3a95b29bf69d11ea197c.1392375504.git.viresh.kumar@linaro.org>
	<530C2FD7.4000105@linux.vnet.ibm.com>
	<CAKohponr5b8nBaV9TFiiFkvyg8Qb6qz_0UXbYCaFRPG=XP28rA@mail.gmail.com>
	<3894986.dK3STNSG71@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <3894986.dK3STNSG71@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pierre Ossman <pierre-list@ossman.eu>
List-Id: linux-pm@vger.kernel.org

On 25 February 2014 18:40, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Well, why exactly does the core need to operate "current frequency" at all?

I don't think I understood what you meant here. Do you mean why should
we maintain policy->cur?
