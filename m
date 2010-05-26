From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 03:17:23 -0700
Message-ID: <AANLkTimHGpRAZklIwXu6wEbA3coKXJvCVLxj2twerkCw__26461.96955252$1274869095$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<201005252344.37639.rjw@sisk.pl>
	<AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y@mail.gmail.com>
	<1274863342.5882.4850.camel@twins>
	<20100526112303.3fef15a4@schatten.dmk.lab>
	<1274866402.5882.5051.camel@twins>
	<AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw@mail.gmail.com>
	<1274868384.5882.5169.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274868384.5882.5169.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, tytso@mit.edu, Greg KH <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

2010/5/26 Peter Zijlstra <peterz@infradead.org>:
> On Wed, 2010-05-26 at 02:54 -0700, Arve Hj=F8nnev=E5g wrote:
>>
>> I'm not sure what you are proposing that we use instead. Both
>> user-space and kernel code needs to block suspend. If we don't have
>> suspend blockers in the kernel then user-space needs to poll when a
>> driver blocks suspend by returning an error from its suspend hook.
>
> In particular I'm suggesting you ditch the /dev/suspend_block thing.
>
> With a single suspend manager process that manages the suspend state you
> can achieve the same goal.
>

Yes we don't need the /dev interface, but it is useful. Without it any
program that needs to block suspend has to make a blocking ipc call
into the suspend manager process. Android already does this for java
code, but system processes written in C block suspend directly with
the kernel since they cannot use the java APIs.

> When the suspend manager has a !0 busy-task count, it ensures the kernel
> won't auto-suspend, when it again reaches a 0 busy-task count, it
> re-instates the auto-suspend feature.
>
> That's pretty much what that device would do too.
>
> Ideally we would not do the auto-suspend thing at all and have
> runtime-PM improved. Not running apps when they expect to run is like
> the world turned upside down.
>
> 'Evil' apps could always report themselves as blocker anyway.
>

-- =

Arve Hj=F8nnev=E5g
