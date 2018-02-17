From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH resend 0/1] thermal: int3400_thermal: Ignore charger
 events
Date: Sat, 17 Feb 2018 13:58:36 +0800
Message-ID: <1518847116.2739.0.camel@intel.com>
References: <20180214151340.1811-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:24633 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbeBQF6j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Feb 2018 00:58:39 -0500
In-Reply-To: <20180214151340.1811-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org

On Wed, 2018-02-14 at 16:13 +0100, Hans de Goede wrote:
> Hi All,
> 
> This patch seems to have fallen through the cracks, hence this
> resend.
> 
I think the problem can be covered by this commit, right?

commit 261ac1d2d9ef9a29c57f8aff341ae3dc323a707c
Author:     Brian Bian <brian.bian@linux.intel.com>
AuthorDate: Tue Nov 14 09:36:36 2017 -0800
Commit:     Zhang Rui <rui.zhang@intel.com>
CommitDate: Wed Dec 27 10:14:58 2017 +0800

    thermal: int3400_thermal: Ignore Unknown Notification Codes
    
    Some BIOS implementations route ACPI codes other than 0x83 to
INT3400
    device. Ignore these ACPI notification codes because the INT3400
driver
    does not handle them.
    
    Signed-off-by: Brian Bian <brian.bian@linux.intel.com>
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
