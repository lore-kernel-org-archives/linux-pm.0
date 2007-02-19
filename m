From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 05/10] powermac: generic time suspend/resume
 code
Date: Mon, 19 Feb 2007 11:00:52 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0702191046160.5056@poirot.grange>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185836.869369000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070205185836.869369000@sipsolutions.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 5 Feb 2007, Johannes Berg wrote:

> This patch removes the time suspend/restore code that was done through
> a PMU notifier in arch/platforms/powermac/time.c.
> =

> Instead, we introduce arch/powerpc/sysdev/timer.c which creates a sys
> device and handles time of day suspend/resume through that.

I think there's a problem with this one. In my tests with this patch the =

system time is incremented twice, so, looks like some code already takes =

care about that. Maybe there's some very indirect code in generic rtc, but =

I haven't found anything yet. Anyway, requires more investigation and, =

probably, should not be included before we clarify this.

Thanks
Guennadi
---
Guennadi Liakhovetski
