From: Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [3.0.y, 3.2.y,
 3.3.y] Re: [PATCH 04/76] ACPICA: Fix regression in FADT revision
 checks
Date: Wed, 4 Apr 2012 11:58:56 -0700
Message-ID: <20120404185856.GA2272@kroah.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
	<1333102459-23750-1-git-send-email-lenb@kernel.org>
	<3e80acd1af40fcd91a200b0416a7616b20c5d647.1333101989.git.len.brown@intel.com>
	<CA+5PVA4EBdoxgSrYKYRnaO2qSXDP_rxeQEogD+6jkKPi8sQB-g@mail.gmail.com>
	<20120403195804.GA19239@burratino>
	<CA+5PVA58jN8S9efACB==o5Z9frEOxVN__wo9yYU6ErQcsKyj8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+5PVA58jN8S9efACB==o5Z9frEOxVN__wo9yYU6ErQcsKyj8w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Josh Boyer <jwboyer@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>, linux-acpi@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, linux-pm@lists.linux-foundation.org, wzab@ise.pw.edu.pl
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 03, 2012 at 04:15:32PM -0400, Josh Boyer wrote:
> On Tue, Apr 3, 2012 at 3:58 PM, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> > Hi Greg,
> >
> > Josh Boyer wrote:
> >> On Fri, Mar 30, 2012 at 6:13 AM, Len Brown <lenb@kernel.org> wrote:
> >
> >>> From: Julian Anastasov <ja@ssi.bg>
> >>>
> >>> =A0 =A0 =A0 =A0commit 64b3db22c04586997ab4be46dd5a5b99f8a2d390 (2.6.3=
9),
> >>> "Remove use of unreliable FADT revision field" causes regression
> >>> for old P4 systems because now cst_control and other fields are
> >>> not reset to 0.
> > [...]
> >>> =A0 =A0 =A0 =A0The fix is to update acpi_gbl_FADT.header.length after
> >>> the original value is used to check for old revisions.
> >>>
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=3D42700
> >>> https://bugzilla.redhat.com/show_bug.cgi?id=3D727865
> >>>
> >>> Signed-off-by: Julian Anastasov <ja@ssi.bg>
> >>> Acked-by: Bob Moore <robert.moore@intel.com>
> >>> Signed-off-by: Len Brown <len.brown@intel.com>
> >>
> >> This one should go into the stable trees.
> >
> > Please apply
> >
> > =A03e80acd1af40 "ACPICA: Fix regression in FADT revision checks"
> >
> > which is in linus's master to the 3.0.y, 3.2.y, and 3.3.y series to
> > fix this old boot problem. =A0(Many affected people disabled HT in the
> > BIOS to work around it in the meantime.)
> >
> > WZab (cc-ed) has tested that the patch addresses the problem when
> > applied to the 3.2.y and 3.3.y branches. =A0[1] has details.
> =

> We've had this applied in Fedora on 3.2 and 3.3 for a while now as
> well.

Wonderful, now queued up, thanks for letting me know.

greg k-h
