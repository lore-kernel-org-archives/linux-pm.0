From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 00:01:10 +0200
Message-ID: <20050927220110.GB2381@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0509271455140.636-100000@iolanthe.rowland.org>
	<1127855345.4802.13.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============49118630090969656=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1127855345.4802.13.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============49118630090969656==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > Later on, when the system wakes up and the image is restored, drivers are 
> > > > asked to resume the devices.  The problem is that now the drivers think 
> > > > the devices are in FREEZE when in fact they are really in SUSPEND.  The 
> > > > difference is significant and it can cause errors in the resume procedure.
> > > 
> > > No; devices are in FREEZE if their driver was in kernel, and in some kind
> > > of power up state when not. Drivers should just handle both.
> > 
> > For USB, that "some kind of power up state" will in fact be SUSPEND.
> 
> Excuse me taking a step back, but I think you guys might be solving a
> problem that doesn't exist...
> 
> How do USB drivers get into a suspend state? At suspend time, before the
> atomic copy is made they have been told to FREEZE. At resume time, prior
> to the atomic restore, they have been told to FREEZE. The state

They have been told to freeze _if you have usb built in_, and not
modular. Imagine kernel with usb as a module, doing resume from kernel
command line. usb will be in "just powered on" state.

								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============49118630090969656==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============49118630090969656==--
