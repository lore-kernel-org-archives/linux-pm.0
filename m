From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: rtc suspend()/resume() restores system clock
Date: Fri, 23 Feb 2007 19:31:27 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0702231927220.8712@poirot.grange>
References: <200702211929.17203.david-b@pacbell.net>
	<200702211950.22422.david-b@pacbell.net>
	<Pine.LNX.4.60.0702222352460.6771@poirot.grange>
	<1172229450.3870.5.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1172229450.3870.5.camel@johannes.berg>
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
Cc: linuxppc-dev@ozlabs.org, Alessandro Zummo <alessandro.zummo@towertech.it>, rtc-linux@googlegroups.com, john stultz <johnstul@us.ibm.com>, Torrance <torrance123@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

First, sorry for messing up the subject line.

On Fri, 23 Feb 2007, Johannes Berg wrote:

> On Thu, 2007-02-22 at 23:58 +0100, Guennadi Liakhovetski wrote:
> =

> > I think, we only want 1, right? And the latter seems to be more generic=
 / =

> > platform independent? And as a side-effect, powermac would have to migr=
ate =

> > to generic rtc:-)
> =

> Can we migrate all of powerpc to genrtc? But yes, I agree. Had enough to
> do though already to get suspend working :)

Johannes, is there any special meaning in "migrate all of powerpc to =

genrtc"? Or is it just porting every single rtc driver to the generic rtc =

API, moving it under drivers/rtc and adjusting its users or are there any =

global changes required to arch/powerpc? Linkstation is now happily using =

a driver under drivers/rtc, whereas originally it also had a "all special" =

driver, and the migration for me wasn't that difficult... Or is there more =

to do for other platforms?

Thanks
Guennadi
---
Guennadi Liakhovetski
