From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [PATCH 08/23] Hibernation: Generic extents support.
Date: Wed, 06 Oct 2010 12:21:29 +1100
Message-ID: <4CABCF19.60902__42829.8493418426$1286328241$gmane$org@tuxonice.net>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<1285566238-10966-9-git-send-email-nigel@tuxonice.net>
	<20101004175122.GB1518@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101004175122.GB1518@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi.

On 05/10/10 04:51, Pavel Machek wrote:
> Hi!
>
>> Separate out the extent storage and manipulation into a separate
>> file and make them more generic, so we can also use extents for
>> recording what sectors are used and (later) support multiple
>> storage devices more easily.
>>
>> Signed-off-by: Nigel Cunningham<nigel@tuxonice.net>
>
>> @@ -0,0 +1,125 @@
>> +/*
>> + * linux/kernel/power/extents.c
>> + *
>> + * This file provides functions for storing and using a series of
>> + * extents.
>> + *
>> + * Copyright (C) 1998,2001-2005 Pavel Machek<pavel@suse.cz>
>
> That address is no longer valid :-(. Jiri Kosina should already have
> patches to remove it elsewhere in the tree.

Okay. You want ucw.cz or something else?

>> +/**
>> + *	free_all_swap_pages - free swap pages allocated for saving image data.
>> + *	It also frees the extents used to register which swap entres had been
>> + *	allocated.
>> + */
>> +
>> +void hib_extents_clear(struct hib_extent_state *pos)
>
> Comment does not match function.

Thanks.

Nigel
