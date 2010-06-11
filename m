From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM QoS dynamic resource manager
Date: Fri, 11 Jun 2010 19:42:46 +0530
Message-ID: <1276265566.8214.2.camel@localhost>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>
	<20100525145223.GA4974@gvim.org>
	<AANLkTikLgu2c1GPE3glHLlaznOM59SVeCj2NHzDjyjZR@mail.gmail.com>
	<20100608033333.GA23066@gvim.org>
	<AANLkTinGBvZm870CsjocsCV1SmQ-FCCbJLtKWR1juB1Q@mail.gmail.com>
	<4C0ECC38.2000003@codeaurora.org>  <20100609030525.GD26668@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100609030525.GD26668@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: mark gross <640e9920@gmail.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-06-08 at 20:05 -0700, mark gross wrote:
> On Tue, Jun 08, 2010 at 04:03:20PM -0700, Bryan Huntsman wrote:
> > 
> > Mike, one idea I'm exploring is having platform-specific busses with
> > QoS constraints specified via runtime_pm as part of the LDM.  Adding
> > dynamic class creation within pm_qos, or a type enum as you suggest,
> > would work.  However, I think this kind of behavior would fit nicely
> > within runtime_pm.
> >
> 
> Something like that is what Kevin Hilman was thinking too.  It would
> bring a qos concept to the LDM for each bus driver object.  

Yes, I definitely have some thoughts/ideas in this direction and is what
we are doing on OMAP.  I've been on the road, so I will chime in more on
this next week when I get back...

Kevin
