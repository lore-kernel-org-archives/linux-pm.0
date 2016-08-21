From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 0/2] minor x86 PM source file cleanup
Date: Sat, 20 Aug 2016 18:15:10 -0600
Message-ID: <8bbb6de2-19fa-1ad8-9946-d2ef17091806@redhat.com>
References: <1471649042-19418-1-git-send-email-ahs3@redhat.com>
 <20160820105537.GA12556@amd>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160820105537.GA12556@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: x86@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, trivial@kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/20/2016 04:55 AM, Pavel Machek wrote:
> On Fri 2016-08-19 17:24:00, Al Stone wrote:
>> Really minor patches: one to cleanup whitespace, the second just makes
>> the code a wee bit more maintainable by correcting some variable names
>> without changing functionality.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> (for both)
> 
>> Al Stone (2):
>>   x86: ACPI: remove extraneous white space after semicolon
>>   x86: ACPI: make variable names clearer in
>>     acpi_parse_madt_lapic_entries()
>>
>>  arch/x86/kernel/acpi/boot.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
> 

Thanks, Pavel.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
