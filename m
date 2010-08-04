From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: 2.6.35 Regression: Ages spent discarding blocks that
 weren't used!
Date: Thu, 05 Aug 2010 07:22:30 +1000
Message-ID: <4C59DA16.4020500__4338.50799822739$1280957419$gmane$org@tuxonice.net>
References: <4C58C528.4000606@tuxonice.net> <4C5960B0.7020003@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C5960B0.7020003@teksavvy.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Lord <kernel@teksavvy.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

On 04/08/10 22:44, Mark Lord wrote:
> Looks to me like more and more things are using the block discard
> functionality, and as predicted it is slowing things down enormously.
>
> The problem is that we still only discard tiny bits (a single range
> still??)
> per TRIM command, rather than batching larger ranges and larger numbers
> of ranges into single TRIM commands.
>
> That's a very poor implementation, especially when things start enabling
> it by default. Eg. the swap code, mke2fs, etc..
>
> Ugh.

I was hoping for a nice quick and simple answer. Since I haven't got 
one, I'll try to find time to do a git bisect. I think I'll also look at 
the swap code more carefully and see if it's doing the sensible thing. I 
can't (at the moment) see the logic behind calling discard when 
allocating swap. At freeing time makes much more sense to me.

Regards,

Nigel
