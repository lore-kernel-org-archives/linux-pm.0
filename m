From: Olaf Hering <olaf@aepfle.de>
Subject: Re: adjusting broken ACPI thermal trip points
Date: Sun, 4 Oct 2015 08:36:56 +0200
Message-ID: <20151004063656.GA4202@aepfle.de>
References: <20151001161622.GA21024@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:62168 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbbJDGhA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 4 Oct 2015 02:37:00 -0400
Received: from probook.fritz.box ([2001:a62:17:8701:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 37.12 AUTH)
	with ESMTPSA id V06995r946avDI2
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate)
	for <linux-pm@vger.kernel.org>;
	Sun, 4 Oct 2015 08:36:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151001161622.GA21024@aepfle.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

On Thu, Oct 01, Olaf Hering wrote:

> Initially I reported https://bugzilla.kernel.org/show_bug.cgi?id=67101

And related to this:

why would the first command enable the fan after boot only sometimes,
while the second one will succeed every time? Is this a kernel or
firmware bug?

# while :;do for i in 2 4 ; do echo 1 > /sys/class/thermal/cooling_device$i/cur_state ; cat /sys/class/thermal/cooling_device$i/cur_state > /dev/null ; done ; sleep 2 ; done

# while :;do for i in 2 4 ; do echo 1 > /sys/class/thermal/cooling_device$i/cur_state ; done ; sleep 2 ; done


Appearently cur_state must be read right after writing to it to have an
effect when selecting fan speeds for 0, 1 or 2.

Olaf
