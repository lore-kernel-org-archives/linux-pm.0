From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 24 May 2010 23:25:11 +0200
Message-ID: <20100524212511.GC1286__48702.4600654424$1274774342$gmane$org@ucw.cz>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	<Pine.LNX.4.44L0.1005131002380.1695-100000@iolanthe.rowland.org>
	<20100513191717.GA3428@atomide.com>
	<20100513192522.GA19256@srcf.ucam.org>
	<20100513194205.GC3428@atomide.com>
	<20100513195349.GB19722@srcf.ucam.org>
	<20100513200003.GE3428@atomide.com>
	<20100513200814.GA20254@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100513200814.GA20254@srcf.ucam.org>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2010-05-13 21:08:14, Matthew Garrett wrote:
> On Thu, May 13, 2010 at 01:00:04PM -0700, Tony Lindgren wrote:
> 
> > The system stays running because there's something to do. The system
> > won't suspend until all the processors hit the kernel idle loop and
> > the next_timer_interrupt_critical() returns nothing.
> 
> At which point an application in a busy loop cripples you. I think we 

Application running busy loop already cripples you, with power going
from 15W to 50W in thinkpad case. Just avoid badly written apps.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
