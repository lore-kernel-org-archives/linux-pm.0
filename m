From: "Markus Rechberger" <markus.rechberger@amd.com>
Subject: Re: [4/4] 2.6.21-rc5: known regressions (v2)
Date: Thu, 05 Apr 2007 16:33:38 +0200
Message-ID: <461508C2.9000207@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Tejun Heo <htejun@gmail.com>, Fr??d??ric Riss <frederic.riss@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Tino Keitel <tino.keitel@gmx.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Adrian Bunk <bunk@stusta.de>, cijoml@volny.cz, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, maximlevitsky@gmail.com
List-Id: linux-pm@vger.kernel.org

Subject    : USB: Oops when changing DVB-T adapter
References : http://lkml.org/lkml/2007/3/9/212
Submitter  : CIJOML <cijoml@volny.cz>
Status     : unknown

regarding this one there's a fix available for unplugging dvb devices =

when they're in still in use.
The problem was that the filehandle was still open and the fops =

structure got deallocated immediatelly when a device got unplugged.

http://mcentral.de/hg/~mrec/v4l-dvb-stable/ (the last 3 patches)

Markus


On 4/1/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
 > > Subject    : after resume: X hangs after drawing a couple of windows
 > >              workaround: clocksource=3Dacpi_pm
 > > References : http://lkml.org/lkml/2007/3/8/117
 > >              http://lkml.org/lkml/2007/3/25/20
 > >              http://lkml.org/lkml/2007/3/26/151
 > > Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
 > > Handled-By : Thomas Gleixner <tglx@linutronix.de>
 > > Status     : problem is being debugged
 >
 > Seems to be resolved with 399afa4fc9238fbae42116cf25a54671c0e8f56e.
 > Thanks Maxim!
 >
 >
 > --
 > MST
 > -
 > To unsubscribe from this list: send the line "unsubscribe =

linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
 >


-- =

Markus Rechberger

-- =

Markus Rechberger
Operating System Research Center
AMD Saxony LLC & Co. KG
