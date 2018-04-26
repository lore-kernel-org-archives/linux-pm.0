From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 0/3] PM / core: Clean up suspend/resume diagnostic messages
Date: Thu, 26 Apr 2018 16:36:20 -0500
Message-ID: <152477804633.202432.12678470890830085798.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

These are pretty minor cleanups to the suspend/resume diagnostic messages.

The first two are trivial.  The third may break scripts that parse dmesg
output.  I looked at scripts/bootgraph.pl, and I don't think it is
affected, but there may be others I don't know about.  Let me know if there
are.

---

Bjorn Helgaas (3):
      PM / core: Remove unused initcall_debug_report() arguments
      PM / core: Simplify initcall_debug_report() timing
      PM / core: Use dev_printk() and symbols in suspend/resume diagnostics


 drivers/base/power/main.c |   37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)
