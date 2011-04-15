From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [uclinux-dist-devel] freezer: should barriers be	smp
	?
Date: Fri, 15 Apr 2011 18:29:38 +0200
Message-ID: <20110415162938.GA11454__22810.2447501898$1302885094$gmane$org@atrey.karlin.mff.cuni.cz>
References: <BANLkTinj3y+-VhzFAPz8Gzb5vAbtUFU6Aw@mail.gmail.com>
	<Pine.LNX.4.44L0.1104131757430.2005-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1104131757430.2005-100000@iolanthe.rowland.org>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-pm@lists.linux-foundation.org, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > I believe the code is correct as is.
> > 
> > that isnt what the code / documentation says.  unless i'm reading them
> > wrong, both seem to indicate that the proposed patch is what we
> > actually want.
> 
> The existing code is correct but it isn't optimal.
> 
> wmb() and rmb() are heavy-duty operations, and you don't want to call
> them when they aren't needed.  That's exactly what smp_wmb() and
> smp_rmb() are for -- they call wmb() and rmb(), but only in SMP 
> kernels.
> 
> Unless you need to synchronize with another processor (not necessarily 
> a CPU, it could be something embedded within a device), you should 
> always use smp_wmb() and smp_rmb() rather than wmb() and rmb().

Maybe; but this code is not performance critical and I believe being
obvious here is better...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
