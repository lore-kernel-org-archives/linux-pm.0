From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Mon, 24 Jul 2006 17:58:47 -0400
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD018ACC7B@de01exm64.ds.mot.com>
References: <200607241446.48366.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <200607241446.48366.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
Cc: Matthew Locke <matt@nomadgs.com>, Pavel Machek <pavel@ucw.cz>, patrick.mochel@intel.com, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

If they're defined dynamically, you can change them without recompiling
the system, building a new rootfs image, etc. This is especially useful
during development and tuning of systems built on new hardware, since
the set of Ops available (that is, that are documented by the chip
vendor to work) can vary over time and even board-to-board.

scott

-----Original Message-----
From: linux-pm-bounces@lists.osdl.org
[mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of David Brownell
Sent: Monday, July 24, 2006 4:47 PM
To: linux-pm@lists.osdl.org
Cc: Matthew Locke; patrick.mochel@intel.com; linux@dominikbrodowski.net;
sampsa.fabritius@nokia.com; Pavel Machek
Subject: Re: [linux-pm] [RFC] PowerOP Take 3, sysfs UI core 2/5

On Monday 24 July 2006 12:35 pm, Pavel Machek wrote:
> =

> > > But better run this by lkml.
> > =

> > I'd rather see some rough consensus on this list that this is the =

> > right way to head, before running things like this by LKML.
> =

> I meant "they could suggest how to do the sysfs thing, in reasonable =

> way". Like echo new_config > file is extermely ugly, but perhaps =

> configfs is suitable?

Makes some sense.  But I'm still puzzled why _creating_ an operating
point would be done outside of the arch/.../board-xx.c file. =


- Dave

_______________________________________________
linux-pm mailing list
linux-pm@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/linux-pm
