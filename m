From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] swsusp: warn about USB devices in
	documentation
Date: Mon, 20 Feb 2006 14:23:58 +0100
Message-ID: <200602201423.59306.rjw@sisk.pl>
References: <200602192306.25170.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0602192243020.29356-100000@netrider.rowland.org>
	<20060220103424.GA16042@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060220103424.GA16042@elf.ucw.cz>
Content-Disposition: inline
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

Hi,

On Monday 20 February 2006 11:34, Pavel Machek wrote:
> > > The appended patch contains a warning about the possiblity to lose data
> > > if any filesystems on USB devices are mounted before suspend.
> > > 
> > > The A:-Q: part is from my correspondence with Alan Stern (thanks Alan).
> > 
> > > --- linux-2.6.16-rc3-mm1.orig/Documentation/power/swsusp.txt
> > > +++ linux-2.6.16-rc3-mm1/Documentation/power/swsusp.txt
> > > @@ -17,6 +17,11 @@ Some warnings, first.
> > >   * but it will probably only crash.
> > >   *
> > >   * (*) suspend/resume support is needed to make it safe.
> > > + *
> > > + * If you have any filesystems on USB devices mounted before suspend,
> > > + * they won't be mounted after resume and you may lose data, as though
> > > + * you have unplugged the USB devices with mounted filesystems on them
> > > + * (see the FAQ below for details).
> > 
> > This isn't quite right.  The filesystems _will_ still be mounted, but 
> > inaccessible (as though you have unplugged the USB devices with mounted 
> > filesystems on them).
> > 
> > Furthermore, this may or may not happen depending on your hardware and the
> > type of suspend.  So the "you _may_ lose data" part is good... but the
> > "they _won't_ be mounted" part is bad.  On some types of machines (I've
> > heard that Apple laptops work well) the process is very reliable; so long 
> > as the battery doesn't discharge entirely -- and provided you don't 
> > actually unplug the device while the machine is asleep -- you can resume 
> > safely with filesystems intact.
> > 
> > Can you update the patch to fix this paragraph?
> 
> Well, this is talking about suspend-to-disk... That is expected to
> power down machine, without providing USB bus power. If box
> suspends-to-disk and leaves USB up, something is wrong with the
> machine.

Still the filesystems will in fact be mounted but inaccessible.  Perhaps we
should replace "they won't be mounted after resume" with
"they won't be accessible after resume".  Would that be right Alan?

Rafael
