From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Wed, 06 Jun 2007 23:14:47 +0200
Message-ID: <466723C7.3090305@s5r6.in-berlin.de>
References: <200705181207.45868.marcus@better.se>	
	<tkrat.5b4ba1068f8b64ee@s5r6.in-berlin.de>	
	<tkrat.07833adfb2306655@s5r6.in-berlin.de>	
	<200705311441.14021.marcus@better.se>	
	<465EDA0E.8060400@s5r6.in-berlin.de>
	<59ad55d30706061314s45c86e7eja587244a6ed37812@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <59ad55d30706061314s45c86e7eja587244a6ed37812@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>
Cc: linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Marcus Better <marcus@better.se>
List-Id: linux-pm@vger.kernel.org

Kristian H=F8gsberg wrote:
> I've posted an updated version of the patch here
                 ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^
You mean "addition to the previous" patch. :-)

> that fixes a byteswapping problem, and should make the stack
> actually work after resuming:
>=20
> http://marc.info/?l=3Dlinux1394-devel&m=3D118108604226326&w=3D2

That is, protocols which do not involve showing the local ROM to remote
nodes are unaffected?  In that case I would prefer to defer this new
patch until the next merge window if you don't mind.  Nevertheless, if
Marcus could take the time to check whether his machine keeps happily
resuming with the new patch applied, that would be good.  I will test it
with APM suspend and SBP-2 circa tomorrow.
--=20
Stefan Richter
-=3D=3D=3D=3D=3D-=3D-=3D=3D=3D -=3D=3D- --=3D=3D-
http://arcgraph.de/sr/
