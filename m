From: Len Brown <lenb@kernel.org>
Subject: cpuidle: remove CPUIDLE_FLAG_TIME_INVALID
Date: Tue, 16 Dec 2014 01:52:05 -0500
Message-ID: <1418712728-2193-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Daniel Lezcano suggested removing CPUIDLE_FLAG_TIME_INVALID because
no states enable interrupts, and so cpuidle can always measure valid
residency time.  That turns out not to be un-true since x86 HALT is
invoked with interrupts enabled.  But looking at the code more closely,
Daniel's suggestion of simply removing the CPUIDLE_FLAG_TIME_INVALID
is actually an improvement over the workaround that we are currently using.

