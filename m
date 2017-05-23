From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
 systems
Date: Tue, 23 May 2017 09:59:11 +0200
Message-ID: <20170523075911.GA25383@nazgul.tnic>
References: <1495030819-4347-1-git-send-email-Yazen.Ghannam@amd.com>
 <20170522162143.GA19781@nazgul.tnic>
 <BN6PR1201MB01312A2AB93708B9115D4865F8F80@BN6PR1201MB0131.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:60516 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762002AbdEWH7P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 May 2017 03:59:15 -0400
Content-Disposition: inline
In-Reply-To: <BN6PR1201MB01312A2AB93708B9115D4865F8F80@BN6PR1201MB0131.namprd12.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>

On Mon, May 22, 2017 at 08:20:56PM +0000, Ghannam, Yazen wrote:
> On the other hand, MWAIT on AMD limits the hardware to using only certain,
> shallower Cstates. This is okay if we define individual states and use MWAIT
> for some of them. But it would consume more power if used always.

Let me see if I understand it correctly:

Even though we used to do HLT on previous families as idling with HLT
*is* the preferred method until now, with your change you're moving
*every* AMD machine out there to do MWAIT now.

Lemme look at the F15h BKDG:

"2.5.3.2

C-state Request Interface

C-states are dynamically requested by software and are exposed through
ACPI objects (see 2.5.3.6 [ACPI Processor C-state Objects]). C-states
can be requested on a per-core basis. Software requests a C-state change
in one of two ways, either by executing the HLT instruction or by
reading from an IO address specified by MSRC001_0073[CstateAddr] plus an
offset of 0 through 7 (see D18F4x11[C:8])."

So this doesn't say anything about using MWAIT.

What's up?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
