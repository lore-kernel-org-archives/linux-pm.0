From: Pavel Machek <pavel@ucw.cz>
Subject: Re: apm for individual devices
Date: Wed, 8 Mar 2006 16:51:53 +0100
Message-ID: <20060308155153.GB3669@elf.ucw.cz>
References: <105E3883E4A2524BB0B1281D1599C473CA93F8@zmy16exm62.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <105E3883E4A2524BB0B1281D1599C473CA93F8@zmy16exm62.ds.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Li Qiang-E3422C <E3422C@motorola.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On =DAt 07-03-06 10:11:31, Li Qiang-E3422C wrote:
> '0' indicates the device is on. Other values (1-3) indicate the device
> is in a low power state.=20
> You can see ACPI's spec.

Actually, no. This is broken interface, please do not use it. 0 =3D=3D on=
,
2 or 3 =3D=3D off. But do not use it.
								Pavel
--=20
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
