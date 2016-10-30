From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 0/5] Functional dependencies between devices
Date: Sun, 30 Oct 2016 17:40:36 +0100
Message-ID: <3608562.cb5YkXLsMf@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <11468990.WB1J8sxXpS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11468990.WB1J8sxXpS@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

On Sunday, October 30, 2016 05:22:13 PM Rafael J. Wysocki wrote:
> Hi,
> 
> Let me quote from the previous intro messages for this series first:
> 
> > > Time for another update. :-)
> > > 
> > > Fewer changes this time, mostly to address issues found by Lukas and
> > > Marek.
> > > 
> > > The most significant one is to make device_link_add() cope with the case
> > > when
> > > the consumer device has not been registered yet when it is called.  The
> > > supplier device still is required to be registered and the function will
> > > return NULL if that is not the case.
> > > 
> > > Another significant change is in patch [4/5] that now makes the core apply
> > > pm_runtime_get_sync()/pm_runtime_put() to supplier devices around the
> > > probing of a consumer one (in analogy with the parent).
> > 
> > One more update after some conversations during LinuxCon Europe.
> > 
> > The main point was to make it possible for device_link_add() to figure out
> > the initial state of the link instead of expecting the caller to provide it
> > which might not be reliable enough in general.
> > 
> > In this version device_link_add() takes three arguments, the supplier and
> > consumer pointers and flags and it sets the correct initial state of the
> > link automatically (unless invoked with the "stateless" flag, of course).
> > The cost is one additional field in struct device (I moved all of the
> > links-related fields in struct device to a separate sub-structure while at
> > it) to track the "driver presence status" of the device (to be used by
> > device_link_add()).
> > 
> > In addition to that, the links list walks in the core.c and dd.c code are
> > under the device links mutex now, so the iternal link spinlock is not needed
> > any more and I have renamed symbols to distinguish between flags, link
> > states and device "driver presence statuses".
> 
> The most significant change in this revision with respect to the previous one is
> related to the fact that SRCU is not available on some architectures, so the
> code falls back to using an RW semaphore for synchronization if SRCU is not
> there.  Fortunately, the code changes needed for that turned out to be quite
> straightforward and confined to the second patch.
> 
> Apart from this, the flags are defined using BIT(x) now (instead of open coding
> the latter in the flag definitions).
> 
> Updated is mostly patch [2/5].  Patches [1,3,5/5] have not changed (except for
> trivial rebasing) and patch [4/5] needed to be refreshed on top of the modified
> [2/5].
> 
> FWIW, I've run the series through 0-day which has not reported any problems
> with it.

BTW, the series is available from the device-links-test branch in my tree:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git device-links-test

in case someone wants to try it out.

Thanks,
Rafael
