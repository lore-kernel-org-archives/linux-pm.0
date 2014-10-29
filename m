From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: v3.18-rc2 compilation under a x86 KVM failed in drivers/thermal/thermal_core.c:
Date: Wed, 29 Oct 2014 17:29:40 +0100
Message-ID: <545115F4.4010404@gmx.de>
References: <544E6F5C.7040900@gmx.de> <9hh1tpsz1x0.fsf@arm.com>	<544FD915.40200@gmx.de> <9hhh9ynxjay.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:54157 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933459AbaJ2Q3o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 Oct 2014 12:29:44 -0400
In-Reply-To: <9hhh9ynxjay.fsf@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: "linux-pm@vger.kernel.org >> Linux PM list" <linux-pm@vger.kernel.org>

On 10/29/2014 11:27 AM, Punit Agrawal wrote:
> Perhaps you had stale artifacts from previous builds causing failure to
> link? Can you try building from a clean source tree? 
ick, even mrproper wasn't enough, so I removed and recreated /usr/src/linux - now it compiles - thx for your hint.


-- 
Toralf
pgp key: 0076 E94E

