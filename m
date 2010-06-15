From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] avoid using smp_processor_id() in
 preemptible code (nr_iowait_cpu)
Date: Tue, 15 Jun 2010 08:08:08 -0700
Message-ID: <20100615080808.6286448b__36122.0756233253$1276614783$gmane$org@infradead.org>
References: <1276461183.2659.4.camel@maxim-laptop>
	<201006140136.18652.rjw@sisk.pl>
	<20100614140941.GA3581@swordfish.minsk.epam.com>
	<20100614073853.6fa2f91f@infradead.org>
	<20100614145439.GA3448@swordfish.minsk.epam.com>
	<20100614080154.7d6a71fc@infradead.org>
	<20100614151735.GB3448@swordfish.minsk.epam.com>
	<20100614204021.52c50cdc@infradead.org>
	<20100615061927.GA3312@swordfish>
	<20100615072435.5a47d850@infradead.org>
	<20100615145029.GB3967@swordfish.minsk.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100615145029.GB3967@swordfish.minsk.epam.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 15 Jun 2010 17:50:29 +0300
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > 
> > hmm this part is wrong
> > you pick the current cpu, rather than the one denoted by ts.....
> > 
> 
> Hmm. Thanks, good catch. 
> Well, there is something I'm missing. How can I match given *ts and
> cpu in update_ts_time_stats (except for introducing
> update_ts_time_stats(..., int cpu)) ?


that'd be option one
option two is to add a "cpu" member to struct tick_sched.....

if you go for option one, I'd replace the ts argument with the cpu
argument.....


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
