From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 23:18:22 +0200
Message-ID: <20050928211822.GE2506@elf.ucw.cz>
References: <20050928205319.GC2506@elf.ucw.cz>
	<Pine.LNX.4.44L0.0509281713490.5193-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1647365580528084=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509281713490.5193-100000@iolanthe.rowland.org>
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

--===============1647365580528084==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On St 28-09-05 17:15:21, Alan Stern wrote:
> On Wed, 28 Sep 2005, Pavel Machek wrote:
> 
> > > You need to state these things carefully.  A complete power-off does
> > > reset/disconnect USB devices.  However, turning off your computer
> > > might not do a complete power-off; it may well leave suspend current 
> > > available.  If that's true, USB devices won't be disconnected.
> > 
> > Examples, please. Thinkpad X32 certainly does not provide power on USB
> > when turned off.
> 
> I don't have any examples.  However you're more likely to find suspend 
> current available on a desktop system than on a laptop, I imagine.  Those 
> big power supplies don't really turn off all the way unless you unplug 
> them from the wall socket.

USB takes enough power to be connected to 5V, not 5V-standby. Sorry.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============1647365580528084==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1647365580528084==--
