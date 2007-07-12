From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to
	kexec	base	hibernation
Date: Thu, 12 Jul 2007 14:06:59 +0000
Message-ID: <20070712140658.GA3881__3726.37168407$1184249960$gmane$org@ucw.cz>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<20070711172243.ab44c4d4.akpm@linux-foundation.org>
	<1184251423.9346.55.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707112345250.28090@asgard.lang.hm>
	<1184260683.9346.91.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707120247230.25614@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707120247230.25614@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: linux-kernel@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> >Maybe my usage of terminology has some problem. But, 
> >the "device
> >hibernate" here means put device into quiescent state 
> >and save the
> >device state, but do not put device into low power 
> >state.
> 
> is there really enough savings (in time or otherwise) to 
> make it worth splitting this into two steps? for 

Yep.

> but I suspect that the number of drivers where this is 
> worth doing is relativly small, and it may be a better 
> approach to start off with just putting everything into 
> the low-power state until some drive shows up that makes 
> it worth adding the intermediate state to the system 

We have had this flamewar before, and linus decided 'snapshot' and
'suspend' are different operations - and he's right. Disk takes 10
seconds to suspend/resume (spindown).
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
