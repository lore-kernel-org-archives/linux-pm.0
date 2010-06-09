From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: 2.6.35-rc2-git2: Reported regressions from 2.6.34
Date: Wed, 09 Jun 2010 11:39:25 +0200
Message-ID: <4C0F614D.7050808__45136.3845299513$1276095862$gmane$org@fusionio.com>
References: <Rlf_Qjov7bG.A.a8F.I8rDMB@chimera>
	<alpine.LFD.2.00.1006081814240.4506@i5.linux-foundation.org>
	<4C0F4872.7090909@fusionio.com> <20100609093249.GA17026@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100609093249.GA17026@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Venkatesh Pallipadi <venki@google.com>, DRI <dri-devel@lists.sourceforge.net>, Mauro Carvalho Chehab <mchehab@redhat.com>, Eric Dumazet <eric.dumazet@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, Carl Worth <cworth@cworth.org>, David H?rdeman <david@hardeman.nu>, Network Development <netdev@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Dave Airlie <airlied@gmail.com>, Linux PM List <linux-pm@lists.linux-foundation.org>, Linux SCSI List <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2010-06-09 11:32, Ingo Molnar wrote:
>> This should be fixed by commit 28f4197e which was merged on friday.
> 
> The scheduler commit adding local_clock() (for .36) is:
> 
>   c676329: sched_clock: Add local_clock() API and improve documentation
> 
> So once that is upstream the block IO statistics code can use that.

Thanks, I'll have to make a note of that.

-- 
Jens Axboe
