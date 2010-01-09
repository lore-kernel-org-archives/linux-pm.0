From: Jerome Glisse <glisse@freedesktop.org>
Subject: Re: [PATCH] DRM / i915: Fix resume regression on MSI
 Wind U100 w/o KMS
Date: Sat, 9 Jan 2010 13:01:41 +0100
Message-ID: <20100109120141.GA4319__45757.1553103209$1263227180$gmane$org@localhost.localdomain>
References: <201001090045.33784.rjw@sisk.pl>
	<alpine.LFD.2.00.1001081548320.7821@localhost.localdomain>
	<alpine.DEB.2.00.1001090214220.21286@skynet.skynet.ie>
	<20100108185041.7aae6c01@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100108185041.7aae6c01@jbarnes-piketon>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 08, 2010 at 06:50:41PM -0800, Jesse Barnes wrote:
> On Sat, 9 Jan 2010 02:15:41 +0000 (GMT)
> Dave Airlie <airlied@linux.ie> wrote:
> 
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > Commit cbda12d77ea590082edb6d30bd342a67ebc459e0 (drm/i915:
> > > > implement new pm ops for i915), among other things, removed
> > > > the .suspend and .resume pointers from the struct drm_driver
> > > > object in i915_drv.c, which broke resume without KMS on my MSI
> > > > Wind U100.
> > > > 
> > > > Fix this by reverting that part of commit cbda12d77ea59.
> > > 
> > > Hmm. I get the feeling that perhaps the of the drm_driver callbacks
> > > was very muchintentional, and that the code presumably wants to be
> > > called purely through the PCI layer, and not through the "drm
> > > class" logic at all?
> > > 
> > > Your patch seems like it would always execute the silly class
> > > suspend even though we explicitly don't want to. And a much nicer
> > > fix would seem to register the thing properly as a PCI driver even
> > > if you don't then use KMS.
> > > 
> > > So it looks to me like the problem is that drm_init() will register
> > > the driver as a real PCI driver only if
> > > 
> > > 	driver->driver_features & DRIVER_MODESET
> > > 
> > > and otherwise it does that very odd "stealth mode manual scanning"
> > > thing which doesn't register it as a proper PCI driver.
> > > 
> > > So could we instead make that "disable KSM" _just_ disable the mode 
> > > setting part, not disable the "I'm a real driver" part?
> > > 
> > 
> > This was mainly due to pre-existing fb drivers binding to the device,
> > and the drm drivers having to work around that, with KMS since we
> > have fb in the drm driver its correct to bind, pre-kms its just a
> > mess I'd rather stay away from.
> 
> Linus, can we ever drop those old paths?  Maybe after the new bits have
> been around for awhile?  Users of really old userspace stacks would
> lose 3D support, but they'd still have 2D, so it wouldn't be a complete
> break.  The non-KMS paths sometimes break like this anyway without us
> noticing (especially some of the weirder 3D paths)...
> 
> Just thinking out loud, we could really kill a lot of really bad code...
> 
> -- 
> Jesse Barnes, Intel Open Source Technology Center

I among those who would love such things to happen :)

Cheers,
Jerome
