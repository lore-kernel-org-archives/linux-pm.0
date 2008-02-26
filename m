From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc2-git] crosslink ACPI and "real"
	device nodes
Date: Mon, 25 Feb 2008 22:45:43 -0800
Message-ID: <200802252245.43282.david-b__11845.6980832436$1204008448$gmane$org@pacbell.net>
References: <200802222154.25204.david-b@pacbell.net>
	<1203976028.10256.87.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1203976028.10256.87.camel@acpi-hp-zz.sh.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 25 February 2008, Zhang, Rui wrote:
> > + =A0 =A0 =A0 if (!ACPI_FAILURE(status)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D sysfs_create_link(&dev->kobj, &ac=
pi_dev->dev.kobj,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "firmware=
_node");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D sysfs_create_link(&acpi_dev->dev.=
kobj, &dev->kobj,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "physical=
_node");
> > + =A0 =A0 =A0 }
>
> ret is not needed here...

But what compiler warnings do you see when you omit it?  :)
