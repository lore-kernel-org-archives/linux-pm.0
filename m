From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] i915: Always register as a PCI driver (was:
	Re: [PATCH] DRM / i915: Fix resume regression on MSI Wind
	U100 w/o KMS)
Date: Sat, 9 Jan 2010 23:07:03 +0100
Message-ID: <201001092307.04077.rjw__12349.1257582375$1263074870$gmane$org@sisk.pl>
References: <201001090045.33784.rjw@sisk.pl> <201001091435.56157.rjw@sisk.pl>
	<21d7e9971001091341j313e6274vd883c0d5301b2586@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <21d7e9971001091341j313e6274vd883c0d5301b2586@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhenyu Wang <zhenyuw@linux.intel.com>, Eric Anholt <eric@anholt.net>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 09 January 2010, Dave Airlie wrote:
> On Sat, Jan 9, 2010 at 11:35 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday 09 January 2010, Jesse Barnes wrote:
> >> On Fri, 8 Jan 2010 16:50:57 -0800 (PST)
> >> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >>
> >> >
> >> >
> >> > On Sat, 9 Jan 2010, Rafael J. Wysocki wrote:
> >> > >
> >> > > Which is functionally equivalent to my patch, because
> >> > > i915_suspend/resume() won't be called by drm_class_suspend/resume()
> >> > > in the KMS case anyway.
> >> >
> >> > Ahh, right you are - that class suspend function does a check for
> >> > DRIVER_MODESET, and only does the suspend/resume if it's not a
> >> > MODESET driver.
> >> >
> >> > Ok, so I withdraw my objections to your original patch - it's
> >> > confusing, but that's just because DRM is such a horrible mess with
> >> > subtle things.
> >>
> >> Yeah the non-KMS paths just suck.
> >>
> >> Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>
> >>
> >> Though hopefully you can get the PCI driver registration working w/o
> >> too much trouble; that would be even better.
> >
> > Actually, I have a working patch, with one tiny detail I'm not sure of.
> >
> > Namely, I need to call pci_set_drvdata(pdev, dev) unconditionally in drm_stub.c
> > for the things to work, but I _think_ it won't hurt even if we're not going to
> > use the pdev's private data.
> >
> > The benefit of this is having just one code path for suspend/resume instead of
> > two different code paths depending on whether the driver is using the KMS or
> > not, which is well worth it IMO.
> >
> > The patch is appended.
> 
> NAK
> 
> for the reasons I explained in the previous email. This conflicts with systems
> where intelfb and intel drm are used together, this is something that ppl do use
> prior to KMS happening.
> 
> We just need to document in the headers why the hooks are needed,
> and maybe a bit of patch review to make sure nobody removes them again.

OK, so my original patch is the right one in that case.

Rafael
