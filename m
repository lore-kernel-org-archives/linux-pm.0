From: Ethan Zhao <ethan.zhao@oracle.com>
Subject: [PATCH 0/2 v2] intel_pstate: skip this driver if hit Sun X86 servers
Date: Mon, 24 Nov 2014 16:50:56 +0900
Message-ID: <1416815458-25312-1-git-send-email-ethan.zhao@oracle.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linda.knippers@hp.com, viresh.kumar@linaro.org, rjw@rjwysocki.net, corbet@lwn.net, dirk.j.brandewie@intel.com
Cc: linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ethan.kernel@gmail.com, Ethan Zhao <ethan.zhao@oracle.com>
List-Id: linux-pm@vger.kernel.org

Oracle Sun servers(X86) have power capping features that work via ACPI _PPC method,
patch No.1 is used to skip this driver if Oracle Sun server and _PPC detected. 
Patch No.2 introduces a kernel command line  parameter for those who would like
to enable intel_pstate on Sun X86 servers and be aware of the risk.


Compiled and tested with stable-3.18-rc5 on Oracle Sun server X4-2.
--
Ethan Zhao (2):
  intel_pstate: skip this driver if Sun server has _PPC method
  intel_pstate: add kernel parameter to enable loading on Sun X86
    servers.

 Documentation/kernel-parameters.txt |  3 +++
 drivers/cpufreq/intel_pstate.c      | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
1.8.3.1

