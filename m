From: "Chidambaram, Praveen" <pchidamb@codeaurora.org>
Subject: Re: PM QoS dynamic resource manager
Date: Tue, 25 May 2010 10:19:59 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005250937090.25765@pchidamb-lnx.qualcomm.com>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>
	<20100525145223.GA4974@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100525145223.GA4974@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mark gross <640e9920@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

Thanks Mark.

I do understand your concern about having static paramters for the 
system, makes it more usuable across architectures. 

My requirement is drivers would want something like what PM QoS 
provides for their driver - (aggregation/max/min) of requests and pass 
on the final value to the driver for that specific driver. Writing it 
out for every driver is a duplication of code when PM QoS already 
provides this as a framework.

If a subsytem wants to use the driver they can use PM QoS with the 
published driver-specific QoS param. If the driver does not exist, ie, 
the param is not defined then they get the error code back. I do have 
something that has been written for arch/arm/mach-msm (it is arch 
agnostic though). I would like to invite you to take a look at the 
link below.

https://www.codeaurora.org/gitweb/quic/la/?p=kernel/msm.git;a=blob;f=Documentation/arm/msm/npa.txt;h=b5134041be1e6109b86179085db8aee19960c5dc;hb=android-msm-2.6.32
The implementation is in arch/arm/mach-msm/npa.c

I would like to bring in some key features that NPA has into PM QoS. 
NPA complements PM QoS in a way that it is completely dynamic and 
supports multiple params (known as resources/nodes). The essence of 
the framework is same as PM QoS - requests can be made by sub-systems 
and the framework aggregates or calculates the final value (the 
function to do this can be driver specific or framework pre-defined 
library) and the result is then passed on to the driver. In addition, 
the NPA framework supports aliasing of params (a 'system bus' on one 
architecture can mean one thing and on an other can reference another 
resource) and would be abstracted from the users. Dependencies between 
params can also be specified. The document also specifies 'remoting', 
which we can ignore it as it is just a layer over the framework.

I am interested in bringing in some of these features into PM QoS. Let 
me know what you think.

Thanks,
Praveen




On Tue, 25 May 2010 8:52am, mark gross <640e9920@gmail.com> wrote:
> On Fri, May 21, 2010 at 03:37:39PM -0600, Chidambaram, Praveen wrote:
> > Hi,
> > 
> > I am looking for some extensible features for PM QoS. Specifically, 
> > dynamic runtime parameters that my architecture could define at 
> > runtime and the drivers can make use of. 
> > 
> > What are the plans in this regard?
> 
> we've talked about it a few times in the past.  
> 
> It's come down to how do we prevent platform independent code from
> depending on such platform independent dynamic prarams in a sane manner.
> 
> I've alway's pushed for coming up with more reasonable abstractions that
> could be re-used and adding them (like the bus thing) as opposed to
> having drivers make / use new parrameters dynamically.
> 
> --mgross
> 
> > 
> > Thanks,
> > Praveen
> > _______________________________________________
> > linux-pm mailing list
> > linux-pm@lists.linux-foundation.org
> > https://lists.linux-foundation.org/mailman/listinfo/linux-pm
> 
