From: "valentin Petkov" <skyval@gmail.com>
Subject: Toshiba L30-113A ACPI Ubuntu 7.04
Date: Mon, 3 Sep 2007 13:56:01 +0300
Message-ID: <97720510709030356kbc968fs853d05043ea0e1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2745744103163306627=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============2745744103163306627==
Content-Type: multipart/alternative;
	boundary="----=_Part_15197_2903666.1188816961798"

------=_Part_15197_2903666.1188816961798
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
In the past few days i became quite frustrated with my Toshiba Satellite
L30-113a laptop. Thing is i can't get the ACPI to work. Or should i say it
works partially, the functional keys work, i got the sound and the wireless
working, yet an important thing in the laptop is not working =96 namely the
CPU fan. I did some research and found that Toshiba are not very Linux
friendly, yet there must be some solution.

So far i have done this:

I turned on Toshiba support in the ACPI at the kernel and compile it.
The ACPI recognized and displayed the battery and the functional keys

#cat /proc/toshiba/ - missing
#cat /proc/acpi/toshiba - missing

#lsmod | grep acpi

pcc_acpi 14080 0
dev_acpi 12292 0
asus_acpi 17308 0

It is clear that toshiba_acpi is missing and the module is not loaded

#sudo modprobe toshiba_acpi

FATAL: Error inserting toshiba_acpi
(/lib/modules/2.6.20-16-generic/kernel/drivers/acpi/toshiba_acpi.ko): No
such device

#find /lib/modules/`uname -r` -name "tosh*"

/lib/modules/2.6.20-16-generic/kernel/drivers/acpi/toshiba_acpi.ko
/lib/modules/2.6.20-16-generic/kernel/drivers/char/toshiba.ko

Yet the module is present but it's not loaded!

#lsmod | grep cpu

cpufreq_userspace 5408 0
cpufreq_stats 7744 0
freq_table 6048 2 cpufreq_stats,cpufreq_ondemand
cpufreq_powersave 2944 0
cpufreq_ondemand 8876 0
cpufreq_conservative 8712 0

#toshset =96 says that the module is not loaded

#acpi -V
Battery 1: charged, 100%
Thermal 1: ok, 54.0 degrees C
AC Adapter 1: on-line

#dmesg =96 nothing suspicious

------=_Part_15197_2903666.1188816961798
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, <br>
In the past few days i became quite frustrated with my Toshiba
Satellite L30-113a laptop. Thing is i can't get the ACPI to work. Or
should i say it works partially, the functional keys work, i got the
sound and the wireless working, yet an important thing in the laptop is
not working =96 namely the CPU fan. I did some research and found that
Toshiba are not very Linux friendly, yet there must be some solution.<br>
<br>
So far i have done this:<br>
<br>
I turned on Toshiba support in the ACPI at the kernel and compile it.<br>
The ACPI recognized and displayed the battery and the functional keys<br>
<br>
#cat /proc/toshiba/  - missing<br>
#cat /proc/acpi/toshiba  - missing<br>
<br>
#lsmod | grep acpi<br>
<br>
pcc_acpi               14080  0<br>
dev_acpi               12292  0<br>
asus_acpi              17308  0<br>
<br>
It is clear that toshiba_acpi is missing and the module is not loaded<br>
<br>
#sudo modprobe toshiba_acpi<br>
<br>
FATAL: Error inserting toshiba_acpi (/lib/modules/2.6.20-16-generic/kernel/=
drivers/acpi/toshiba_acpi.ko): No such device<br>
<br>
#find /lib/modules/`uname -r` -name &quot;tosh*&quot;<br>
<br>
/lib/modules/2.6.20-16-generic/kernel/drivers/acpi/toshiba_acpi.ko<br>
/lib/modules/2.6.20-16-generic/kernel/drivers/char/toshiba.ko<br>
<br>
Yet the module is present but it's not loaded!<br>
<br>
#lsmod | grep cpu<br>
<br>
cpufreq_userspace       5408  0<br>
cpufreq_stats           7744  0<br>
freq_table              6048  2 cpufreq_stats,cpufreq_ondemand<br>
cpufreq_powersave       2944  0<br>
cpufreq_ondemand        8876  0<br>
cpufreq_conservative     8712  0<br>
<br>
#toshset =96 says that the module is not loaded<br>
<br>
#acpi -V<br>
    Battery 1: charged, 100%<br>
    Thermal 1: ok, 54.0 degrees C<br>
 AC Adapter 1: on-line<br>
<br>
#dmesg =96 nothing suspicious

------=_Part_15197_2903666.1188816961798--

--===============2745744103163306627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2745744103163306627==--
