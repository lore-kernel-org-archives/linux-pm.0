From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 linux-next] cpufreq: ondemand: Calculate gradient of
 CPU load to early increase frequency
Date: Thu, 4 Apr 2013 12:21:09 +0530
Message-ID: <CAKohpok2ubQmpmim2p7aE_T3N-+4CVwf31M=-kyb00UTC7hALw@mail.gmail.com>
References: <c47p1i8x8eiep3wulmq44fxd.1365058077739@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c47p1i8x8eiep3wulmq44fxd.1365058077739@email.android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stratosk <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 4 April 2013 12:17, stratosk <stratosk@semaphore.gr> wrote:
> Why do you suspect significant increased power? With ondemand  the CPU will go down to lowest freq as soon as the load will decreased. And the measurement shows that the CPU load will decrease faster (because of faster calculation).

I suspect it because we are increasing freq based on the assumption:
"If increase in load from last calculation is more then threshold, then
we must use high freq"..

So, this rise can be false alarm multiple times and we might not see
a load increase after moving to high freq and so we are running at
high/max freq without any need of it. And so more power.
