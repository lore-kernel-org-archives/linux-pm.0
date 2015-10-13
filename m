From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH] CPPC: Add a CPUFreq driver for use with CPPC
Date: Tue, 13 Oct 2015 05:17:35 -0400
Message-ID: <CAJ5Y-ebscpSSg4s0T_8PySMxWAF5O1piDfhUQPS10M1sZ-rTEg@mail.gmail.com>
References: <6d24b51b0387f4ef6cc4a2517ace2e5e9731d7be.1441830300.git.ashwin.chaugule@linaro.org>
 <1443794641-6960-1-git-send-email-ashwin.chaugule@linaro.org>
 <5435965.g6l5q97a6S@vostro.rjw.lan> <1714977.kqYb6jVT6F@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1714977.kqYb6jVT6F@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 12 October 2015 at 17:34, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, October 12, 2015 11:23:01 PM Rafael J. Wysocki wrote:
>> On Friday, October 02, 2015 10:04:01 AM Ashwin Chaugule wrote:
>> > This driver utilizes the methods introduced in a previous
>> > patch titled - "ACPI: Introduce CPU performance controls using CPPC"
>> > and enables usage with existing CPUFreq governors.
>> >
>> > Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> > Reviewed-by: Al Stone <al.stone@linaro.org>
>>
>> This doesn't seem to apply for me, care to refresh (on top of my
>> bleeding-edge branch)?
>
> Never mind, I've resolved this already.

Guessing some Makefile conflict. Thanks though!

Regards,
Ashwin.
