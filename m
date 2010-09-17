From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] opp: introduce library for device-specific
	OPPs
Date: Fri, 17 Sep 2010 11:20:10 -0500
Message-ID: <4C93953A.3010702__43034.1681735173$1284744583$gmane$org@ti.com>
References: <[PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs>
	<1284686973-13993-1-git-send-email-nm@ti.com>
	<A24693684029E5489D1D202277BE89447260B073@dlee02.ent.ti.com>
	<4C93898B.2070606@ti.com>
	<A24693684029E5489D1D202277BE89447260B287@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <A24693684029E5489D1D202277BE89447260B287@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew@smtp1.linux-foundation.org, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Andi Kleen <ak@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Garrett <mjg@redhat.com>, Tero@smtp1.linux-foundation.org, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@stericsson.com>, "Granados Dorado,
	Roberto" <x0095451@ti.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, lkml <linux-kernel@v>
List-Id: linux-pm@vger.kernel.org

Aguirre, Sergio had written, on 09/17/2010 11:15 AM, the following:
>>>>> diff --git a/include/linux/opp.h b/include/linux/opp.h
>>>>> new file mode 100644
>>>>> index 0000000..94a552b
>>>>> --- /dev/null
>>>>> +++ b/include/linux/opp.h
>>>>> @@ -0,0 +1,136 @@
>>>>> +/*
>>>>> + * Generic OPP Interface
>>>>> + *
>>>>> + * Copyright (C) 2009-2010 Texas Instruments Incorporated.
>>>>> + *   Nishanth Menon
>>>>> + *   Romit Dasgupta <romit@ti.com>
>>>>> + * Copyright (C) 2009 Deep Root Systems, LLC.
>>>>> + *   Kevin Hilman
>>>> Just curious why only Romit's e-mail address is there, and not Kevin's
>>> or
>>>> yours...
>>> personal choice I guess, Romit prefered his email id added Kevin and I
>>> did not.
>> OK. No problem then :)
> 
> Actually, Romit's e-mail address seems to be invalid... Is he still having that address? (OR is he still working in TI? 8-| )
On an internal thread, I am told to remove the email id - so will remove 
Romit's email id and cc from v2 patch.

-- 
Regards,
Nishanth Menon
