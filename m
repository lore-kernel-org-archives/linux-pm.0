From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Power Management framework proposal
Date: Tue, 24 Jul 2007 08:23:25 +1000
Message-ID: <1185229405.5439.148.camel__1689.18276108361$1185229501$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185125189.2714.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1185125189.2714.13.camel@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: david@lang.hm, linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-07-22 at 10:26 -0700, Arjan van de Ven wrote:
> On Sat, 2007-07-21 at 23:49 -0700, david@lang.hm wrote:
> 
> > this approach would allow the transition of ALL drivers to the new mode of 
> > operation in one fell swoop, and then adding additional power management 
> > features is just adding to the existing list rather then implementing new 
> > functions.
> 
> 
> I have a concern with this approach though. It seems to assume that
> there is one global thing somewhere that sets the system state; in my
> experience that is the wrong approach; in fact there is a very definite
> evidence that there are many decisions on power that are to be made
> local at a high frequency. An example of this is the processor speed;
> the ondemand governer does exactly this for the cpus that can switch
> speeds fast; it's just impossible to beat such a local, fast decision
> with anything on a global scale.
> 
> On the other hand, some things (the high level goals and constraints)
> are obviously global.

I think we need a set of constraints that trickle down the power tree
and limit what a given driver can do locally.

Ben.
