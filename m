From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFT][PATCH 0/2] ACPI / PM: Avoid spurious wakeups from
 non-wakeup GPEs in suspend-to-idle
Date: Mon, 17 Dec 2018 18:50:25 +0200
Message-ID: <20181217165025.GA2469@lahna.fi.intel.com>
References: <4307523.O7RPX2KSmk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4307523.O7RPX2KSmk@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 17, 2018 at 12:19:27PM +0100, Rafael J. Wysocki wrote:
> Hi All,

Hi Rafael,

> It turns out that on some systems non-wakeup GPEs cause trouble (see the
> changelog of patch [1/2]), so they better should be disabled during
> suspend-to-idle (at least before entering the main loop of it).  This
> is done in patch [1/2].
> 
> Patch [2/2] is just a folllow-up.

I tested both patches on Lenovo Carbon X1 6th generation and one new
Dell system. Both default to s2idle. I did not see any issues around
s2idle with the two patches applied.

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
