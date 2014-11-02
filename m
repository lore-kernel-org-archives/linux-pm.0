From: Ferenc Wagner <wferi@niif.hu>
Subject: running wpa_supplicant during saving hibernation image
Date: Sun, 02 Nov 2014 16:18:21 +0100
Message-ID: <8761ex1via.fsf@lant.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from listserv2.niif.hu ([193.225.14.155]:49551 "EHLO
	listserv2.niif.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbaKBPtw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Nov 2014 10:49:52 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: wferi@niif.hu

Hi,

I'm running an iSCSI rooted system over WPA authenticated wireless
network.  I'd like to enable hibernation on it (restore from S3 seems
unreliable on this Acer Aspire 2920 notebook).  The problem is that to
have network access for saving the hibernation image, wpa_supplicant
must be running, but as a user space process, it's frozen before
creating the hibernation snapshot.  Is there a way to thaw it after
taking the snapshot, or to skip freezing it?  I found no interface for
setting the corresponding task flag, but I may have missed something.
It's running from rootfs, so I guess either would be safe.  -- Well,
currently it's logging into a tmpfs file, is that permissible (being
swappable)?
-- 
Thanks for your time,
Feri.
