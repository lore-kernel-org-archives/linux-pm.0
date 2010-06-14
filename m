From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: BUG: using smp_processor_id() in preemptible code:
	s2disk
Date: Mon, 14 Jun 2010 07:38:53 -0700
Message-ID: <20100614073853.6fa2f91f__8918.32944839752$1276526311$gmane$org@infradead.org>
References: <20100613203352.GA3577@swordfish>
	<1276461183.2659.4.camel@maxim-laptop>
	<201006140136.18652.rjw@sisk.pl>
	<20100614140941.GA3581@swordfish.minsk.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100614140941.GA3581@swordfish.minsk.epam.com>
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

On Mon, 14 Jun 2010 17:09:41 +0300
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> Hello,
> Not sure if this simple solution is the correct one.

it's not; the caller needs to pass in the cpu number I suspect for this
to be really correct....

I just returned from family emergency travel and will take a look today


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
