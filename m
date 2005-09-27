From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 07:30:34 +1000
Message-ID: <1127855345.4802.13.camel@localhost>
References: <Pine.LNX.4.44L0.0509271455140.636-100000@iolanthe.rowland.org>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============55488173898767879=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509271455140.636-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============55488173898767879==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Alan.

On Wed, 2005-09-28 at 05:02, Alan Stern wrote:
> On Tue, 27 Sep 2005, Pavel Machek wrote:
> 
> > Hi!
> > 
> > > A problem with the PM_FREEZE state has surfaced recently.
> > > 
> > > It has to do with the device state recorded in the memory image.  When the 
> > > image is made, devices are in the FREEZE state, and that's what gets 
> > > recorded.  But then the image is written to disk and devices are put into 
> > > SUSPEND.
> > > 
> > > Later on, when the system wakes up and the image is restored, drivers are 
> > > asked to resume the devices.  The problem is that now the drivers think 
> > > the devices are in FREEZE when in fact they are really in SUSPEND.  The 
> > > difference is significant and it can cause errors in the resume procedure.
> > 
> > No; devices are in FREEZE if their driver was in kernel, and in some kind
> > of power up state when not. Drivers should just handle both.
> 
> For USB, that "some kind of power up state" will in fact be SUSPEND.

Excuse me taking a step back, but I think you guys might be solving a
problem that doesn't exist...

How do USB drivers get into a suspend state? At suspend time, before the
atomic copy is made they have been told to FREEZE. At resume time, prior
to the atomic restore, they have been told to FREEZE. The state they're
told to enter when we powerdown should be irrelevant, because after that
we have powered down the whole system and then powered it back up like
we would for a normal boot. The "some kind of powered up state" should
be ON, unless the usb drivers are managing to retain power and state
across a power down and reboot (I suppose you're going to tell me they
are!).

Regards,

Nigel
> 
> ______________________________________________________________________
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
-- 



--===============55488173898767879==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============55488173898767879==--
