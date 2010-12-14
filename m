From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: pm_runtime_suspended() and
	non-pm_runtime-using	(i2c) drivers
Date: Tue, 14 Dec 2010 23:19:25 +0000
Message-ID: <20101214231924.GA26411__15601.5279041187$1292368954$gmane$org@opensource.wolfsonmicro.com>
References: <20101214220050.GB25106@opensource.wolfsonmicro.com>
	<Pine.LNX.4.44L0.1012141754190.2087-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1012141754190.2087-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 14, 2010 at 06:03:06PM -0500, Alan Stern wrote:
> On Tue, 14 Dec 2010, Mark Brown wrote:

> > When I've been working with the runtime PM subsystem before I've thought
> > that it might be nice to have a specific RPM_UNINITIAZLIZED state which
> > would generally get out of the way.  It might be a bit clearer than the

> That's an interesting suggestion.  In general the PM core can't tell 
> what power state a device is really in when it is first discovered and 
> registered.

> I don't know if it would really solve your problem, though.  What we 
> really need is a better way to tell when a device shouldn't prevent its 
> parent from suspending.  Something like: If a device has no driver and 
> no children, it should automatically be put in the RPM_SUSPENDED state.

Yes, there'd need to be a bunch of code implementing behaviours that
look like what you suggest above and I'm not clear if it'd be worth the
hassle of implementing it - like I say, I'm not generally comfortable
enough with my understanding in this area to have a strong opinion on
the best approach.
