From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6/8] PM: Add suspend blocking work.
Date: Wed, 28 Apr 2010 09:18:28 +0200
Message-ID: <4BD7E144.6050608@kernel.org>
References: <1272429119-12103-1-git-send-email-arve@android.com>	
	<1272429119-12103-2-git-send-email-arve@android.com>	
	<1272429119-12103-3-git-send-email-arve@android.com>	
	<1272429119-12103-4-git-send-email-arve@android.com>	
	<1272429119-12103-5-git-send-email-arve@android.com>	
	<1272429119-12103-6-git-send-email-arve@android.com>	
	<1272429119-12103-7-git-send-email-arve@android.com>	
	<4BD7D948.4080406@kernel.org>
	<i2vd6200be21004280002tde778c02h1586b4c06de2a89a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <i2vd6200be21004280002tde778c02h1586b4c06de2a89a@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,

On 04/28/2010 09:02 AM, Arve Hj=F8nnev=E5g wrote:
>> Maybe work->active can be an atomic_t and the lock can be removed?
> =

> I need the spinlock to prevent the work from getting re-queued before
> suspend_unblock.

OIC.

> I'm not sure what the best terminology is here, but cancel_work_sync()
> only waits for work running on all the cpu-workqueues of the last
> workqueue. So, if the caller queued the work on more than one
> workqueue, suspend_blocking_work_destroy does not ensure that the
> suspend_blocking_work structure is not still in use (it should trigger
> the WARN_ON though).

Right, I was thinking about different cpu_workqueues and yeah, the
terminology gets pretty confusing.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- =

tejun
