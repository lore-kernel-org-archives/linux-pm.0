From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 12:24:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606241220100.19990-100000@netrider.rowland.org>
References: <Pine.LNX.4.64.0606232029200.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606232029200.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, 23 Jun 2006, Linus Torvalds wrote:

> Ok, here.
> =

> This simple patch is nothing but cleanups, cleanups, cleanups.

>  - "suspend_prepare()" is called for every device (with the semaphore =

>    held, you are _not_ allowed to try to unlink yourself in the prepare =

>    function)

There should be a big fat warning about this somewhere, maybe added to the =

documentation.  It's quite possible for dpm_list_sem to be acquired while =

holding a device's lock; since the suspend_prepare() method is called =

while holding dpm_list_sem it therefore mustn't do _anything_ to acquire =

any device's lock.  That includes plenty of other actions in addition to =

unregistering the device.

In particular, it may complicate synchronization between suspend_prepare() =

and the rest of the driver.

Alan Stern
