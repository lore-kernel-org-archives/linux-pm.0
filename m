From: Jiri Slaby <jslaby@suse.cz>
Subject: -next: no resume from suspend
Date: Mon, 14 Jan 2013 11:11:52 +0100
Message-ID: <50F3D9E8.6040802@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:57199 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322Ab3ANKL4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jan 2013 05:11:56 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM mailing list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi,

since friday's -next (the last known to be working is the last monday's)
I cannot resume from suspend. The last thing I see with
no_console_suspend is:
i915: No ACPI video bus found

But I used to see the message always, so this is no difference. Any idea
before I start bisecting?

It is x86_64, core 2 duo, intel g33 GPU, 6G RAM.

thanks,
-- 
js
suse labs
