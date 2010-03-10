From: =?ISO-8859-1?Q?=C1kos_Mar=F3y?= <akos@maroy.hu>
Subject: suspend works until core pm_test, but the still fails
Date: Wed, 10 Mar 2010 00:42:51 -0600
Message-ID: <4B973F6B.4000709@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

I'm still trying to make power management work on my HP Envy 15.

I'm experimenting with unloading as many modules as possible, testing
the suspend feature using various levels of /sys/power/pm_test

I managed to get the number of modules as low as these:

Module                  Size  Used by
binfmt_misc             7454  1
bnep                   11287  2
btusb                  12729  2


then I was going through these steps;

echo freezer > /sys/power/pm_test
echo mem > /sys/power/state
echo devices > /sys/power/pm_test
echo mem > /sys/power/state
echo platform > /sys/power/pm_test
echo mem > /sys/power/state
echo processors > /sys/power/pm_test
echo mem > /sys/power/state
echo core > /sys/power/pm_test
echo mem > /sys/power/state

and all these worked fine - meaning that I got back to the console
screen. I also ran dmesg, and didn't see anything suspicious.

but, when I do:

echo none > /sys/power/pm_test
echo mem > /sys/power/state


the machine will still hang :(


what am I doing wrong?

this is all on a 2.6.32.9 kernel


Akos
