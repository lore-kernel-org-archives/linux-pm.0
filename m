From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Wed, 24 Sep 2014 12:17:18 +0200
Message-ID: <87vbodiaq9.fsf@nemi.mork.no>
References: <87zjdq8k7i.fsf@nemi.mork.no> <2218322.ridXK8jFtJ@vostro.rjw.lan>
	<878ulaxn6d.fsf@nemi.mork.no> <1435748.4Qh6HZyMEY@vostro.rjw.lan>
	<87vbodihrd.fsf@nemi.mork.no> <20140924095111.GC10438@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:40579 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754448AbaIXKRh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 06:17:37 -0400
In-Reply-To: <20140924095111.GC10438@suse.de> (Joerg Roedel's message of "Wed,
	24 Sep 2014 11:51:11 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Joerg Roedel <jroedel@suse.de> writes:

>> @@ -1343,7 +1343,15 @@ void swsusp_free(void)
>>  {
>>         unsigned long fb_pfn, fr_pfn;
>> =20
>> +WARN_ON(!forbidden_pages_map);
>> +if (!forbidden_pages_map)
>> +       return;
>> +
>>         memory_bm_position_reset(forbidden_pages_map);
>> +WARN_ON(!free_pages_map);
>> +if (!free_pages_map)
>> +       return;
>> +
>>         memory_bm_position_reset(free_pages_map);
>
> ... the old code did not check for a valid forbidden_pages_map and
> free_pages_map either, so it should crash there too.

Well, it did test AFAICS...  The 3.16 code is

int swsusp_page_is_forbidden(struct page *page)
{
        return forbidden_pages_map ?
                memory_bm_test_bit(forbidden_pages_map, page_to_pfn(pag=
e)) : 0;
}

=2E.

void swsusp_free(void)
{
=2E.
                                if (swsusp_page_is_forbidden(page) &&
                                    swsusp_page_is_free(page)) {
                                        swsusp_unset_page_forbidden(pag=
e);
                                        swsusp_unset_page_free(page);
                                        __free_page(page);
                                }






Bj=C3=B8rn
