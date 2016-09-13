From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v2 0/7] Functional dependencies between devices
Date: Wed, 14 Sep 2016 00:41:33 +0200
Message-ID: <7509218.TxKN3m4AN5@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <CGME20160913095858eucas1p267ec2397c9e4577f94557e4a38498164@eucas1p2.samsung.com> <291f428a-da27-1c69-b0fb-c78f7a4665eb@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65439 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S932581AbcIMWf1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 18:35:27 -0400
In-Reply-To: <291f428a-da27-1c69-b0fb-c78f7a4665eb@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.og>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Tuesday, September 13, 2016 11:58:56 AM Marek Szyprowski wrote:
> Hi Rafael,
> 
> 
> On 2016-09-08 23:25, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This is a refresh of the functional dependencies series that I posted last
> > year and which has picked up by Marek quite recently.  For reference, appended
> > is my introductory message sent previously (which may be slightly outdated now).
> >
> > As last time, the first patch rearranges the code around __device_release_driver()
> > a bit to prepare it for the next one (it actually hasn't changed AFAICS).
> >
> > The second patch introduces the actual device links mechanics, but without
> > system suspend/resume and runtime PM support which are added by the subsequent
> > patches.
> >
> > Some bugs found by Marek during his work on these patches should be fixed
> > here.  In particular, the endless recursion in device_reorder_to_tail()
> > which simply was broken before.
> >
> > There are two additional patches to address the issue with runtime PM support
> > that occured when runtime PM was disabled for some suppliers due to a PM
> > sleep transition in progress.  Those patches simply make runtime PM helpers
> > return 0 in that case which may be controversial, so please let me know if
> > there are concerns about those.
> >
> > The way device_link_add() works is a bit different, as it takes an additional
> > status argument now.  That makes it possible to create a link in any state,
> > with extra care of course, and should address the problem pointed to by Lukas
> > during the previous discussion.
> >
> > Also some comments from Tomeu have been addressed.
> >
> > This hasn't been really tested yet and I'm sort of relying on Marek to test
> > it, because he has a use case ready.  Hence, the RFT tag on the series.
> 
> I've checked it with my updated Exynos SYSMMU patches and it works 
> really well.
> Both runtime pm and system sleep. It took some time to do the test, because
> this patchset changed somehow the probe order of the devices, what revealed
> some issues related to incorrect driver and device registration in Samsung
> Exynos FIMC-IS driver, but those were not related to Rafael's changes.
> I will post my patches in a few minutes.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks, much appreciated!

> Rafael, BTW, didn't you plan to change the name of the device_link_add()
> function to device_dependency_add() to avoid confusion with network device
> "link"?

I was concerned about the "devlink" name in particular, but I thought that
struct device_link would be distinct enough.  If not, I can still change it.

Thanks,
Rafael

