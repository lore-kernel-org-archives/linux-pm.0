From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 17:15:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509281713490.5193-100000@iolanthe.rowland.org>
References: <20050928205319.GC2506@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8049697066246484=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050928205319.GC2506@elf.ucw.cz>
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
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============8049697066246484==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 28 Sep 2005, Pavel Machek wrote:

> > You need to state these things carefully.  A complete power-off does
> > reset/disconnect USB devices.  However, turning off your computer
> > might not do a complete power-off; it may well leave suspend current 
> > available.  If that's true, USB devices won't be disconnected.
> 
> Examples, please. Thinkpad X32 certainly does not provide power on USB
> when turned off.

I don't have any examples.  However you're more likely to find suspend 
current available on a desktop system than on a laptop, I imagine.  Those 
big power supplies don't really turn off all the way unless you unplug 
them from the wall socket.

Alan Stern


--===============8049697066246484==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============8049697066246484==--
