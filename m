From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] swsusp: warn about USB devices in
	documentation
Date: Mon, 20 Feb 2006 11:41:49 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0602201139480.18560-100000@netrider.rowland.org>
References: <20060220163707.GA19156@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============83945753152863078=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060220163707.GA19156@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============83945753152863078==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 20 Feb 2006, Pavel Machek wrote:

> Hi!
> > > > Can you update the patch to fix this paragraph?
> > > 
> > > Well, this is talking about suspend-to-disk... That is expected to
> > > power down machine, without providing USB bus power. If box
> > > suspends-to-disk and leaves USB up, something is wrong with the
> > > machine.
> > 
> > Oh, sorry, I didn't realize that.
> > 
> > Isn't there an ACPI mode that powers down most things (including RAM) but
> > is able to respond to wakeup events?  I can't remember the mode's name,
> > except that it's almost certainly "S" followed by some meaningless number
> > followed by some unhelpful word. :-)  Since USB plug/unplug is potentially
> > a wakeup event, such a mode must provide suspend power to the USB
> > controller.
> 
> Maybe S4 does that, but I'm not sure...
> 
> > Does swsusp still support these not-completely-powered-off modes?
> 
> Yes. echo platform > /sys/power/disk.

So if you did that, you could suspend-to-disk while leaving USB up, right?  
Without anything being wrong with the machine.

Alan Stern


--===============83945753152863078==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============83945753152863078==--
