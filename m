From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspended devices and drivers
Date: Sun, 11 Sep 2005 15:03:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509111359240.9186-100000@netrider.rowland.org>
References: <20050911015539.GB883@best.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============92213706152557395=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050911015539.GB883@best.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Leo L. Schwab" <ewhac@best.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============92213706152557395==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 10 Sep 2005, Leo L. Schwab wrote:

> 	Apologies for the delay in response:
> 
> On Mon, Sep 05, 2005 at 01:09:04PM -0400, Alan Stern wrote:
> > The floppy disk situation is about what you'd expect.  Even without 
> > putting the computer to sleep, you can remove a floppy disk while a 
> > program has an open file on it.  Windows just puts up a screen asking you 
> > to replace the floppy, and things continue as if nothing happened.  This 
> > is obviously an historical relic going back to the days of DOS.
> >
> 	Well, not exactly.

Why do you say "not exactly"?  All your comments below are consistent with 
what I wrote.

>  This is what you have to do when dealing with
> media that can be yanked out from under you without warning or veto.  You
> have to run the filesystem with a write-through cache or no cache at all.
> Thus, when you attempt to read, you simply notice there's no media present.
> Throw a dialog, retry.  Is it the same volume ID?  Nope, throw a dialog,
> retry.

Yes, but it's not really a dialog.  That is, Windows does not display a
dialog window or a message box.  Instead it goes to a white-on-blue screen
in text mode (rather resembling the BSOD).  It's sort of a souped-up
version of the old "Abort, retry, or ignore?" message.

> 	If you're uber-studly, all this happens completely inside the
> filesystem, and the app never notices anything odd happened (except perhaps
> by noticing the read() took a long time to complete).
> 
> > With the USB device, things are more interesting.  If you unplug the 
> > device (even while it's not in use), Windows warns you not to do this 
> > without first getting permission by using the "Eject Removable Devices" 
> > button.
> 
> 	What happens if you attempt to continue after this warning without
> replacing the device?

The program continued reading until it exhausted some buffer, then it
stopped exactly as though it had reached end-of-file.  Maybe it got an
error return from the OS and didn't tell me about it, or maybe the file
descriptor was summarily closed.

>  What happens if you put the USB device in a
> *different machine* after doing this?  Is the filesystem consistent?

I don't know, and I don't really care.  With this particular experiment it 
certainly would be consistent, because I wasn't doing any writing, only 
reading.

> > If you try to press that button while a program has a file open 
> > on the device, Windows says that you can't remove the device right now and 
> > advises you to try again later.
> >
> 	Leave it to Micros~1 to fsck up something even this basic.  They're
> trying to use an ungainly UI to fake a media eject request event.  If they
> mounted the USB volume in write-through mode like they were supposed to,
> then you should be able to yank the media any time the activity light is
> off.  Further read/write attempts would notice the media was missing and
> simply generate a "please put that back" dialog.
> 
> 	The fact is, if you have media that can be yanked by the user
> without the OS being able to stop it, then your default option should be to
> mount the filesystem as write-through or uncached, or you risk filesystem
> corruption.  (If the *user* requests full caching with deferred writes, then
> the user takes responsibility for making sure the media doesn't go anywhere
> until its explicitly unmounted.)  You should only enable deferred writes by
> default if you have high confidence that either A) the medium isn't going
> anywhere; or B) you have full eject control, and can properly flush and
> unmount the volume when the user presses Eject.

Things aren't that simple.  First, bear in mind that most removable USB
devices used with Windows have VFAT filesystems, which require constant 
updating of the FATs while writing new files.  Next, bear in mind that 
flash memory devices tend to behave very badly when the same sectors are 
written over and over again.  Performance suffers and eventually those 
sectors stop working entirely.

The upshot is that you're much better off caching the metadata updates, at
least for short periods or until a file is closed.  There are messages in
the email archives describing the problems people started to encounter
when the VFAT driver in Linux finally implemented "-o sync" correctly.  
For a good summary look at bug #4882 in the OSDL Bugzilla.

> > However...  I put the laptop into Hibernate mode.  To be absolutely sure 
> > this was a true snapshot-poweroff-resume cycle, I also unplugged the power 
> > cord and removed the battery.  Then I removed and replaced the USB device 
> > and restarted the laptop.  Everything worked smoothly; the file remained 
> > open and the program was able to continue reading it, well past the point 
> > where the I/O buffers needed to be refilled.
> >
> 	A far more interesting experiment would be to hibernate the machine,
> remove the USB device, resume the machine, then replace the USB device and
> see how Windows reacts.

Just tried it, several times.  On some of the occasions the hibernate
failed, even before I removed the device (the computer never shut down
fully -- don't ask me why not).  On the occasions when it did go to sleep
properly, resuming without the device plugged in succeeded provided I
wasn't running a program with an open file on the device.  There wasn't
even a message box warning about my failure to use the "Eject removable
media" button.

If a program _was_ running with an open file on the device, then after 
unplugging the device the resume from hibernate failed.  It hung up at 
some stage after restoring the memory image, and I gave up on it after two 
minutes.  Even plugging the device back in didn't help.  However, cycling 
the power, plugging the device back in, and trying to resume over again 
did work.

>  (Still more interesting tests: Attempt to continue
> without replacing the device, replace the USB device in a different socket.)

Not feasible on my system.  Still, this is only Windows ME.  I would
expect XP to be considerably more robust.  I haven't had a chance yet to
try doing these sorts of things on an XP system.  _You_ could do some
experiments, if you have access to such a machine.

Alan Stern


--===============92213706152557395==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============92213706152557395==--
