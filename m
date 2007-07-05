From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 23:37:26 +0200
Message-ID: <200707052337.27066.oliver__9366.14711904458$1183671497$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0707051713440.2753-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707051713440.2753-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 5. Juli 2007 schrieb Alan Stern:
> On Thu, 5 Jul 2007, Miklos Szeredi wrote:
> 
> > I fear, that your efforts to "save" the freezer are in vain.  It is
> > already moderately hackish with that PF_FREEZER_SKIP and the kernel
> > dotted randomly with try_to_freeze() calls, but adding bandaids to try
> > to order freezing userspace processes in the right order would just
> > make it a horrible mess.
> 
> I agree that bandaids won't work.  What's needed is something more 
> radical.  Things like FUSE must be written so that the kernel parts 
> _can_ freeze even while they are waiting for a response from a user 
> thread.

OK, some radical ideas.

In principle we want a deadlock here. Tasks that are frozen due to fuse
are as good as frozen, there's no need to formally freeze them.
The bad uninterruptible tasks are those waiting for hardware.

Can we detect the difference? Perhaps we can label those crucial locks
and when only tasks in the refrigerator and tasks waiting on these locks
are left we are content and go on to suspending the device tree.

	Flame away
		Oliver
