From: Pingfan Liu <kernelfans@gmail.com>
Subject: Re: [PATCH 1/3] drivers/base: move device_shutdown() to base/power
Date: Wed, 19 Sep 2018 11:56:50 +0800
Message-ID: <CAFgQCTsy-PGogprdVEApnpBuJzDkhiE42MGrYjE-UOpXDkNP_Q@mail.gmail.com>
References: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
 <1534756717-25553-2-git-send-email-kernelfans@gmail.com> <76851595.dP8mLy4DGX@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <76851595.dP8mLy4DGX@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 14, 2018 at 5:10 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, August 20, 2018 11:18:35 AM CEST Pingfan Liu wrote:
> > Consider the shutdown as a system state transition, i.e. something like
> > suspend, hibernate, hence move it under the base/power. (This is a first
> > step to unify the duplicate code logic on devices_kset and dpm_list.)
>
> I don't really think that device_shutodwn() belongs in base/power/.
>
> Moving it to a separate file sounds like a good idea, but let that file
> reside in base/ proper.
>
> Then, I would separate the dpm_list definition, locking etc out of
> base/power/, move it to the new file containing device_shutdown() and
> make the code in base/power/ refer to it (you may want to move the list
> entry list head from dev_pm_info to struct device directly while at that
> too).
>
> Then, it should be straightforward enough to switch device_shutdown() over to
> using it.
>
Thanks for your advice. I will find a time slot to redo it.

Regards,
Pingfan
