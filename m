From: Stefan Seyfried <seife@suse.de>
Subject: Re: Hibernation considerations
Date: Wed, 1 Aug 2007 18:58:15 +0200
Message-ID: <20070801165815.GA19065__26227.1414780573$1185987581$gmane$org@suse.de>
References: <Pine.LNX.4.44L0.0707171010490.3551-100000@iolanthe.rowland.org>
	<200707171802.30903.rjw@sisk.pl>
	<Pine.LNX.4.64.0707170959160.2467@asgard.lang.hm>
	<200707172150.44417.rjw@sisk.pl>
	<Pine.LNX.4.64.0707171302430.2467@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707171302430.2467@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: Al Boldi <a1426z@gawab.com>, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi,

Sorry for joining late, just a small annotation:

On Tue, Jul 17, 2007 at 01:18:13PM -0700, david@lang.hm wrote:
=20
> non-ACPI hibernate
>=20
>   since the box powers off
>     it uses zero power while suspended
>     another OS could be run before a resume
>     hardware can be swapped, suspend image could be sent around the wor=
ld to be restored on another system.
>     restore makes no assumptions about the state of the hardware when i=
t is restored
>     restore is slower (full BIOS boot is required)
>   should be able to work on just about any hardware (the limit is the a=
bility to initialize the devices)
>=20
>=20
> ACPI suspends
>=20
>   since the box never completely powers off:A

wrong

>     a complete power failure breaks the suspend

wrong

>     the OS must remain in control so other uses must be prevented.
>     hardware must remain in the ACPI state from suspend until restore.
>     restore can be faster (some initialization may be able to be skippe=
d)
>   requires ACPI hardware support
>=20
> under the catagory of ACPI suspends you have

ACPI S4 turns off the machine completely and you can remove the battery (=
this
is even required somewhere in the spec). Any state saving is done in CMOS=
 RAM
or flash.

But for example many Notebooks resume much faster if they go through the
ACPI S4 hooks during suspend (less than one second from "lid open" to "gr=
ub"
while they need ~10 seconds through the BIOS on a "normal" boot.
My Toughbook resumes on "Lid Opened" after S4, it doesn't after a shutdow=
n.

So there will be differences.
I'm not saying that they are too important, but 20% faster resume still i=
s
a good saving for me.

No need to restart this thread btw ;-)

Have fun,

    Stefan
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=20

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
