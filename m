From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspended devices and drivers
Date: Mon, 5 Sep 2005 13:09:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509051257110.6343-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0509042055440.6059-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============39301144668770926=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509042055440.6059-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============39301144668770926==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 4 Sep 2005, Alan Stern wrote:

> P.S.: Does anyone know how Windows behaves if a running program has files
> open on a floppy disk (or a USB disk) across a Hibernate?  I should try
> the experiment...

I tried it on my laptop, which has an old copy of Windows ME.

The floppy disk situation is about what you'd expect.  Even without 
putting the computer to sleep, you can remove a floppy disk while a 
program has an open file on it.  Windows just puts up a screen asking you 
to replace the floppy, and things continue as if nothing happened.  This 
is obviously an historical relic going back to the days of DOS.

With the USB device, things are more interesting.  If you unplug the 
device (even while it's not in use), Windows warns you not to do this 
without first getting permission by using the "Eject Removable Devices" 
button.  If you try to press that button while a program has a file open 
on the device, Windows says that you can't remove the device right now and 
advises you to try again later.

However...  I put the laptop into Hibernate mode.  To be absolutely sure 
this was a true snapshot-poweroff-resume cycle, I also unplugged the power 
cord and removed the battery.  Then I removed and replaced the USB device 
and restarted the laptop.  Everything worked smoothly; the file remained 
open and the program was able to continue reading it, well past the point 
where the I/O buffers needed to be refilled.

If Windows ME can do this, Linux should be able to do it too.

Alan Stern


--===============39301144668770926==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============39301144668770926==--
