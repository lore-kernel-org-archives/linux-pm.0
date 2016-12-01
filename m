From: David Howells <dhowells@redhat.com>
Subject: [PATCH 07/39] Annotate hardware config module parameters in
 drivers/cpufreq/
Date: Thu, 01 Dec 2016 12:30:32 +0000
Message-ID: <148059543222.31612.3648801189087582676.stgit@warthog.procyon.org.uk>
References: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
Sender: owner-linux-security-module@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gnomes@lxorguk.ukuu.org.uk, minyard@acm.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When the kernel is running in secure boot mode, we lock down the kernel to
prevent userspace from modifying the running kernel image.  Whilst this
includes prohibiting access to things like /dev/mem, it must also prevent
access by means of configuring driver modules in such a way as to cause a
device to access or modify the kernel image.

To this end, annotate module_param* statements that refer to hardware
configuration and indicate for future reference what type of parameter they
specify.  The parameter parser in the core sees this information and can
skip such parameters with an error message if the kernel is locked down.
The module initialisation then runs as normal, but just sees whatever the
default values for those parameters is.

Note that we do still need to do the module initialisation because some
drivers have viable defaults set in case parameters aren't specified and
some drivers support automatic configuration (e.g. PNP or PCI) in addition
to manually coded parameters.

This patch annotates drivers in drivers/cpufreq/.

Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc: Viresh Kumar <viresh.kumar@linaro.org>
cc: linux-pm@vger.kernel.org
---

 drivers/cpufreq/speedstep-smi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/speedstep-smi.c b/drivers/cpufreq/speedstep-smi.c
index 770a9ae1999a..37b30071c220 100644
--- a/drivers/cpufreq/speedstep-smi.c
+++ b/drivers/cpufreq/speedstep-smi.c
@@ -378,7 +378,7 @@ static void __exit speedstep_exit(void)
 	cpufreq_unregister_driver(&speedstep_driver);
 }
 
-module_param(smi_port, int, 0444);
+module_param_hw(smi_port, int, ioport, 0444);
 module_param(smi_cmd,  int, 0444);
 module_param(smi_sig, uint, 0444);
 

