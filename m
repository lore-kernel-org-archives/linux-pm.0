From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 07/12] tools/power turbostat: modprobe msr, if needed
Date: Sun, 19 Apr 2015 07:29:28 -0700
Message-ID: <000401d07aad$3e9d4710$bbd7d530$@net>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org> <a21d38c846fce05ef55ab240f18fb19755bed16a.1429402554.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta2.telus.net ([209.171.16.75]:55356 "EHLO cmta2.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747AbbDSO3b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 19 Apr 2015 10:29:31 -0400
In-Reply-To: <a21d38c846fce05ef55ab240f18fb19755bed16a.1429402554.git.len.brown@intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Len Brown' <lenb@kernel.org>
Cc: 'Len Brown' <len.brown@intel.com>, linux-pm@vger.kernel.org

On 2015.04.18 17:50 Len Brown wrote:

> Some distros (Ubuntu) ship the msr driver as a module.
> If turbosat is run as root on those systems, and discovers
> that there is no /dev/cpu/cpu0/msr, it will now "modprobe msr"
> for the user.

This is a great addition. Thanks so much.
Why? Because, myself, I always forget to do "modprobe msr" first.


