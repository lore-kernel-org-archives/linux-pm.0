From: mark gross <640e9920@gmail.com>
Subject: Re: PM QoS dynamic resource manager
Date: Tue, 8 Jun 2010 20:05:25 -0700
Message-ID: <20100609030525.GD26668@gvim.org>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>
	<20100525145223.GA4974@gvim.org>
	<AANLkTikLgu2c1GPE3glHLlaznOM59SVeCj2NHzDjyjZR@mail.gmail.com>
	<20100608033333.GA23066@gvim.org>
	<AANLkTinGBvZm870CsjocsCV1SmQ-FCCbJLtKWR1juB1Q@mail.gmail.com>
	<4C0ECC38.2000003@codeaurora.org>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C0ECC38.2000003@codeaurora.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bryan Huntsman <bryanh@codeaurora.org>
Cc: linux-pm@lists.linux-foundation.org, mark gross <640e9920@gmail.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 08, 2010 at 04:03:20PM -0700, Bryan Huntsman wrote:
> >>http://lkml.org/lkml/2010/4/22/213  (I guess the details are in the
> >>archives)  I'm happy to re-visit it.
> >>
> >
> >Interesting patch, it looks like having a "system wide bus" doesn't
> >easily apply to msm and tegra platforms.
> >An example of some things I would like to be able to control are i2c
> >and memory bus.
> >
> >I'm tempted to suggest adding two types memory and i2c but I'm not
> >sure how future proof this will be given the growing complexity in the
> >embedded hardware road-map.
> >What about the possibility of registering not one but several buses?
> >You could add a bus qos param, with a type enum, or bind to some
> >platform_driver or bus_driver
> >
> >Then there's the issue of having to deal with platform specific buses,
> >do you add this type to pm qos with only one user? Or have some
> >platform bus types defined somewhere. The generic code of min / max
> >for resource X can be useful so everyone doesn't spin their own
> >resource framework in their own architecture.
> >
> >-- Mike
> 
> Mike, one idea I'm exploring is having platform-specific busses with
> QoS constraints specified via runtime_pm as part of the LDM.  Adding
> dynamic class creation within pm_qos, or a type enum as you suggest,
> would work.  However, I think this kind of behavior would fit nicely
> within runtime_pm.
>

Something like that is what Kevin Hilman was thinking too.  It would
bring a qos concept to the LDM for each bus driver object.  Picking what
qos parameters to use (I recommend latency and bandwidth) and how "local"
the parameters effect of these bus_qos interfaces are.  

They are not the same as the more global system wide pm_qos parameters,
and they would be unlikely things ever exposed to usermode.

Yes I think something like this is inevitable and will happen.  But we
need some good applications to roll out the idea with.  (I think.)

--mgross
 
