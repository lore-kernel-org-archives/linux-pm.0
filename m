From: Ilari Stenroth <ilari.stenroth@gmail.com>
Subject: Intel_powerclamp on Xeon E3v3 Haswell?
Date: Sat, 17 Aug 2013 18:58:00 +0300
Message-ID: <520F9D88.2050500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42342 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753625Ab3HQQAF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 17 Aug 2013 12:00:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1VAiv5-0004Kj-KW
	for linux-pm@vger.kernel.org; Sat, 17 Aug 2013 18:00:03 +0200
Received: from gw.stenroth.fi ([188.127.202.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Sat, 17 Aug 2013 18:00:03 +0200
Received: from ilari.stenroth by gw.stenroth.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Sat, 17 Aug 2013 18:00:03 +0200
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Hi,

Does somebody know why intel_powerclamp driver doesn't work on
a Xeon E3v3 CPU? Tried it on E3-1265L v3 but the driver gave out errors:
[  632.399837] intel_powerclamp: Start idle injection to reduce power
[  632.400068] intel_powerclamp: pkg cstate counter not functional, abort

cat /sys/kernel/debug/intel_powerclamp/powerclamp_calib 
controlling cpu: 0
pct confidence steady dynamic (compensation)
0	0	0	0
1	0	0	0
2	0	0	0
3	0	0	0
4	0	0	0
5	0	0	0
6	0	0	0
7	0	0	0
8	0	0	0
9	0	0	0
10	0	0	0
11	0	0	0
12	0	0	0
13	0	0	0
14	0	0	0
15	0	0	0
16	0	0	0
17	0	0	0
18	0	0	0
19	0	0	0
20	0	0	0
21	0	0	0
22	0	0	0
23	0	0	0
24	0	0	0
25	0	0	0
26	0	0	0
27	0	0	0
28	0	0	0
29	0	0	0
30	0	0	0
31	0	0	0
32	0	0	0
33	0	0	0
34	0	0	0
35	0	0	0
36	0	0	0
37	0	0	0
38	0	0	0
39	0	0	0
40	0	0	0
41	0	0	0
42	0	0	0
43	0	0	0
44	0	0	0
45	0	0	0
46	0	0	0
47	0	0	0
48	0	0	0
49	0	0	0

I've applied a simple patch to make intel_powerclamp detect a CPU
family 0x06 model 0x3c:

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index b40b37c..bac481f 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -675,6 +675,7 @@ static const struct x86_cpu_id intel_powerclamp_ids[] = {
        { X86_VENDOR_INTEL, 6, 0x2e},
        { X86_VENDOR_INTEL, 6, 0x2f},
        { X86_VENDOR_INTEL, 6, 0x3a},
+       { X86_VENDOR_INTEL, 6, 0x3c},
        {}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);


--
Ilari Stenroth

