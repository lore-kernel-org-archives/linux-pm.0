From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 17:05:26 +0100
Message-ID: <20070703160526.GA24334@srcf.ucam.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<Pine.LNX.4.44L0.0707031200240.3936-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0707031200240.3936-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 03, 2007 at 12:03:33PM -0400, Alan Stern wrote:
> On Tue, 3 Jul 2007, Matthew Garrett wrote:
> 
> > Suspend to RAM on a machine with / on a fuse filesystem turns out to be 
> > a screaming nightmare - either the suspend fails because syslog (for 
> > instance) can't be frozen, or the machine deadlocks for some other 
> > reason I haven't tracked down. We could "fix" fuse, or alternatively we 
> > could do what we do for suspend to RAM on other platforms (PPC and APM) 
> > and just not use the freezer.
> 
> Quite apart from the sync() matter, _any_ synchronous call to a FUSE 
> filesystem during STR will cause trouble.  Even if the user task 
> implementing the filesystem isn't frozen, when it tries to carry out 
> some I/O to a suspended device it will either:
> 
> 	block until the system wakes up, or

For the suspend to RAM case, that sounds absolutely fine.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
