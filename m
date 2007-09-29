From: Daniel Phillips <phillips@phunq.net>
Subject: Re: A unresponsive file system can hang all I/O in the
	system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Fri, 28 Sep 2007 18:27:47 -0700
Message-ID: <200709281827.48350.phillips__49537.7618856311$1191029431$gmane$org@phunq.net>
References: <10659.1190986132@lwn.net> <1190986542.13204.10.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1190986542.13204.10.camel@twins>
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
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Chakri n <chakriin5@gmail.com>, Jonathan Corbet <corbet@lwn.net>, lkml <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 28 September 2007 06:35, Peter Zijlstra wrote:
> ,,,it would be grand (and dangerous) if we could provide for a
> button that would just kill off all outstanding pages against a dead
> device.

Substitute "resources" for "pages" and you begin to get an idea of how 
tricky that actually is.  That said, this is exactly what we have done 
with ddsnap, for the simple reason that our users, now emboldened by 
being able to stop or terminate the user space part, felt justified in 
expecting that the system continue as if nothing had happened, and 
furthermore, be able to restart ddsnap without a hiccup.  (Otherwise 
known as a sysop's diety-given right to kill.)

So this is what we do in the specific case of ddsnap:

   * When we detect some nasty state change such as our userspace
      control daemon disappearing on us, we go poking around and
      explicitly release every semaphore that the device driver could
      possibly wait on forever (interestingly they are all in our own
      driver except for BKL, which is just an artifact of device mapper
      not having gone over to unlock_ioctl for no good reason that I
      know of).

   * Then at the points were the driver falls through some lock thus
      released, we check our "ready" flag, and if it indicates "busted",
      proceed with wherever cleanup is needed at that point.

Does not sound like an approach one would expect to work reliably, does 
it?  But there just may be some general principle to be ferretted out 
here.  (Anyone who has ideas on how bits of this procedure could be 
abstracted, please do not hesitate to step boldly forth into the 
limelight.)

Incidentally, only a small subset of locks needed special handling as 
above.  Most can be shown to have no way to block forever, short of an 
outright bug.

I shudder to think how much work it would be to bring every driver in 
the kernel up to such a standard, particularly if user space components 
are involved, as with USB.  On the other hand, every driver fixed is 
one less driver that sucks.  The next one to emerge from the pipeline 
will most likely be NBD, which we have been working on in fits and 
starts for a while.  Look for it to morph into "ddbd", with cross-node 
distributed data awareness, in addition to perforning its current job 
without deadlocking.

Regards,

Daniel
