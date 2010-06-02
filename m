From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [PATCH 1/9] PM / Hibernate: swap,
	switch to hibernate_io_handle
Date: Wed, 02 Jun 2010 22:37:13 +1000
Message-ID: <4C065079.1020208__31396.3687200614$1275482636$gmane$org@crca.org.au>
References: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi.

On 02/06/10 18:52, Jiri Slaby wrote:
> Hi,
>
> I addressed the comments I got on the previous RFC. I left the handles
> in place, the functions in hibernate_io_ops now works on them. Further
> I got rid of the memory barriers and minimized global variables as much
> as possible. Comments welcome.
>
> --
>
> Some code, which will be moved out of swap.c, will know nothing about
> swap. There will be also other than swap writers later, so that it
> won't make sense at all.
>
> So introduce a new structure called hibernate_io_handle which
> currently contains only a pointer to private data, but is independent
> on I/O reader/writer actually used. Private data are swap_map_handle
> for now.
>
> This structure is allocated in _start and freed in _finish. This will
> correspond to the later introduction of hibernate_io_ops where users
> will do handle=start->repeat{read/write(handle)}->finish(handle).
> I.e. they will operate on handle instead of global variables.

I'm starting on appending your patch series to mine (yes, I've given you 
no time to object :> I'm too keen!)

Since, in my tree, swap_map pages are history, I'll skip this patch.

Nigel
