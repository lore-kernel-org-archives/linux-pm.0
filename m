From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v4 0/5] Functional dependencies between devices
Date: Thu, 29 Sep 2016 02:24:58 +0200
Message-ID: <10860219.QqH5akBVoh@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48157 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1752209AbcI2Afe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2016 20:35:34 -0400
In-Reply-To: <27296716.H9VWo8ShOm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

Hi Everyone,

On Thursday, September 08, 2016 11:25:44 PM Rafael J. Wysocki wrote:
> > Hi Everyone,
> > 
> > This is a refresh of the functional dependencies series that I posted last
> > year and which has picked up by Marek quite recently.  For reference,
> > appended is my introductory message sent previously (which may be
> > slightly outdated now).
> > 
> > As last time, the first patch rearranges the code around
> > __device_release_driver() a bit to prepare it for the next one (it
> > actually hasn't changed AFAICS).
> > 
> > The second patch introduces the actual device links mechanics, but without
> > system suspend/resume and runtime PM support which are added by the
> > subsequent patches.
> > 
> > Some bugs found by Marek during his work on these patches should be fixed
> > here.  In particular, the endless recursion in device_reorder_to_tail()
> > which simply was broken before.
> > 
> > There are two additional patches to address the issue with runtime PM
> > support
> > that occured when runtime PM was disabled for some suppliers due to a PM
> > sleep transition in progress.  Those patches simply make runtime PM
> > helpers
> > return 0 in that case which may be controversial, so please let me know if
> > there are concerns about those.
> > 
> > The way device_link_add() works is a bit different, as it takes an
> > additional
> > status argument now.  That makes it possible to create a link in any
> > state,
> > with extra care of course, and should address the problem pointed to by
> > Lukas
> > during the previous discussion.
> > 
> > Also some comments from Tomeu have been addressed.
> 
> An update here.
> 
> The first patch hasn't changed, so I'm resending it.
> 
> The majority of changes in the other patches are in order to address Lukas'
> comments.
> 
> First off, I added a DEVICE_LINK_STATELESS flag that will prevent the driver
> core from trying to maintain device links having it set.
> 
> Also, the DEVICE_LINK_PERSISTENT flag was dropped (as link "persistence" is
> the default behavior now) and there's a new one, DEVICE_LINK_AUTOREMOVE,
> that will cause the driver core to remove the link on the consumer driver
> unbind.
> 
> Moreover, the code checks attempts to create a link between a parent and a
> child device now and actively prevents that from happening.
> 
> The changelog of the second patch has been updated as requested by Ulf.
> 
> The third patch was updated to fix a bug related to the (previously missing)
> clearing of power.direct_complete for supplier devices having consumers that
> don't use direct_complete.
> 
> The next two (runtime PM) patches turned out to be unnecessary, so I've
> dropped them.
> 
> The runtime PM patch [4/5] was reorganized somewhat to reduce the
> indentation
> level in there, but the code flow introduced by it is essentially the same
> and the last patch was simply rebased on top of the new series.

Time for another update. :-)

Fewer changes this time, mostly to address issues found by Lukas and Marek.

The most significant one is to make device_link_add() cope with the case when
the consumer device has not been registered yet when it is called.  The
supplier device still is required to be registered and the function will return
NULL if that is not the case.

Another significant change is in patch [4/5] that now makes the core apply
pm_runtime_get_sync()/pm_runtime_put() to supplier devices around the probing
of a consumer one (in analogy with the parent).

Thanks,
Rafael

