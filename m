From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [3.0.y, 3.2.y, 3.3.y] Re: [PATCH 04/76] ACPICA: Fix regression in
 FADT revision checks
Date: Tue, 3 Apr 2012 14:58:44 -0500
Message-ID: <20120403195804.GA19239@burratino>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
 <1333102459-23750-1-git-send-email-lenb@kernel.org>
 <3e80acd1af40fcd91a200b0416a7616b20c5d647.1333101989.git.len.brown@intel.com>
 <CA+5PVA4EBdoxgSrYKYRnaO2qSXDP_rxeQEogD+6jkKPi8sQB-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+5PVA4EBdoxgSrYKYRnaO2qSXDP_rxeQEogD+6jkKPi8sQB-g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, Len Brown <len.brown@intel.com>, Josh Boyer <jwboyer@gmail.com>, wzab@ise.pw.edu.pl, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Greg,

Josh Boyer wrote:
> On Fri, Mar 30, 2012 at 6:13 AM, Len Brown <lenb@kernel.org> wrote:

>> From: Julian Anastasov <ja@ssi.bg>
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit 64b3db22c04586997ab4be46dd5a5b99f8=
a2d390 (2.6.39),
>> "Remove use of unreliable FADT revision field" causes regression
>> for old P4 systems because now cst_control and other fields are
>> not reset to 0.
[...]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0The fix is to update acpi_gbl_FADT.header=
=2Elength after
>> the original value is used to check for old revisions.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D42700
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D727865
>>
>> Signed-off-by: Julian Anastasov <ja@ssi.bg>
>> Acked-by: Bob Moore <robert.moore@intel.com>
>> Signed-off-by: Len Brown <len.brown@intel.com>
>
> This one should go into the stable trees.

Please apply

  3e80acd1af40 "ACPICA: Fix regression in FADT revision checks"

which is in linus's master to the 3.0.y, 3.2.y, and 3.3.y series to
fix this old boot problem.  (Many affected people disabled HT in the
BIOS to work around it in the meantime.)

WZab (cc-ed) has tested that the patch addresses the problem when
applied to the 3.2.y and 3.3.y branches.  [1] has details.

Thanks,
Jonathan

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D38262
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
