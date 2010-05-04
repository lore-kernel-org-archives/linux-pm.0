From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Tue, 4 May 2010 13:40:27 -0700
Message-ID: <n2ud6200be21005041340x32141eaem328765be77223cdd__39462.3252483599$1273005816$gmane$org@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<1272667021-21312-2-git-send-email-arve@android.com>
	<20100504051256.GC3043@thegnar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100504051256.GC3043@thegnar.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/5/3 mark gross <640e9920@gmail.com>:
> On Fri, Apr 30, 2010 at 03:36:54PM -0700, Arve Hj=F8nnev=E5g wrote:
...
>> +When the policy is "opportunisic", there is a special value, "on", that=
 can be
>> +written to /sys/power/state. This will block the automatic sleep reques=
t, as if
>> +a suspend blocker was used by a device driver. This way the opportunist=
ic
>> +suspend may be blocked by user space whithout switching back to the "fo=
rced"
>> +mode.
>
> You know things would be so much easier if the policy was a one-shot
> styled thing. =A0i.e. when enabled it does what it does, but upon resume
> the policy must be re-enabled by user mode to get the opportunistic
> behavior. =A0That way we don't need to grab the suspend blocker from the
> wake up irq handler all the way up to user mode as the example below
> calls out. =A0I suppose doing this would put a burden on the user mode co=
de
> to keep track of if it has no pending blockers registered after a wake
> up from the suspend. =A0but that seems nicer to me than sprinkling
> overlapping blocker critical sections from the mettle up to user mode.
>
> Please consider making the policy a one shot API that needs to be
> re-enabled after resume by user mode. =A0That would remove my issue with
> the design.
>

Making it one shot does not change where kernel code needs to block
suspend, but it does force user space to poll trying to suspend while
suspend is blocked by a driver.

-- =

Arve Hj=F8nnev=E5g
