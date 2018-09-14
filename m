From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] drivers/base: move device_shutdown() to base/power
Date: Fri, 14 Sep 2018 11:07:57 +0200
Message-ID: <76851595.dP8mLy4DGX@aspire.rjw.lan>
References: <1534756717-25553-1-git-send-email-kernelfans@gmail.com> <1534756717-25553-2-git-send-email-kernelfans@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534756717-25553-2-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, August 20, 2018 11:18:35 AM CEST Pingfan Liu wrote:
> Consider the shutdown as a system state transition, i.e. something like
> suspend, hibernate, hence move it under the base/power. (This is a first
> step to unify the duplicate code logic on devices_kset and dpm_list.)

I don't really think that device_shutodwn() belongs in base/power/.

Moving it to a separate file sounds like a good idea, but let that file
reside in base/ proper.

Then, I would separate the dpm_list definition, locking etc out of
base/power/, move it to the new file containing device_shutdown() and
make the code in base/power/ refer to it (you may want to move the list
entry list head from dev_pm_info to struct device directly while at that
too).

Then, it should be straightforward enough to switch device_shutdown() over to
using it.

Thanks,
Rafael
