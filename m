From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [QUESTION] How to reset TCP connections when
	resuming system from disk/ram
Date: Wed, 4 Jun 2008 16:59:00 +0200
Message-ID: <20080604145900.GA6762@ucw.cz>
References: <200806020026.56875.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200806020026.56875.maximlevitsky@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Thanks to your effort, the suspend to ram/disk works flawlessly on my
> desktop system.
> 
> But I still have rather small, but annoying problem, that system doesn't
> understands that a long suspend cycle was done, and still waits for long closed
> TCP connections.
> 
> I remember there was a patch to close all TCP connections on suspend, but it was rejected
> due to the fact that TCP sessions can live through short suspend/resume cycles.

Well... tcp sessions can survive even long suspends ... if there's no
NAT nearby and both sides are quiescent...

Dig out the patch and lets see if it can be made acceptable?

> Btw, I recently bought an acer laptop (5720G), and there are few suspend/resume issues,
> namely:
> 
> *attempt to do a second suspend to ram freezes the system hard on resume.
> for example this works:
> 
> suspend to ram
> suspend to disk
> suspend to ram
> suspend to disk
> 
> but this doesn't
> 
> suspend to ram
> suspend to ram

Try it from minimum system, but this looks like acpi problem...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
