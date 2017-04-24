From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 8/8] platform: x86: intel_bxtwc_tmu: remove first
 level irq unmask
Date: Mon, 24 Apr 2017 13:24:39 +0100
Message-ID: <20170424122439.nwrlincsvhjq4ljf@dell>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <93377b77b9493d79de48741b030fa1b03f80094f.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170421220025.GC31650@fury>
 <d9ead97f-db7b-a0b0-4eb1-1c783ee1e841@linux.intel.com>
 <CAHp75VeGQ=Zb=azNZCEfA25VdvuQcbMJoHuXkyQ24KOh4WQjRw@mail.gmail.com>
 <20170424092401.uijlbkcxosoy4zmt@dell>
 <CAHp75Vd-V1jzPcEj1ZgA204gL_+ToeO7itbxjE_2e2ptki_PpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vd-V1jzPcEj1ZgA204gL_+ToeO7itbxjE_2e2ptki_PpQ@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>, Andy Shevchenko <andy@infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Apr 2017, Andy Shevchenko wrote:

> On Mon, Apr 24, 2017 at 12:24 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Sat, 22 Apr 2017, Andy Shevchenko wrote:
> >
> >> On Sat, Apr 22, 2017 at 1:34 AM, sathyanarayanan kuppuswamy
> >> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>
> >> > Thanks for brining it up. I was planning to ask either Andy or Lee regarding
> >> > this issue after all patches in the series are reviewed.
> >>
> >> Darren, I'm planning to review this soon.
> >>
> >> P.S. We have few series flying around regarding to Intel PMIC(s): my
> >> for Kconfig naming, Hans' for Crystal Cove (touches Kconfig as well),
> >> and Sathya's series. I hope Lee can collect them in proper order.
> >
> > That could be easier said than done.
> 
> Some of them are already in your tree, then apply
> - my Kconfig patch which makes Broxton Whiskey Cove to be built
> independently of Crystal Cove (I didn't notice that patch in your
> tree, though some of your mail told it had been applied)
> - Hans' series regarding CherryTrail Whiskey Cove support (if it has all ACKs)
> - this series after my review.
> 
> Does it sound doable?

My Inbox is now empty, so all patches are now either applied or
waiting further Acks/Actions.

I'm pretty certain that this set is not going in before v4.13.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
