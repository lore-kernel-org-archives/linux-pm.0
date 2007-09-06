From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] Hibernation: Check if ACPI is enabled
	during restore in the right place
Date: Thu, 6 Sep 2007 01:56:03 +0000
Message-ID: <20070906015603.GA5097__42435.0743800916$1189069290$gmane$org@ucw.cz>
References: <200709020021.37881.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200709020021.37881.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2007-09-02 00:21:37, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> The following scenario leads to total confusion of the platform firmwar=
e on
> some boxes (eg. HPC nx6325):
> * Hibernate with ACPI enabled
> * Pass "acpi=3Doff" to the boot kernel
>=20
> To prevent this from happening it's necessary to check if ACPI is enabl=
ed (and
> enable it if that's not the case) _right_ _after_ control has been tran=
sfered
> from the boot kernel to the image kernel, before device_power_up() is c=
alled
> (ie. with interrupts disabled). =A0Enabling ACPI after calling device_p=
ower_up()
> turns out to be insufficient.
>=20
> For this reason, introduce new hibernation callback ->leave() that will=
 be
> executed before device_power_up() by the restored image kernel. =A0To m=
ake it
> work, it also is necessary to move swsusp_suspend() from swsusp.c to di=
sk.c
> (it's name is changed to "create_image", which is more up to the point).
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
