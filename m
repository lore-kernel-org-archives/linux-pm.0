From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 7/9] PM: Add suspend blocking work.
Date: Sat, 24 Apr 2010 09:43:25 +0200
Message-ID: <4BD2A11D.7040507@kernel.org>
References: <1271984938-13920-1-git-send-email-arve@android.com>	
	<1271984938-13920-4-git-send-email-arve@android.com>	
	<1271984938-13920-5-git-send-email-arve@android.com>	
	<1271984938-13920-6-git-send-email-arve@android.com>	
	<1271984938-13920-7-git-send-email-arve@android.com>	
	<1271984938-13920-8-git-send-email-arve@android.com>	
	<4BD1576E.5070401@kernel.org> <20100423122032.GA23544@redhat.com>	
	<y2ud6200be21004231549q8e52c9c0z441d82b5a15e177d@mail.gmail.com>	
	<4BD290CC.4080601@kernel.org>
	<r2zd6200be21004240021sfaec0f3ft8a1ea7c1b12ea52a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <r2zd6200be21004240021sfaec0f3ft8a1ea7c1b12ea52a@mail.gmail.com>
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
Cc: Dmitri Vorobiev <dmitri.vorobiev@movial.com>, Andi Kleen <ak@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On 04/24/2010 09:21 AM, Arve Hj=F8nnev=E5g wrote:
> OK, I'll try to do this. Do you want it in a separate header file as well?

I think it would fit better with the rest of suspend_blocker.h APIs
but it's not like I thought about it hard and long, so please take my
preference with a grain of salt.

> I only touch the work structure after the callback has returned for
> suspend blocking work, which does not allow that.

Oh, you're right.  I missed the current_work_blocks_suspend test.
Sorry about that.

Thanks.

-- =

tejun
