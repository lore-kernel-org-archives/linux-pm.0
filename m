From: Pavel Machek <pavel@suse.cz>
Subject: Suspend to RAM and disk
Date: Mon, 16 Jan 2006 12:40:37 +0100
Message-ID: <20060116114037.GA26986@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============44590094963555948=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, seife@suse.de
List-Id: linux-pm@vger.kernel.org

--===============44590094963555948==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

In good old days of Pentium MMX, when ACPI was not yet born and APM
ruled the world, I had and thinkpad 560X notebook. And that beast
supported suspend-to-both: It stored image on disk, but then suspended
to RAM, anyway. I think I want that feature back.

[Advantage was, that suspend/resume was reasonably fast for common
case, yet you did not loose your opened applications if your battery
ran flat. Speed advantage will be even greater these days -- boot of
"resume" kernel takes most of time.]

Unfortunately, suspend-to-RAM is not in quite good state these
days. It tends to work -- after you setup your video drivers according
to video.txt, with some scripting needed. Unfortunately, after we
suspended to disk, system is frozen -- we may not run scripts.

I guess the solution is to create userland application that will parse
the DMI, look into table, and if it is neccessary do the vbe
saving/restoring itself. (We may not run external binaries on frozen
system; everything has to be pagelocked.) I guess that will include
quite a lot of cut-copy-and-paste from various project, but I see no
other way :-(.

OTOH this should get us to state where suspend-to-RAM "just works", so
I guess it is worth it.
								Pavel 
-- 
Thanks, Sharp!

--===============44590094963555948==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============44590094963555948==--
