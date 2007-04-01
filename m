From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [4/4] 2.6.21-rc5: known regressions (v2)
Date: Sun, 1 Apr 2007 10:04:24 +0300
Message-ID: <20070401070424.GB5436@mellanox.co.il>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
	<20070330214956.GQ14134@stusta.de>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070330214956.GQ14134@stusta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Tejun Heo <htejun@gmail.com>, Fr??d??ric Riss <frederic.riss@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Tino Keitel <tino.keitel@gmx.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-pm@vger.kernel.org

> Subject    : after resume: X hangs after drawing a couple of windows
>              workaround: clocksource=3Dacpi_pm
> References : http://lkml.org/lkml/2007/3/8/117
>              http://lkml.org/lkml/2007/3/25/20
>              http://lkml.org/lkml/2007/3/26/151
> Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
> Handled-By : Thomas Gleixner <tglx@linutronix.de>
> Status     : problem is being debugged

Adrian,
the bug was found by Maxim Levitsky and
the following patch appears to have fixed the problem:
http://lkml.org/lkml/2007/3/28/104

the right way to fix it is still being discussed:
http://lkml.org/lkml/2007/3/28/182


-- =

MST
