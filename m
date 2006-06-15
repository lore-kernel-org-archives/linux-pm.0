From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Wed, 14 Jun 2006 20:39:26 -0400
Message-ID: <20060615003926.GA11083@neo.rr.com>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141529270.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606141529270.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Power management list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 14, 2006 at 03:37:51PM -0700, Linus Torvalds wrote:
> And btw, the reason it didn't resume originally was because _we_ did =

> things wrong. The PCI command word mustn't be writen before the rest of =

> the config space has been restored (one of the things I used my debugging =

> patches for, until I noticed that -mm had the same fix independently, so =

> that's the one that is merged right now ;)

I was hoping to see a more complete fix merged.  This patch still writes to=
 a
large number of read-only registers, touches BIST (which can be dangerous on
some hardware), and isn't careful about the initial state of the PCI command
word.

I attempted to rework pci_save/restore_state() a couple weeks ago:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D114949711413176&w=3D2

Any comments would be appreciated.

Thanks,
Adam
