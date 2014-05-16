From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH v2] PM / OPP: discard duplicate OPP additions
Date: Fri, 16 May 2014 14:12:02 +0530
Message-ID: <CANuQgHGPKpNYOVAgr8riULEoNr=h71OQRZLC9U193S7akM3B8g@mail.gmail.com>
References: <CAKohpo=SXFYEncSe__XQHQ588hTME7cbmS+ykeWZOOt4ESb2Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=SXFYEncSe__XQHQ588hTME7cbmS+ykeWZOOt4ESb2Pg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 16 May 2014 13:54, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 16 May 2014 13:43, Chander Kashyap <chander.kashyap@linaro.org> wrote:
>> From: Chander Kashyap <k.chander@samsung.com>
>>
>> It may be possible to unregister and re-register the cpufreq driver.
>> One such example is arm big-little IKS cpufreq driver. While
>> re-registering the driver, same OPPs may get added again.
>>
>> This patch detects the duplicacy and discards them.
>
> Diff looks fine but not the log ofcourse. It doesn't have anything to do with
> big LITTLE.. Its just a patch to avoid addition of duplicate OPPs..
>

Big little reference is provided as an example. Nothing much

> Also fix spelling mistakes in log..
>
> And subject should be:
> PM / OPP: discard duplicate OPPs

Duplicates are discarded during OPP addition, and subject line indicates that.

-- 
with warm regards,
Chander Kashyap
