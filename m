From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v5 5/5] intel_idle: Add S0ix validation
Date: Tue, 11 Jul 2017 11:43:51 -0400
Message-ID: <CAJvTdKmV9KitivMQXGb4GiDTJVuUxHHsym+uQULKNw1w63fUAQ@mail.gmail.com>
References: <20170708000303.21863-1-dbasehore@chromium.org>
 <4255011.FH94tfVCB1@aspire.rjw.lan> <CAGAzgsq-4VZRGgeS7XSzP+QHMpUx9jRGa-ANk3=UxD9BxwKuRg@mail.gmail.com>
 <2519579.h5lvWVZraV@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33412 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933384AbdGKPnw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 11:43:52 -0400
In-Reply-To: <2519579.h5lvWVZraV@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "dbasehore ." <dbasehore@chromium.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, X86 ML <x86@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

I acknowledge the specific need for this check to assure a great
user-experience on specific hardware.

I also concur the motivation to make mechanisms general and generic so
they can be re-used.

However, it isn't clear to me that this check would be used outside of
some very specific scenarios,
and so we may be trying too hard to make it general, and the code
would be simpler
if we focus on that.  We can always make it more general when we have
more use-cases...

-- 
Len Brown, Intel Open Source Technology Center
