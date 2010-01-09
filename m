From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] DRM / i915: Fix resume regression on MSI
 Wind U100 w/o KMS
Date: Fri, 8 Jan 2010 17:13:11 -0800
Message-ID: <20100108171311.128c43d0__25170.867300085$1262999834$gmane$org@jbarnes-piketon>
References: <201001090045.33784.rjw@sisk.pl>
	<alpine.LFD.2.00.1001081548320.7821@localhost.localdomain>
	<20100108163217.341da699@jbarnes-piketon>
	<201001090146.17793.rjw@sisk.pl>
	<alpine.LFD.2.00.1001081648490.7821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1001081648490.7821@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, Wang <zhenyuw@linux.intel.com>, Eric Anholt <eric@anholt.net>, list <linux-pm@lists.linux-foundation.org>, Zhenyu@smtp1.linux-foundation.org, pm@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 8 Jan 2010 16:50:57 -0800 (PST)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Sat, 9 Jan 2010, Rafael J. Wysocki wrote:
> > 
> > Which is functionally equivalent to my patch, because
> > i915_suspend/resume() won't be called by drm_class_suspend/resume()
> > in the KMS case anyway.
> 
> Ahh, right you are - that class suspend function does a check for 
> DRIVER_MODESET, and only does the suspend/resume if it's not a
> MODESET driver.
> 
> Ok, so I withdraw my objections to your original patch - it's
> confusing, but that's just because DRM is such a horrible mess with
> subtle things.

Yeah the non-KMS paths just suck.

Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

Though hopefully you can get the PCI driver registration working w/o
too much trouble; that would be even better.

-- 
Jesse Barnes, Intel Open Source Technology Center
