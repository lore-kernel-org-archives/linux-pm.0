From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: linux-pm bleeding-edge build failure
Date: Mon, 12 May 2014 05:35:52 +0300
Message-ID: <53703388.3010501@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:39150 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750905AbaELCfz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 11 May 2014 22:35:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Rafael,

Building the latest bleeding edge (4881a46e969889ba1c20fed733e742bf19d0=
591e),
I get this error:

drivers/acpi/acpica/tbfadt.c: In function =91acpi_tb_convert_fadt=92:
drivers/acpi/acpica/tbfadt.c:493:12: error: too few arguments to functi=
on =91acpi_tb_init_generic_address=92
            fadt_info_table[i].name);
            ^
drivers/acpi/acpica/tbfadt.c:190:1: note: declared here
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_addr=
ess,
 ^
drivers/acpi/acpica/tbfadt.c:394:5: warning: unused variable =91flags=92=
 [-Wunused-variable]
  u8 flags;
     ^
drivers/acpi/acpica/tbfadt.c:393:5: warning: unused variable =91length=92=
 [-Wunused-variable]
  u8 length;
     ^
drivers/acpi/acpica/tbfadt.c: In function =91acpi_tb_validate_fadt=92:
drivers/acpi/acpica/tbfadt.c:572:3: error: =91flags=92 undeclared (firs=
t use in this function)
   flags =3D fadt_info_table[i].flags;
   ^
drivers/acpi/acpica/tbfadt.c:572:3: note: each undeclared identifier is=
 reported only once for each function it appears in
drivers/acpi/acpica/tbfadt.c:599:7: error: =91address32=92 undeclared (=
first use in this function)
   if (address32) {
       ^
make[3]: *** [drivers/acpi/acpica/tbfadt.o] Error 1
make[2]: *** [drivers/acpi/acpica] Error 2
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....



Thanks,
Stratos
