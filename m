From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Mon, 6 Aug 2007 16:46:41 -0700
Message-ID: <200708061646.41835.david-b@pacbell.net>
References: <200708061111.03407.david-b@pacbell.net>
	<200708061338.08561.david-b@pacbell.net>
	<20070806214805.GE3360@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070806214805.GE3360@flint.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Victor <andrew@sanpeople.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 06 August 2007, Russell King wrote:
> On Mon, Aug 06, 2007 at 01:38:08PM -0700, David Brownell wrote:
> > And since you asked for a build fix ... I have a hard time thinking
> > that anything else could really be the "right fix".
> 
> Do you have to drag every discussion right down into the shit pile?
> Your message isn't even worth this response.

Don't introduce four letter words then.  You know the drill:
good *technical* arguments are what should win.

I agree it would have been easier if I had asked to merge this
earlier; like for 2.6.18 as originally planned, or 2.6.22 ... sigh.
It never got to the top of the priority list until that Makefile
patch forced the issue; and merge windows are filled with stuff
that's higher priority.

Thing is, I've never been one to prefer short term hacks when
a good long-term solution is available.  In this case, that
solution has been used for over 9 months now, and was presented
more than once on LKML.  Even now, there are no good technical
counter-arguments.  So I still think this is the "right fix".
