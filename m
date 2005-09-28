From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 15:51:30 +0200
Message-ID: <200509281551.30587.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0509271455140.636-100000@iolanthe.rowland.org>
	<1127863145.4802.40.camel@localhost>
	<20050928130405.GB2118@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36974400711493161=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050928130405.GB2118@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============36974400711493161==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Wednesday, 28 of September 2005 15:04, Pavel Machek wrote:
> Hi!
> 
> > I guess there are three possible solutions:
> > 1) Leave things as they are and say it is the user's problem if they
> > make the state inconsistent.
> > 2) Keep knowledge of the device states across the atomic restore and use
> > that information in deciding what to do in device resume/powerup.
> > 3) Make device drivers handle the situation properly without knowledge
> > of what state the hardware is really in (or check the real state - where
> > possible - and rely on that in deciding what to do).
> > 
> > 2 seems to me to make for the most reliable solution.
> 
> I actually like 3 most -- it does not need core changes.

IMO if the driver is a module it should not make any assumptions
on the state of the device when its resume routine is called.  Instead,
it should assume the device can be in an arbitrary state and proceed
in the safest way possible.  Which is 3.

Greetings,
Rafael

--===============36974400711493161==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============36974400711493161==--
