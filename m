From: David Brownell <david-b@pacbell.net>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 14:20:22 -0700
Message-ID: <20050928212022.6743AE3727@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <1127877808.4802.74.camel@localhost>
	<Pine.LNX.4.44L0.0509281151140.4491-100000@iolanthe.rowland.org>
	<20050928205319.GC2506@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============97946098759662092=="
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
To: stern@rowland.harvard.edu, pavel@ucw.cz
Cc: ncunningham@cyclades.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============97946098759662092==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > You need to state these things carefully.  A complete power-off does
> > reset/disconnect USB devices.  However, turning off your computer
> > might not do a complete power-off; it may well leave suspend current 
> > available.  If that's true, USB devices won't be disconnected.
>
> Examples, please. Thinkpad X32 certainly does not provide power on USB
> when turned off.

I think Alan's point applies more directly to things like ACPI S4
state than ACPI S5 (off) ... it's quite legit for USB controllers
to maintain VBUS power even after entering D3cold, which they'll
often do in S4 sleep.

EHCI for example is carefully specified in terms of what registers
are powered through PCI VAUX, and it's designed to support remote
wakeup from D3cold.  VAUX provides suspend current to the various
USB devices that are connected, which can initiate remote wakeup
by pulling D+ high for long enough (maybe 20 msec).

- Dave


--===============97946098759662092==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============97946098759662092==--
