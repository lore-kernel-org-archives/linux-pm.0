From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [linux-pm] Dangers of touching disk
	between	suspend and resume
Date: Sat, 02 Dec 2006 15:41:52 +1100
Message-ID: <1165034513.3143.2.camel@nigel.suspend2.net>
References: <1164727307.26898.12.camel@systems03.lan.brontes3d.com>
	<Pine.LNX.4.44L0.0611281034130.3064-100000@iolanthe.rowland.org>
	<20061128163757.GM14640@suse.de>
	<1164916843.6031.9.camel@localhost.localdomain>
	<20061130201311.GK2227@suse.de>
	<1164925067.6031.29.camel@localhost.localdomain>
	<20061201073956.GB18690@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061201073956.GB18690@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Stefan Seyfried <seife@suse.de>
Cc: suspend-devel@lists.sourceforge.net, linux-pm@osdl.org, Peter Jones <pjones@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On Fri, 2006-12-01 at 08:39 +0100, Stefan Seyfried wrote:
> So if somebody submits a patch that implements a "reset_signature" program,
> i'll include that in the suspend package.

I don't know if you care (you might not want to support Suspend2), but
for Suspend2 enabled kernels, you can just do:

[ -f /sys/power/suspend2/image_exists ] && echo 0 > /sys/power/suspend2/image_exists

You can cat the file to find out if an image exists, if you prefer (eg
from an initrd/ramfs). Return values are:

-1: resume= doesn't point to a recognised signature
0: No image, normal signature
1: Image exists.

Regards,

Nigel


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
