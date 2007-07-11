From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: sysrq-t dumps of s2ram/fuse deadlock (was Re:
	[PATCH] Remove process freezer from suspend to RAM pathway)
Date: Wed, 11 Jul 2007 14:28:20 +0100
Message-ID: <20070711132819.GA5753__17666.0380945124$1184160719$gmane$org@srcf.ucam.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031456.36027.rjw@sisk.pl> <20070709132905.GA5212@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070709132905.GA5212@ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 09, 2007 at 01:29:05PM +0000, Pavel Machek wrote:
> Hi!
> 
> Can we get them? They are neccessary for debugging 'what in suspend
> calls fuse' problem. And yes, that problem is there even when you
> remove freezer.

I can produce them, but haven't managed to do that in any way that lets 
me get them off the system yet.

> Matthew, you seem to be the only one able to produce them...

sys_sync may not do anything on a fuse filesystem, but if you've 
loopback-mounted an ext3 filesystem from that fuse filesystem then it's 
going to result in writes to it and deadlock.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
