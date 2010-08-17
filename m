From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Tue, 17 Aug 2010 11:00:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008171056100.1656-100000__19831.9965661087$1282057275$gmane$org@iolanthe.rowland.org>
References: <201008171518.14069.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008171518.14069.rjw@sisk.pl>
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
Cc: peterz@infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Ted Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Aug 2010, Rafael J. Wysocki wrote:

> > In general, we try to keep such complexity out of the
> > kernel, but not always; there are compelling cases for putting
> > complexity in the kernel to provide uniformity and flexibility (e.g.
> > application state save/restore vs. system-wide checkpoints, the former
> > preserves the "if it can be done outside the kernel, it should be",
> > while the latter provides much greater flexibility and avoids the need
> > to port applications to potentially incompatible or unportable state
> > saves/restore libraries).
> 
> I understand that and IMO it should be decided on the case-by-case basis.
> In this particular case, however, I don't think it's appropriate to use the
> interface designed with user space in mind for implementing a kernel-based
> mechanism.

Putting the "opportunistic suspend" loop into the kernel doesn't save 
as much as one might think.  The loop itself is quite simple, and the 
task switch it entails is required in any case (since suspend must be 
carried out within a process context).  Putting it in the kernel would 
save a few user/kernel context switches, not enough to matter IMO.  And 
it wouldn't offer any greater flexibility -- it might even cut down the 
flexibility.

Alan Stern
