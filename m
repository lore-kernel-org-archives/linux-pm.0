From: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: [PATCH][RFC] Kill off legacy power management stuff.
Date: Wed, 18 Apr 2007 14:31:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704181427470.13500@localhost.localdomain>
References: <Pine.LNX.4.64.0704122025380.3628@CPE00045a9c397f-CM001225dbafb6>
	<200704131022.45315.rjw@sisk.pl> <46254666.2020308@tmr.com>
	<Pine.LNX.4.64.0704172045100.18821@localhost.localdomain>
	<46265F60.4040600@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46265F60.4040600@tmr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Apr 2007, Bill Davidsen wrote:

> Robert P. J. Day wrote:
...
> > um ... what does APM have to do with legacy PM?  two different
> > issues, no?

> Since the patches are going into apm.c and apm was used for suspend
> and poweroff before ACPI was a feature of the hardware, I assume
> there's a relationship. As of 2.6.9 ACPI still couldn't power down
> one of my old boxes, it hasn't been updated since that time, so I
> can't say what later kernels will do.

perhaps i completely misunderstood what i was looking at but when i
submitted a patch to remove "legacy power management," i wasn't
referring to APM.  i was talking about the PM stuff even *older* than
that, that's listed as "Legacy Power Management API (DEPRECATED)"
under the PM config menu.

so, politics and scheduling aside, was that earlier patch a reasonable
and correct way to do *that*?

rday

-- =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=3DMain_Page
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
