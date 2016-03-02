From: Tamas Papp <tkpapp@gmail.com>
Subject: STI problem and workaround for Dell XPS 13 (Skylake, 2016) / Broadcom BCM4350
Date: Wed, 02 Mar 2016 10:51:05 +0100
Message-ID: <87h9gpp5rt.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38828 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbcCBJvJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 04:51:09 -0500
Received: by mail-wm0-f45.google.com with SMTP id l68so69729520wml.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 01:51:08 -0800 (PST)
Received: from tamas ([78.104.73.25])
        by smtp.gmail.com with ESMTPSA id y3sm3287816wmy.17.2016.03.02.01.51.06
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2016 01:51:07 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

I have a Dell XPS 13 (Skylake, 2016) and wanted to get STI working, so I
followed the instructions at [1]. I found that the Broadcom wireless
chip is waking the machine up from STI / freeze.

A workaround is

INTERFACE=wlp58s0
ifconfig $INTERFACE down
modprobe -r brcmfmac && echo freeze > /sys/power/state && modprobe brcmfmac
ifconfig $INTERFACE up

I thought I would ask whether I should report this as a bug, and if yes,
where.

Best,

Tamas

[1] https://01.org/blogs/rzhang/2015/best-practice-debug-linux-suspend/hibernate-issues

Hardware info (lspci -v):

3a:00.0 Network controller: Broadcom Corporation BCM4350 802.11ac Wireless Network Adapter (rev 08)
	Subsystem: Dell BCM4350 802.11ac Wireless Network Adapter
	Flags: bus master, fast devsel, latency 0, IRQ 283
	Memory at dc400000 (64-bit, non-prefetchable) [size=32K]
	Memory at dc000000 (64-bit, non-prefetchable) [size=4M]
	Capabilities: [48] Power Management version 3
	Capabilities: [58] MSI: Enable+ Count=1/16 Maskable- 64bit+
	Capabilities: [68] Vendor Specific Information: Len=44 <?>
	Capabilities: [ac] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [13c] Device Serial Number 00-00-28-ff-ff-77-c8-ff
	Capabilities: [150] Power Budgeting <?>
	Capabilities: [160] Virtual Channel
	Capabilities: [1b0] Latency Tolerance Reporting
	Capabilities: [220] #15
	Capabilities: [240] L1 PM Substates
	Kernel driver in use: brcmfmac
	Kernel modules: brcmfmac
