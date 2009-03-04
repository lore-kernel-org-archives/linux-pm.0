From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] [Patch] Fix device_move() vs. dpm list
	ordering, v2
Date: Wed, 4 Mar 2009 10:59:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0903041058010.3064-100000@iolanthe.rowland.org>
References: <20090304124400.6822dd83@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090304124400.6822dd83@gondolin>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Greg KH <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Mar 2009, Cornelia Huck wrote:

> dpm_list currently relies on the fact that child devices will
> be registered after their parents to get a correct suspend
> order. Using device_move() however destroys this assumption, as
> an already registered device may be moved under a newly registered
> one.
> 
> This patch adds a new argument to device_move(), allowing callers
> to specify how dpm_list should be adapted.

I like this version much better.  device_move() is now a little more 
complicated, but the callers are considerably simpler.

Alan Stern
