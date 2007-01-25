From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs
	functions in sysfs
Date: Thu, 25 Jan 2007 09:17:48 +0100
Message-ID: <200701250917.48689.rjw@sisk.pl>
References: <1168083306.5619.34.camel@localhost.localdomain>
	<200701242103.57153.lenb@kernel.org>
	<1169693548.9381.1.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1169693548.9381.1.camel@nigel.suspend2.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: nigel@nigel.suspend2.net
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday, 25 January 2007 03:52, Nigel Cunningham wrote:
> Hi.
> =

> On Wed, 2007-01-24 at 21:03 -0500, Len Brown wrote:
> > > > Patch 03-05:
> > > > 	add ACPI sleep attributes in sysfs.
> > > > 	/proc/acpi/sleep is already deprecated by /sys/power/state.
> > > =

> > > Does that mean we drop standby (S1) capability on PCs?
> > =

> > I think we need to make /sys/power/state handle S1.
> > =

> > There are two cases
> > =

> > 1. Platform supports S1, but does not support S3.
> > =

> > This is more common.  You see this a lot on server-class machines.
> > =

> > We could make "mem" simply mean S1 here b/c it is effectively
> > the closest thing to S3.
> > =

> > 2. Platform supports both S1 and S3.
> > =

> > This is pretty rare -- at least on the systems I've got.
> > I'd  like the generic interface be able to describe and handle this cas=
e.
> > =

> > I'm open to suggestions on what to call S1 if it isn't called "mem".
> =

> 'standby'? That's what occurs to me from previous M$ usage.

Yes, something like that, I think..

Greetings,
Rafael
