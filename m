From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] introduce /sys/power/disk_powerdown_mode
Date: Wed, 21 Mar 2007 15:01:36 +0100
Message-ID: <200703211501.37164.rjw@sisk.pl>
References: <1174468981.3769.8.camel@johannes.berg>
	<1174482773.4230.19.camel@johannes.berg>
	<20070321131709.GA5788@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070321131709.GA5788@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 21 March 2007 14:17, Pavel Machek wrote:
> Hi!
> =

> > > > > Does it really need to be this complex? Maybe we can disply change
> > > > > /sys/power/disk format? Is the change required at all?
> > > > =

> > > > Dunno. Does anything ever read it? Maybe the whole change isn't
> > > > necessary since this thing exists only as a hack for ACPI anyway, b=
ut if
> > > > anybody starts using it with an actual choice being able to see the
> > > > choices would imho be useful.
> > > =

> > > I believe we can just show the list of choices, without changing the
> > > name.
> > =

> > Ok, I can simplify the patch down to that, the only thing about that is
> > that it breaks userspace ABI. Dunno how people react to that with
> > suspend though :)
> =

> I do not know... maybe you can just ask akpm first. I believe we can
> do that.

I agree, but _all_ of the doocumentation will have to be updated in the same
patch (or patch series), IMHO.

Greetings,
Rafael


-- =

If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
