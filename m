From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 03/16] ARM: mvebu: Add function to export the physical
 address of the boot register
Date: Tue, 1 Jul 2014 12:02:54 -0300
Message-ID: <20140701150254.GA1986@arch.cereza>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
 <1403875377-940-4-git-send-email-gregory.clement@free-electrons.com>
 <20140701134651.7d34de62@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140701134651.7d34de62@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 01 Jul 01:46 PM, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> =

> On Fri, 27 Jun 2014 15:22:44 +0200, Gregory CLEMENT wrote:
> =

> >  static void __iomem *system_controller_base;
> > +static u32 system_controller_phys_base;
> >  =

> >  struct mvebu_system_controller {
> >  	u32 rstoutn_mask_offset;
> > @@ -109,6 +110,13 @@ void mvebu_system_controller_set_cpu_boot_addr(voi=
d *boot_addr)
> >  	writel(virt_to_phys(boot_addr), system_controller_base +
> >  	       mvebu_sc->resume_boot_addr);
> >  }
> > +
> > +u32 mvebu_system_controller_get_phys_addr(void)
> > +{
> > +	BUG_ON(system_controller_phys_base =3D=3D NULL);
> =

> This rightfully generates a fairly strong warning at compile time:
> you're comparing an u32 to NULL. It should be =3D=3D 0 here.
> =


Or a more readable BUG_ON(!system_controller_phys_base);
-- =

Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
