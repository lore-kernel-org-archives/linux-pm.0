From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: wacom + runtime PM = AA deadlock
Date: Mon, 13 Sep 2010 11:17:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009131114050.1315-100000__27887.9741010771$1284391335$gmane$org@iolanthe.rowland.org>
References: <201009131656.18199.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009131656.18199.oneukum@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oneukum@suse.de>
Cc: pingc@wacom.com, Dmitry Torokhov <dtor@mail.ru>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-pm <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Mon, 13 Sep 2010, Oliver Neukum wrote:

> PM in this driver looks broken. Please try this.
> 
> In short you want to drop the PM reference and depend on remote
> wakeup and busy marking for this driver. Currently it gets a reference
> on every open() but never drops it.
> 
> For locking you depend on the PM core's internal lock. You simply
> make sure you have a PM reference during open() and close()

Is there any point in resuming the device during close() just in order
to kill the interrupt URB?  It seems counterproductive -- if the device 
had been suspended then there wouldn't be any interrupt URB to kill in 
the first place.

Alan Stern
