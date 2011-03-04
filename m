From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] power: disable hibernation if module loading
	is disabled
Date: Fri, 4 Mar 2011 21:48:39 +0100
Message-ID: <201103042148.39944.rjw__13389.962379779$1299271860$gmane$org@sisk.pl>
References: <1299255084-4390-1-git-send-email-segoon@openwall.com>
	<20110304184324.GQ372@outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110304184324.GQ372@outflux.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kees Cook <kees.cook@canonical.com>
Cc: Len Brown <len.brown@intel.com>, security@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Vasiliy Kulikov <segoon@openwall.com>
List-Id: linux-pm@vger.kernel.org

On Friday, March 04, 2011, Kees Cook wrote:
> On Fri, Mar 04, 2011 at 07:11:24PM +0300, Vasiliy Kulikov wrote:
> > If /proc/sys/kernel/modules_disabled is set to 1, then nobody (even full
> > root) may not read/write arbitrary kernel memory.  In spite of it,
> > hibernation allows anyone with an access to either /dev/snapshot or
> > /sys/power/ make the full snapshot of the system.  This snapshot may be
> > freely changed and uploaded back.
> 
> Ah, yes please. I'd like to try to have ways to close all the
> "intentional" arbitrary memory writing interfaces.

They are not exactly arbitrary and I'd like to see a plausible attack
scenario using the hibernation interface as is (assuming you're not a
full root at least).

> Hooking it to modules_disable seems as good as any other toggle.

You're kidding, aren't you?

> Still waiting to hear
> anything on this: http://article.gmane.org/gmane.linux.acpi.devel/49471

I personally don't think it's a good idea, but I'm not the maintainer of that
code.

Thanks,
Rafael
