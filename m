From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Async runtime put in __device_release_driver()
Date: Tue, 5 Nov 2013 22:29:49 +0100
Message-ID: <CAPDyKFp0UGjEbn+pWDLKOQvKsxeXSh5hY3++TA1rpErfihOtPA@mail.gmail.com>
References: <5267A0DF.7080604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5267A0DF.7080604@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Archit Taneja <archit@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 23 October 2013 12:11, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
> I was debugging why clocks were left enabled after removing omapdss
> driver, and I found this commit:
>
> fa180eb448fa263cf18dd930143b515d27d70d7b (PM / Runtime: Idle devices
> asynchronously after probe|release)
>
> I don't understand how that is supposed to work.
>
> When a driver is removed, instead of using pm_runtime_put_sync() the
> commit uses pm_runtime_put(), so the runtime_suspend call is queued. But
> who is going to handle the queued suspend call, as the driver is already
> removed? At least in my case, obviously nobody, as I only get
> runtime_resume call in my driver, never the runtime_suspend.
>
> Is there something I need to add to my driver to make this work, or
> should that part of the patch be reverted?

I believe it is quite common that a device driver calls
pm_runtime_get_sync as a part of it's remove callback, then it
explicitly returns it's resources that has been fetched during probe.
Like a clk_disable_unprepare for example.

The idea behind the change in __device_release_driver, was to try to
prevent  devices from going active->idle->active and instead just
remain active (if possible).

In your case, which seems like a more modern way of implementing
"remove", you shall call "pm_runtime_suspend" to make sure the
runtime_suspend callbacks gets called.

Kind regards
Ulf Hansson

>
>  Tomi
>
