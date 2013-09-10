From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/5] cpufreq: Remove temporary fix for race between CPU
 hotplug and sysfs-writes
Date: Tue, 10 Sep 2013 12:39:43 +0530
Message-ID: <CAKohpon96ecA3L9ux0tnFngPbWDmrVfW3xUWf_3aZ5qYZGXLVw@mail.gmail.com>
References: <20130906195206.26919.20884.stgit@srivatsabhat.in.ibm.com>
	<20130906195353.26919.76123.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130906195353.26919.76123.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Boyd <sboyd@codeaurora.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 7 September 2013 01:23, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Commit "cpufreq: serialize calls to __cpufreq_governor()" had been a temporary
> and partial solution to the race condition between writing to a cpufreq sysfs
> file and taking a CPU offline. Now that we have a proper and complete solution
> to that problem, remove the temporary fix.
>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---

I would still vote for keeping this code or reverting this patch of yours..
As there might be other scenarios, than hotplug races, where this serialization
would be useful..

--
viresh
