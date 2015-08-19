From: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v2 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Wed, 19 Aug 2015 08:02:37 +0800
Message-ID: <20150819000236.GA23719@shlinux2>
References: <20150818052011.GF1864@shlinux2>
 <20150818161200.GK10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150818161200.GK10748-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sojka-Knnw/vAvyUalVyrhU4qvOw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 18, 2015 at 09:12:00AM -0700, Mark Brown wrote:
> On Tue, Aug 18, 2015 at 01:20:12PM +0800, Peter Chen wrote:
> 
> > ok, I just had suspected below function's correctness, after looking
> > it again, it always set 1800 as charging limit, does it be expected?
> 
> > +       /* Find the highest supported limit */
> > +       best = 0;
> > +       for (i = 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
> > +               if (limit < wm831x_usb_limits[i] &&
> 

+/* In miliamps */
+static unsigned int wm831x_usb_limits[] = {
+       0,
+       2,
+       100,
+       500,
+       900,
+       1500,
+       1800,
+       550,
+};
+
+static int wm831x_usb_limit_change(struct notifier_block *nb,
+                                  unsigned long limit, void *data)
+{
+       struct wm831x_power *wm831x_power = container_of(nb,
+                                                        struct wm831x_power,
+                                                        usb_notify);
+       int i, best;
+
+       /* Find the highest supported limit */
+       best = 0;
+       for (i = 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
+               if (limit < wm831x_usb_limits[i] &&
+                   wm831x_usb_limits[best] < wm831x_usb_limits[i])
+                       best = i;
+       }
+
+       dev_dbg(wm831x_power->wm831x->dev,
+               "Limiting USB current to %dmA", wm831x_usb_limits[best]);
+
+       wm831x_set_bits(wm831x_power->wm831x, WM831X_POWER_STATE,
+                       WM831X_USB_ILIM_MASK, best);
+
+       return 0;
+}
+

> The above check is intended to ensure that we don't go over the limit
> that was passed in in the callback.  The goal is to select the highest
> option that is less than the limit passed in.

Please correct me if I was wrong, If there is SDP (PC), the current
limit is 500mA, then when the i = 4, (500 < 900) && (0 < 900) is true,
the best is 4. When the i goes to 5, (500 < 1500) && (900 < 1500) is
true, the best is 5. At last, the best will be 1800, which is not our
expectation.

Below code may be correct for the goal you expressed.

       for (i = 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
               if (limit >= wm831x_usb_limits[i] &&
                   wm831x_usb_limits[best] < wm831x_usb_limits[i])
                       best = i;
       }

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
