From: Sasha Levin <levinsasha928@gmail.com>
Subject: Wake on LAN works once,
	doesn't allow sleep on following attempts
Date: Wed, 24 Mar 2010 18:39:31 +0200
Message-ID: <be7cd4141003240939v561d92b5gbe3671d20c13310@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8152497748920935395=="
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

--===============8152497748920935395==
Content-Type: multipart/alternative; boundary=0016e649862a481d7104828e9475

--0016e649862a481d7104828e9475
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I have a PC with a 2.6.31 kernel on it running Ubuntu.
The PC has an Intel 82567LM-3 NIC which uses the e1000e module.

After enabling WOL for the card using the sysfs interface (using 'echo
enabled > /sys/devices/pci0000:00/0000:00:19.0/power/wakeup') the PC
successfully goes to sleep and wakes up only when it receives a WOL packet.

Problem is, Once it has received the WOL packet once the PC will immediately
wake up after being sent to sleep. Furthermore, it'll immediately wake up
after being shutdown too.
Disabling wake-up for the NIC using the sysfs interface still keeps on
waking the machine.

The solution I've found is a cold reboot, warm reboot doesn't solve the
issue - The computer will keep on waking up even without receiving a WOL
packet until it has been cold booted.

I haven't seen anything in syslog to suggest what the problem is.

How should I debug this issue?

Some (possibly) useful information:

uname -a
Linux sasha-lindev 2.6.31-19-generic #56-Ubuntu SMP Thu Jan 28 02:39:34 UTC
2010 x86_64 GNU/Linux

lspci | grep Ethernet
00:19.0 Ethernet controller: Intel Corporation 82567LM-3 Gigabit Network
Connection (rev 02)


Thanks,
Sasha

--0016e649862a481d7104828e9475
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>I have a PC with a 2.6.31 kernel on it runn=
ing Ubuntu.<br>The PC has an Intel 82567LM-3 NIC which uses the e1000e modu=
le.<br><br>After enabling WOL for the card using the sysfs interface (using=
 &#39;echo enabled &gt; /sys/devices/pci0000:00/0000:00:19.0/power/wakeup&#=
39;) the PC successfully goes to sleep and wakes up only when it receives a=
 WOL packet.<br>

<br>Problem is, Once it has received the WOL packet once the PC will immedi=
ately wake up after being sent to sleep. Furthermore, it&#39;ll immediately=
 wake up after being shutdown too.<br>Disabling wake-up for the NIC using t=
he sysfs interface still keeps
 on waking the machine.<br><br>The solution I&#39;ve found is a cold reboot=
, warm reboot doesn&#39;t solve the issue - The computer will keep on wakin=
g up even without receiving a WOL packet until it has been cold booted.<br>

<br>I haven&#39;t seen anything in syslog to suggest what the problem is.<b=
r><br>How should I debug this issue?<br><br>Some (possibly) useful informat=
ion:<br><br>uname -a<br>Linux sasha-lindev 2.6.31-19-generic #56-Ubuntu SMP=
 Thu Jan 28 02:39:34 UTC 2010 x86_64 GNU/Linux<br>

<br>lspci | grep Ethernet<br>00:19.0 Ethernet controller: Intel Corporation=
 82567LM-3 Gigabit Network Connection (rev 02)<br><br><br>Thanks,<br>Sasha<=
br></div>

--0016e649862a481d7104828e9475--

--===============8152497748920935395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8152497748920935395==--
