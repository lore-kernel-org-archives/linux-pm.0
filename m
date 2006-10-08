From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Re: 2.6.19-rc1: known regressions (v2)
Date: 7 Oct 2006 21:43:51 -0700
Message-ID: <EXSVLRB01xe0ymQ1WE900000265__6233.8009862744$1160282679$gmane$org@exsvlrb01.hq.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

Cc: Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-ke=
rnel@vger.kernel.org>, art@usfltd.com, ak@suse.de, discuss@x86-64.org,  Pra=
kash Punnoor <prakash@punnoor.de>, perex@suse.cz, alsa-devel@alsa-project.o=
rg, Steve Fox <drfickle@us.ibm.com>,  netdev@vger.kernel.org, "Michael S. T=
sirkin" <mst@mellanox.co.il>,  len.brown@intel.com, linux-acpi@vger.kernel.=
org, Pavel Machek <pavel@ucw.cz>,  Olaf Hering <olaf@aepfle.de>, Antonino D=
aplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net,  Thierry =
Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com, linux-ide@vger.kernel.o=
rg, Ernst Herzberg <list-lkml@net4u.de>, Matthieu Castet <castet.matthieu@f=
ree.fr>,  linux-usb-devel@lists.sourceforge.net, Jens Axboe <axboe@oracle.c=
om>,  Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@osdl.org,=
 linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@suse.de>,  Mel Gorman <mel=
@skynet.ie>, Alex Romosan <romosan@sycorax.lbl.gov>, Sukadev Bhattiprolu <s=
ukadev@us.ibm.!
 com>, Dave Kleikamp <shaggy@austin.ibm.com>, Torsten Kaiser <kernel@bardio=
c.dyndns.org>, Magnus Damm <magnus.damm@gmail.com>, Vivek Goyal <vgoyal@in.=
ibm.com>, ebiederm@xmission.com, fastboot@osdl.org, Alistair John Strachan =
<s0348365@sms.ed.ac.uk>, Stefan Richter <stefanr@s5r6.in-berlin.de>,  linux=
1394-devel@lists.sourceforge.net
In-Reply-To: <20061007214620.GB8810@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	 <20061007214620.GB8810@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Sun, 08 Oct 2006 00:43:35 -0400
Message-Id: <1160282615.5506.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 =


On Sat, 2006-10-07 at 23:46 +0200, Adrian Bunk wrote:

> Subject    : NFSv4 fails to mount (timeout)
> References : http://bugzilla.kernel.org/show_bug.cgi?id=3D7274
> Submitter  : Torsten Kaiser <kernel@bardioc.dyndns.org>
> Guilty     : Trond Myklebust <Trond.Myklebust@netapp.com>
>              commit 51b6ded4d9a94a61035deba1d8f51a54e3a3dd86
> Handled-By : Trond Myklebust <Trond.Myklebust@netapp.com>
> Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=3D7274
> Status     : patch available

Thanks... Always nice to hear that you have been judged and found
guilty. Now go and reread that fucking bug report...
