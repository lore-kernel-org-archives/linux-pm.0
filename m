From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: discard duplicate OPP additions
Date: Tue, 13 May 2014 13:52:51 +0530
Message-ID: <CAKohpo=6qXer+RRS-F6x=O1VLzbWq+_a-b29MaUzZBvt7XzDwQ@mail.gmail.com>
References: <1399966890-22926-1-git-send-email-k.chander@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399966890-22926-1-git-send-email-k.chander@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "[Chander Kashyap" <chander.kashyap@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 13 May 2014 13:11, [Chander Kashyap <chander.kashyap@linaro.org> wrote:

What happened to your name ? "["

> From: Chander Kashyap <k.chander@samsung.com>
>
> It may be possible to unregister and re-register the cpufreq driver.
> One such example is arm big-little IKS cpufreq driver. While
> re-registering the driver, same OPPs may get added again.
>
> This patch detects the duplicacy and discards them.
>
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
> ---
>  drivers/base/power/opp.c |   28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)

I wouldn't say that this approach is particularly bad or wrong, but what
about this instead?

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 2553867..7efdaf3 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -713,6 +713,11 @@ int of_init_opp_table(struct device *dev)
        const __be32 *val;
        int nr;

+       if (!IS_ERR(find_device_opp(dev))) {
+               dev_warn("%s: opp table already exists\n", __func__);
+               return -EEXIST;
+       }
+
        prop = of_find_property(dev->of_node, "operating-points", NULL);
        if (!prop)
                return -ENODEV;
