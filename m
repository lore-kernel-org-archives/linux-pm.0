From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI backlight regression fix for 3.18-rc8
Date: Fri, 5 Dec 2014 02:17:39 +0100
Message-ID: <CAJZ5v0ikkZ9LMFzMoj854nkN9Kno9FqoKffGYh8nJzoQ3GOyWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-3.18-rc8

to receive an ACPI backlight fix for v3.18-rc8 (or for final 3.18 if
there's no -rc8) as commit 35d0565b95547ec12d025dc9b1394f22968d113d

 ACPI / video: update condition to check if device is in _DOD list

on top of commit 009d0431c3914de64666bec0d350e54fdd59df6a

 Linux 3.18-rc7

This is a simple fix for an ACPI backlight regression introduced by
a recent commit that overlooked a corner case which should have been
taken into account.

Thanks!

---------------

Aaron Lu (1):
      ACPI / video: update condition to check if device is in _DOD list

---------------

 drivers/acpi/video.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
