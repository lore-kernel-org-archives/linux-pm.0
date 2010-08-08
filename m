From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sun, 8 Aug 2010 17:17:09 +0100
Message-ID: <20100808161709.GB7968__42192.4824979671$1281291633$gmane$org@srcf.ucam.org>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org> <201008071111.05585.rjw@sisk.pl>
	<7F55B423-3F07-4DF7-B958-7380FDD53545@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7F55B423-3F07-4DF7-B958-7380FDD53545@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Theodore Tso <tytso@MIT.EDU>
Cc: david@lang.hm, menage@google.com, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 07, 2010 at 10:46:59AM -0400, Theodore Tso wrote:

> True, but again, consider the MacBook.  If you plug in an iPod, the 
> machine will wake up for *just* long enough to let the iTunes sync the 
> iPod, but once its done, the machine goes back to sleep again 
> immediately.  I doubt MacOS has something called a "suspend blocker" 
> which prevents the machine from sleeping until iTunes finished, which 
> when released, allows the machine to suspend again immediately.  But 
> neither did I see any evidence that it took 30 seconds for some kludgy 
> polling process to decide that iTunes was done, and to allow the 
> MacBook to go back to sleep.  Clearly, the MacBook allows some 
> interrupts through, and some USB insert events through, but clearly 
> not all.  (Inserting a USB drive doesn't wake up the laptop; at least, 
> not for long.)

On the contrary, I suspect that it's precisely equivalent to userspace 
suspend blockers. There's no way to conditionalise USB wakeups - the 
system comes up when you plug or unplug any USB device. The system is 
then fully awake and I'd *guess* that ipods are magically exempted in 
some way, with itunes sending a signal when it's complete in order to 
allow the suspend policy daemon to trigger a suspend again.

> Can we do something as smooth with a Linux desktop?  And if not, why 
> not?  (Oh yeah, and wasn't this supposed to be the year of the Linux 
> Desktop?  :-)

gnome-power-manager supports applications inhibiting suspend, but right 
now I suspect that it'll never deal with the case where you resume with 
the lid closed. It's a simple matter of coding, though.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
