From: Stefan Seyfried <seife@suse.de>
Subject: Re: [linux-pm] Dangers of touching disk between
	suspend and resume
Date: Thu, 30 Nov 2006 21:13:11 +0100
Message-ID: <20061130201311.GK2227@suse.de>
References: <1164727307.26898.12.camel@systems03.lan.brontes3d.com>
	<Pine.LNX.4.44L0.0611281034130.3064-100000@iolanthe.rowland.org>
	<20061128163757.GM14640@suse.de>
	<1164916843.6031.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1164916843.6031.9.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Peter Jones <pjones@redhat.com>
Cc: suspend-devel@lists.sourceforge.net, linux-pm@osdl.org, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 30, 2006 at 03:00:43PM -0500, Peter Jones wrote:
> On Tue, 2006-11-28 at 17:37 +0100, Stefan Seyfried wrote:
> =

> > So it is a good idea to tell the engineer to do "mkswap" on the swap
> > partition before putting the disk into the replacement hardware.
> =

> Ugh, no it's not.  You really want the UUID on the swap area to remain
> the same.

Well, but the system won't care because it won't resume?
Or am i missing something?
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
