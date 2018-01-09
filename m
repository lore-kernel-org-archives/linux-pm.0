From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] Fix a race condition between SPI domain validation and system suspend
Date: Tue, 09 Jan 2018 01:27:46 +0100
Message-ID: <2498832.2KDevDSTHF@aspire.rjw.lan>
References: <20180105171909.11839-1-bart.vanassche@wdc.com> <20180105171909.11839-3-bart.vanassche@wdc.com> <yq1mv1opccy.fsf@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:41705 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbeAIA25 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jan 2018 19:28:57 -0500
In-Reply-To: <yq1mv1opccy.fsf@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Bart Van Assche <bart.vanassche@wdc.com>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, Woody Suwalski <terraluna977@gmail.com>, Alan Stern <stern@rowland.harvard.edu>

On Monday, January 8, 2018 5:02:53 PM CET Martin K. Petersen wrote:
> 
> Bart,
> 
> > Avoid that the following warning is reported when suspending a system
> > that is using the mptspi driver:
> 
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks!

Let me take both patches to the linux-pm tree then.

Thanks,
Rafael
