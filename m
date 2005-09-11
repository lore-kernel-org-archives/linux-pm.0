From: "Leo L. Schwab" <ewhac@best.com>
Subject: Re: Suspended devices and drivers
Date: Sat, 10 Sep 2005 18:55:39 -0700
Message-ID: <20050911015539.GB883@best.com>
References: <Pine.LNX.4.44L0.0509042055440.6059-100000@netrider.rowland.org>
	<Pine.LNX.4.44L0.0509051257110.6343-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============66324069689854204=="
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============66324069689854204==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Apologies for the delay in response:

On Mon, Sep 05, 2005 at 01:09:04PM -0400, Alan Stern wrote:
> The floppy disk situation is about what you'd expect.  Even without 
> putting the computer to sleep, you can remove a floppy disk while a 
> program has an open file on it.  Windows just puts up a screen asking you 
> to replace the floppy, and things continue as if nothing happened.  This 
> is obviously an historical relic going back to the days of DOS.
>
	Well, not exactly.  This is what you have to do when dealing with
media that can be yanked out from under you without warning or veto.  You
have to run the filesystem with a write-through cache or no cache at all.
Thus, when you attempt to read, you simply notice there's no media present.
Throw a dialog, retry.  Is it the same volume ID?  Nope, throw a dialog,
retry.

	If you're uber-studly, all this happens completely inside the
filesystem, and the app never notices anything odd happened (except perhaps
by noticing the read() took a long time to complete).

> With the USB device, things are more interesting.  If you unplug the 
> device (even while it's not in use), Windows warns you not to do this 
> without first getting permission by using the "Eject Removable Devices" 
> button.

	What happens if you attempt to continue after this warning without
replacing the device?  What happens if you put the USB device in a
*different machine* after doing this?  Is the filesystem consistent?

> If you try to press that button while a program has a file open 
> on the device, Windows says that you can't remove the device right now and 
> advises you to try again later.
>
	Leave it to Micros~1 to fsck up something even this basic.  They're
trying to use an ungainly UI to fake a media eject request event.  If they
mounted the USB volume in write-through mode like they were supposed to,
then you should be able to yank the media any time the activity light is
off.  Further read/write attempts would notice the media was missing and
simply generate a "please put that back" dialog.

	The fact is, if you have media that can be yanked by the user
without the OS being able to stop it, then your default option should be to
mount the filesystem as write-through or uncached, or you risk filesystem
corruption.  (If the *user* requests full caching with deferred writes, then
the user takes responsibility for making sure the media doesn't go anywhere
until its explicitly unmounted.)  You should only enable deferred writes by
default if you have high confidence that either A) the medium isn't going
anywhere; or B) you have full eject control, and can properly flush and
unmount the volume when the user presses Eject.

> However...  I put the laptop into Hibernate mode.  To be absolutely sure 
> this was a true snapshot-poweroff-resume cycle, I also unplugged the power 
> cord and removed the battery.  Then I removed and replaced the USB device 
> and restarted the laptop.  Everything worked smoothly; the file remained 
> open and the program was able to continue reading it, well past the point 
> where the I/O buffers needed to be refilled.
>
	A far more interesting experiment would be to hibernate the machine,
remove the USB device, resume the machine, then replace the USB device and
see how Windows reacts.  (Still more interesting tests: Attempt to continue
without replacing the device, replace the USB device in a different socket.)

					Schwab

--===============66324069689854204==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============66324069689854204==--
