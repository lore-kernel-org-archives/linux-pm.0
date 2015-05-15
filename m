From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: tegra: cpuidle: implement
 cpuidle_state.enter_freeze()
Date: Sat, 16 May 2015 00:30:41 +0100
Message-ID: <20150515233041.GN2067@n2100.arm.linux.org.uk>
References: <1428490480-10144-1-git-send-email-tomeu.vizoso@collabora.com>
 <20150408115546.GA24271@red-moon>
 <552643E1.3060200@collabora.com>
 <285738930.THBQOWvsah@vostro.rjw.lan>
 <20150410100844.GC23730@red-moon>
 <CAAObsKAihF1k1yzZxQEs_jpPnCdV3HQbLaYHWu1QNsNd5zqiOg@mail.gmail.com>
 <20150417140819.GB2347@red-moon>
 <CAAObsKBLHqf1+KUE89Orr7ZwzY3-WEW1CHokSOxSD9pEOmTkhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAObsKBLHqf1+KUE89Orr7ZwzY3-WEW1CHokSOxSD9pEOmTkhg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 15, 2015 at 11:03:35AM +0200, Tomeu Vizoso wrote:
> I have been looking and asking around, and seems like we should
> actually leave FIQs enabled when the tick is frozen and only disable
> them within enter_freeze.
> 
> My understanding is that FIQ handlers are extremely limited in what
> they can do, with the main use being NMI-like functionality. There are
> a handful of other FIQ handlers in mainline, but they don't call into
> any other kernel code and limit themselves to doing some basic I/O.
> 
> The only reason why they should be disabled in enter_freeze is that
> the context of the CPU that is going to a lower power state could
> become corrupted if a FIQ gets fired during a save or restore
> operation.

Right, that makes total sense.

(And yes, FIQ handlers are very limited in what they're allowed to do,
since they can't take any locks without the potential for deadlock.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
