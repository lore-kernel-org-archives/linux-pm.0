From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] PM / OPP: discard duplicate OPP additions
Date: Fri, 16 May 2014 13:54:03 +0530
Message-ID: <CAKohpo=SXFYEncSe__XQHQ588hTME7cbmS+ykeWZOOt4ESb2Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 16 May 2014 13:43, Chander Kashyap <chander.kashyap@linaro.org> wrote:
> From: Chander Kashyap <k.chander@samsung.com>
>
> It may be possible to unregister and re-register the cpufreq driver.
> One such example is arm big-little IKS cpufreq driver. While
> re-registering the driver, same OPPs may get added again.
>
> This patch detects the duplicacy and discards them.

Diff looks fine but not the log ofcourse. It doesn't have anything to do with
big LITTLE.. Its just a patch to avoid addition of duplicate OPPs..

Also fix spelling mistakes in log..

And subject should be:
PM / OPP: discard duplicate OPPs
