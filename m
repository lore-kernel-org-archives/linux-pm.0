From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Fri, 13 Jan 2006 01:16:40 +0100
Message-ID: <20060113001640.GD10088@elf.ucw.cz>
References: <200601122241.07363.rjw@sisk.pl>
	<20060112220940.GA10088@elf.ucw.cz>
	<200601130031.34624.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============96943880090445544=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200601130031.34624.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============96943880090445544==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > +commands defined in kernel/power/power.h.  The major and minor
> > > +numbers of the device are, respectively, 10 and 231, and they can
> > > +be read from /sys/class/misc/snapshot/dev.
> > 
> > Is this still true?
> 
> You mean the /sys/class/misc/snapshot/dev?  Yes, until sysfs gets revamped.

Ahha, but it is not your code but misc-handling code in kernel, right?

> > > +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (the last argument
> > > +	should be a pointer to an unsigned int variable that will contain
> > > +	the result if the call is successful)
> > 
> > Is this good idea? It will overflow on 32-bit systems. Ammount of
> > available swap can be >4GB. [Or maybe it is in something else than
> > bytes, then you need to specify it.]
> 
> It returns the number of pages.  Well, it should be written explicitly,
> so I'll fix that.
> 
> [This feature is actually useful, because it allows you to check if you have
> enough swap after creating the snapshot and retry for eg. image_size = 0
> without unfreezing tasks.]

Ok. [I was asking about unsigned int, it is clear that querying
available swap is useful]. If you return swap offsets, you may want to
specify if it is #bytes/#pages, too.

> > Ouch and you have my ACK on next attempt :-).
> 
> Thanks (you are brave, though ;-)).

I... think you can call it "brave", yes. Nice euphemism ;-)))).
								Pavel
-- 
Thanks, Sharp!

--===============96943880090445544==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============96943880090445544==--
