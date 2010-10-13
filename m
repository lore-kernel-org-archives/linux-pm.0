From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [PATCH 13/23] Hibernation: Partial page I/O support.
Date: Thu, 14 Oct 2010 08:17:19 +1100
Message-ID: <4CB621DF.9070109__47749.7865599163$1287004961$gmane$org@tuxonice.net>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<1285566238-10966-14-git-send-email-nigel@tuxonice.net>
	<20101013071008.GA1610@ucw.cz> <201010132228.22604.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010132228.22604.rjw@sisk.pl>
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
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi.

On 14/10/10 07:28, Rafael J. Wysocki wrote:
> On Wednesday, October 13, 2010, Pavel Machek wrote:
>> Hi!
>>
>>> Add functions that can be used for coalescing and splitting buffers
>>> that are smaller than PAGE_SIZE. These functions provide no method
>>> of determining where the boundaries of the smaller buffers are to
>>> be found - that is the caller's problem.
>>
>> I don't get it; why do we need that support?
>
> This is related to compression.  This way we can put data from two or more
> compressed pages into one page frame.

It also provides a simple way of putting information from multiple 
sources into a larger-than-at-the-moment header:

- Which pfns are stored
- What swap extents are used
- What devices are used (dev_t, UUID, last mount time for each)
- Whether compression is enabled and what algo is used (if made 
configurable)

and so on.

I do see the logic to Pavel's question though - the last set of patches 
I sent didn't switch the compression code over to using this support. 
That change would make their usefulness a lot clearer.

Regarding speed, I haven't measured the difference but would expect that 
the cost of combining and splitting pages in this way would be less than 
that of waiting on extra I/O. In addition, if we merge the pages in this 
way, our image size will be much closer to the compression ratio and 
will therefore make it more feasible for us to estimate how much storage 
is needed, taking into account an expected compression ratio (which is 
what TuxOnIce currently does).

Regards,

Nigel
