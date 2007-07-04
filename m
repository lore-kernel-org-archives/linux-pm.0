From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 18:27:19 +1000
Message-ID: <18059.23015.860618.268754__27416.803854476$1183537776$gmane$org@cargo.ozlabs.ibm.com>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031342.14295.oliver@neukum.org>
	<18058.55215.185633.434117@cargo.ozlabs.ibm.com>
	<200707041011.33279.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707041011.33279.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Oliver Neukum writes:

> > Indeed, and the USB framework has code to know when the host
> > controller is suspended and avoid trying to send out urbs in that
> > case. =A0Or at least it did last time I looked at it in any detail; i=
t's
> > been "just working" - including suspending and resuming, without the
> > freezer - for quite a while now.
>=20
> And what happens to that IO? I suspended and lost data is not an
> acceptable behavior.

It's not lost, it's sitting in RAM, and will be sent out when you
resume.

Paul.
