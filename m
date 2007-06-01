From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [3/3] 2.6.22-rc3: known regressions v2  (suspend,
	fw-ohci)
Date: Fri, 01 Jun 2007 16:23:55 +0200
Message-ID: <46602BFB.9040706__34735.4854028255$1180707889$gmane$org@s5r6.in-berlin.de>
References: <465FED20.3090206@googlemail.com> <46600F34.8010404@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46600F34.8010404@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@bitplanet.net>, linux-usb-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, Marcus Better <marcus@better.se>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux1394-devel@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Michal Piotrowski wrote:
> Suspend
>=20
> Subject    : 2.6.22-rc1 suspend to RAM problem
> References : http://permalink.gmane.org/gmane.linux.power-management.ge=
neral/5819
> Submitter  : Marcus Better <marcus@better.se>
> Handled-By : Stefan Richter <stefanr@s5r6.in-berlin.de>
>              Kristian H=C3=B8gsberg <krh@bitplanet.net>
> Status     : caused by fw-ohci module

A patch is now available and was tested by Marcus yesterday:
http://marc.info/?l=3Dlinux1394-devel&m=3D118060953728808

The patch is part of today's linux1394-2.6.git pull request.
--=20
Stefan Richter
-=3D=3D=3D=3D=3D-=3D-=3D=3D=3D -=3D=3D- ----=3D
http://arcgraph.de/sr/
