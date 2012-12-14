From: tim <tim@klingt.org>
Subject: "Unknown header type 7f" after wakeup
Date: Fri, 14 Dec 2012 21:01:47 +0100
Message-ID: <kag0j9$8a5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35402 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271Ab2LNUEz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Dec 2012 15:04:55 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1TjbVI-0004UV-EY
	for linux-pm@vger.kernel.org; Fri, 14 Dec 2012 21:05:04 +0100
Received: from 91-119-62-127.dynamic.xdsl-line.inode.at ([91.119.62.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Fri, 14 Dec 2012 21:05:04 +0100
Received: from tim by 91-119-62-127.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Fri, 14 Dec 2012 21:05:04 +0100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

hi all,

i'm having some troubles with my RME hdsp audio interface after waking
up my machine:

lspci tells me:
04:01.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
DSP (rev ff) (prog-if ff)
        !!! Unknown header type 7f
        Kernel modules: snd-hdsp

all other devices work fine ... rmmod/modprobe of the specific module
doesn't help, either ... iac, it somehow seems that the PCI device state
is not properly restored, maybe because the fpga on the device is too
slow ... how can i help in fixing this issue?

tia,
tim

