From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI target state during S4 quiesce phase
Date: Wed, 12 Jul 2017 22:40:31 +0200
Message-ID: <CAJZ5v0g=c3FL3X-_SuYp-=pds+r7VtaQpZESSNzNht9i0o94kw@mail.gmail.com>
References: <20170712191009.pylvv4kpjmyi7lny@ideak-desk.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36746 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdGLUkc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 16:40:32 -0400
Received: by mail-it0-f49.google.com with SMTP id m68so21042747ith.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2017 13:40:32 -0700 (PDT)
In-Reply-To: <20170712191009.pylvv4kpjmyi7lny@ideak-desk.fi.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Imre Deak <imre.deak@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>

On Wed, Jul 12, 2017 at 9:10 PM, Imre Deak <imre.deak@intel.com> wrote:
> Hi,
>
> I noticed that acpi_target_system_state() returns ACPI_STATE_S0
> when called from a dev pm->freeze hook before restoring the hibernation
> image (PMSG_QUIESCE). Is this on purpose?

Yes, it is.

After all, the platform is not going to change the power state, is it?

> One could argue that it should
> be ACPI_STATE_S4, matching the target state before creating the
> hibernation image (PMSG_FREEZE).

And what would the argument be then?

Thanks,
Rafael
