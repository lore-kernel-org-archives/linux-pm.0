From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 04/76] ACPICA: Fix regression in FADT revision checks
Date: Fri, 30 Mar 2012 09:14:53 -0400
Message-ID: <CA+5PVA4EBdoxgSrYKYRnaO2qSXDP_rxeQEogD+6jkKPi8sQB-g@mail.gmail.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
	<1333102459-23750-1-git-send-email-lenb@kernel.org>
	<3e80acd1af40fcd91a200b0416a7616b20c5d647.1333101989.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3e80acd1af40fcd91a200b0416a7616b20c5d647.1333101989.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 30, 2012 at 6:13 AM, Len Brown <lenb@kernel.org> wrote:
> From: Julian Anastasov <ja@ssi.bg>
>
> =A0 =A0 =A0 =A0commit 64b3db22c04586997ab4be46dd5a5b99f8a2d390 (2.6.3=
9),
> "Remove use of unreliable FADT revision field" causes regression
> for old P4 systems because now cst_control and other fields are
> not reset to 0.
>
> =A0 =A0 =A0 =A0The effect is that acpi_processor_power_init will noti=
ce
> cst_control !=3D 0 and a write to CST_CNT register is performed
> that should not happen. As result, the system oopses after the
> "No _CST, giving up" message, sometimes in acpi_ns_internalize_name,
> sometimes in acpi_ns_get_type, usually at random places. May be
> during migration to CPU 1 in acpi_processor_get_throttling.
>
> =A0 =A0 =A0 =A0Every one of these settings help to avoid this problem=
:
> =A0- acpi=3Doff
> =A0- processor.nocst=3D1
> =A0- maxcpus=3D1
>
> =A0 =A0 =A0 =A0The fix is to update acpi_gbl_FADT.header.length after
> the original value is used to check for old revisions.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D42700
> https://bugzilla.redhat.com/show_bug.cgi?id=3D727865
>
> Signed-off-by: Julian Anastasov <ja@ssi.bg>
> Acked-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>

This one should go into the stable trees.  The bug it fixes causes a
number of machines to not boot with anything newer than 2.6.38.

josh
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
