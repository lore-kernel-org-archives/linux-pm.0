From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH v2 linux-next] cpufreq: governors: Calculate iowait time
 only when necessary
Date: Fri, 22 Mar 2013 09:12:49 +0200
Message-ID: <514C0471.5000306@semaphore.gr>
References: <512E45E9.5020801@semaphore.gr> <512F8C7C.2020101@semaphore.gr> <CAKohponkj++4AkW__i7vWykURkAkgiHGLMX973KWMjQw9sTQYg@mail.gmail.com> <1776032.T2F0vtOmT3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1776032.T2F0vtOmT3@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/22/2013 01:54 AM, Rafael J. Wysocki wrote:
> 
> Applied to linux-pm.git/bleeding-edge and will be moved to linux-next if there
> are no build problems in the bleeding-edge branch.
> 
> Thanks,
> Rafael

Hi Rafael,

I just noticed a regression with this patch with the calculation of wall time
in get get_cpu_idle_time that prevents the CPU to increase to max frequency,
when we use ondemand with io_is_busy = 1.

I'm sorry about that, I'm sending a patch to fix it.

Regards,
Stratos 

