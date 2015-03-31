From: Brian Norris <computersforpeace@gmail.com>
Subject: thermal: uevent/netlink with step_wise?
Date: Tue, 31 Mar 2015 15:43:48 -0700
Message-ID: <20150331224348.GZ32500@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33790 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbbCaWnz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2015 18:43:55 -0400
Received: by pdrw1 with SMTP id w1so26276462pdr.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2015 15:43:55 -0700 (PDT)
Received: from ld-irv-0074 (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id li10sm13837090pbc.33.2015.03.31.15.43.54
        for <linux-pm@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 31 Mar 2015 15:43:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

I'm a bit new to the thermal subsystem, but I'm trying to figure out how
best to use it. It seems quite flexible, but this flexibility means it's
not obvious what the best approach to using it should be.

Particularly, I'm looking right now at using the uevent/netlink
notification mechanism. It seems that this is only active when we use
the 'user_space' governor, meaning I can't get any user-space
notifications when using the in-kernel governor. Am I missing something,
or is this a known limitation? Is there any reason we can't enable both?
For the user-space side, I'd mostly be interested in being a consumer;
e.g., display warnings in high-temperature scenarios; although I might
also use it to trigger some user-space cooling mechanisms.

Also, can anyone point me at the best up-to-date documenation,
especially any overall design documents? Should I just be looking at
Documentation/thermal/, Documentation/devicetree/bindings/thermal/, and
example drivers?

Thanks in advance.

Brian
