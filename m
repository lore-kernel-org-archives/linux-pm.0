From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 20:33:53 +0100
Message-ID: <20100507193353.GA27175__12642.7177958705$1273260982$gmane$org@srcf.ucam.org>
References: <20100507020541.GH30928@atomide.com>
	<20100507171218.GA23142@srcf.ucam.org>
	<20100507173549.GF387@atomide.com>
	<20100507175025.GA23952@srcf.ucam.org>
	<20100507180152.GH387@atomide.com>
	<20100507182824.GA25198@srcf.ucam.org>
	<20100507184333.GL387@atomide.com>
	<20100507184621.GA25978@srcf.ucam.org>
	<1273259186.3542.93.camel@c-dwalke-linux.qualcomm.com>
	<20100507192837.GM387@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100507192837.GM387@atomide.com>
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

On Fri, May 07, 2010 at 12:28:37PM -0700, Tony Lindgren wrote:
> * Daniel Walker <dwalker@fifo99.com> [100507 12:01]:
> > On Fri, 2010-05-07 at 19:46 +0100, Matthew Garrett wrote:
> > > Freezer cgroups would work better, but it doesn't really change the 
> > > point - if that application has an open network socket, how do you know 
> > > to resume that application when a packet comes in?
> 
> No idea, but that still sounds a better situation to me than
> trying to deal with that for a suspended system! :)

Suspend blocks deal with that problem. Nobody has yet demonstrated a 
workable alternative solution.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
