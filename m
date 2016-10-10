From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v5 0/5] Functional dependencies between devices
Date: Mon, 10 Oct 2016 14:36:31 +0200
Message-ID: <13957403.ZrB4mMbICz@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <27296716.H9VWo8ShOm@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

Hi Everyone,

> On Thursday, September 08, 2016 11:25:44 PM Rafael J. Wysocki wrote:
> 

[cut]

> 
> Time for another update. :-)
> 
> Fewer changes this time, mostly to address issues found by Lukas and Marek.
> 
> The most significant one is to make device_link_add() cope with the case
> when
> the consumer device has not been registered yet when it is called.  The
> supplier device still is required to be registered and the function will
> return NULL if that is not the case.
> 
> Another significant change is in patch [4/5] that now makes the core apply
> pm_runtime_get_sync()/pm_runtime_put() to supplier devices around the
> probing of a consumer one (in analogy with the parent).

One more update after some conversations during LinuxCon Europe.

The main point was to make it possible for device_link_add() to figure out the
initial state of the link instead of expecting the caller to provide it which
might not be reliable enough in general.

In this version device_link_add() takes three arguments, the supplier and
consumer pointers and flags and it sets the correct initial state of the link
automatically (unless invoked with the "stateless" flag, of course).  The cost
is one additional field in struct device (I moved all of the links-related
fields in struct device to a separate sub-structure while at it) to track
the "driver presence status" of the device (to be used by device_link_add()).

In addition to that, the links list walks in the core.c and dd.c code are
under the device links mutex now, so the iternal link spinlock is not needed
any more and I have renamed symbols to distinguish between flags, link states
and device "driver presence statuses".

More information is there in the changelogs.

Thanks,
Rafael
