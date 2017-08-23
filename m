From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: Convert to using %pOF instead of full_name
Date: Wed, 23 Aug 2017 22:34:11 +0200
Message-ID: <CAJZ5v0groP7jZRgRK5egHfCU+nMDb7zVw6P2HRv5L_ArDB5+kg@mail.gmail.com>
References: <20170718214339.7774-15-robh@kernel.org> <CAL_JsqJVrCHsj23GQrbsAuVkwsnMEOA0QFLN5hjBNrSBZ=yZog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJVrCHsj23GQrbsAuVkwsnMEOA0QFLN5hjBNrSBZ=yZog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 23, 2017 at 8:14 PM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jul 18, 2017 at 4:42 PM, Rob Herring <robh@kernel.org> wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> ---
>>  drivers/cpuidle/dt_idle_states.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> Rafael, Ping. Please apply this one and 2 others for cpufreq and
> PM-domains which haven't been applied yet.

I thought that these would go in through the DT tree.

I'll try to find them, but next time please make it clear how you want
to route things.

Thanks,
Rafael
