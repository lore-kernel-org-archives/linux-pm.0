From: David Brownell <david-b@pacbell.net>
Subject: Re: Suspended devices and drivers
Date: Mon, 05 Sep 2005 16:27:00 -0700
Message-ID: <20050905232700.A599CD4380@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509051257110.6343-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============40608623013347467=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509051257110.6343-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============40608623013347467==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> With the USB device, things are more interesting.  If you unplug the
> device (even while it's not in use), Windows warns you not to do this
> without first getting permission by using the "Eject Removable Devices"
> button.  If you try to press that button while a program has a file open
> on the device, Windows says that you can't remove the device right now and
> advises you to try again later.

So it's inconsistent in behavior, since this isn't how it handles
the same thing during resume-from-hibernate ...


> However...  I put the laptop into Hibernate mode.  To be absolutely sure
> this was a true snapshot-poweroff-resume cycle, I also unplugged the power
> cord and removed the battery.  Then I removed and replaced the USB device
> and restarted the laptop.  Everything worked smoothly; the file remained
> open and the program was able to continue reading it, well past the point
> where the I/O buffers needed to be refilled.

So basically there's a special case somewhere to treat _this_ disconnect
differently than other ones.

How does real suspend behave (like STR)?  How does it handle cases where you
plug in a different instance of the same device ... example, different CF
card in a CF reader?  Or when you move the device to another port?  And
does XP behave identically?


> If Windows ME can do this, Linux should be able to do it too.

That argument can be stretched too far!  Though from time to time I have
indeed wished for something more like a BSOD.  An oops hidden in a logfile
that never gets flushed to disk, with an X desktop, gives no clues ... :)

Linux certainly _could_ try to emulate up all the fault handling of some
version of Windows.  But whether it _should_ is a different story.

- Dave



--===============40608623013347467==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============40608623013347467==--
