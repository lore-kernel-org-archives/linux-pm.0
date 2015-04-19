From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 01/12] tools/power turbostat: simplify default output
Date: Sun, 19 Apr 2015 07:26:24 -0700
Message-ID: <000301d07aac$d1856bd0$74904370$@net>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org> <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta5.telus.net ([209.171.16.78]:42544 "EHLO cmta5.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbbDSO02 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 19 Apr 2015 10:26:28 -0400
In-Reply-To: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Len Brown' <lenb@kernel.org>
Cc: 'Len Brown' <len.brown@intel.com>, linux-pm@vger.kernel.org

On 2015.04.18 17:40 Len Brown wrote:

> Casual turbostat users generally just want to know MHz.
> So by default, just print enough information to make sense of MHz.
> 
> All the other configuration data and columns for C-states and temperature etc,
> are printed with the --debug option.

I almost never use turbostat to obtain MHz.
I only use turbostat to observe Energy or Power, and C-states.

I am not in favor of this change.

I do not want the extra clutter that comes with the --debug option
(although I do use it sometimes).
When doing experiments manually, without a script, it is convenient
to have many energy or power samples visible on the screen all at once.

Note: If I am using the acpi cpufreq driver (i.e. rarely), then yes
I use turbostat to obtain actual CPU frequencies, as I know of no
other way.

I reviewed some help type forums, and yes while many postings involving
turbostat are about CPU frequency, there are also some about power.


