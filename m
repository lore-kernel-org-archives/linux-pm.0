From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH][RFC,v4] ACPI / PM: Introduce efi poweroff for HW-full
 platforms without _S5
Date: Mon, 14 Mar 2016 20:00:33 +0000
Message-ID: <20160314200033.GG2619@codeblueprint.co.uk>
References: <1457687133-3730-1-git-send-email-yu.c.chen@intel.com>
 <20160311155546.GJ15775@codeblueprint.co.uk>
 <36DF59CE26D8EE47B0655C516E9CE640286D442A@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38749 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932814AbcCNUAh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 16:00:37 -0400
Received: by mail-wm0-f48.google.com with SMTP id l68so117708145wml.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Mar 2016 13:00:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE640286D442A@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mark Salter <msalter@redhat.com>

On Fri, 11 Mar, at 04:33:46PM, Chen, Yu C wrote:
>
> There is  a future Base-IA platform, we are planning to skip
> implementing the SLP_TYP register and the S5 object.  (already there
> will be no S3 and no S4)
 
Cool. This is really valuable information that should go into the
commit message.

Because if this is the rationale for the change, I don't see why we'd
need to provide the default stuff. Instead we should just enforce EFI
reboot, and only add the pm_poweroff_default hook if there is an
explicit user in the future, IMO.
