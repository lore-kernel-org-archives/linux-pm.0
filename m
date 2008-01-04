From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] base: Change power/wakeup output from "" to
	"unsupported" if wakeup feature isn't supported by a device
Date: Fri, 4 Jan 2008 11:38:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801041136490.4078-100000__40054.7965350144$1199464810$gmane$org@iolanthe.rowland.org>
References: <20080104160933.B01D81FBAB5@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080104160933.B01D81FBAB5@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: yi.y.yang@intel.com, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 4 Jan 2008, David Brownell wrote:

> > > This patch changes empty output to "unsupported" in order that a user knows
> > > wakeup feature isn't supported by this device when he/she
> > > 'cat /sys/devices/.../power/wakeup', please consider to apply,
> > > thanks.
> >
> > What about simply removing "wakuep" file if wakeup is not supported?
> 
> It may not *stay* unsupported, so I think changing it in either
> of those permanent ways would be confusing/misleading.

How about changing it to say "unavailable"?  That doesn't imply 
permanence.

Alan Stern
