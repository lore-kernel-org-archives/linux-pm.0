From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 12:08:40 +0200
Message-ID: <200707041208.40735.oliver__42180.2434525036$1183543765$gmane$org@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707041039.30015.oliver@neukum.org>
	<18059.26259.765791.62319@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18059.26259.765791.62319@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 4. Juli 2007 schrieb Paul Mackerras:
> Oliver Neukum writes:
>=20
> > > It's not lost, it's sitting in RAM, and will be sent out when you
> > > resume.
> >=20
> > Unfortunately this is not the case. The URB will error out.
>=20
> So the higher-level driver needs to do the sensible thing, i.e.,
> resubmit the URB after resume. =A0It's not rocket science. =A0The data =
is
> not lost, it's sitting in RAM, and the higher-level driver will send
> it out when you resume. =A0If not, then we fix the higher-level driver.

You cannot simply restart the URB without thinking.
The device after resumption may or may not be in the stage
you left it. It needs to be rechecked and some settings must be
renewed. You cannot simple throw an URB from an arbitrary
stage of the protocol at it.
Suspension of devices can only happen at some points
in the protocol.

	Oliver
