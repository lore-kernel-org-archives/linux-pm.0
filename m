From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFC 2/6] mfd: Support for Ettus Research E31x devices PMU
Date: Mon, 18 Feb 2019 08:56:45 +0000
Message-ID: <20190218085645.GA4118@dell>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
 <20190212010143.3729-3-virendra.kakade@ni.com>
 <20190214093445.GF13737@dell>
 <CAAtXAHemEOOKOmQGT5StDt-Jxn0RUOoc9L-breMNURhd8=9q=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAtXAHemEOOKOmQGT5StDt-Jxn0RUOoc9L-breMNURhd8=9q=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Virendra Kakade <virendra.kakade@ni.com>, Devicetree List <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 17 Feb 2019, Moritz Fischer wrote:
> On Thu, Feb 14, 2019 at 1:34 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 11 Feb 2019, Virendra Kakade wrote:
> >
> > > Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> > > ---
> > >  drivers/mfd/Kconfig          |  7 +++
> > >  drivers/mfd/Makefile         |  2 +-
> > >  drivers/mfd/e31x-pmu.c       | 89 ++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/e31x-pmu.h | 20 ++++++++
> > >  4 files changed, 117 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/mfd/e31x-pmu.c
> > >  create mode 100644 include/linux/mfd/e31x-pmu.h

[...]

Try not to quote too many unnecessary lines when replying please.

> > So the whole purpose of this driver is to do a version check.
> >
> > Seems like over-kill!
> >
> > Probably better to do the version check in an inline function stored
> > in a header file, then call it from each of the children's .probe()
> > function.
> 
> A bit of context here, this is based on an in-house driver that we had that does
> a bunch of other stuff (e.g. it controls a flag on whether the device auto-boots
> on power being plugged in etc.). These functions will use the regmap.
> 
> I had advised Virendra to submit a base version and follow up with patches
> that would add these functions one by one as he figures out how to expose them
> in a proper way to the kernel.

Probably best to wait until you have something a little more
featureful before attempting to upstream then.  I couldn't tell you
how many times I've had contributors tell me that they plan to follow
up with additional patches and (for their own perfectly decent reasons
I'm sure) fail to do so.

As it stands, this driver over-kill for what you're trying to achieve
and therefore isn't overly suitable for upstreaming at the moment.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
