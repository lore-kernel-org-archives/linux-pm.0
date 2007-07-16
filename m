From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Hibernation considerations
Date: Mon, 16 Jul 2007 01:51:35 +0100
Message-ID: <20070716005135.GB8140__6229.21404797143$1184547198$gmane$org@srcf.ucam.org>
References: <200707151433.34625.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707151433.34625.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: david@lang.hm, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sun, Jul 15, 2007 at 02:33:32PM +0200, Rafael J. Wysocki wrote:

(snip)

Many of these assumptions are based on the assumption that we want to 
save a full image of RAM. I'm not convinced that this is true. The two 
things that we need are application state and hardware state. 
Application state can clearly be saved without kernel involvement 
(though restoring some of it may need some help from the kernel...), so 
hardware state is a more interesting question.

The obvious argument for saving the entirity of memory is that we have 
no mechanism for picking apart hardware state from any other part of the 
kernel. In reality, we're looking at implementing a set of hibernation 
operations anyway - it would be possible to utilise those to save as 
much state as needed. You also get fringe benefits, like being able to 
freeze a process that's accessing a piece of flaky hardware, swap the 
card out (assuming hotplug PCI), restore some amount of state and then 
let the process continue.

I appreciate that this suggestion sounds kind of fragile and 
complicated, but I think that's true of most descriptions of suspend to 
disk :) The main benefit is that it means we can use the hibernation 
infrastructure for other purposes (checkpointing, swapping hardware, 
that kind of thing) and reduce the damage caused by users doing 
seemingly reasonable things (like suspending Linux, booting Windows and 
then writing to a shared partition...). 

-- 
Matthew Garrett | mjg59@srcf.ucam.org
