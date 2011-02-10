From: Brendan Cully <brendan@cs.ubc.ca>
Subject: Re: [Xen-devel] Re: [PATCH 0/2] Fix hangup after
 creating checkpoint on Xen.
Date: Thu, 10 Feb 2011 09:53:44 -0800
Message-ID: <20110210175344.GB380__42104.5463801876$1297360488$gmane$org@zanzibar.kublai.com>
References: <Pine.LNX.4.44L0.1102081143470.2100-100000@iolanthe.rowland.org>
	<1297186554.9388.248.camel@zakaz.uk.xensource.com>
	<20110209231659.GB249@zanzibar.kublai.com>
	<1297337473.20491.144.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1297337473.20491.144.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ian Campbell <ijc@hellion.org.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Alan@cs.ubc.ca, LKML <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "SUZUKI,
	Kazuhiro" <kaz@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, 10 February 2011 at 11:31, Ian Campbell wrote:
> On Wed, 2011-02-09 at 23:16 +0000, Brendan Cully wrote:
> > I'd like to keep the fast resume option, and expect that it can be
> > contained entirely in Xen-specific code. I'll try to get someone to
> > look into it here.
> 
> Thanks, please put them in contact with Kazuhiro who has already been
> looking into this.
> 
> > I think fast resume is somewhat orthogonal to the problem of hanging
> > on resume, which just sounds like a xen-specific bug in the slow
> > path.
> 
> The bug on the Xen side is taking the slow path when the suspend was
> actually cancelled, which is what the original patch tries to fix.
> 
> Or should/could the slow path be able cope either way?

I haven't looked at what's actually happening yet, but what should be
happening is that the pvops kernel should not advertise SUSPEND_CANCEL
since it doesn't yet support it. So xm save -c should call
xc_domain_resume with the fast argument set to 0, to do slow path
resumption, and that slow path should be able to handle resuming on
the same host where it suspended. Slow path resumption from checkpoint
was supported in the pre-pvops kernel.
