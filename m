From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [Update][PATCH 8/8] ARM / shmobile: Support for I/O
	power domains for SH7372 (v6)
Date: Tue, 21 Jun 2011 21:47:43 +0900
Message-ID: <20110621124742.GK7920__13742.654483258$1308660619$gmane$org@linux-sh.org>
References: <201106112223.04972.rjw@sisk.pl>
	<20110620020125.GA26125@linux-sh.org>
	<201106210030.01922.rjw@sisk.pl> <201106211357.09202.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201106211357.09202.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 21, 2011 at 01:57:08PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 21, 2011, Rafael J. Wysocki wrote:
> > On Monday, June 20, 2011, Paul Mundt wrote:
> > > Given that these functions can return errors, it's probably more prudent
> > > to implement some timeout logic on top of the busy loop. Hardware does
> > > get stuck, after all.
> > 
> > Yes, it does, but we don't really know what timeout value to use in there.
> > 
> > In fact, failures of pd_power_down() don't really matter (at worst the power
> > domain won't be powered off really) and pd_power_up() should only return error
> > code if the error is known to be unrecoverable.
> > 
> > So, what about this: repeat certain number of times (I verified that it took
> > several iterations of the loop until the new value settled on my hardware)
> > and then return from pd_power_down() or go to sleep for a short time and repeat
> > in pd_power_up()?
> 
> Having discussed that with Magnus I changed pd_power_down() to use a timeout.
> Specifically, it will bail out if the state doesn't change after approximately
> 1 ms.
> 
Looks good to me, thanks for fixing it up.

Acked-by: Paul Mundt <lethal@linux-sh.org>
