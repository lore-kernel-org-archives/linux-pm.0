From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] Two important suspend/hibernation patches updated
Date: Wed, 20 Feb 2008 01:33:43 +0100
Message-ID: <200802200133.44098.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.osdl.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Len,

New version of:
* hibernate: handle DEBUG_PAGEALLOC
  (commit af7e61cc86a6d052a7eddcd777a8a87906ab5a35 in the suspend branch)
* suspend: wakeup code in C
  (commit 280529bd8a01a6d7045658b322ba9a1cda793de2 in the test branch)
follow.

The first one doesn't contain the powerpc change included in the original
"hibernate: handle DEBUG_PAGEALLOC" patch, that turned out to be harmful.
I'd like it to go into 2.6.25, if possible.

The second one addresses the following problem reports related to the original
"suspend: wakeup code in C" patch:
* http://lkml.org/lkml/2008/2/16/178
* http://lkml.org/lkml/2008/2/16/74
* http://marc.info/?l=linux-acpi&m=120313725501682&w=4
* http://lkml.org/lkml/2008/2/19/263
It is considered as 2.6.26 material.

Please replace the previous versions of these patches with the new ones.

Thanks,
Rafael

