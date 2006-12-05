From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [linux-pm] Dangers of touching
	disk	between	suspend and resume
Date: Tue, 05 Dec 2006 22:28:08 +1100
Message-ID: <1165318090.15384.15.camel@nigel.suspend2.net>
References: <1164727307.26898.12.camel@systems03.lan.brontes3d.com>
	<Pine.LNX.4.44L0.0611281034130.3064-100000@iolanthe.rowland.org>
	<20061128163757.GM14640@suse.de>
	<1164916843.6031.9.camel@localhost.localdomain>
	<20061130201311.GK2227@suse.de>
	<1164925067.6031.29.camel@localhost.localdomain>
	<20061201073956.GB18690@suse.de>
	<1165034513.3143.2.camel@nigel.suspend2.net>
	<20061204081049.GA12174@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061204081049.GA12174@suse.de>
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
Cc: suspend-devel@lists.sourceforge.net, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Mon, 2006-12-04 at 09:10 +0100, Stefan Seyfried wrote:
> On Sat, Dec 02, 2006 at 03:41:52PM +1100, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Fri, 2006-12-01 at 08:39 +0100, Stefan Seyfried wrote:
> > > So if somebody submits a patch that implements a "reset_signature" program,
> > > i'll include that in the suspend package.
> > 
> > I don't know if you care (you might not want to support Suspend2), but
> 
> Wrong, if i was to write such a "restore_signature" program, i'd want it
> to support all known ways of screwing up your SWAP partition :-)
> 
> > for Suspend2 enabled kernels, you can just do:
> > 
> > [ -f /sys/power/suspend2/image_exists ] && echo 0 > /sys/power/suspend2/image_exists
> > 
> > You can cat the file to find out if an image exists, if you prefer (eg
> > from an initrd/ramfs). Return values are:
> 
> But you need a suspend2-enabled kernel.

Everyone should have one of those! :)

> For rescue purposes ("engineer on-site to repair the hardware, diagnosing with
> a rescue CD first" scenario), a standalone binary that resets the signature is
> probably better.

Yeah, that makes sense.

> But this engineer should also know if he depends on the UUID of the swap 
> partition to find it. If he does not, he can simply do a "mkswap" to reset
> the signature.

Since you mentioned it, what's they point to using these ugly, looong
uuids? /dev/hda2 is so much simpler and easier to read for mere humans.
I guess it might be useful for USB and so on with the hotplug messiness,
but when I look in /etc/fstab after some upgrade and stuff that's
irrelevant to hotplugging is changed into uuids,... why?

Regards,

Nigel


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
