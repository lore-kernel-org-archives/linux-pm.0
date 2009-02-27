From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 27 Feb 2009 09:46:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902270943490.2926-100000__1689.78617662123$1235746127$gmane$org@iolanthe.rowland.org>
References: <20090227101632.GG4582@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090227101632.GG4582@elf.ucw.cz>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 27 Feb 2009, Pavel Machek wrote:

> 
> > To summarize, we can:
> > * Use a refcount such that automatic suspend will only be possible if it's
> >   equal to zero (but that need not be the only criterion).
> > * Use a per-device flag in dev_pm_info that will be set whenever the device
> >   driver increases the refcount and unset whenever the driver decreases the
> >   refcount.
> > * Use a per-process flag that will be set whenever the process increases the
> >   refcount and unset whenever the process decreases the refcount.
> 
> Yes, that sounds sane, and that's how reasonable wakelock
> implementation should look like.

One small point: If you add a per-device flag and a per-process flag as 
described above, then drivers and processes must not acquire nested 
references.

Obviously this is fixable, but it's worth mentioning...

Alan Stern
