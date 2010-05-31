From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] lp_events: an lternitive to suspend blocker
	user mode and kernel API
Date: Tue, 1 Jun 2010 00:45:21 +0200
Message-ID: <201006010045.21382.rjw__5201.02087543837$1275345882$gmane$org@sisk.pl>
References: <20100530200409.GA21632@gvim.org>
	<20100531095753.4c174f2d@notabene.brown>
	<20100531221035.GB31155@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100531221035.GB31155@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: mark.gross@intel.com, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 June 2010, mark gross wrote:
> On Mon, May 31, 2010 at 09:57:53AM +1000, Neil Brown wrote:
...
> > So I would suggest modifying your proposal to simply create a new 'input'
> > device.  Any driver that supports wake-from-suspend queues an event to that
> > device when a wakeup event occurs.  If the device is open and has any queued
> > events, then a suspend request such as 'echo mem > /sys/power/state' completes
> > without going into full suspend.
> 
> /me likes.
>  
> > Then you just need to convince us that this mechanism can be used without any
> > race problems.  If it can, then it would certainly be a simple and
> > unobtrusive approach.
> 
> Lets find out.

Simple question: how is that better than the Alan Stern's proposed approach?

Rafael
