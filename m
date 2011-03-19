From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: Question about hibernation
Date: Sun, 20 Mar 2011 05:17:23 +0530
Message-ID: <SNT117-W5712D8F8C5F4734915B5D1EBB30@phx.gbl>
References: <BLU102-W26157F65094C5BCB0C51ADEB080@phx.gbl>
	<201101050927.53977.rjw@sisk.pl>
	<SNT117-W3213A3C4E358A6A690C09BEBB00@phx.gbl>,
	<201103181509.02943.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3552556263759473415=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103181509.02943.oneukum@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: oneukum@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============3552556263759473415==
Content-Type: multipart/alternative;
	boundary="_a1d3a9e1-7c51-4a35-8fd2-765fc4b55406_"

--_a1d3a9e1-7c51-4a35-8fd2-765fc4b55406_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi=2C
=20
Thanks for reply. What if memory is allocated using dma_alloc_coherent wher=
e the physical address is from dedicated area of RAM(which is not addressab=
le by OS)? I also believe that all the buffers and state variables are take=
n care by OS kernel. Right?
=20
Thanks
Raj
=20

=20
> From: oneukum@suse.de
> To: linux-pm@lists.linux-foundation.org
> Subject: Re: [linux-pm] Question about hibernation
> Date: Fri=2C 18 Mar 2011 15:09:02 +0100
> CC: rajkumar278@hotmail.com
>=20
> Am Freitag=2C 18. M=E4rz 2011=2C 14:45:24 schrieb Raj Kumar:
> >=20
> > Hi=2C
> >=20
> > I have following question regarding the hibernation. If a device driver=
 uses dedicated memory (dedicated memory in linux which is not OS addressab=
le e.g. device driver is using some pages from dedicated memory)=2C When th=
e system hibernates=2C will this be responsibility of device driver to save=
 this area=20
> > or=20
> > OS hibernation procedure save this area of ram (dedicated memory area) =
into swap image?
>=20
> If you got it from get_free_pages (at the end of a long call chain) the
> kernel saves it. If not=2C it is your problem.
>=20
> HTH
> Oliver
 		 	   		  =

--_a1d3a9e1-7c51-4a35-8fd2-765fc4b55406_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'>
Hi=2C<BR>
&nbsp=3B<BR>
Thanks for reply. What if memory is allocated using dma_alloc_coherent wher=
e the physical address is from dedicated area of RAM(which is not addressab=
le by OS)? I also believe that all the buffers and state variables are take=
n care by OS kernel. Right?<BR>
&nbsp=3B<BR>
Thanks<BR>
Raj<BR>
&nbsp=3B<BR>
<BR>&nbsp=3B<BR>
&gt=3B From: oneukum@suse.de<BR>&gt=3B To: linux-pm@lists.linux-foundation.=
org<BR>&gt=3B Subject: Re: [linux-pm] Question about hibernation<BR>&gt=3B =
Date: Fri=2C 18 Mar 2011 15:09:02 +0100<BR>&gt=3B CC: rajkumar278@hotmail.c=
om<BR>&gt=3B <BR>&gt=3B Am Freitag=2C 18. M=E4rz 2011=2C 14:45:24 schrieb R=
aj Kumar:<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B Hi=2C<BR>&gt=3B &gt=3B <BR>&gt=
=3B &gt=3B I have following question regarding the hibernation. If a device=
 driver uses dedicated memory (dedicated memory in linux which is not OS ad=
dressable e.g. device driver is using some pages from dedicated memory)=2C =
When the system hibernates=2C will this be responsibility of device driver =
to save this area <BR>&gt=3B &gt=3B or <BR>&gt=3B &gt=3B OS hibernation pro=
cedure save this area of ram (dedicated memory area) into swap image?<BR>&g=
t=3B <BR>&gt=3B If you got it from get_free_pages (at the end of a long cal=
l chain) the<BR>&gt=3B kernel saves it. If not=2C it is your problem.<BR>&g=
t=3B <BR>&gt=3B HTH<BR>&gt=3B Oliver<BR> 		 	   		  </body>
</html>=

--_a1d3a9e1-7c51-4a35-8fd2-765fc4b55406_--

--===============3552556263759473415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3552556263759473415==--
