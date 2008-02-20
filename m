From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: APM depends on PM_SLEEP?
Date: Thu, 21 Feb 2008 00:56:26 +0100
Message-ID: <200802210056.26992.rjw@sisk.pl>
References: <Pine.LNX.4.64.0802191209260.5385@axis700.grange>
	<200802200117.58533.rjw@sisk.pl>
	<Pine.LNX.4.64.0802202358580.10149@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0802202358580.10149@axis700.grange>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 21 of February 2008, Guennadi Liakhovetski wrote:
> On Wed, 20 Feb 2008, Rafael J. Wysocki wrote:
> 
> > On Tuesday, 19 of February 2008, Guennadi Liakhovetski wrote:
> > > Hi
> > 
> > Hi,
> > 
> > > Could anyone explain me why APM depends on PM_SLEEP?
> > 
> > Because it refers to the code in drivers/base/power/main.c that depends on
> > PM_SLEEP.
> > 
> > > Isn't it a valid configuration, when I don't want to sleep / suspend, but
> > > need APM to, say, turn my machine off using
> > > APM_REAL_MODE_POWER_OFF, or if I need APM_DISPLAY_BLANK?
> > 
> > Yes, in theory, but that would require some more fine-grained #ifdeffing or
> > something similar.
> 
> As we see, for example, here:
> 
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0802.2/2215.html
> 
> it also happens in practice.

There are configurations in which it doesn't compile when this dependency
is removed.

I'm not an APM developer/maintainer/whatever and I have _much_ more urgent
things to take care of than this one.

Thanks,
Rafael
