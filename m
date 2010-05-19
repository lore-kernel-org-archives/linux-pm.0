From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Tue, 18 May 2010 17:00:21 -0700
Message-ID: <AANLkTinXyoHb8g597NW60rXuAvQBffNeG0Gvcjz8AGrq__36639.548399444$1274227285$gmane$org@mail.gmail.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005142308.48386.rjw@sisk.pl>
	<AANLkTilX0uhqrJtUSOC4smdH1M8V-h14J7YtRG4PPxOQ@mail.gmail.com>
	<201005172342.52660.rjw@sisk.pl>
	<AANLkTilQ5wZ_7fMyDMpUBCtu9oD1Wh22JGllyS1EPlxB@mail.gmail.com>
	<87tyq5qj3v.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87tyq5qj3v.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

2010/5/18 Kevin Hilman <khilman@deeprootsystems.com>:
> Arve Hj=F8nnev=E5g <arve@android.com> writes:
>
>>
>> PM: Opportunistic suspend support.
>>
>> Power management features present in the current mainline kernel are
>> insufficient to get maximum possible energy savings on some platforms,
>> such as Android, because low power states can only safely be entered
>> from idle. =A0Suspend, in its current form, cannot be used, since wakeup
>> events that occur right after initiating suspend will not be processed
>> until another possibly unrelated event wake up the system again.
>
> I think the problems with wakeups in the current suspend path need to
> be described in more detail. =A0In particular, why check_wakeup_irqs()
> is not enough etc.
>

check_wakeup_irqs only handles interrupts that occurred after the
interrupt was masked during suspend. If the interrupt occurred before
it was masked, it will not be pending when check_wakeup_irqs is
called.

>> On some systems idle combined with runtime PM can enter the same power
>> state as suspend, but periodic wakeups increase the average power
>> consumption. Suspending the system also reduces the harm caused by
>> apps that never go idle. On other systems suspend can enter a much
>> lower power state than idle.
>>
>> To allow Android and similar platforms to save more energy than they
>> currently can save using the mainline kernel, we introduce a mechanism
>> by which the system is automatically suspended (i.e. put into a
>> system-wide sleep state) whenever it's not doing useful work, called
>> opportunistic suspend.
>
> A definition of "useful work" here would provide clarity and would
> also help clarify by what criteria other on-going work is determined
> to be not useful.
>
> Kevin
>



-- =

Arve Hj=F8nnev=E5g
