From: Len Brown <lenb@kernel.org>
Subject: ACPI & Power Management Patches for Linux 3.3-rc1
Date: Mon, 23 Jan 2012 20:29:59 -0500
Message-ID: <1327368609-28409-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This fixes a merge-window regression due to a conflict
between error injection and preparation to remove atomicio.c
Here we fix that regression and complete the removal
of atomicio.c.

This also re-orders some idle initializtion code to
complete the merge window series that allows cpuidle
to cope with bringing processors on-line after boot.

Please let me know if you see issues with any of these patches.

thanks,
Len Brown, Intel Open Source Technolgy Center

