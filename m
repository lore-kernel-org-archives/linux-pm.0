From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 22:51:06 +0200
Message-ID: <20050928205106.GA2506@elf.ucw.cz>
References: <200509281551.30587.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0509281451010.5193-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============82217583044084974=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509281451010.5193-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============82217583044084974==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > IMO if the driver is a module it should not make any assumptions
> > on the state of the device when its resume routine is called.  Instead,
> > it should assume the device can be in an arbitrary state and proceed
> > in the safest way possible.  Which is 3.
> 
> That's what it should do when resuming from disk.
> 
> But that's not what it should do when it's being resumed just after the
> memory image was created, in order to write out the image.  In this case
> the device is known to be in FREEZE, not SUSPEND, and to save time we
> would like the driver not to go through a full resume procedure.

Do you have any driver which can save some significant ammount of time
that way?
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============82217583044084974==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============82217583044084974==--
