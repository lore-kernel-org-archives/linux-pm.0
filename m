From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
 systems
Date: Tue, 23 May 2017 15:06:16 +0200
Message-ID: <20170523130616.GC25383@nazgul.tnic>
References: <1495030819-4347-1-git-send-email-Yazen.Ghannam@amd.com>
 <20170522162143.GA19781@nazgul.tnic>
 <BN6PR1201MB01312A2AB93708B9115D4865F8F80@BN6PR1201MB0131.namprd12.prod.outlook.com>
 <20170523075911.GA25383@nazgul.tnic>
 <BN6PR1201MB0131B6E13B6E782494751054F8F90@BN6PR1201MB0131.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:43666 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbdEWNGU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 May 2017 09:06:20 -0400
Content-Disposition: inline
In-Reply-To: <BN6PR1201MB0131B6E13B6E782494751054F8F90@BN6PR1201MB0131.namprd12.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>

On Tue, May 23, 2017 at 12:50:15PM +0000, Ghannam, Yazen wrote:
> No, AMD systems will continue to use HLT unless the BIOS specifies the
> use of MWAIT using a FFH entry in the ACPI _CST.
> 
> All this change does is *allow* us to use MWAIT through the FFH
> implementation if the BIOS defines it. It doesn't *force* a change.

So that could very well be part of the commit message as it explains
what exactly you're changing.

> If the BIOS doesn't define the appropriate _CST entry or it defines it
> wrong, then we'll fallback to using HLT.

I'm assuming you've tested it on older families to make sure they still
work as expected? I wouldn't trust the BIOS...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
