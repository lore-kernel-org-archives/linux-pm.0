From: "Akinobu Mita" <akinobu.mita@gmail.com>
Subject: Re: [PATCH 2/2] swsusp: simplify memory bitmap
Date: Mon, 7 Jul 2008 22:26:47 +0900
Message-ID: <961aa3350807070626m37b3e218sb29303987e6983a2__14850.8266582668$1215440875$gmane$org@mail.gmail.com>
References: <20080705110946.GA17071@localhost.localdomain>
	<20080705111123.GB17071@localhost.localdomain>
	<200807071449.11817.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807071449.11817.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

2008/7/7 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday, 5 of July 2008, Akinobu Mita wrote:
>> This patch simplifies the memory bitmap manipulations.
>>
>> - remove the member size in struct bm_block
>>
>> It is not necessary for struct bm_block to have the number of bit chunks
>> that can be calculated by using end_pfn and start_pfn.
>>
>> - use find_next_bit() for memory_bm_next_pfn
>>
>> No need to invent the bitmap library only for the memory bitmap.
>
> Thanks for doing this change, it looks OK.
>
> I haven't have the time to test it yet, but once it's been tested, I'll push
> it to Andrew for merging.  I'll fold patch 1/2 into this one.

Thanks. I have only tested it on an x86_64 box.
