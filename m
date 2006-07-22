From: <rasmit.ranjan@wipro.com>
Subject: suspend to RAM not working
Date: Sat, 22 Jul 2006 11:59:39 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB2023B6E72@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi all,
    I am using ACER Aspire 3003LC laptop. My kernel version 2.6.15.4.
I tried suspend to RAM by giving following command =

    echo mem > /sys/power/state
 =

My system goes into suspended state as it seems because system becomes
powered off. But when i press my power button or Fn button it does not
resume ( my screen becomes blank ).My system supports both suspend to
RAM and suspend to Disk. Suspend to Disk works properly in my system. I
thought my video card might create some problem.So i run the following
script.
#!/bin/sh
ID=3D`lspci | grep VGA | awk '{ print $1 }' | sed -e 's@0000:@@' -e
's@:@/@'`
TMP_FILE=3D`mktemp /var/tmp/video_state.XXXXXX`
trap 'rm -f $TMP_FILE' 0 1 15
chvt 1
sync
cat /proc/bus/pci/$ID > $TMP_FILE
echo mem > /sys/power/state
cat $TMP_FILE > /proc/bus/pci/$ID
chvt 7
rm -f $TMP_FILE

But this did not work for my laptop. Has anybody faced this problem
before.Please suggest what else can i do to make suspend to RAM working?
 =

Regards,
Rasmit.
