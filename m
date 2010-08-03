From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: Nigel's current for-rafael queue
Date: Tue, 03 Aug 2010 17:00:57 +1000
Message-ID: <4C57BEA9.9020504__23599.7407966808$1280819035$gmane$org@tuxonice.net>
References: <1275481160-31150-1-git-send-email-nigel@tuxonice.net>
	<20100803065543.GF3344@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100803065543.GF3344@ucw.cz>
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

On 03/08/10 16:55, Pavel Machek wrote:
> On Wed 2010-06-02 22:18:59, Nigel Cunningham wrote:
>> Hi all.
>>
>> Here is my current patch queue.
>>
>> Taken together, the patches implement the separation of low level
>> block i/o into a separate file, switch from using swap_map_pages
>> to extents stores prior to the 'header' page and implement fully
>> asynchronous (rather than batched I/O). I have only run it under
>> VMware so far, but would estimate a doubling in speed due to the
>> async i/o.
>
> Do you have any numbers from real hw? Could similar speedup be
> accomplished by just increasing the batch size?

Yeah. I've been thinking I should really prepend a patch that lets you 
get the stats post-resume - unless you guys have some trick to enable 
you to read them that I haven't noticed yet :)

Nigel
