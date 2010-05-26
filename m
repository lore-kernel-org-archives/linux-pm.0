From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 02:54:37 -0700
Message-ID: <AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw__8047.42167606509$1274867768$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<201005252344.37639.rjw@sisk.pl>
	<AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y@mail.gmail.com>
	<1274863342.5882.4850.camel@twins>
	<20100526112303.3fef15a4@schatten.dmk.lab>
	<1274866402.5882.5051.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274866402.5882.5051.camel@twins>
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

On Wed, May 26, 2010 at 2:33 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
> On Wed, 2010-05-26 at 11:23 +0200, Florian Mickler wrote:
>
>> There is polling, because the suspend manager in userspace doesn't have
>> the whole picture. i.e. it doesn't know if a suspend will be
>> successfull.
>> So for aggressive suspending as a powersave-feature you need to poll
>> (i.e. retry upon failure). because you don't want to stay unsuspended.
>
> Clearly if it fails, there something to be done, right? So whoever does
> the thing will communicate with the suspend manager that it's going to
> do and has finished doing its thing, at which point it will try again.
>

If you are talking about user-space code here, then that does not
work. Not all kernel events that need to block suspend make it to
user-space.

> That's event driven, not polled.
>
> Also, if you want you can keep the kernel-side auto-suspend side, and
> have the suspend manager clear on !0 and re-establish the auto-suspend
> state on 0.
>
> But you really don't need this device thingy.
>

I'm not sure what you are proposing that we use instead. Both
user-space and kernel code needs to block suspend. If we don't have
suspend blockers in the kernel then user-space needs to poll when a
driver blocks suspend by returning an error from its suspend hook.

-- =

Arve Hj=F8nnev=E5g
