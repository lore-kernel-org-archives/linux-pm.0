From: Tejun Heo <tj@kernel.org>
Subject: Re: [REGRESSION]: hibernate/sleep regression w/ bisection
Date: Thu, 3 Nov 2011 14:39:59 -0700
Message-ID: <20111103213959.GP4417@google.com>
References: <20111101124759.GA1326@zeus>
	<20111102054658.GA29035@core.coreip.homeip.net>
	<20111102160208.GA6657@zeus>
	<20111102163109.GA29430@core.coreip.homeip.net>
	<20111103155956.GG4417@google.com> <20111103184559.GA3295@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111103184559.GA3295@zeus>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Watts <akwatts@ymail.com>
Cc: linux-pm@lists.linux-foundation.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello, Andrew.

On Thu, Nov 03, 2011 at 01:46:19PM -0500, Andrew Watts wrote:
> On Thu, Nov 03, 2011 at 08:59:56AM -0700, Tejun Heo wrote:
> > Andrew, just in case, can you please double check that you're
> > reverting only that single commit (not all the ones afterwards) and
> > the test results?  If they're all okay, can you please trigger the
> > problem, wait a while, trigger sysrq-t and attach the kernel log?
> 
> Hi Tejun.
> 
> I am only reverting 8ee294cd9def0004887da7f44b80563493b0a097 though I first
> revert part of 1d64b655dc083df5c5ac39945ccbbc6532903bf1 so it reverts 
> cleanly. 
> 
> I am very sure of my test results; normally I get 4-5 bad resumes on a 20
> hibernate loop and get no bad resumes with the commit reverted. I have
> been very thorough in my testing to ensure I am not generating false
> positives or false negatives (repeating the loops many times).

Thanks.  Yeah, this is odd & interesting.

> Below is the output you asked for (sysrq t).
> 
> Thanks.
> 
> ~ Andy
> 
> ======================
> 
> 
> kernel: [  345.226523] SysRq : Show State
> kernel: [  345.226531]   task                PC stack   pid father
> kernel: [  345.226535] init            S f4a47b68  5488     1      0 0x00000000
> kernel: [  345.226765] kthreadd        S 00000000  7172     2      0 0x00000000

This is missing all stack traces.  Can you please turn on
FRAME_POINTER and adjust log level such that all stack dumps are
included too?

Thank you.

-- 
tejun
