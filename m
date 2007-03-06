From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Tue, 6 Mar 2007 14:08:08 +0200
Message-ID: <20070306120808.GA9537@mellanox.co.il>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	<20070226220152.GA29575@stusta.de>
	<20070228211318.GB4301@mellanox.co.il>
	<b6a2187b0702281945n5f62a6b5w1c535de3ef9aaa8f@mail.gmail.com>
	<20070305000421.GF3441@stusta.de>
	<b6a2187b0703051732v79a532f6mbf0d3da857a914e6@mail.gmail.com>
	<b6a2187b0703060403o48130853m9393df70160303c1@mail.gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <b6a2187b0703060403o48130853m9393df70160303c1@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> Quoting Jeff Chua <jeff.chua.linux@gmail.com>:
> Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
> =

> On 3/6/07, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> > On 3/5/07, Adrian Bunk <bunk@stusta.de> wrote:
> >
> > > > I have the same problem on my IBM X60s on rc1 and rc2. Can't resume
> > > > from RAM, can't suspend to disk. It is possible to revert all the
> > > > changes to ACPI and test it?
> > >
> > > This is with CONFIG_KVM=3Dn?
> >
> > Yes.
> =

> I've tried with CONFIG_KVM=3Dn and CONFIG_KVM=3Dy and both does not suspe=
nd.

Do you mean that they "do not resume after suspend"?

-- =

MST
