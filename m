From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 21:12:53 +0300
Message-ID: <20100517181252.GA14260__10274.4238138714$1274123054$gmane$org@gandalf>
References: <Pine.LNX.4.44L0.1005151716180.24645-100000@netrider.rowland.org>
	<87hbm6cz90.fsf@deeprootsystems.com>
	<1274115885.4418.59.camel@mulgrave.site>
	<20100517174647.GA11512@gandalf>
	<1274119179.4418.68.camel@mulgrave.site>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1274119179.4418.68.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Matthew Garrett <mjg@redhat.com>, me@felipebalbi.com, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Mon, May 17, 2010 at 01:59:39PM -0400, James Bottomley wrote:
> Have you actually tried this?  On my N1 with CM5.0.6 just running
> powertop requires me to keep the USB system up (debugging cable) and
> paths into the usb console ... all of this produces significant wakeup
> distortion, mostly in the msm i2c subsystem.  But in all the noise it's
> hard to find rogue applications.

Well, I use serial console, but in the worst case scenario I would make
powertop save the output to a memory buffer a big one, and after
finished flush to some mmc or anything like that.

> The technical reason for wanting suspend blockers (as has been stated
> more times than I can be bothered to go back and count) is that no-one
> can currently produce a working model for race free kernel to user work
> handoff and, in the face of open app stores, rogue applications are a
> significant problem.  The fact that suspend blockers enables easy
> identification of power hogging apps is just a very useful side effect.

I still can't get over the fact that suspend_blockers are dealing with
userland problems in kernel space. If we can't really trust apps, I'm
sorry but companies like Google and Nokia (which I work for) will have
to setup better application acceptance on their stores. The fact that we
can get statistics of power usage from kernel space is actually really
good and could be easily automated on an AppStore environment. If it's
cause too many wakeups you report that to the developer of the app
before accepting. The same feature could be shipped on the SDK, so
developer has also early feedback about how good (or bad) his/her
application really is to the system.

IMO we should be celebrating good apps, not dealing in kernel space with
bad ones. And on top of all that, we would still need custom
applications with suspend_blockers support built into them.

-- 
balbi
