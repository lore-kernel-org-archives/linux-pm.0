From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: BUG: using smp_processor_id() in preemptible code:
	s2disk
Date: Sun, 13 Jun 2010 23:33:03 +0300
Message-ID: <1276461183.2659.4.camel__49190.9389420927$1276461256$gmane$org@maxim-laptop>
References: <20100613203352.GA3577@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100613203352.GA3577@swordfish>
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

On Sun, 2010-06-13 at 23:33 +0300, Sergey Senozhatsky wrote: 
> Hello,
> 
> .35-rc3, x86
> 
> Hit the following error today:

I confirm the same issue. Sorry for not reporting it earlier.


Best regards,
Maxim Levitsky
