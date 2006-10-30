From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Date: Mon, 30 Oct 2006 19:54:49 +0200
Message-ID: <20061030175449.GP1941@mellanox.co.il>
References: <4546345E.3050706@ce.jp.nec.com>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <4546345E.3050706@ce.jp.nec.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, Linus Torvalds <torvalds@osdl.org>, linux-pm@osdl.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Martin Lorenz <martin@lorenz.eu.org>
List-Id: linux-pm@vger.kernel.org

Quoting r. Jun'ichi Nomura <j-nomura@ce.jp.nec.com>:
> Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
> =

> Hi Michael,
> =

> Michael S. Tsirkin wrote:
> >> The code is related to bd_claim_by_disk which is called when
> >> device-mapper or md tries to mark the underlying devices
> >> for exclusive use and creates symlinks from/to the devices
> >> in sysfs. The patch added error handlings which weren't in
> >> the original code.
> >>
> >> I have no idea how it affects ACPI event handling.
> > =

> > It's a mystery. Probably exposes a bug somewhere?
> > =

> >> Are you using dm and/or md on your machine?
> > =

> > The .config is attached to bugzilla.
> =

> OK, I found you disabled CONFIG_MD, which means neither
> dm.ko nor md.ko was built.
> Do you have any out-of-tree kernel modules which call either
> bd_claim_by_kobject or bd_claim_by_disk?

No, I don't have any out-of-tree modules.

> If you aren't using either of them, I'm afraid reverting
> the patch doesn't really solve your problem because the patched
> code is called only from them.

I agree this could be just papering over some issue.
The test results (of both git-bisect and reverting the patch) seem to be pr=
etty
consistent so far though. Keep me posted if you rework the patch.

> >> Have you seen any unusual kernel messages or symptoms regarding
> >> dm/md before the ACPI problem occurs?
> > =

> > I haven't.
> =

> Thanks,

-- =

MST
