From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 22:39:17 +0100
Message-ID: <20100507213917.GE28906__1763.83372531763$1273268582$gmane$org@srcf.ucam.org>
References: <20100507184333.GL387@atomide.com>
	<20100507184621.GA25978@srcf.ucam.org>
	<1273259186.3542.93.camel@c-dwalke-linux.qualcomm.com>
	<20100507192837.GM387@atomide.com>
	<20100507193353.GA27175@srcf.ucam.org>
	<20100507195548.GN387@atomide.com>
	<20100507202859.GA27328@srcf.ucam.org>
	<20100507205329.GP387@atomide.com>
	<20100507210304.GA28701@srcf.ucam.org>
	<20100507212556.GQ387@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100507212556.GQ387@atomide.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 07, 2010 at 02:25:56PM -0700, Tony Lindgren wrote:
> * Matthew Garrett <mjg@redhat.com> [100507 13:58]:
> > Here's a different example. A process is waiting for a keypress, but 
> > because it's badly written it's also drawing to the screen at 60 frames 
> > per second and preventing the system from every going to idle. How do 
> > you quiesce the system while still ensuring that the keypress will be 
> > delivered to the application?
> 
> I guess it depends. If it's a game and I'm waiting to hit the fire
> button, then I don't want the system to suspend!
> 
> It's starting to sound like you're really using suspend blocks
> to "certify" that the app is safe to keep running.
> 
> Maybe it could be done with some kind of process flag instead that
> would tell "this process is safe to keep running from timer point of view"
> and if that flag is not set, then assume it's OK to stop the process
> at any point?

How do you know to wake the process up in response to the keypress?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
