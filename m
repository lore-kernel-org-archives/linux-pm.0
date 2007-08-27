From: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
Subject: Re: Sleep problems with kernels >= 2.6.21 on powerpc
Date: Mon, 27 Aug 2007 10:37:27 +0200
Message-ID: <1188203847.10738.357.camel__24691.8850848035$1188225719$gmane$org@thor.sulgenrain.local>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
	<20070827065246.GA21220@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070827065246.GA21220@ime.usp.br>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@gmail.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-08-27 at 03:52 -0300, Rog=C3=A9rio Brito wrote:
>=20
> I did 13 compiles with git bisect and some of them were unsucessfuly
> compiled, which I am afraid that may miss the real cause if I tag them =
as
> being "bad" (which I did).

Yes, don't mark such cases as bad or good but look for a nearby commit
that compiles.


--=20
Earthling Michel D=C3=A4nzer           |          http://tungstengraphics=
.com
Libre software enthusiast         |          Debian, X and DRI developer
