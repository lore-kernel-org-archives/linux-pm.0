From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Proposal for a new algorithm for reading & writing a
 hibernation image.
Date: Thu, 03 Jun 2010 18:14:21 +1000
Message-ID: <4C07645D.1060409__4744.50759725205$1275553087$gmane$org@crca.org.au>
References: <4BE7475A.8030901@crca.org.au> <20100530052546.GA25287@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100530052546.GA25287@ucw.cz>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi.

On 30/05/10 15:25, Pavel Machek wrote:
> Hi!
>
>> 2. Prior to writing any of the image, also set up new 4k page tables
>> such that an attempt to make a change to any of the pages we're about to
>> write to disk will result in a page fault, giving us an opportunity to
>> flag the page as needing an atomic copy later. Once this is done, write
>> protection for the page can be disabled and the write that caused the
>> fault allowed to proceed.
>
> Tricky.
>
> page faulting code touches memory, too...

Yeah. I realise we'd need to make the pages that are used to record the 
faults be unprotected themselves. I'm imagining a bitmap for that.

Do you see any reason that it could be inherently impossible? That's 
what I really want to know before (potentially) wasting time trying it.

Regards,

Nigel
