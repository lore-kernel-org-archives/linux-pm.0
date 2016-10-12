From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 6/6] cpufreq: pxa: convert to clock API
Date: Wed, 12 Oct 2016 08:22:30 +0200
Message-ID: <87mvia6q8p.fsf@belgarion.home>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
        <1476130149-31834-7-git-send-email-robert.jarzmik@free.fr>
        <20161012023601.GC19385@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20161012023601.GC19385@vireshk-i7> (Viresh Kumar's message of
        "Wed, 12 Oct 2016 08:06:01 +0530")
Sender: linux-clk-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 10-10-16, 22:09, Robert Jarzmik wrote:
>> As the clock settings have been introduced into the clock pxa drivers,
>> which are now available to change the CPU clock by themselves, remove
>> the clock handling from this driver, and rely on pxa clock drivers.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>>  drivers/cpufreq/pxa2xx-cpufreq.c | 191 ++++++++-------------------------------
>>  1 file changed, 39 insertions(+), 152 deletions(-)
>
> As you mentioned in the previous patch, why can't you use cpufreq-dt
> driver now and delete this one ?

PXA architecture have both legacy platform_data based configurations and new
devicetree based ones.

I don't think cpufreq-dt can handle the legacy platform_data ones, can it ?

Cheers.

-- 
Robert
