From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: x86: Increase PCIBIOS_MIN_IO to 0x1500 to fix nForce
	4 suspend-to-RAM
Date: Mon, 24 Dec 2007 14:44:23 +0100
Message-ID: <200712241444.24031.rjw@sisk.pl>
References: <200712231419.40207.carlos@strangeworlds.co.uk>
	<alpine.LFD.0.9999.0712231703390.21557@woody.linux-foundation.org>
	<200712240305.18080.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712240305.18080.carlos@strangeworlds.co.uk>
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
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 24 of December 2007, Carlos Corbacho wrote:
> On Monday 24 December 2007 01:14:34 Linus Torvalds wrote:
> > Side note: we could obviously undo the commit that triggered this for you
> > [..]
> > In other words, we'd have to go back to our original ordering, which Len
> > said was fundamentally wrong. I don't think anybody really wants that.
> 
> Nor would I argue to do so.
> 
> > It would be better to figure out why "device_suspend()" apparently causes
> > problems for your AML crud.
> 
> Will do - thanks for the pointer.

Well, having considered that for a longer while, I think the AML code is
referring to a device that we have suspended already, and since it's in a low
power state, it just can't handle the reference.

If that is the case, we'll have to find the device (that should be possible
using some code instrumentation) and move the suspending of it into the late
stage.

> > Oh, and why is linux-kernel cc'd, but not linux-pm?
> 
> Because I like to compound my errors (I mean, if you're going to screw up, you 
> might as well _really_ go for it).

BTW, linux-pm is on linux-foundation, changed the CC. ;-)

Thanks,
Rafael
