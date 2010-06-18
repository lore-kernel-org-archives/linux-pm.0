From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] DRM / radeon / PM: Do not evict VRAM during
	freeze phase of hibernation
Date: Sat, 19 Jun 2010 01:23:00 +0200
Message-ID: <201006190123.00694.rjw__21685.373542323$1276903611$gmane$org@sisk.pl>
References: <201006182221.57333.rjw@sisk.pl> <1276895296.6513.3.camel@t60prh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276895296.6513.3.camel@t60prh>
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
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <alexdeucher@gmail.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, June 18, 2010, Dave Airlie wrote:
> On Fri, 2010-06-18 at 22:21 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > I have recently noticed a 55 sec. delay during the "device freeze"
> > phase of hibernation on my test-bed HP nx6325.  Due to the 100%
> > reproducibility of it I was able to narrow it down to
> > radeon_suspend_kms() and then it turned out that the delay occured
> > somewhere in radeon_bo_evict_vram().  However, it doesn't seem really
> > necessary or even very useful to me to evict VRAM at this particular
> > point, because we're going to create an image and bring the device
> > back to the fully functional state in a little while.  Thus, I think
> > the VRAM evicition can be skipped for state.event == PM_EVENT_FREEZE,
> > which makes the delay go away.
> 
> I'm not 100% sure of the hibernate sequencing and its early in the
> morning, but we want to evict VRAM before image building so we can have
> the contents of VRAM in the image so we can restore them on resume. Does
> this just avoid evicting them a second time after we created the image?

No, it's the first time, before creating the image, but I didn't seen any
difference on resume with and without the patch, so I thought it was a good
idea. :-)

If you don't like it, though, I guess it will be necessary to find the root
cause of the delay.

Rafael
