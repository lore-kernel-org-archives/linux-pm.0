From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 7/7] USB / PM: Allow USB devices to remain runtime-suspended when sleeping
Date: Fri, 03 Apr 2015 23:23:32 +0200
Message-ID: <1670645.XN7urnStQD@vostro.rjw.lan>
References: <1428065887-16017-1-git-send-email-tomeu.vizoso@collabora.com> <1428065887-16017-8-git-send-email-tomeu.vizoso@collabora.com> <20150403204436.GB19867@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150403204436.GB19867@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Scot Doyle <lkml14@scotdoyle.com>, Alan Stern <stern@rowland.harvard.edu>, Dan Williams <dan.j.williams@intel.com>, Julius Werner <jwerner@chromium.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Pratyush Anand <pratyush.anand@st.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, April 03, 2015 01:44:36 PM Dmitry Torokhov wrote:
> Hi Tomeu,
> 
> On Fri, Apr 03, 2015 at 02:57:56PM +0200, Tomeu Vizoso wrote:
> > Have dev_pm_ops.prepare return 1 for USB devices, interfaces, endpoints
> > and ports so that USB devices can remain runtime-suspended when the
> > system goes to a sleep state, if their wakeup state is correct.
> > 
> > Also enable runtime PM for endpoints, which is another requirement for
> > the above to work.
> 
> After patching I think the 4th unrelated subsystem with stubs for
> prepare() I think it is pretty clear that this approach is not the right
> one.
> 
> If your driver does not care about any children hanging off it there is
> dev->ignore_children flag that either already does what you want, or
> maybe needs adjusted to support your use case.

I wouldn't overload ignore_children with that meaning.  That said adding
a "return 1 from device_prepare() if this is set" flag might be a good idea.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
