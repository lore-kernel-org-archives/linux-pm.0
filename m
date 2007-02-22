From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: several messages
Date: Thu, 22 Feb 2007 23:58:55 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0702222352460.6771@poirot.grange>
References: <200702211929.17203.david-b@pacbell.net>
	<200702211950.22422.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702211950.22422.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>, David Brownell <david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, Alessandro Zummo <alessandro.zummo@towertech.it>, rtc-linux@googlegroups.com, john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel list <linux-kernel@vger.kernel.org>, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

of the following 2 patches:

On Mon, 5 Feb 2007, Johannes Berg wrote:

> This patch removes the time suspend/restore code that was done through
> a PMU notifier in arch/platforms/powermac/time.c.
> =

> Instead, we introduce arch/powerpc/sysdev/timer.c which creates a sys
> device and handles time of day suspend/resume through that.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Andrew Morton <akpm@osdl.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

[patch trimmed]

On Wed, 21 Feb 2007, David Brownell wrote:

> RTC class suspend/resume support, re-initializing the system clock on res=
ume
> >from the clock used to initialize it at boot time.
> =

>  - Inlining the same code used by ARM, which saves and restores the
>    delta between a selected RTC and the current system wall-clock time.
> =

>  - Removes calls to that ARM code from AT91, OMAP, and S3C RTCs.
> =

> This goes on top of the patch series removing "struct class_device" usage
> >from the RTC framework.  That makes class suspend()/resume() work.
> =

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> =

> ---
>  drivers/rtc/Kconfig          |   24 +++++++++----
>  drivers/rtc/class.c          |   74 ++++++++++++++++++++++++++++++++++++=
+++++++
>  drivers/rtc/rtc-at91rm9200.c |   30 -----------------
>  drivers/rtc/rtc-omap.c       |   17 ---------
>  drivers/rtc/rtc-s3c.c        |   22 ------------
>  5 files changed, 91 insertions(+), 76 deletions(-)

[patch trimmed]

I think, we only want 1, right? And the latter seems to be more generic / =

platform independent? And as a side-effect, powermac would have to migrate =

to generic rtc:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
