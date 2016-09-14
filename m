From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] minor x86 PM source file cleanup
Date: Wed, 14 Sep 2016 03:04:38 +0200
Message-ID: <3231912.dxysaRV8Do@vostro.rjw.lan>
References: <1471649042-19418-1-git-send-email-ahs3@redhat.com> <20160820105537.GA12556@amd> <8bbb6de2-19fa-1ad8-9946-d2ef17091806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64760 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1753442AbcINA6b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 20:58:31 -0400
In-Reply-To: <8bbb6de2-19fa-1ad8-9946-d2ef17091806@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ahs3@redhat.com
Cc: Pavel Machek <pavel@ucw.cz>, x86@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, trivial@kernel.org

On Saturday, August 20, 2016 06:15:10 PM Al Stone wrote:
> On 08/20/2016 04:55 AM, Pavel Machek wrote:
> > On Fri 2016-08-19 17:24:00, Al Stone wrote:
> >> Really minor patches: one to cleanup whitespace, the second just makes
> >> the code a wee bit more maintainable by correcting some variable names
> >> without changing functionality.
> > 
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > (for both)
> > 
> >> Al Stone (2):
> >>   x86: ACPI: remove extraneous white space after semicolon
> >>   x86: ACPI: make variable names clearer in
> >>     acpi_parse_madt_lapic_entries()
> >>
> >>  arch/x86/kernel/acpi/boot.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> > 
> 
> Thanks, Pavel.

Both applied.

Thanks,
Rafael

