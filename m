From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: Possible regression caused by commit 1bd047be37d9 ("tpm_crb: Use
 devm_ioremap_resource")
Date: Wed, 3 Aug 2016 12:37:25 -0600
Message-ID: <20160803183725.GA4308@obsidianresearch.com>
References: <1469933246.2361.7.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:52315 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319AbcHCSiA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Aug 2016 14:38:00 -0400
Content-Disposition: inline
In-Reply-To: <1469933246.2361.7.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Sun, Jul 31, 2016 at 10:47:26AM +0800, Zhang Rui wrote:
> Hi, Jason,
> 
> we got a bug report complaining that the system can not enter deeper
> package c-states than pc2, and the git bisect result points to commit
> 1bd047be37d9 ("tpm_crb: Use devm_ioremap_resource").
> 
> can you take a look at this issue?
> 
> Bugzilla link: https://bugzilla.kernel.org/show_bug.cgi?id=118451

The tagged commit basically swiches devm_ioremap_nocache for
devm_ioremap_resource - AFAIK the only external difference being that the
TPM driver is now part of the resource tree.

I didn't think resource tree interacted with Intel PM at all?

One thing we know about is that the TPM driver fails to load on some
systems due to resource conflicts. Is it possible Yrjan's is seeing
TPM load failures in one kernel? Presumably not loading the tpm driver
would impact PM somehow??

I recommend checking for the issue solved in this patch:

commit 422eac3f7deae34dbaffd08e03e27f37a5394a56
Author: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Tue Apr 19 12:54:18 2016 +0300

    tpm_crb: fix mapping of the buffers
    
    On my Lenovo x250 the following situation occurs:
    
    [18697.813871] tpm_crb MSFT0101:00: can't request region for resource
    [mem 0xacdff080-0xacdfffff]

Jason
