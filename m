From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [2/6] 2.6.21-rc2: known regressions
Date: Sun, 11 Mar 2007 09:20:02 +0100
Message-ID: <20070311082002.GA4013@elte.hu>
References: <Pine.LNX.4.64.0703080954220.10832@woody.linux-foundation.org>
	<20070308192554.GA2999@elte.hu> <20070308230705.GA4611@elte.hu>
	<Pine.LNX.4.64.0703081545110.10832@woody.linux-foundation.org>
	<20070309174821.GA31754@linuxtv.org>
	<20070309233508.GB2197@elf.ucw.cz> <20070310090121.GB15647@elte.hu>
	<20070310114301.GA30554@suse.de> <20070310151804.GA10627@elte.hu>
	<20070310220810.GF2758@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070310220810.GF2758@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Ash Milsted <thatistosayiseenem@gawab.com>, Johannes Stezenbach <js@linuxtv.org>, Arkadiusz Miskiewicz <arekm@maven.pl>, linux-pm@lists.osdl.org, Jens Axboe <jens.axboe@oracle.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, dmitry.torokhov@gmail.com, Stefan Seyfried <seife@suse.de>, linux-usb-devel@lists.sourceforge.net, Jeff Chua <jeff.chua.linux@gmail.com>, Meelis Roos <mroos@linux.ee>, Janosch Machowinski <jmachowinski@gmx.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Thomas Meyer <thomas.mey@web.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Pavel Machek <pavel@suse.cz> wrote:

> > Probably tweaking the webpage doesnt help because people dont get =

> > there - as the results plainly show it. Maybe some more automation =

> > would be useful too, a tool that detects failed resume and tries all =

> > those options that makes sense on that box or something? It's not =

> > like that
> =

> Unfortunately, these tend to crash the box when you pass wrong =

> options, and I do not see easy way to test "can user see whats on =

> display" automatically.

you could perhaps try what X's modesetting utility does: display a =

dialog box that times out if it does not get clicked on, and reboot if =

it did not get clicked on. Likewise, detect upon the next bootup that a =

suspend-test was in progress (and didnt get back via normal resume), via =

some temporary file. That way both the 'did not resume and i had to =

power-cycle' and the 'resume did not restore my X' problems can be =

handled.

Finally, when the correct options have been established (worse-case with =

a small number of reboots and "yes, indeed the resume did not work fine" =

clicks done upon bootup by the user), automatically fill in a webform in =

firefox and ask the user to do a single click to submit that form.

techniques like that have more chance i think to get Linux =

suspend/resume anywhere near to working. The current 'rely on the =

developer' technique apparently does not work.

	Ingo
