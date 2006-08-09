From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 09 Aug 2006 07:14:50 +0100
Message-ID: <1155104090.5812.5.camel@insmouth>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<200608090750.40111.nigel@suspend2.net>
	<Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net
List-Id: linux-pm@vger.kernel.org

On Tue, 2006-08-08 at 19:31 -0400, Steven Rostedt wrote:
> Hmm, it requires windows, and I've already wiped out that partition.
> I did a search but it seems really scary to update the BIOS via Linux.

I've done it in the past by using memdisk[0] to boot a freedos floppy
image[1] which I have added the BIOS update to... It worked but it was a
bit nerve wracking ;-)

Ian.

[0] http://syslinux.zytor.com/memdisk.php
[1] http://odin.fdos.org/odin2005/ (FWIW I used odin2880.img)

-- =

Ian Campbell

BOFH excuse #382:

Someone was smoking in the computer room and set off the halon systems.
