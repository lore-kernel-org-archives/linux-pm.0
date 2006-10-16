From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: x60 backlight Re: [discuss] 2.6.19-rc1: known
	regressions (v2)
Date: Mon, 16 Oct 2006 21:39:25 +0200
Message-ID: <20061016193925.GA20009@mellanox.co.il>
References: <20061008193005.GJ6755@stusta.de>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061008193005.GJ6755@stusta.de>
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
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-pm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Quoting r. Adrian Bunk <bunk@stusta.de>:
> Subject: Re: x60 backlight Re: [discuss] 2.6.19-rc1: known regressions (v=
2)
> =

> On Sun, Oct 08, 2006 at 07:59:58PM +0200, Michael S. Tsirkin wrote:
> > Quoting r. Adrian Bunk <bunk@stusta.de>:
> > > Subject: Re: x60 backlight Re: [discuss] 2.6.19-rc1: known regression=
s (v2)
> > > =

> > > On Sun, Oct 08, 2006 at 07:12:54AM +0000, Pavel Machek wrote:
> > > > =

> > > > On Sat 07-10-06 23:46:21, Adrian Bunk wrote:
> > > > > This email lists some known regressions in 2.6.19-rc1 compared to=
 2.6.18
> > > > > that are not yet fixed Linus' tree.
> > > > > =

> > > > ...
> > > > > Subject    : T60 stops triggering any ACPI events
> > > > > References : http://lkml.org/lkml/2006/10/4/425
> > > > > Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> > > > > Status     : unknown
> > =

> > This was on a pre -rc1 git tree.
> > I've been using -rc1 since it's out and does not happen to me anymore.
> > So we probably can write this off as a memory corruption
> > issue that got fixed in between.
> =

> Thanks for the information, I've removed it from the list.
 =


Unfortunately, this came back after using 2.6.19-rc1 for a couple of days
without reboot. And I just re-tested and was able to re-produce the problem=
 on
2.6.19-rc2, as well. So the problem is still there, with the same symptoms:
after usig machine for a while, or under stress (e.g. if I do a full kernel
compile), I stop getting any ACPI events.

tail -f /var/log/acpid
does not show anything, even on Fn/F4 which is supposed ot be always enable=
d.
Restarting the acpid doesn't do anything either - ACPI starts working
again, for a while, only after reboot.

Worked fine under 2.6.18 (I was running vanilla + this patch
http://lkml.org/lkml/2006/7/20/56 which made it into upstream since then).

Any ideas? How to debug this?

-- =

MST
