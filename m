From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 22:53:19 +0200
Message-ID: <20050928205319.GC2506@elf.ucw.cz>
References: <1127877808.4802.74.camel@localhost>
	<Pine.LNX.4.44L0.0509281151140.4491-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============39301697276576719=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509281151140.4491-100000@iolanthe.rowland.org>
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
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============39301697276576719==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On St 28-09-05 12:17:33, Alan Stern wrote:
> [Replying to two people at once]
> 
> On Wed, 28 Sep 2005, Nigel Cunningham wrote:
> On Wed, 28 Sep 2005, David Brownell wrote:
> 
> > > 	If the image does contain USB drivers and the boot kernel
> > > 	did not meddle with the device states, then the devices
> > > 	will be suspended even though the image thinks they are
> > > 	frozen.
> > 
> > So a power off or reboot doesn't reset the USB devices?
> 
> > Those would reset them, yes ... or more to the point, disconnect
> > them.  All the checkpoint/resume style PM scenarios should trigger
> > disconnection for every USB device.  (And in fact they do, with
> > the USB PM fixes upcoming for 2.6.15 ... that seems to have been
> > broken in the past few releases.)
> 
> You need to state these things carefully.  A complete power-off does
> reset/disconnect USB devices.  However, turning off your computer
> might not do a complete power-off; it may well leave suspend current 
> available.  If that's true, USB devices won't be disconnected.

Examples, please. Thinkpad X32 certainly does not provide power on USB
when turned off.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============39301697276576719==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============39301697276576719==--
