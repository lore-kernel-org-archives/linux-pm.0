From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: question on resume()
Date: Wed, 31 Jan 2007 12:04:40 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274293DCC43@dlee13.ent.ti.com>
References: <20070131093653.GA19643@elf.ucw.cz>
	<Pine.LNX.4.44L0.0701311048560.3803-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.44L0.0701311048560.3803-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>
Cc: Oliver Neukum <oneukum@suse.de>, Oliver Neukum <oliver@neukum.name>, pm list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


> Again you misunderstood the question.  The driver must start queued
I/O
> when its resume() method is called.  It should then be okay for the
driver
> to call wake_up_interruptible(), even before tasks are unfrozen.

I kind of like the way MontaVista worked around this in some 2.4 drivers
where no freezer is present.  A tiny amount of state is kept at the
driver and suspend lock outs are added at service entry points and at
thread wake up points inside of the driver.

This way if some process makes a request in or wakes up when the driver
is not ready for the action, that context will get re-slept.

With 2.6 on some of our variants for TI boards we still kept our suspend
lock outs even though the freezer was there.  It allows some interesting
run time idling.  You potentially can turn ON and OFF a driver
individually for something like a high latency operational mode.  I
suppose based on your comments it also works around issues in the
freezer.  It doesn't take all that many lock outs to shore up a driver.

Regards,
Richard W.
