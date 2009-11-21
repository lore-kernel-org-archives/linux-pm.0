From: Sriram V <vshrirama@gmail.com>
Subject: wakeup wakelock issues
Date: Sat, 21 Nov 2009 22:07:34 +0530
Message-ID: <8bf247760911210837y3f089eaegd57fcec21d93681b__34193.0345901803$1258821525$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6816040633430029451=="
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
To: android-porting@googlegroups.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============6816040633430029451==
Content-Type: multipart/alternative; boundary=00504502cc9f9a47bf0478e4351a

--00504502cc9f9a47bf0478e4351a
Content-Type: text/plain; charset=ISO-8859-1

Hi,
  I am trying to test pm on a custom board with android.

  Whats happening:
   1) Android is putting the system to sleep - calling system wide suspend
   2) During suspend, kernel resume immediately - I get "wakeup wake lock:
omap-8250-serial". and again puts it back to suspend.*
   *3) This keeps happening, There is no serial activity except for printing
the messages (transmission from the board) - No serial inputs from the host
pc.
   4) Is there any way to disable this?


Regards,
sriram



# PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
Powerdomain (iva2_pwrdm) didn't enter target state 1
Powerdomain (core_pwrdm) didn't enter target state 1
Could not enter target state in pm_suspend
*wakeup wake lock: omap-8250-serial*
usb 1-2: reset high speed USB device using ehci-omap and address 2
Restarting tasks ... <7>hub 1-0:1.0: state 7 ports 3 chg 0004 evt 0000
done.
suspend: exit suspend, ret = 0 (2000-01-01 03:42:06.047454761 UTC)
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
Powerdomain (iva2_pwrdm) didn't enter target state 1
Powerdomain (core_pwrdm) didn't enter target state 1
Could not enter target state in pm_suspend
wakeup wake lock: omap-8250-serial
usb 1-2: reset high speed USB device using ehci-omap and address 2
Restarting tasks ... <7>hub 1-0:1.0: state 7 ports 3 chg 0004 evt 0000
done.
suspend: exit suspend, ret = 0 (2000-01-01 03:42:16.157318042 UTC)
PM: Syncing filesystems ... done.

--00504502cc9f9a47bf0478e4351a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>=A0 I am trying to test pm on a custom board with android.<br><br>=
=A0 Whats happening:<br>=A0=A0 1) Android is putting the system to sleep - =
calling system wide suspend<br>=A0=A0 2) During suspend, kernel resume imme=
diately - I get &quot;wakeup wake lock: omap-8250-serial&quot;. and again p=
uts it back to suspend.<b><br>
=A0=A0 </b>3) This keeps happening, There is no serial activity except for =
printing the messages (transmission from the board) - No serial inputs from=
 the host pc.<br>=A0=A0 4) Is there any way to disable this?<br>=A0=A0 <br>=
<br>Regards,<br>
sriram<br><br><br><br># PM: Syncing filesystems ... done.<br>Freezing user =
space processes ... (elapsed 0.01 seconds) done.<br>Freezing remaining free=
zable tasks ... (elapsed 0.00 seconds) done.<br>Suspending console(s) (use =
no_console_suspend to debug)<br>
Powerdomain (iva2_pwrdm) didn&#39;t enter target state 1<br>Powerdomain (co=
re_pwrdm) didn&#39;t enter target state 1<br>Could not enter target state i=
n pm_suspend<br><b>wakeup wake lock: omap-8250-serial</b><br>usb 1-2: reset=
 high speed USB device using ehci-omap and address 2<br>
Restarting tasks ... &lt;7&gt;hub 1-0:1.0: state 7 ports 3 chg 0004 evt 000=
0<br>done.<br>suspend: exit suspend, ret =3D 0 (2000-01-01 03:42:06.0474547=
61 UTC)<br>PM: Syncing filesystems ... done.<br>Freezing user space process=
es ... (elapsed 0.00 seconds) done.<br>
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.<br>Susp=
ending console(s) (use no_console_suspend to debug)<br>Powerdomain (iva2_pw=
rdm) didn&#39;t enter target state 1<br>Powerdomain (core_pwrdm) didn&#39;t=
 enter target state 1<br>
Could not enter target state in pm_suspend<br>wakeup wake lock: omap-8250-s=
erial<br>usb 1-2: reset high speed USB device using ehci-omap and address 2=
<br>Restarting tasks ... &lt;7&gt;hub 1-0:1.0: state 7 ports 3 chg 0004 evt=
 0000<br>
done.<br>suspend: exit suspend, ret =3D 0 (2000-01-01 03:42:16.157318042 UT=
C)<br>PM: Syncing filesystems ... done.<br><br>

--00504502cc9f9a47bf0478e4351a--

--===============6816040633430029451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6816040633430029451==--
