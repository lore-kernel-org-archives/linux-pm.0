From: <rasmit.ranjan@wipro.com>
Subject: Re: suspend to disk not working due to swap space failure
Date: Thu, 10 Aug 2006 11:53:43 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB20250BB3E@PNE-HJN-MBX01.wipro.com>
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
To: rjw@sisk.pl, linux-pm@lists.osdl.org
Cc: johannes@sipsolutions.net
List-Id: linux-pm@vger.kernel.org

 =


> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@sisk.pl] =

> Sent: Wednesday, August 09, 2006 11:34 AM
> To: linux-pm@lists.osdl.org
> Cc: Rasmit Ranjan (WT01 - Semiconductors & Consumer =

> Electronics); johannes@sipsolutions.net
> Subject: Re: [linux-pm] suspend to disk not working due to =

> swap space failure
> =

> On Wednesday 09 August 2006 05:05, rasmit.ranjan@wipro.com wrote:
> > =

> > > -----Original Message-----
> > > From: Johannes Berg [mailto:johannes@sipsolutions.net]
> > > Sent: Tuesday, August 08, 2006 7:23 PM
> > > To: Rasmit Ranjan (WT01 - Semiconductors & Consumer Electronics)
> > > Cc: linux-pm@lists.osdl.org
> > > Subject: Re: [linux-pm] suspend to disk not working due to swap =

> > > space failure
> > > =

> > > rasmit.ranjan@wipro.com wrote:
> > > > So i tried creating a new
> > > > swap space by the command " mkswap". But still my swap
> > > partition does
> > > > not come up. I reboot my system but that did not work as well. =

> > > > What might be the problem?
> > > Is it listed in /etc/fstab so swapon -a can find it?
> > =

> > No it is not listed in /etc/fstab file. But `fdisk -l` =

> shows the swap =

> > partition.
> =

> OK
> =

> What's the name of your swap partition and how does your =

> /etc/fstab look like?
> =


Output of `fdisk -l` : =


Disk /dev/hda: 40.0 GB, 40007761920 bytes
255 heads, 63 sectors/track, 4864 cylinders
Units =3D cylinders of 16065 * 512 =3D 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1         383     3076416   12  Compaq
diagnostics
/dev/hda2   *         384        2612    17904442+   c  W95 FAT32 (LBA)
/dev/hda3            2613        3887    10241437+  83  Linux
/dev/hda4            3888        4864     7847752+   5  Extended
/dev/hda5            3888        3952      522081   82  Linux swap /
Solaris

Content of /etc/fstab :

# This file is edited by fstab-sync - see 'man fstab-sync' for details
LABEL=3D/                 /                       ext3    defaults
1 1
/dev/devpts             /dev/pts                devpts  gid=3D5,mode=3D620
0 0
/dev/shm                /dev/shm                tmpfs   defaults
0 0
/dev/proc               /proc                   proc    defaults
0 0
/dev/sys                /sys                    sysfs   defaults
0 0

/dev/hdc                /media/cdrecorder       auto
pamconsole,exec,noauto,managed 0 0


> Rafael
> =
