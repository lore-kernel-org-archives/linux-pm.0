From: Stefan Seyfried <seife@suse.de>
Subject: Re: [linux-pm] Dangers of touching disk between
	suspend and resume
Date: Tue, 28 Nov 2006 17:37:57 +0100
Message-ID: <20061128163757.GM14640@suse.de>
References: <1164727307.26898.12.camel@systems03.lan.brontes3d.com>
	<Pine.LNX.4.44L0.0611281034130.3064-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611281034130.3064-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: suspend-devel@lists.sourceforge.net, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 28, 2006 at 10:43:51AM -0500, Alan Stern wrote:
> On Tue, 28 Nov 2006, Daniel Drake wrote:
> =

> > Hi,
> > =

> > I have some questions about this text in Documentation/power/swsusp.txt:
> > =

> >  * If you touch anything on disk between suspend and resume...
> >  *				...kiss your data goodbye.
> > =

> > It's obvious that this is a bad idea but I'm interested in the details.
> > I'm working with the userspace suspend-to-disk tools in this case.
> > =

> > Specifically, where it says "kiss your data goodbye" is that saying that
> > upon next resume you would lose data in open and unsaved documents (i.e.
> > session data), or does it mean that your root partition is effectively
> > destroyed?
> =

> Almost anything could happen, depending on the type of filesystem and the =

> nature of the changes you make to the disk.

ACK.
 =

> > Is the danger only in touching the swap partition where the resume data
> > is saved, or is mounting any of the filesystems that are mounted in the
> > suspended session dangerous?
> =

> Touching _anything_ is dangerous.

ACK.

> > How dangerous?
> =

> Like I said above, it depends.

Let's put it this way. In the early days of me trying software suspend
(around 2.6.$early), i once suspended a machine, wanted to resume but
selected the wrong kernel on resume. Machine booted. I noticed this and
immediately powered the machine off (the fs had already been mounted).
Then i tried to resume.
Afterwards i had an interesting session with "reiserfsck --rebuild-tree"
and other funny tools you don't want to use. I was just lucky, that i
always have a current backup, since sorting out the useful parts of my
home directory in lost+found would not have been a funny job. And /home
was less affected than /, since / was also written to during boot.

> > Are we talking instant loss
> > of entire filesystem, or just a chance that some files will be
> > corrupted?

If you are lucky, the filesytem is just instantly screwed.
If you are unlucky, you get silent corruption that keeps growing until
your backups are phased out and you finally start noticing it.

> File corruption is the most likely outcome, but I wouldn't say that =

> losing an entire filesystem is impossible.  You'd have to try pretty hard=
, =

> though.  Running mkfs would certainly do it.  :-)
> =

> > When does the corruption happen - during mount after suspend
> > but before resume, or during resume after suspend+modifications?
> =

> Corruption occurs when you write to the disk.  Note the the disk doesn't
> have to be mounted.  In addition, even if you mount an ext3 filesystem
> read-only, the fs code will play back the journal -- thereby writing to
> the disk.

> > What kind of dangers are associated with suspending to disk, modifying
> > data on disk but then *not* resuming (doing a complete boot, e.g.
> > recreating the swap partition to prevent resume from being attempted)?

This case is just like "powered off hard by tripping the power cord",
maybe even less dramatic since the disk buffers will at least be flushed
by swsusp. The filesystem will be dirty, the fsck on boot will probably
just fix it (i have had no real problems after a hard shutdown for a
long time).

> > The context I'm thinking of is an engineer called out to repair a broken
> > system. This system will not boot, lets say the RAM is screwed and the
> > kernel hangs/panics during early init (before any resuming is
> > attempted).
> > =

> > Without touching the disks, there is no way of knowing if the system was
> > shut down fully or suspended-to-disk on last shutdown.

He just has to look at the end of the first page of the swap partition
for the signature :-)

So it is a good idea to tell the engineer to do "mkswap" on the swap
partition before putting the disk into the replacement hardware.

-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
