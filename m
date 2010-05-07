From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 07 May 2010 12:06:26 -0700
Message-ID: <1273259186.3542.93.camel__18494.6314235733$1273259241$gmane$org@c-dwalke-linux.qualcomm.com>
References: <20100506174331.GA29103@srcf.ucam.org>
	<20100506183335.GE30928@atomide.com>
	<20100506184418.GA30669@srcf.ucam.org>
	<20100507020541.GH30928@atomide.com>
	<20100507171218.GA23142@srcf.ucam.org>
	<20100507173549.GF387@atomide.com>
	<20100507175025.GA23952@srcf.ucam.org>
	<20100507180152.GH387@atomide.com>
	<20100507182824.GA25198@srcf.ucam.org>
	<20100507184333.GL387@atomide.com>
	<20100507184621.GA25978@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100507184621.GA25978@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-05-07 at 19:46 +0100, Matthew Garrett wrote:
> On Fri, May 07, 2010 at 11:43:33AM -0700, Tony Lindgren wrote:
> > * Matthew Garrett <mjg@redhat.com> [100507 11:23]:
> > > On Fri, May 07, 2010 at 11:01:52AM -0700, Tony Lindgren wrote:
> > > > * Matthew Garrett <mjg@redhat.com> [100507 10:46]:
> > > > > Effective power management in the face of real-world applications is a 
> > > > > reasonable usecase.
> > > > 
> > > > Sure there's no easy solution to misbehaving apps.
> > > 
> > > That's the point of the suspend blockers.
> > 
> > To me it sounds like suspending the whole system to deal with
> > some misbehaving apps is an overkill. Sounds like kill -STOP
> > the misbehaving apps should do the trick?
> 
> Freezer cgroups would work better, but it doesn't really change the 
> point - if that application has an open network socket, how do you know 
> to resume that application when a packet comes in?

suspend blockers can get abused also .. I had my phone in my pocket and
accidentally ran "Google Talk" or something. It must have kept the
screen on or kept the phone from suspending, so the battery drained
completely over the course of an hour or so.

Daniel
