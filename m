From: Pavel Machek <pavel@ucw.cz>
Subject: Re: what handles disk drive(s) shutdown?
Date: Fri, 10 Feb 2006 23:56:05 +0100
Message-ID: <20060210225605.GB1952@elf.ucw.cz>
References: <Pine.LNX.4.58.0602091407590.7095@shark.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76759190179492642=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0602091407590.7095@shark.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============76759190179492642==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> in Documentation/power/devices.txt, I read:
> 
> <quote>
> System shutdown -- at least disks need to be spun down, or data may be
> lost. Quiesce devices, just to make life easier for BIOS. event =
> FREEZE, flags = SYSTEM_SHUTDOWN
> </quote>
> 
> Is this actually done somewhere?  I can't find /SYSTEM_SHUTDOWN/
> in any kernel .h or .c files.

I think we do FREEZE during shutdown, but flags never got
implemented. It seems nobody really needs them, so...

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...

--===============76759190179492642==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76759190179492642==--
