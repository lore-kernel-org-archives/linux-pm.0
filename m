From: Kevin Cernekee <cernekee@chromium.org>
Subject: Re: [PATCH v2] PM / sleep: add configurable delay for pm_test
Date: Sun, 22 Feb 2015 07:17:54 -0800
Message-ID: <CAJiQ=7CWO9MbvQi0jdrEfektk1sxA4ieQg40H-pxcuwnK=Bx7Q@mail.gmail.com>
References: <1409788535-28264-1-git-send-email-computersforpeace@gmail.com>
 <20150222082654.GB24441@norris-Latitude-E6410> <20150222122754.GA7955@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150222122754.GA7955@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Brian Norris <computersforpeace@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Chirantan Ekbote <chirantan@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 22, 2015 at 4:27 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Sun 2015-02-22 00:26:54, Brian Norris wrote:
>> When CONFIG_PM_DEBUG=y, we provide a sysfs file (/sys/power/pm_test) for
>> selecting one of a few suspend test modes, where rather than entering a
>> full suspend state, the kernel will perform some subset of suspend
>> steps, wait 5 seconds, and then resume back to normal operation.
>>
>> This mode is useful for (among other things) observing the state of the
>> system just before entering a sleep mode, for debugging or analysis
>> purposes. However, a constant 5 second wait is not sufficient for some
>> sorts of analysis; for example, on an SoC, one might want to use
>> external tools to probe the power states of various on-chip controllers
>> or clocks.
>>
>> This patch turns this 5 second delay into a configurable module
>> parameter, so users can determine how long to wait in this
>> pseudo-suspend state before resuming the system.
>>
>> Example (wait 30 seconds);
>>
>>   # echo 30 > /sys/module/suspend/parameters/pm_test_delay
>>   # echo core > /sys/power/pm_test
>>   # time echo mem  > /sys/power/state
>>   ...
>>   [   17.583625] suspend debug: Waiting for 30 second(s).
>>   ...
>>   real        0m30.381s
>>   user        0m0.017s
>>   sys 0m0.080s
>>
>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> (Does this need documentation in kernel-parameters.txt or in place
> where pm_test is documented?)

Perhaps both places?  Documentation/power/basic-pm-debugging.txt still
has the "wait 5 seconds" verbiage.

Beyond that, it looks good to me:

Reviewed-by: Kevin Cernekee <cernekee@chromium.org>
