From: Tehn Yit Chin <tehn-yit.chin@greyinnovation.com>
Subject: Re: apm for individual devices
Date: Thu, 09 Mar 2006 12:57:42 +1100
Message-ID: <440F8B96.5080802@greyinnovation.com>
References: <105E3883E4A2524BB0B1281D1599C473CA93F8@zmy16exm62.ds.mot.com>
	<20060308155153.GB3669@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060308155153.GB3669@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Li Qiang-E3422C <E3422C@motorola.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> On =DAt 07-03-06 10:11:31, Li Qiang-E3422C wrote:
>=20
>>'0' indicates the device is on. Other values (1-3) indicate the device
>>is in a low power state.=20
>>You can see ACPI's spec.
>=20
>=20
> Actually, no. This is broken interface, please do not use it. 0 =3D=3D =
on,
> 2 or 3 =3D=3D off. But do not use it.
> 								Pavel

Are you saying not to the the power/state that is present in the=20
device's sysfs entry? What interface do you recommend that I use?

cheers,
tyc
