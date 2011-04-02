From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 16/18] 2.6.40: x86 idle APM: remove
 deprecated apm_cpu_idle()
Date: Sat, 02 Apr 2011 15:44:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1104021529580.18682__7767.45124389908$1301773537$gmane$org@x980>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
	<5d9716021b20302ece48fd486bbad9bcb2502353.1301724243.git.len.brown@intel.com>
	<20110402124054.49c3a3f4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110402124054.49c3a3f4@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> > There is some doubt whether the APM idle feature
> > to call into the BIOS from the idle loop is reliable.
> > Certainly it was known to fail on some machines,
> 
> And it was known to work on lots - a point that despite repeated
> reminding you seem keen to ignore.
> 
> The fundamental problem I have with this patch set is this
> 
> You've provided no architectural overall justification for all this
> effort. What is the big picture around your crusade here ? What is the
> grand plan ?

This patch series was posted in reply to a table of contents

https://lkml.org/lkml/2011/4/2/8

"By the end of this series, pm_idle is removed as a public
 x86 idle-loop registration mechanism.  A few other things are
 cleaned up in the process."

I labeled it "idle cleanup - v3" -- I'm sorry if it went un-noticed
because I neglected to put the [PATCH 0/18] on it.

Trinabh also replied to you, pointing one of the previous
LKML discussions about the mis-use of pm_idle.

> > but more importantly, APM machines have not shipped
> > for a decade and so finding machines to test the code
> > is problematic.
> 
> So don't test it - if it's wrong someone will let you know, believe me 8)
> 
> And 2.6.40 is far too soon - it takes about a year for stuff to rattle
> through to leading edge distro users in bulk

If you insist.

We'll create a new APM cpuidle driver in Linux (Trinabh prototyped one),
and at the same time, schedule it for removal in a year.  Personally,
I think it is make-work, and in real-life it is more likely to do
more harm than removing apm_idle, but I don't want to stand in the
way of process.

thanks,
-Len
