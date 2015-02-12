From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC v4 1/3] PM / Runtime: Add an API pm_runtime_set_slave
Date: Thu, 12 Feb 2015 10:13:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1502121010070.1209-100000@iolanthe.rowland.org>
References: <CADGdYn6OwXgsGFspQva-q5WV5b_WB=G2PxZyhcETTgt8zY96ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CADGdYn6OwXgsGFspQva-q5WV5b_WB=G2PxZyhcETTgt8zY96ZQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: amit daniel kachhap <amit.daniel@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Feb 2015, amit daniel kachhap wrote:

> Hi Alan,
> 
> On Mon, Feb 9, 2015 at 9:28 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Mon, 9 Feb 2015, Amit Daniel Kachhap wrote:
> >
> >> This API creates a pm runtime slave type device which does not itself
> >> participates in pm runtime but depends on the master devices to power
> >> manage them.
> >
> > This makes no sense.  How can a master device manage a slave device?
> > Devices are managed by drivers, not by other devices.
> May be my commit is not explaining the requirements completely and the
> API name may not reflect the relevance. But If you see the 3rd patch
> it has one clock use-case where this new feature is used and the
> current pm runtime feature is not sufficient enough to handle it. I
> have one more IOMMU use case also which is not part of this patch
> series.

Regardless, your description should say what is really happening.  The
master device doesn't power-manage the clock; some driver power-manages
it.

> I am not sure if this approach is final but I looked at runtime.c file
> and it has couple of API's like pm_runtime_forbid/allow which
> blocks/unblocks the runtime callbacks according to driver requirement.
> In the similar line I added this new API.

forbid/allow blocks/unblocks runtime PM according to the user's 
requirements, not the driver's requirements.

> > Besides, doesn't the no_callbacks flag already do more or less what you
> > want?
> yes to some extent. But I thought its purpose is different so I added 1 more.

The purpose doesn't matter.  If no_callbacks does what you want then 
you should use it instead of adding another API.

Alan Stern
