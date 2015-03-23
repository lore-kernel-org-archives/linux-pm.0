From: =?utf-8?Q?Peter_M=C3=BCnster?= <pmlists@free.fr>
Subject: Re: prevent disk from spinning up at system resume
Date: Mon, 23 Mar 2015 15:07:17 +0100
Message-ID: <871tkfiz8q.fsf@free.fr>
References: <87iodsht89.fsf@free.fr>
	<Pine.LNX.4.44L0.1503230956210.1336-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40746 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbbCWOH3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Mar 2015 10:07:29 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1Ya30p-0003OV-7v
	for linux-pm@vger.kernel.org; Mon, 23 Mar 2015 15:07:27 +0100
Received: from arennes-651-1-273-185.w2-2.abo.wanadoo.fr ([2.2.240.185])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2015 15:07:27 +0100
Received: from pmlists by arennes-651-1-273-185.w2-2.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2015 15:07:27 +0100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

On Mon, Mar 23 2015, Alan Stern wrote:

>> - when doing "echo scsi remove-single-device 2 0 0 0 >/proc/scsi/scsi"
>>   before s2ram, sdb keeps sleeping after resume
>
> It looks like you already have your answer.

Sorry, I forgot to mention, that the disk needs to be mounted.
I just wanted to point out, that the kernel wakes up the disk, and not
the bios or something else.

-- 
           Peter

