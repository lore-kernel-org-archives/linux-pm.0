From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Add SIMPLE_PM_OPS: make switching to
	dev_pm_ops less error-prone
Date: Wed, 5 Aug 2009 20:47:25 +0200
Message-ID: <200908052047.26293.rjw__27205.3449335091$1249498152$gmane$org@sisk.pl>
References: <20090803163304.GF5002@laptop>
	<20090805045533.C3574526EA5@mailhub.coreip.homeip.net>
	<20090805093758.GE5854@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090805093758.GE5854@laptop>
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
To: Albin Tonnerre <albin.tonnerre@free-electrons.com>
Cc: Frans Pop <elendil@planet.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 05 August 2009, Albin Tonnerre wrote:
> On Tue, Aug 04, 2009 at 09:55:33PM -0700, Dmitry Torokhov wrote :
> > On Tue, Aug 04, 2009 at 11:36:12AM +0200, Albin Tonnerre wrote:
> > > In a number of cases, the .suspend, .freeze, .poweroff and .resume,
> > > .thaw, .restore functions are identical. However, they all need to be
> > > assigned to avoid regressionsm as the previous code called .suspend
> > > resp. .resume in all those cases. SIMPLE_PM_OPS allows to deal with
> > > this case.
> 
> 
> > I'd much rather have conversions done with a bit more analysis now that
> > our framework is more flexible and we can have specialized routines for
> > hibernation and suspend.
> 
> I still think that even though they can, quite a number of drivers won't
> /need/ to have different functions for this, but maybe I'm mistaken.
> 
> > Maybe we should try changing from run-time to build time warning so that
> > users are not overly concerned with it?
> 
> I'm not sure that solves the problem. The fact is that even for developers, it's
> easy to overlook that assiging only the .suspend and .resume fields is probably
> a mistake.

I agree, so I'm going to take the patch.

I'll add a comment describing what the macro is for, though.

Thanks,
Rafael
