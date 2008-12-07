From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
	and resume
Date: Sun, 7 Dec 2008 09:26:42 -0800
Message-ID: <20081207172642.GC23744__43487.6621388414$1228753447$gmane$org@kroah.com>
References: <200812020320.31876.rjw@sisk.pl>
	<alpine.LFD.2.00.0812060952100.3425@nehalem.linux-foundation.org>
	<20081207054149.GA20415@kroah.com> <200812071347.18608.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200812071347.18608.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 07, 2008 at 01:47:18PM +0100, Rafael J. Wysocki wrote:
> On Sunday, 7 of December 2008, Greg KH wrote:
> > On Sat, Dec 06, 2008 at 10:00:35AM -0800, Linus Torvalds wrote:
> > > 
> > > 
> > > On Sat, 6 Dec 2008, Rafael J. Wysocki wrote:
> > > > 
> > > > So, to fix the issue at hand, I'd like the $subject patch to go first.  Then,
> > > > there is a major update of the new framework waiting for .29 in the Greg's
> > > > tree (that's the main reason why nobody uses it so far, BTW) and I'd really
> > > > prefer it to go next.  After it's been merged, I'm going to add the mandatory
> > > > suspend-resume things (save state and go to a low power state on suspend,
> > > > restore state on resume) to the new framework in a separete patch.
> > > > 
> > > > Is this plan acceptable?
> > > 
> > > Sounds good to me. And assuming Jesse/Greg are all aboard, I'll just wait 
> > > for the pull requests from Jesse and Greg.
> > 
> > No objection from me, I'll wait for Jesse to "go first" in the .29 merge
> > window.
> 
> Unfortunately, the merge of the $subject patch with the one in your tree
> results in code that doesn't compile.  Namely, some lines of code that the
> $subject patch relies on are removed by the patch in your tree.
> 
> If there is no objection from Jesse and if you don't mind, I'll prepare a
> version of the $subject patch on top of the patch in your tree and send it to
> you.

I sure don't mind.

thanks,

greg k-h
