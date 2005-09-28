From: David Brownell <david-b@pacbell.net>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 14:08:37 -0700
Message-ID: <20050928210837.02F19E3727@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <200509281551.30587.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0509281451010.5193-100000@iolanthe.rowland.org>
	<20050928205106.GA2506@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============19361336992746381=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050928205106.GA2506@elf.ucw.cz>
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

--===============19361336992746381==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > But that's not what it should do when it's being resumed just after the
> > memory image was created, in order to write out the image.  In this case
> > the device is known to be in FREEZE, not SUSPEND, and to save time we
> > would like the driver not to go through a full resume procedure.
>
> Do you have any driver which can save some significant ammount of time
> that way?

If there is no such driver, then there's no need for the FREEZE state.


--===============19361336992746381==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============19361336992746381==--
