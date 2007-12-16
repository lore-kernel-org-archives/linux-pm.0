From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] Suspend: More cleanups
Date: Sun, 16 Dec 2007 23:46:09 +0100
Message-ID: <200712162346.10241.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches are targeted for 2.6.25.

The first one fixes a comment in x86-64 low-level suspend code.

The other one adds a config option allowing to drop the freezer from the
suspend (ie. STR / standby) code path.

Please add to the suspend branch.

Thanks,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

