From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Sat, 31 Jan 2009 18:14:13 -0800
Message-ID: <d6200be20901311814n24518903m23731685324c7cce@mail.gmail.com>
References: <20090131074743.GA13633@bulgaria.corp.google.com>
	<200902010118.25810.rjw@sisk.pl>
	<d6200be20901311717i2c49cd45ged21066df395900b@mail.gmail.com>
	<200902010232.22055.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902010232.22055.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 31, 2009 at 5:32 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > If incoming calls are supposed to wake up the system, then there are t=
wo
>> > possibilities:
>> > - the already started suspend sequence may be aborted and the system m=
ay be put
>> >  into the low power state,
>>
>> I assume you mean high power state not low power state, or does low
>> power state mean early-suspend state. If so, locking a wakelock will
>> accomplish this.
>
> Actually, I meant the working state.  Aborting suspend sequence always me=
ans
> go back to the working state.
>
> Also, I think the device that detected the incoming call should abort the
> suspend sequence by refusing to suspend.
>
>> > - the system may be suspended and then immediately woken up.
>>
>> If you mean this as a general strategy, and not a specific outcome,
>> then it does not always work (for the reasons I have already stated).
>
> I meant a specific outcome.
>
> It may be impossible to abort suspend if the call comes in sufficiently
> late.

In that case, why are you against using wakelocks to abort the suspend
sequence? It covers the case where the driver knows that a call is
coming in, without any confusion about when the abort condition
clears. And, it avoids the overhead of freezing every process for an
operation that is doomed to fail.

-- =

Arve Hj=F8nnev=E5g
