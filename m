From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RFC] apm-emulation: apm_mutex breaks ACK;
	remove it
Date: Tue, 17 May 2011 21:13:04 +0200
Message-ID: <201105172113.04249.rjw@sisk.pl>
References: <500147.35778.qm@web29013.mail.ird.yahoo.com>
	<alpine.LNX.2.00.1105171425340.28291@pobox.suse.cz>
	<alpine.LNX.2.00.1105171429220.28291@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LNX.2.00.1105171429220.28291@pobox.suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 17, 2011, Jiri Kosina wrote:
> On Tue, 17 May 2011, Jiri Kosina wrote:
> 
> > On Fri, 13 May 2011, Paul Parsons wrote:
> > 
> > > apm_mutex is locked by a process (e.g. apm -s) at the start of 
> > > apm_ioctl() and remains locked while pm_suspend() is called. Any 
> > > subsequent process trying to ACK the suspend (e.g. apmd) is then blocked 
> > > at the start of apm_ioctl(), causing the suspend to be delayed for 5 
> > > seconds in apm_suspend_notifier() while the ACK times out. In short, 
> > > ACKs don't work.
> > > 
> > > The driver's data structures are sufficiently protected by assorted 
> > > locks. And pm_suspend() has its own mutex to prevent reentrancy. 
> > > Consequently there is no obvious requirement for apm_mutex, which 
> > > evolved from earlier BKL calls. So let's remove it.
> > >
> > > 
> > > Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> > > ---
> > > This patch supersedes my previous "apm-emulation: Fix mutex race condition" patch; this patch fixes that earlier bug too.
> > 
> > Looks good to me (and sorry for the delay). Thanks Paul, will apply.
> 
> (unless Rafael sees any potential issue there of course ... but I myself 
> don't).

No, I don't.

Thanks,
Rafael
