From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [Query] CPUFreq: Why do we need policy->user_policy?
Date: Mon, 26 Aug 2013 20:00:52 +0530
Message-ID: <CAKohponkO6oZrvrsUGVK0uUbAM5wse7eHd7udtWkab7y2aatGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

I am almost done with cleanup of drivers and am back at cpufreq core.. :)
I got to this structure: struct cpufreq_real_policy;

And I am not able to understand what's the need for this structure?
Can you let me know? Before I try to get rid of it :)

--
viresh
