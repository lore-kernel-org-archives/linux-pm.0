From: Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [2/6] 2.6.21-rc2: known regressions
Date: Sat, 10 Mar 2007 14:53:12 +0100
Message-ID: <20070310135312.GA7659@linuxtv.org>
References: <20070305015034.GG3441@stusta.de>
	<20070308123143.GF5149@mellanox.co.il>
	<Pine.LNX.4.64.0703080954220.10832@woody.linux-foundation.org>
	<20070308192554.GA2999@elte.hu> <20070308230705.GA4611@elte.hu>
	<Pine.LNX.4.64.0703081545110.10832@woody.linux-foundation.org>
	<20070309174821.GA31754@linuxtv.org>
	<20070309233508.GB2197@elf.ucw.cz> <20070310090121.GB15647@elte.hu>
	<20070310114301.GA30554@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070310114301.GA30554@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Stefan Seyfried <seife@suse.de>
Cc: Ash Milsted <thatistosayiseenem@gawab.com>, dmitry.torokhov@gmail.com, Arkadiusz Miskiewicz <arekm@maven.pl>, linux-pm@lists.osdl.org, Jens Axboe <jens.axboe@oracle.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-usb-devel@lists.sourceforge.net, Jeff Chua <jeff.chua.linux@gmail.com>, Meelis Roos <mroos@linux.ee>, Janosch Machowinski <jmachowinski@gmx.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Thomas Meyer <thomas.mey@web.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 10, 2007 at 12:43:01PM +0100, Stefan Seyfried wrote:
> On Sat, Mar 10, 2007 at 10:01:21AM +0100, Ingo Molnar wrote:
> > =

> > i'm wondering, do you have any idea how Windows handles the =

> > suspend/resume quirks problem area? Do they "curse BIOS vendors and =

> > maintain a large DB of DMI-driven exceptions", or do they perhaps have =

> > some fundamentally better approach than us? If it's the former, then we =

> > might as well try to bring more automatism (and more of your database) =

> > into the kernel itself.
> =

> I think that in windows, you simply install the "HP nx$FOOBAR intel graph=
ics
> driver" on a nx$FOOBAR machine, and the "ASUS $FOOBAR ATI graphics driver"
> on an ASUS $FOOBAR machine etc. Those drivers are mostly stock intel/ATI/
> whoever drivers, but with the little bit of extra knowledge on how to wake
> up the graphics chip.

That's also what the thinkwiki page suggests. It says:

"Affected Operating Systems:
  * Linux, all flavours.
  * Windows, for some models as well (only when using non-IBM drivers).
  * FreeBSD (on the A22M)"


Johannes
