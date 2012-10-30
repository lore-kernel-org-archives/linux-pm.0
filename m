From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v8 05/11] libata-eh: allow defer in ata_exec_internal
Date: Mon, 29 Oct 2012 20:01:44 -0700
Message-ID: <20121030030144.GG4066@htj.dyndns.org>
References: <1351501298-3716-1-git-send-email-aaron.lu@intel.com>
 <1351501298-3716-6-git-send-email-aaron.lu@intel.com>
 <20121029152051.GK5171@htj.dyndns.org>
 <508F42C0.8070807@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45491 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab2J3DB5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Oct 2012 23:01:57 -0400
Content-Disposition: inline
In-Reply-To: <508F42C0.8070807@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, James Bottomley <James.Bottomley@hansenpartnership.com>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>, Jeff Wu <jeff.wu@amd.com>, Aaron Lu <aaron.lwe@gmail.com>, Shane Huang <shane.huang@amd.com>, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org

Hello,

On Tue, Oct 30, 2012 at 11:00:16AM +0800, Aaron Lu wrote:
> > Why not do the discovery from EH?
> 
> Do you mean set a device level EH flag and then schedule EH to do the
> discovery?

Yeah, something like that or why can't it be done while probing the
device in the first place?

Thanks.

-- 
tejun
