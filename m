From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3] PM / sleep: don't suspend parent when async child
 suspend_{noirq,late} fails
Date: Wed, 9 Nov 2016 18:00:29 -0800
Message-ID: <20161110020028.GA141513@google.com>
References: <1477584334-39956-1-git-send-email-briannorris@chromium.org>
 <1478740868-55269-1-git-send-email-briannorris@chromium.org>
 <CAJZ5v0j818ApkM+0aKDuaAKv6-GezuEGFLDd+UH16Kf6BUqWjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j818ApkM+0aKDuaAKv6-GezuEGFLDd+UH16Kf6BUqWjg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Linux PM <linux-pm@vger.kernel.org>, Chuansheng Liu <chuansheng.liu@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 10, 2016 at 02:53:20AM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 10, 2016 at 2:21 AM, Brian Norris <briannorris@chromium.org> wrote:
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index c58563581345..57a8ca4bc8ab 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1027,6 +1027,8 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
> >         TRACE_DEVICE(dev);
> >         TRACE_SUSPEND(0);
> >
> > +       dpm_wait_for_children(dev, async);
> > +
> 
> On a second thought. I'd move the
> 
> if (dev->power.syscore || dev->power.direct_complete)
> 
> along with this (and put it in front), because those flags won't
> change while children are being waited on anyway.

I can do that, but is it really necessary? It's also not the order we do
it for __device_suspend(). I don't like arbitrarily making optimizations
in this code differently to the non-{noirq,late} versions.

Also, would it cause any problem to have a parent return success before
its children have suspended? I haven't reasoned through all the cases
there, but I wouldn't do that without reason.

Brian
