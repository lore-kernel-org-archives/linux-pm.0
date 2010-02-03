From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [regression] "drm/i915: implement new pm ops"
	disables irq on aborted s2disk
Date: Wed, 3 Feb 2010 23:44:41 +0100
Message-ID: <201002032344.41915.rjw__41199.4434231476$1265237235$gmane$org@sisk.pl>
References: <4B695BA0.4000007@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B695BA0.4000007@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Eric Anholt <eric@anholt.net>, dri-devel@lists.sourceforge.net, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Kernel Testers List <kernel-testers@vger.kernel.org>, Zhenyu Wang <zhenyuw@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 03 February 2010, Alan Jenkins wrote:
> Hi
> 
> I found this regression on my EeePC 701 with modesetting enabled.  When 
> I hibernate using s2disk, I can abort the hibernation by pressing the 
> backspace key.  Doing so breaks X on 2.6.32-rc6 (but not 2.6.32).

Yeah.

To be honest, I knew that's going to happen, but didn't have the time to take
care of it.

The problem is that i915 does literally _nothing_ in its .thaw() callback,
although it should at least reverse whatever .freeze() did to the hardware
(and memory allocations and so on), so that the adapter is functional
after creating the image.

Fixing this requires some thought, though, because at the moment .freeze()
thinks it's .suspend(), which is not the case as this report clearly shows.
So, in fact i915_pci_suspend() has to be split into the .freeze() part and
the poweroff part cleanly and that's not  so simple (at least to me).

Hopefully I'll have some time to work on this during the weekend.

Rafael
