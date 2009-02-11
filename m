From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Wed, 11 Feb 2009 16:45:46 +0100
Message-ID: <200902111645.46843.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0902110955490.3056-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902110955490.3056-100000@iolanthe.rowland.org>
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
To: Brian Swetland <swetland@google.com>
Cc: linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Wednesday 11 February 2009, Alan Stern wrote:
> On Tue, 10 Feb 2009, Brian Swetland wrote:
> 
> > [Pavel Machek <pavel@ucw.cz>]
> > > > 
> > > > wake_lock never blocks.
> > > 
> > > Wakelock is really bad name: it is not a lock and it does not protect
> > > wake. I'd say we need better name here.
> > 
> > I agree with you here -- I've had this discussion with Arve previously,
> > but have been unable to offer a compelling alternative name.  Anybody
> > have a good idea?

Well, even "sleep lock" would have been better.

> delay_sleep or delaysleep?  block_sleep or blocksleep?  Any of the 
> above with "sleep" replaced by "suspend"?

I also thought about "sleep stopper".  It reflects what the feature does. :-)

Thanks,
Rafael
