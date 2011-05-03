From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC][PATCH] PM: Print a warning if firmware is
 requested when tasks are frozen
Date: Tue, 3 May 2011 07:05:25 -0700
Message-ID: <20110503140525.GA7944__23809.0661740445$1304431791$gmane$org@suse.de>
References: <201105030044.51661.rjw@sisk.pl> <20110502231234.GA6430@suse.de>
	<BANLkTikCHO1ST27uhJLU5mBxtWPuuVkNKA@mail.gmail.com>
	<20110502232820.GA9578@suse.de>
	<BANLkTimwmC=ckj4g_ct4EhOSLD7NDgxdng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BANLkTimwmC=ckj4g_ct4EhOSLD7NDgxdng@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 02, 2011 at 05:59:22PM -0700, Linus Torvalds wrote:
> On Mon, May 2, 2011 at 4:28 PM, Greg KH <gregkh@suse.de> wrote:
> >
> > A driver that does not rely on the firmware being built in would be
> > correct in calling request_firmware_nowait() on resume, then when
> > userspace is properly woken up, the firmware would be sent to the
> > device, then the driver would be notified, load it, and handle things
> > as part of its resume sequence from that notification.
> >
> > Isn't that ideally what we want to have happen?
> 
> No. Absolutely not.
> 
> What we ideally want to happen is for the driver to not be a stupid
> piece of sh*t.

Well, we all want that :)

> A driver that needs firmware loading at resume time IS A BROKEN DRIVER.
> 
> It really is that simple.

Ok, fair enough, then I have no objection to this patch.  It will let us
catch those shitty drivers and fix them up to not do this.

thanks,

greg k-h
