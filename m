From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.19-rc2: known unfixed regressions (v3)
Date: Wed, 25 Oct 2006 10:37:11 +0200
Message-ID: <20061025083711.GB9518@mellanox.co.il>
References: <20061025082820.GD7083@elf.ucw.cz>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061025082820.GD7083@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, Linus Torvalds <torvalds@osdl.org>, linux-pm@osdl.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

Quoting r. Pavel Machek <pavel@suse.cz>:
> > >
> > > Subject    : T60 stops triggering any ACPI events
> > > References : http://lkml.org/lkml/2006/10/4/425
> > >              http://lkml.org/lkml/2006/10/16/262
> > > Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> > > Status     : unknown
> > =

> > Just retested with 2.6.19-rc3 - it's still there:
> > e.g. after I do a full kernel compile, my T60 stops triggering any ACPI=
 events:
> > tail -f /var/log/acpid does not show anything, even on Fn/F4 which is s=
upposed
> > to be always enabled.  Restarting the acpid doesn't do anything either =
- ACPI
> > starts working again, for a while, only after reboot.
> > =

> > Works fine in 2.6.18 ( + this patch http://lkml.org/lkml/2006/7/20/56).
> =

> Bugzilla.kernel.org, assign it to acpi people...

Already done, http://bugzilla.kernel.org/show_bug.cgi?id=3D7408

-- =

MST
