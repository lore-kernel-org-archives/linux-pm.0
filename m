From: =?utf-8?Q?Peter_M=C3=BCnster?= <pmlists@free.fr>
Subject: Re: prevent disk from spinning up at system resume
Date: Mon, 23 Mar 2015 15:36:20 +0100
Message-ID: <877fu7hjbv.fsf@roche-blanche.net>
References: <871tkfiz8q.fsf@free.fr>
	<Pine.LNX.4.44L0.1503231015390.1336-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43375 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbbCWOgq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Mar 2015 10:36:46 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1Ya3T2-0005eT-Fu
	for linux-pm@vger.kernel.org; Mon, 23 Mar 2015 15:36:36 +0100
Received: from arennes-651-1-273-185.w2-2.abo.wanadoo.fr ([2.2.240.185])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2015 15:36:36 +0100
Received: from pmlists by arennes-651-1-273-185.w2-2.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2015 15:36:36 +0100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

On Mon, Mar 23 2015, Alan Stern wrote:

> Why does the disk need to be mounted if you aren't using it more than 
> once a week or so?  Why not mount it only while it is in use?

The workflow would be quite different:
normal workflow:
- application needs file on sdb
- sdb spins up
- application can open the file

workflow with unmounted sdb:
- application needs file on sdb
- error message: no such file (or similar)
- user sees error message: "oh dear, the file is on sdb..."
- superuser needs to "add-single-device" and mount it
- user can continue with application


> The kernel wakes up _every_ device during system resume, even ones that
> were in runtime suspend when the system suspend started.  With only a
> few exceptions, there is no way around this in the current kernel.

Even after  "echo 0 >/sys/block/sdb/device/scsi_disk/2:0:0:0/manage_start_stop" ?

If there wasn't the "Synchronizing SCSI cache" at system resume, would
the disk spin up nevertheless?

-- 
           Peter

