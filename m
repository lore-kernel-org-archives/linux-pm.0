From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Date: Tue, 31 Oct 2006 23:15:38 +0200
Message-ID: <20061031211538.GC6866@mellanox.co.il>
References: <Pine.LNX.4.64.0610300953150.25218@g5.osdl.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610300953150.25218@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, linux-pm@osdl.org, linux-acpi@vger.kernel.org, Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, Adrian Bunk <bunk@stusta.de>, Martin Lorenz <martin@lorenz.eu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Quoting r. Linus Torvalds <torvalds@osdl.org>:
> Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
> =

> =

> =

> On Mon, 30 Oct 2006, Jun'ichi Nomura wrote:
> > =

> > Please revert the patch. I'll fix the wrong error handling.
> > =

> > I'm not sure reverting the patch solves the ACPI problem
> > because Michael's kernel seems not having any user of
> > bd_claim_by_kobject.
> =

> Yeah, doing a grep does seem to imply that there is no way that those =

> changes could matter.
> =

> Michael, can you double-check? I think Jun'ichi is right - in your kernel=
, =

> according to the config posted on bugzilla, I don't think there should be =

> a single caller of bd_claim_by_disk, since CONFIG_MD is disabled.

I double-checked, and of course you are right - the issues resurfaced after=
 some
more use, even with the patch reverted.  I've written some scripts that do =
some
compiles from scratch, and suspend/resume several times.  Plan to try bi-se=
cting
with that and see what that will come up with.

OTOH, from the discussion it seems just randomly pointing a finger at a pat=
ch
has uncovered some bugs - so maybe we should do this a bit more :)


-- =

MST
