From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 3/3] clk: keystone: Add sci-clk driver support
Date: Wed, 31 Aug 2016 15:31:01 -0700
Message-ID: <20160831223101.GI12510@codeaurora.org>
References: <20160820003342.13599-1-nm@ti.com>
 <20160820003342.13599-4-nm@ti.com>
 <20160824083415.GA6502@codeaurora.org>
 <c1a66f45-fa81-8137-4d9b-73e84141f67f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c1a66f45-fa81-8137-4d9b-73e84141f67f-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 08/31, Tero Kristo wrote:
> On 24/08/16 11:34, Stephen Boyd wrote:
> >On 08/19, Nishanth Menon wrote:
> >>diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> >>new file mode 100644
> >>index 000000000000..6c43e097e6d6
> >>--- /dev/null
> >>+++ b/drivers/clk/keystone/sci-clk.c
> >>@@ -0,0 +1,539 @@
> >>+	return (int)new_rate;
> >
> >determine rate should return a negative number on failure and 0
> >on success. The actual rate that was found should go into
> >req->rate. This looks broken.
> 
> Yea it seems broken, I wonder how we haven't seen any issues with
> this in testing.... Apparently positive return values from this are
> interpreted as success. Having a quick look at clk.c seems to
> confirm this.
> 
> Anyway, will fix.

True, perhaps we should fix that so we don't use a long to hold
the int return value either.

> >>+ *
> >>+ * Gets a handle to an existing TI SCI clock, or builds a new clock
> >>+ * entry and registers it with the common clock framework. Called from
> >>+ * the common clock framework, when a corresponding of_clk_get call is
> >>+ * executed, or recursively from itself when parsing parent clocks.
> >>+ * Returns a pointer to the clock struct, or ERR_PTR value in failure.
> >>+ */
> >
> >Please move this driver to clk_hw_register() and friends. This on
> >the fly clk generation is scary considering how we hold locks
> >while the provider is asked to give us the pointer, so allocating
> >and registering clks (basically reentering the CCF again) could
> >lead to a locking nightmare. Best to avoid that.
> 
> Ok, so just converting the driver to use provider->get_hw should be
> enough? This seems to be a relatively new API in the CCF. Will look
> at that.

Hopefully it will simplify things greatly.

> 
> >>+	}
> >>+
> >>+	snprintf(name, 20, "%s:%d:%d", dev_name(provider->dev), sci_clk->dev_id,
> >>+		 sci_clk->clk_id);
> >
> >I hope we don't make dev_name() longer than 20 characters
> 
> Shall I just increase the size of the buffer and add a length check?
> Using kmalloc or something here seems overkill, as the name gets
> copied by CCF anyway.

There's kasprintf() which would always make it long enough. I
don't know if it really matters though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
