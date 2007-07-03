From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 10:20:13 +0200
Message-ID: <200707031020.13691.oliver__34102.8526112952$1183451127$gmane$org@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<1183448224.12649.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183448224.12649.14.camel@localhost>
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
To: Romano Giannetti <romanol@upcomillas.es>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 3. Juli 2007 schrieb Romano Giannetti:
> On Tue, 2007-07-03 at 05:29 +0100, Matthew Garrett wrote:
> > or alternatively we =C2=A0could do what we do for suspend to RAM on o=
ther
> > platforms (PPC and APM) and just not use the freezer.
>=20
> As a data point, I am running with this patch on top of 2.6.21.2 the
> last 3+ weeks, with an average of 5/6 STR cycles a day, and had no
> problems at all. (Sony vaio pcg-fx701). Just normal work, I didn't try
> to stress the thing, but I have quite a few times suspended/resumed ove=
r
> a big compile without a glitch.
>=20
> What are the risks of this patch supposed to be?

You did this test only while stressing normal block devices. Try
provoking races in character devices.

	Regards
		Oliver
