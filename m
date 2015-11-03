From: riel@redhat.com
Subject: [PATCH 0/3] cpuidle: small improvements & fixes for menu governor (resend)
Date: Tue,  3 Nov 2015 17:34:16 -0500
Message-ID: <1446590059-18897-1-git-send-email-riel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, arjan@linux.intel.com, len.brown@intel.com, daniel.lezcano@linaro.org
List-Id: linux-pm@vger.kernel.org

While working on a paravirt cpuidle driver for KVM guests, I
noticed a number of small logic errors in the menu governor
code.

These patches should get rid of some artifacts that can break
the logic in the menu governor under certain corner cases, and
make idle state selection work better on CPUs with long C1 exit
latencies.

I have not seen any adverse effects with them in my (quick)
tests. As expected, they do not seem to do much on systems with
many power states and very low C1 exit latencies and target residencies. 
