From: Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] DRM / radeon / PM: Do not evict VRAM during
 freeze phase of hibernation
Date: Sat, 19 Jun 2010 07:08:16 +1000
Message-ID: <1276895296.6513.3.camel__15050.8441999138$1277134458$gmane$org@t60prh>
References: <201006182221.57333.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006182221.57333.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <alexdeucher@gmail.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-06-18 at 22:21 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> I have recently noticed a 55 sec. delay during the "device freeze"
> phase of hibernation on my test-bed HP nx6325.  Due to the 100%
> reproducibility of it I was able to narrow it down to
> radeon_suspend_kms() and then it turned out that the delay occured
> somewhere in radeon_bo_evict_vram().  However, it doesn't seem really
> necessary or even very useful to me to evict VRAM at this particular
> point, because we're going to create an image and bring the device
> back to the fully functional state in a little while.  Thus, I think
> the VRAM evicition can be skipped for state.event == PM_EVENT_FREEZE,
> which makes the delay go away.

I'm not 100% sure of the hibernate sequencing and its early in the
morning, but we want to evict VRAM before image building so we can have
the contents of VRAM in the image so we can restore them on resume. Does
this just avoid evicting them a second time after we created the image?

Dave.
