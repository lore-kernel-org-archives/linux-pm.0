From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 13:37:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010131335580.2311-100000__6262.66055410287$1286991577$gmane$org@iolanthe.rowland.org>
References: <AANLkTi=ouKDuPgUgLOwfBPhWKM=RCoh8hb0tY3h53i2r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=ouKDuPgUgLOwfBPhWKM=RCoh8hb0tY3h53i2r@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sundar <sunder.svit@gmail.com>
Cc: "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Oct 2010, Sundar wrote:

> On Wed, Oct 13, 2010 at 7:40 PM, Alan Stern <stern@rowland.harvard.edu> w=
rote:
> >
> > Absolutely. =A0Another point worth mentioning is that a device in
> > runtime-suspend can be resumed at any time, for a variety of reasons
> > unconnected with anything the user does. =A0While it is back at full
> > power, there is nothing to stop it from generating events.
> >
> =

> Well, so are you still aligned that we can support low power or enable/di=
sable
> switches for devices via the standard PM helpers; even if it is the "acce=
lerated
> suspend" way ( if Rafael thinks otherwise)

Sorry, I don't quite understand your question.  I think it would be
okay to add an interface for userspace to cut short a runtime-suspend
delay, but I don't think anything more is needed.

Alan Stern
