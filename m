From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Tue, 25 May 2010 23:04:04 +0200
Message-ID: <AANLkTin98MXVaXJxizOsfYDkR2rl2Y6qVABf1qftAFWq__36659.671055577$1274821574$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005251359580.1634-100000@iolanthe.rowland.org>
	<201005252147.22358.rjw@sisk.pl>
	<20100525195300.GA4455@core.coreip.homeip.net>
	<201005252221.55888.rjw@sisk.pl>
	<20100525204405.GE4455@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100525204405.GE4455@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 25, 2010 at 10:44 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

>> Now, we can reject their patches, but that's not going to cause any prog=
ress
>> to happen, realistically. =A0Quite on the contrary, Android will continu=
e to use
>> wakelocks and Android driver writers will continue to ignore the mainline
>> and the gap between the two kernel lines will only get wider and wider o=
ver
>> time.
>>
>> And what really is the drawback if we merge the patches? =A0Quite frankl=
y,
>> I don't see any.
>
> Adding stuff that is not beneficial to anyone but a particular platform?
> It is uncommon to say the least.

Yeah, I'd even say we're about to adopt mechanism which will provoke
adding drivers with buggy solutions.

Moving that stuff to platform-specific userspace will solve that, more or l=
ess.

Also, I'm less than happy about Android vs mainline talks that come
into play when out of the technical points. Google is doing a good job
but we shouldn't compromise neither the quality nor the principles in
order to make them happy. They will not support tons of drivers with
custom PM solution by themselves, so it's to mutual benefit if they
come with a satisfactory solution.

~Vitaly
