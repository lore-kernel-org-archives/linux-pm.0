From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] intel_pstate: More fixes related to limits
Date: Tue, 14 Mar 2017 16:14:54 +0100
Message-ID: <2130954.RIJyMN1BRu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Three limits-related fixes more.

[1/3] fixes a regression introduced by another recent fix.

[2/3] gets rid of excessive rounding errors in computations.

[3/3] makes limits work in the most straightforward way possible.

On top of https://patchwork.kernel.org/patch/9622401/ .

Thanks,
Rafael
