From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: state[i].transition_latency and state[i].bus_master_latency set to 0. BUG?
Date: Tue, 5 Aug 2014 17:37:57 +0200
Message-ID: <CAPybu_0wdTRYHwPN6mHdBrx8_RjcEXBWRpBs4HU5LASR16cOQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, "alex@qtec.com" <alex@qtec.com>
List-Id: linux-pm@vger.kernel.org

Hello!

I am working with an AMD family 14h Processor. And I believe that the
governor is not behaving as expected.

On the _PSS table, the transition_latency and bus_master_latency are set to 0.

The AMDs BIOS development guide (page 60 and 61)
http://developer.amd.com/wordpress/media/2012/10/43170_14h_Mod_00h-0Fh_BKDG.pdf
they recommend to use value of 0.

Is 0 valid value? The governor will work properly with this value?

What could be a good default value?

Is there a way to experimentally measure the latency?

Thanks for your help!

Extract from dmesg:
[    0.843340] Extracting state 0
[    0.843374] State [0]: core_frequency[1650] power[6075]
transition_latency[0] bus_master_latency[0] control[0x0] status[0x0]
[    0.843481] Extracting state 1
[    0.843513] State [1]: core_frequency[1320] power[3712]
transition_latency[0] bus_master_latency[0] control[0x1] status[0x1]
[    0.843618] Extracting state 2
[    0.843652] State [2]: core_frequency[825] power[1472]
transition_latency[0] bus_master_latency[0] control[0x2] status[0x2]
[    0.843757] Extracting state 3
[    0.843790] State [3]: core_frequency[528] power[1008]
transition_latency[0] bus_master_latency[0] control[0x3] status[0x3]


-- 
Ricardo Ribalda
