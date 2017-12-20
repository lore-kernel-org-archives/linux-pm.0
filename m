From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.15-rc5
Date: Wed, 20 Dec 2017 20:07:49 +0100
Message-ID: <CAJZ5v0h7BZgVFSaVBWcNrNBy76gh+ubZvf1_7sVvu9kt=S__1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.15-rc5

with top-most commit 9245fe9fccdbda5d81d97155e5c5de7e16510cee

 Merge branch 'acpi-cppc'

on top of commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b

 Linux 4.15-rc4

to receive ACPI fixes for 4.15-rc5.

These fix a recently introduced issue in the ACPI CPPC driver and
an obscure error hanling bug in the APEI code.

Specifics:

 - Fix an error handling issue in the ACPI APEI implementation
   of the >read callback in struct pstore_info (Takashi Iwai).

 - Fix a possible out-of-bounds arrar read in the ACPI CPPC
   driver (Colin Ian King).

Thanks!


---------------

Colin Ian King (1):
      ACPI: CPPC: remove initial assignment of pcc_ss_data

Takashi Iwai (1):
      ACPI: APEI / ERST: Fix missing error handling in erst_reader()

---------------

 drivers/acpi/apei/erst.c | 2 +-
 drivers/acpi/cppc_acpi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
