From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [linux-pm] Dangers
	of	touching	disk	between	suspend and resume
Date: Wed, 06 Dec 2006 11:10:06 +1100
Message-ID: <1165363806.19284.8.camel@nigel.suspend2.net>
References: <1164727307.26898.12.camel@systems03.lan.brontes3d.com>
	<Pine.LNX.4.44L0.0611281034130.3064-100000@iolanthe.rowland.org>
	<20061128163757.GM14640@suse.de>
	<1164916843.6031.9.camel@localhost.localdomain>
	<20061130201311.GK2227@suse.de>
	<1164925067.6031.29.camel@localhost.localdomain>
	<20061201073956.GB18690@suse.de>
	<1165034513.3143.2.camel@nigel.suspend2.net>
	<20061204081049.GA12174@suse.de>
	<1165318090.15384.15.camel@nigel.suspend2.net>
	<45755D4D.3090900@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45755D4D.3090900@genesi-usa.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Matt Sealey <matt@genesi-usa.com>
Cc: suspend-devel@lists.sourceforge.net, linux-pm@osdl.org, Stefan Seyfried <seife@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi again.

On Tue, 2006-12-05 at 11:51 +0000, Matt Sealey wrote:
> Nigel Cunningham wrote:
> > 
> >> But this engineer should also know if he depends on the UUID of the swap 
> >> partition to find it. If he does not, he can simply do a "mkswap" to reset
> >> the signature.
> > 
> > Since you mentioned it, what's they point to using these ugly, looong
> > uuids? /dev/hda2 is so much simpler and easier to read for mere humans.
> > I guess it might be useful for USB and so on with the hotplug messiness,
> > but when I look in /etc/fstab after some upgrade and stuff that's
> > irrelevant to hotplugging is changed into uuids,... why?
> 
> /dev/hda2 may move if they move the disk.. I think the preferred way (since
> it seems fairly hard to 'fix' a disk in the /dev tree under Linux, not so
> easy as - say - FreeBSD or NetBSD) is to mount disks from disk labels these
> days (ext2 and xfs supports it at least) as then you can move the disk
> around. USB, Firewire, external SATA disks will fall under this trap, but
> perhaps not internal IDE.. however you can't have both ways :D

Thanks for the reply.

Is all the converting of uuids to device nodes done in userspace? I
haven't noticed anything in the kernel to handle uuids, but I don't look
at filesystem code much.

Regards,

Nigel


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
