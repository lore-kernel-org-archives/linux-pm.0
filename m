From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Sat, 9 May 2009 14:12:46 +0300
Message-ID: <84144f020905090412kf7622b2s9af8061b782c680e__22528.1801227995$1242054242$gmane$org@mail.gmail.com>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090507215112.GC14611@elf.ucw.cz>
	<1241746459.19600.246.camel@nigel-laptop>
	<200905082144.57955.bzolnier@gmail.com>
	<1241819971.19600.288.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1241819971.19600.288.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@tuxonice.net
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

On Fri, 2009-05-08 at 21:44 +0200, Bartlomiej Zolnierkiewicz wrote:
>> Please proceed to Plan B then.
>>
>> Adding third core code framework to do the same thing is out of question
>> (probably same should have been said about adding second one in the past).

On Sat, May 9, 2009 at 12:59 AM, Nigel Cunningham <nigel@tuxonice.net> wrote:
> Why? We have plenty of history of having multiple implementations of
> things (slub, slab and slob...).

Yes, so please don't make the same mistake we did. Once you have
multiple implementations in the kernel, it's extremely hard to get rid
of them.
