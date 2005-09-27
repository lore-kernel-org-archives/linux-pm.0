From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 09:19:58 +1000
Message-ID: <1127863145.4802.40.camel@localhost>
References: <Pine.LNX.4.44L0.0509271455140.636-100000@iolanthe.rowland.org>
	<1127855345.4802.13.camel@localhost> <20050927220110.GB2381@elf.ucw.cz>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============41565325700975841=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050927220110.GB2381@elf.ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============41565325700975841==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Wed, 2005-09-28 at 08:01, Pavel Machek wrote:
> Hi!
> 
> > > > > Later on, when the system wakes up and the image is restored, drivers are 
> > > > > asked to resume the devices.  The problem is that now the drivers think 
> > > > > the devices are in FREEZE when in fact they are really in SUSPEND.  The 
> > > > > difference is significant and it can cause errors in the resume procedure.
> > > > 
> > > > No; devices are in FREEZE if their driver was in kernel, and in some kind
> > > > of power up state when not. Drivers should just handle both.
> > > 
> > > For USB, that "some kind of power up state" will in fact be SUSPEND.
> > 
> > Excuse me taking a step back, but I think you guys might be solving a
> > problem that doesn't exist...
> > 
> > How do USB drivers get into a suspend state? At suspend time, before the
> > atomic copy is made they have been told to FREEZE. At resume time, prior
> > to the atomic restore, they have been told to FREEZE. The state
> 
> They have been told to freeze _if you have usb built in_, and not
> modular. Imagine kernel with usb as a module, doing resume from kernel
> command line. usb will be in "just powered on" state.

Yes, that's true. If the usb modules are loaded when suspending and not
loaded when resuming or vice versa, you'll get inconsistencies:

State at suspend	State at resume		Image state

Built in		Built in		Freeze->Freeze
Loaded modules		Unloaded modules	Undefined->Freeze
Unloaded modules	Loaded modules		Freeze->Undefined

I guess there are three possible solutions:
1) Leave things as they are and say it is the user's problem if they
make the state inconsistent.
2) Keep knowledge of the device states across the atomic restore and use
that information in deciding what to do in device resume/powerup.
3) Make device drivers handle the situation properly without knowledge
of what state the hardware is really in (or check the real state - where
possible - and rely on that in deciding what to do).

2 seems to me to make for the most reliable solution.

Regards,

Nigel
> 								Pavel
-- 



--===============41565325700975841==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============41565325700975841==--
