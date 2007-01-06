From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 6/6] [-mm]: ACPI: duplicate ACPI "info"
	attribute in sysfs
Date: Sat, 6 Jan 2007 13:36:49 -0800
Message-ID: <200701061336.49518.david-b@pacbell.net>
References: <1168083333.5619.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1168083333.5619.40.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Saturday 06 January 2007 3:35 am, Zhang Rui wrote:

> +static struct subsys_attribute info_attr =3D {
> +	.attr	=3D {
> +		.name =3D __stringify(info),
> +		.mode =3D 0444,
> +	},
> +	.show =3D info_show,
> +	.store =3D NULL,
> +};

Please don't expand __ATTR_RO(info) by hand; notice what
your manual version omitted, for one thing ...
