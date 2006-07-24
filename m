From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Mon, 24 Jul 2006 14:46:46 -0700
Message-ID: <200607241446.48366.david-b@pacbell.net>
References: <c55240ed0607201256q2d902a0nd3e9e3fba4ac9dd8@mail.gmail.com>
	<200607241149.01700.david-b@pacbell.net>
	<20060724193545.GA2806@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060724193545.GA2806@elf.ucw.cz>
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
To: linux-pm@lists.osdl.org
Cc: Matthew Locke <matt@nomadgs.com>, patrick.mochel@intel.com, linux@dominikbrodowski.net, sampsa.fabritius@nokia.com, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Monday 24 July 2006 12:35 pm, Pavel Machek wrote:
> =

> > > But better run this by lkml.
> > =

> > I'd rather see some rough consensus on this list that this is the right=
 way
> > to head, before running things like this by LKML.  =

> =

> I meant "they could suggest how to do the sysfs thing, in reasonable
> way". Like echo new_config > file is extermely ugly, but perhaps configfs
> is suitable?

Makes some sense.  But I'm still puzzled why _creating_ an operating point
would be done outside of the arch/.../board-xx.c file. =


- Dave
