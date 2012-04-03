From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [3.0.y, 3.2.y, 3.3.y] Re: [PATCH 04/76] ACPICA: Fix regression in
 FADT revision checks
Date: Tue, 3 Apr 2012 16:15:32 -0400
Message-ID: <CA+5PVA58jN8S9efACB==o5Z9frEOxVN__wo9yYU6ErQcsKyj8w@mail.gmail.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
	<1333102459-23750-1-git-send-email-lenb@kernel.org>
	<3e80acd1af40fcd91a200b0416a7616b20c5d647.1333101989.git.len.brown@intel.com>
	<CA+5PVA4EBdoxgSrYKYRnaO2qSXDP_rxeQEogD+6jkKPi8sQB-g@mail.gmail.com>
	<20120403195804.GA19239@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120403195804.GA19239@burratino>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, Len Brown <len.brown@intel.com>, wzab@ise.pw.edu.pl, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 3, 2012 at 3:58 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Hi Greg,
>
> Josh Boyer wrote:
>> On Fri, Mar 30, 2012 at 6:13 AM, Len Brown <lenb@kernel.org> wrote:
>
>>> From: Julian Anastasov <ja@ssi.bg>
>>>
>>> =A0 =A0 =A0 =A0commit 64b3db22c04586997ab4be46dd5a5b99f8a2d390 (2.6=
=2E39),
>>> "Remove use of unreliable FADT revision field" causes regression
>>> for old P4 systems because now cst_control and other fields are
>>> not reset to 0.
> [...]
>>> =A0 =A0 =A0 =A0The fix is to update acpi_gbl_FADT.header.length aft=
er
>>> the original value is used to check for old revisions.
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D42700
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D727865
>>>
>>> Signed-off-by: Julian Anastasov <ja@ssi.bg>
>>> Acked-by: Bob Moore <robert.moore@intel.com>
>>> Signed-off-by: Len Brown <len.brown@intel.com>
>>
>> This one should go into the stable trees.
>
> Please apply
>
> =A03e80acd1af40 "ACPICA: Fix regression in FADT revision checks"
>
> which is in linus's master to the 3.0.y, 3.2.y, and 3.3.y series to
> fix this old boot problem. =A0(Many affected people disabled HT in th=
e
> BIOS to work around it in the meantime.)
>
> WZab (cc-ed) has tested that the patch addresses the problem when
> applied to the 3.2.y and 3.3.y branches. =A0[1] has details.

We've had this applied in Fedora on 3.2 and 3.3 for a while now as
well.

josh
