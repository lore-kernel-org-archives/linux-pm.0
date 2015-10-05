From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 1/2] PM / sleep: Go direct_complete if driver has no callbacks
Date: Mon, 05 Oct 2015 15:29:59 +0200
Message-ID: <5808910.FQ4CPUCAtb@vostro.rjw.lan>
References: <1443529760-17612-1-git-send-email-tomeu.vizoso@collabora.com> <CAAObsKDtE_uj7iA53pzMaoT+EPctCgnHxypVhXL6GuVUQimn+w@mail.gmail.com> <20151005090727.GA24851@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151005090727.GA24851@xo-6d-61-c0.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, martyn.welch@collabora.co.uk, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, October 05, 2015 11:07:27 AM Pavel Machek wrote:
> On Mon 2015-10-05 10:25:45, Tomeu Vizoso wrote:
> > On 4 October 2015 at 17:16, Pavel Machek <pavel@ucw.cz> wrote:
> > > On Tue 2015-09-29 14:29:19, Tomeu Vizoso wrote:
> > >> If a suitable prepare callback cannot be found for a given device and
> > >> its driver has no PM callbacks at all, assume that it can go direct to
> > >> complete when the system goes to sleep.
> > >>
> > >> The reason for this is that there's lots of devices in a system that do
> > >> no PM at all and there's no reason for them to prevent their ancestors
> > >> to do direct_complete if they can support it.
> > >
> > > Dunno. This sounds like asking for trouble. Even if most devices can handle
> > > this, is not this bound to introduce some bugs?
> > 
> > Hi Pavel,
> > 
> > in which situations do you think that this could be problematic?
> 
> Well.. driver with no PM callbacks probably works "by accident",

How exactly?

Do you have at least one example of that?

Thanks,
Rafael
