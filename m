From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: SATA resume slowness, e1000 MSI warning
Date: Sun, 11 Mar 2007 20:37:09 +0200
Message-ID: <20070311183709.GB19601@mellanox.co.il>
References: <20070311180342.GE24475@mellanox.co.il>
	<m1mz2jws83.fsf@ebiederm.dsl.xmission.com>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <m1mz2jws83.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Kok, Auke" <auke-jan.h.kok@intel.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> Quoting Eric W. Biederman <ebiederm@xmission.com>:
> Subject: Re: SATA resume slowness, e1000 MSI warning
> =

> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> =

> >> Rumor has it that some pci devices can't tolerate < 32bit accesses.
> >> Although I have never met one.
> >
> > hopefully not bridge devices?
> >
> >> The two factors together suggest that
> >> for generic code it probably makes sense to operate on 32bit
> >> quantities, and just to ignore the read-only portion.
> >
> > The code for regular devices seems to use 16-bit accesses, so
> > I think it's best to stay consistent. Or do you want to change this too?
> =

> If we are stomping rare probabilities we might as well change that too.
> The code to save pci-x state is relatively recent.  So it probably just
> hasn't met a problem device yet (assuming they exist).

OK I guess. I gather we assume writing read-only registers has no side effe=
cts?
Are there rumors circulating wrt to these?

-- =

MST
