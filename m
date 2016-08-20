From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2] minor x86 PM source file cleanup
Date: Sat, 20 Aug 2016 12:55:37 +0200
Message-ID: <20160820105537.GA12556@amd>
References: <1471649042-19418-1-git-send-email-ahs3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53298 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753656AbcHTKzm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Aug 2016 06:55:42 -0400
Content-Disposition: inline
In-Reply-To: <1471649042-19418-1-git-send-email-ahs3@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: x86@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, trivial@kernel.org

On Fri 2016-08-19 17:24:00, Al Stone wrote:
> Really minor patches: one to cleanup whitespace, the second just makes
> the code a wee bit more maintainable by correcting some variable names
> without changing functionality.

Acked-by: Pavel Machek <pavel@ucw.cz>

(for both)

> Al Stone (2):
>   x86: ACPI: remove extraneous white space after semicolon
>   x86: ACPI: make variable names clearer in
>     acpi_parse_madt_lapic_entries()
> 
>  arch/x86/kernel/acpi/boot.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
