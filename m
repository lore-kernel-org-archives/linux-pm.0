From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 linux-next] cpufreq: ondemand: Calculate gradient of
 CPU load to early increase frequency
Date: Wed, 3 Apr 2013 12:13:56 +0530
Message-ID: <CAKohponUuwiQ9EiKq66Mgf7zZxonxHs=DNbhx=uydDVB5bed6w@mail.gmail.com>
References: <ore61p9gvaic2j0fc083dpbd.1364970699079@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <ore61p9gvaic2j0fc083dpbd.1364970699079@email.android.com>
Sender: cpufreq-owner@vger.kernel.org
To: stratosk <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 3 April 2013 12:01, stratosk <stratosk@semaphore.gr> wrote:
> I'm sorry, I don't understand.
> The goal of this patch is not energy saving.

He probably misunderstood it...

> The goal is to detect CPU load as soon as possible to increase frequency.
>
> Could you please clarify this?

But he is looking for some numbers to prove your patch. Some numbers
that shows performance is better with your changes...
