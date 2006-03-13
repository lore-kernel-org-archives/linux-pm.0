From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: Re: standby to disk transition
Date: Tue, 14 Mar 2006 07:59:07 +1000
Message-ID: <200603140759.15754.nigel@suspend2.net>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<20060313212420.GG10348@elf.ucw.cz>
	<20060313212856.GA16874@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============99738322551801495=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060313212856.GA16874@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>
Cc: linux-pm@osdl.org, "Victor Porton, , , " <porton@ex-code.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============99738322551801495==
Content-Type: multipart/signed; boundary="nextPart1559119.egA1TnWxqu";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1559119.egA1TnWxqu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Dave.

On Tuesday 14 March 2006 07:28, Dave Jones wrote:
> On Mon, Mar 13, 2006 at 10:24:20PM +0100, Pavel Machek wrote:
>  > > if suspend-to-disk is fast enough, you could just *always* write
>  > > to disk, even if we're doing S3.  If power runs out, you then have a
>  > > valid resume image on-disk.  iirc, this is what Windows does.
>  >
>  > Yep, I call that suspend-to-both. It is planned, but not really
>  > trivial, and I'm a little busy. If someone wants to help....
>
> I was thinking a few days ago. With your move of all this stuff to
> userspace, if it was done in multiple stages, we could implement
> a form of checkpointing this way.
>
> So instead of doing the 'suspend to disk/ram' after 'write out all pages',
> we just continue.
>
> Why is this useful ?  We've seen bugs reported that only ever bite
> customers after they've run their workload for a month.  Now, if they had=
 a
> means of checkpointing, then when it crashes, they could capture the last
> image that landed somewhere, and set that up for more tests/monitoring wi=
th
> kprobes etc and reproduce those hard-to-reproduce bugs a lot faster.

I've been asked about this from time to time too. Apart from the issues Pav=
el=20
has already mentioned, the big problem in my mind was figuring out what to =
do=20
about disk storage. As the algorithm stands at the moment, the image includ=
es=20
information about the state of mounted filesystems. We'd need to somehow ge=
t=20
rid of or be able to ignore that. Any suggestions?

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1559119.egA1TnWxqu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEFeszN0y+n1M3mo0RApC/AJ43Lhuo1t5OCwU7DqLPnwE2+nJ0/QCfb/RL
E2V84Bv8GgfReiJtnkP0zvA=
=HSEh
-----END PGP SIGNATURE-----

--nextPart1559119.egA1TnWxqu--

--===============99738322551801495==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============99738322551801495==--
