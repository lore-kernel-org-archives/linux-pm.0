From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] DRM / i915: Fix resume regression on MSI
	Wind U100 w/o KMS
Date: Sat, 9 Jan 2010 01:46:17 +0100
Message-ID: <201001090146.17793.rjw__6551.04294787652$1262997998$gmane$org@sisk.pl>
References: <201001090045.33784.rjw@sisk.pl>
	<alpine.LFD.2.00.1001081548320.7821@localhost.localdomain>
	<20100108163217.341da699@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100108163217.341da699@jbarnes-piketon>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhenyu Wang <zhenyuw@linux.intel.com>, Eric Anholt <eric@anholt.net>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 09 January 2010, Jesse Barnes wrote:
> On Fri, 8 Jan 2010 16:01:46 -0800 (PST)
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > 
> > 
> > On Sat, 9 Jan 2010, Rafael J. Wysocki wrote:
> > >
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Commit cbda12d77ea590082edb6d30bd342a67ebc459e0 (drm/i915: implement
> > > new pm ops for i915), among other things, removed the .suspend and
> > > .resume pointers from the struct drm_driver object in i915_drv.c,
> > > which broke resume without KMS on my MSI Wind U100.
> > > 
> > > Fix this by reverting that part of commit cbda12d77ea59.
> > 
> > Hmm. I get the feeling that perhaps the of the drm_driver callbacks
> > was very muchintentional, and that the code presumably wants to be
> > called purely through the PCI layer, and not through the "drm class"
> > logic at all?
> > 
> > Your patch seems like it would always execute the silly class suspend
> > even though we explicitly don't want to. And a much nicer fix would
> > seem to register the thing properly as a PCI driver even if you don't
> > then use KMS.
> > 
> > So it looks to me like the problem is that drm_init() will register
> > the driver as a real PCI driver only if
> > 
> > 	driver->driver_features & DRIVER_MODESET
> > 
> > and otherwise it does that very odd "stealth mode manual scanning"
> > thing which doesn't register it as a proper PCI driver.
> > 
> > So could we instead make that "disable KSM" _just_ disable the mode 
> > setting part, not disable the "I'm a real driver" part?
> 
> This is the minimal fix I think (totally untested):
> 
> diff --git a/drivers/gpu/drm/i915/i915_drv.c
> b/drivers/gpu/drm/i915/i915_drv.c index a0a2cad..1364c3e 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -541,6 +541,11 @@ static int __init i915_init(void)
>                 driver.driver_features &= ~DRIVER_MODESET;
>  #endif
>  
> +       if (!(driver.driver_features & DRIVER_MODESET)) {
> +               driver.suspend = i915_suspend;
> +               driver.resume = i915_resume;
> +       }
> +
>         return drm_init(&driver);
>  }

Which is functionally equivalent to my patch, because i915_suspend/resume()
won't be called by drm_class_suspend/resume() in the KMS case anyway.

Rafael
