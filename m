From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
 before hibernation/suspend
Date: Mon, 28 May 2007 18:29:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705281719200.10323-100000__19403.7068322816$1180391418$gmane$org@netrider.rowland.org>
References: <20070528205727.GA5911@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070528205727.GA5911@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 28 May 2007, Pavel Machek wrote:

> > The theoretical answer is that it behaves the way we want.  The kernel 
> > thread does selective resumes in response to device requests.  If such 
> > a request comes in while the system is asleep it will awaken the 
> > system; so it's only logical that a request coming in while the system 
> > is in the process of going to sleep should abort the suspend.
> 
> I'd say that it shows ppc being broken. User wanted to suspend the
> system, and now unrelated task did lsusb... and system will not sleep.
> 
> AFAICT it is DoS issue -- if one of your users keeps doing lsusb, root
> will not be able to suspend the system.

This is a matter of one's philosophy.  In suspend-to-RAM, should tasks
be frozen or should I/O queues be frozen?

With the USB subsystem I have followed the approach taken by the PM
core, which is that tasks are frozen.  But one can -- and Linus has on
at least one occasion -- make a good case that tasks should be left
running while only I/O is frozen.  This would require the subsystem to
distinguish between a selective device suspend and a system-wide
suspend-to-RAM, so that selective resume could be enabled on demand in
one case but not the other.

It's quite doable in principle -- it's just not the technique I used.

Alan Stern
