From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 6 May 2010 10:08:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005061007050.1708-100000__45727.1763043993$1273154948$gmane$org@iolanthe.rowland.org>
References: <h2va55d774e1005051642m6159aadclfda9d1c77cb10cda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <h2va55d774e1005051642m6159aadclfda9d1c77cb10cda@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 5 May 2010, Brian Swetland wrote:

> > Probably generalizing these into the LDM is the direction to go so
> > userspace can set constraints on a per-device (or per-class?) basis:
> >
> > /sys/devices/.../power/constraint/throughput
> > /sys/devices/.../power/constraint/wakeup_latency
> > /sys/devices/.../power/constraint/... ?
> 
> The constraint stuff is definitely something I'd love to talk about in
> detail.  It's a problem that I think is common to every SoC I've
> worked with.  Having a general solution for this problem (of
> specifying and observing various constraints for clock, power, qos,
> etc) kernel-wide would seem like a big win.
> 
> Might be worth kicking some design ideas around and getting a bunch of
> the interested parties together at some of the upcoming linux
> conference things this fall on the east coast?

The Linux Power-Management Summit is scheduled for August 9, at the 
start of the LinuxCon meeting in Boston.  This would make an excellent 
topic for discussion.

Alan Stern
