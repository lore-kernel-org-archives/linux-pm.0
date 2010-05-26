From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 03:06:20 -0700
Message-ID: <AANLkTiksR3YozbBH0Iv5kNsQkEGKCH1APCvn_s6LkjV9__18304.6354250566$1274868430$gmane$org@mail.gmail.com>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005242049.18920.rjw@sisk.pl> <87wrusvrqe.fsf@deeprootsystems.com>
	<201005250138.16293.rjw@sisk.pl> <1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274867106.5882.5090.camel@twins>
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
Cc: LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/5/26 Peter Zijlstra <peterz@infradead.org>:
> On Wed, 2010-05-26 at 02:41 -0700, Arve Hj=F8nnev=E5g wrote:
>> On Wed, May 26, 2010 at 1:47 AM, Peter Zijlstra <peterz@infradead.org> w=
rote:
>> > On Tue, 2010-05-25 at 01:38 +0200, Rafael J. Wysocki wrote:
>> >> > This of course will lead to a scattering of suspend blockers into a=
ny
>> >> > drivers/subsystems considered "useful", which by looking through cu=
rrent
>> >> > Android kernels is many of them.
>> >>
>> >> That depends on the maintainers of these subsystems, who still have t=
he power
>> >> to reject requested changes.
>> >
>> > So as a scheduler maintainer I'm going to merge a patch that does a
>> > suspend_blocker when the runqueue's aren't empty... how about that?
>> >
>>
>> I don't know if you are serious, since the all the runqueues are never
>> empty while suspending, this would disable opportunistic suspend
>> altogether.
>
> So why again was this such a great scheme? Go fix your userspace to not
> not run when not needed.
>

I was not talking about our user-space code. Suspend has to be called
by a running thread, so at least one runqueue is not empty.

-- =

Arve Hj=F8nnev=E5g
