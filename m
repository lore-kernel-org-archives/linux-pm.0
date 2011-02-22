From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: extremely slow resume with 2.6.37
Date: Tue, 22 Feb 2011 21:39:11 +0100
Message-ID: <201102222139.12599.Martin__3701.43161057985$1298407314$gmane$org@lichtvoll.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

A moment ago I had an extremely slow resume with 2.6.37. So slow that I =

aborted it.

It was at 37% as I looked and then took a minute or more for each percent. =

I am using in kernel suspend to disk via hibernate 1.99 which uses sysfs =

power state disk.

Anyone have seen something like this? This was the first occurence, and I =

am using 2.6.37 for quite a while.

I am calling hibernate-disk from this script:

shambhala:~> cat /etc/acpi/hibernate-extra.sh =

#!/bin/sh

# Zur Sicherheit gleich am Anfang alle ausstehenden =C4nderungen schreiben
sync

# Versuchen, m=F6glichst viele LowMem Pages freizubekommen
# Dir Entries legt Ext4 offenbar auch ins LowMem
# Und mit zu wenig LowMem Pages klappt der Tiefschlaf mit
# Radeon DRM KMS nicht.
echo 3 > /proc/sys/vm/drop_caches

# Network Manager schlafen legen
# siehe /usr/lib/pm-utils/sleep.d/55NetworkManager
dbus-send --print-reply --system                        \
        --dest=3Dorg.freedesktop.NetworkManager \
        /org/freedesktop/NetworkManager       \
        org.freedesktop.NetworkManager.sleep

# Systemzeit in Hardware-Uhr speichern
/etc/init.d/hwclock.sh stop

# Uptimed stoppen, damit er die Rekorde schreibt
/etc/init.d/uptimed stop

# Zur Sicherheit hier nochmal alle ausstehenden =C4nderungen schreiben
sync

# Gutnacht
# /etc/acpi/hibernate.sh
#echo 1 > /sys/power/tuxonice/do_hibernate
#pm-suspend-hybrid
#pm-hibernate
hibernate-disk

# Uptimed wieder starten. Dabei schreibt er erneut die Rekorde
/etc/init.d/uptimed start

# Rekorde gleich schreiben
sync

# Festplatten-Parameter wieder setzen
/etc/init.d/hdparm start

# Systemzeit anhand Hardware-Uhr wieder setzen
/etc/init.d/hwclock.sh start

# Network Manager aufwecken
dbus-send --print-reply --system                        \
        --dest=3Dorg.freedesktop.NetworkManager \
        /org/freedesktop/NetworkManager       \
        org.freedesktop.NetworkManager.wake


I am echoing 3 onto drop_caches cause often in kernel suspend - as well as =

TuxOnIce as I used it back then - was not able to free lowmem pages in =

order for the image to be allocated after I switched to radeon kms which =

seems to require quite some lowmem pages of its own, but I will post a =

different mail about this one.

I am using

shambhala:~> cat /proc/version
Linux version 2.6.37-tp42-rtime-00004-g9eb63ce (martin@shambhala) (gcc =

version 4.4.5 (Debian 4.4.5-8) ) #1 PREEMPT Thu Jan 13 10:59:19 CET 2011

which is 2.6.37 + some recursive mtime changes from Jan Kara, which should =

only affect Ext3 and Ext4.

Ciao,
-- =

Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
