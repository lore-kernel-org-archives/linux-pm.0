From: Yi Yang <yi.y.yang@intel.com>
Subject: Re: [PATCH] base: Change power/wakeup output from "" to
	"unsupported" if wakeup feature isn't supported by a device
Date: Mon, 07 Jan 2008 09:52:59 +0800
Message-ID: <1199670779.3551.7.camel__8837.81827656112$1199671258$gmane$org@yangyi-dev.bj.intel.com>
References: <Pine.LNX.4.44L0.0801041136490.4078-100000@iolanthe.rowland.org>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801041136490.4078-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2008-01-04 at 11:38 -0500, Alan Stern wrote:
> On Fri, 4 Jan 2008, David Brownell wrote:
> 
> > > > This patch changes empty output to "unsupported" in order that a user knows
> > > > wakeup feature isn't supported by this device when he/she
> > > > 'cat /sys/devices/.../power/wakeup', please consider to apply,
> > > > thanks.
> > >
> > > What about simply removing "wakuep" file if wakeup is not supported?
> > 
> > It may not *stay* unsupported, so I think changing it in either
> > of those permanent ways would be confusing/misleading.
> 
> How about changing it to say "unavailable"?  That doesn't imply 
> permanence.
This should be an option.
> 
> Alan Stern
> 
