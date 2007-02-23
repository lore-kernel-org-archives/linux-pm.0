From: David Brownell <david-b@pacbell.net>
Subject: Re: several messages
Date: Thu, 22 Feb 2007 17:15:01 -0800
Message-ID: <200702221715.03195.david-b@pacbell.net>
References: <200702211929.17203.david-b@pacbell.net>
	<200702211950.22422.david-b@pacbell.net>
	<Pine.LNX.4.60.0702222352460.6771@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.60.0702222352460.6771@poirot.grange>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, Torrance <torrance123@gmail.com>, Alessandro Zummo <alessandro.zummo@towertech.it>, rtc-linux@googlegroups.com, john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, Johannes Berg <johannes@sipsolutions.net>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 22 February 2007 2:58 pm, Guennadi Liakhovetski wrote:
> =

> I think, we only want 1, right? And the latter seems to be more generic / =

> platform independent? And as a side-effect, powermac would have to migrat=
e =

> to generic rtc:-)

I'd certainly think that restoring the system clock should be, as much
as possible, in platform-agnostic code.  Like the generic RTC framework.

And hmm, that powermac/time.c file replicates other RTC code...

Minor obstacle:  removing the EXPERIMENTAL label from that code.

- Dave
