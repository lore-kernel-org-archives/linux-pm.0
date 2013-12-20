From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: remove sysfs files for CPU which failed to come
 back after resume
Date: Fri, 20 Dec 2013 21:26:35 +0530
Message-ID: <CAKohpo=pBUCXNUce6DiZAJU4yshVJdPiKfMWk77nKHGuMusqgA@mail.gmail.com>
References: <c6b53b186145559668722120ea1f37d28ddb3177.1387516043.git.viresh.kumar@linaro.org>
	<2118684.kuZSLHD0UA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2118684.kuZSLHD0UA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 20 December 2013 20:44, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Well, this just looks odd.  Please do
>
>         return sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");

Yeah, that was stupid :)
