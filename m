From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] PM / OPP: discard duplicate OPPs
Date: Tue, 20 May 2014 17:35:04 +0530
Message-ID: <CAKohpomKvPcioNmfzvx7vqJHqs_TrhnHH6yYb5w_0f+YvA5hvA@mail.gmail.com>
References: <1400230809-11401-1-git-send-email-chander.kashyap@linaro.org>
	<537A0247.1030503@ti.com>
	<CAKohpoknoFuz8qnDpunA7oxr5E_18=+EQsFEy0P39fcU=4Ps9w@mail.gmail.com>
	<CAGo_u6o+Vysq0LkdFTrP82WOpS1TT-=MD+zgP+Q_L=3RV8x5hA@mail.gmail.com>
	<CAKohponAx=Hi_Ywgg4hXxrpmmaqy5=pYnb3nSBNUP3KtADTEeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohponAx=Hi_Ywgg4hXxrpmmaqy5=pYnb3nSBNUP3KtADTEeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 20 May 2014 16:56, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> But we aren't talking about failure here. Its not failure. The operation
> we are trying to do is already done and nothing should break if the
> OPP was already there or its added now. Its all the same.

Though after more thought into this I feel this must also be done:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index bdf09f5..3f540d8 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -453,9 +453,13 @@ int dev_pm_opp_add(struct device *dev, unsigned
long freq, unsigned long u_volt)
        }

        if (new_opp->rate == opp->rate) {
+               int ret = 0;
+
+               if (new_opp->u_volt == opp->u_volt)
+                       ret = -EEXIST;
                mutex_unlock(&dev_opp_list_lock);
                kfree(new_opp);
-               return 0;
+               return ret;
        }

        list_add_rcu(&new_opp->node, head);
