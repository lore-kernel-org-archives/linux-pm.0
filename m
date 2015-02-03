From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] ACPI / cpuidle: More code complexity/duplication reduction
Date: Tue, 03 Feb 2015 22:14:20 +0100
Message-ID: <2355370.OryAt3A2Tj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Two more ACPI cpuidle patches on top of the ones I sent a few days ago:

https://lkml.org/lkml/2015/1/29/779

They don't break anything for me and preserve the original logic AFAICS,
but please holler if you see any problems with them.

Thanks!
