From: Len Brown <lenb@kernel.org>
Subject: Re: Toshiba L30-113A ACPI Ubuntu 7.04
Date: Mon, 3 Sep 2007 11:00:54 -0400
Message-ID: <200709031100.55012.lenb__47837.7775325955$1188831502$gmane$org@kernel.org>
References: <97720510709030356kbc968fs853d05043ea0e1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <97720510709030356kbc968fs853d05043ea0e1f@mail.gmail.com>
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
Cc: linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

(probably linux-acpi is a better place for this thread than linux-pm...)


On Monday 03 September 2007 06:56, valentin Petkov wrote:
> Hi,
> In the past few days i became quite frustrated with my Toshiba Satellit=
e
> L30-113a laptop. Thing is i can't get the ACPI to work. Or should i say=
 it
> works partially, the functional keys work, i got the sound and the wire=
less
> working, yet an important thing in the laptop is not working =E2=80=93 =
namely the
> CPU fan.

In what way does the CPU fan not work?  Does it not spin up
when the system is under load?

> I did some research and found that Toshiba are not very Linux=20
> friendly, yet there must be some solution.
>
> So far i have done this:
>=20
> I turned on Toshiba support in the ACPI at the kernel and compile it.
> The ACPI recognized and displayed the battery and the functional keys
>=20
> #cat /proc/toshiba/ - missing
> #cat /proc/acpi/toshiba - missing
>=20
> #lsmod | grep acpi
>=20
> pcc_acpi 14080 0
> dev_acpi 12292 0
> asus_acpi 17308 0
>=20
> It is clear that toshiba_acpi is missing and the module is not loaded
>=20
> #sudo modprobe toshiba_acpi
>=20
> FATAL: Error inserting toshiba_acpi
> (/lib/modules/2.6.20-16-generic/kernel/drivers/acpi/toshiba_acpi.ko): N=
o
> such device

toshiba_acpi is a reverse engineered platform specific driver,
and it depends on specific code in the ACPI DSDT on toshiba machines.
In this case, it apparently doesn't find that code, and gives up.

Your fan should work correctly even without this driver.

Perhaps you can open a sighting at bugzilla.kernel.org and
attach the output from acpidump?

thanks,
-Len
