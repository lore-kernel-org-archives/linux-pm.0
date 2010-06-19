From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] DRM / radeon / PM: Do not evict VRAM during
	freeze phase of hibernation
Date: Sun, 20 Jun 2010 01:43:05 +0200
Message-ID: <201006200143.06059.rjw__28366.0981375307$1276991158$gmane$org@sisk.pl>
References: <201006182221.57333.rjw@sisk.pl> <1276904995.6513.7.camel@t60prh>
	<201006191453.58379.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006191453.58379.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@redhat.com>
Cc: Ondrej Zary <linux@rainbow-software.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <alexdeucher@gmail.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, June 19, 2010, Rafael J. Wysocki wrote:
> On Saturday, June 19, 2010, Dave Airlie wrote:
> > On Sat, 2010-06-19 at 01:23 +0200, Rafael J. Wysocki wrote:
> > > On Friday, June 18, 2010, Dave Airlie wrote:
> > > > On Fri, 2010-06-18 at 22:21 +0200, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > > 
> > > > > I have recently noticed a 55 sec. delay during the "device freeze"
> > > > > phase of hibernation on my test-bed HP nx6325.  Due to the 100%
> > > > > reproducibility of it I was able to narrow it down to
> > > > > radeon_suspend_kms() and then it turned out that the delay occured
> > > > > somewhere in radeon_bo_evict_vram().  However, it doesn't seem really
> > > > > necessary or even very useful to me to evict VRAM at this particular
> > > > > point, because we're going to create an image and bring the device
> > > > > back to the fully functional state in a little while.  Thus, I think
> > > > > the VRAM evicition can be skipped for state.event == PM_EVENT_FREEZE,
> > > > > which makes the delay go away.
> > > > 
> > > > I'm not 100% sure of the hibernate sequencing and its early in the
> > > > morning, but we want to evict VRAM before image building so we can have
> > > > the contents of VRAM in the image so we can restore them on resume. Does
> > > > this just avoid evicting them a second time after we created the image?
> > > 
> > > No, it's the first time, before creating the image, but I didn't seen any
> > > difference on resume with and without the patch, so I thought it was a good
> > > idea. :-)
> > 
> > On the machine you have its most likely not going to show up unless you
> > are running a 3D app or something across suspend, since currently X
> > re-exposes most apps on VT switch, so they just redraw.
> 
> Yes.  Moreover, hibernation is always done after a VT switch.  That's why
> I said I thought the eviction wasn't necessary in the changelog.
> 
> BTW, I have three different test boxes with radeon hardware and the
> $subject patch is not a problem on any of them.
> 
> > Was it always this slow?
> 
> Nope.  It definitely is a regression, although I'm not sure what's the last
> good kernel.
> 
> > you can see how many objects are in vram using
> > debugfs (/sys/kernel/debug/dri/0/radeon_vram_mm), it sounds like the TTM
> > eviction process is blocking on something,

I did some more debug work (the _total_ lack of comments inside of the
relevant radeon and ttm code makes this a next-to-impossible task, though)
and found that all of the delays (up to 5 seconds) happen inside of
ttm_bo_move_accel_cleanup() called from radeon_move_blit(), where the "new"
memory type is TTL_PL_TT and the "old" one is TTL_PL_VRAM.  The preceding
radeon_copy() always returns 0.

Please let me know if you need more information.

Thanks,
Rafael
