From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: APM depends on PM_SLEEP?
Date: Thu, 21 Feb 2008 00:01:05 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802202358580.10149@axis700.grange>
References: <Pine.LNX.4.64.0802191209260.5385@axis700.grange>
	<200802200117.58533.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802200117.58533.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 20 Feb 2008, Rafael J. Wysocki wrote:

> On Tuesday, 19 of February 2008, Guennadi Liakhovetski wrote:
> > Hi
> 
> Hi,
> 
> > Could anyone explain me why APM depends on PM_SLEEP?
> 
> Because it refers to the code in drivers/base/power/main.c that depends on
> PM_SLEEP.
> 
> > Isn't it a valid configuration, when I don't want to sleep / suspend, but
> > need APM to, say, turn my machine off using
> > APM_REAL_MODE_POWER_OFF, or if I need APM_DISPLAY_BLANK?
> 
> Yes, in theory, but that would require some more fine-grained #ifdeffing or
> something similar.

As we see, for example, here:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0802.2/2215.html

it also happens in practice.

Thanks
Guennadi
---
Guennadi Liakhovetski
