From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH 0/9] Suspend block api (version 3)
Date: Fri, 08 May 2009 16:36:10 -0700
Message-ID: <87y6t7kw0l.fsf@deeprootsystems.com>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<873abixiam.fsf@deeprootsystems.com>
	<d6200be20905071542k6810b817idf2a07dc55665324@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20905071542k6810b817idf2a07dc55665324@mail.gmail.com>
	("Arve =?iso-8859-1?Q?Hj=F8nnev=E5g=22's?= message of "Thu\, 7 May 2009
	15\:42\:27 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

Arve Hj=F8nnev=E5g <arve@android.com> writes:

> 2009/5/6 Kevin Hilman <khilman@deeprootsystems.com>:
>> Arve Hj=F8nnev=E5g <arve@android.com> writes:
>>
>>> This patch series adds a suspend-block api that provides the same
>>> functionality as the android wakelock api. This patch series removes
>>> the sysdev that was used to abort suspend and adds a direct check in
>>> suspend_enter instead. It also has some other code style changes.
>>
>> Sorry for joining the wakelock/suspend-block discussion a bit late,
>> but I have a very basic, and possibly stupid question on the need for
>> such a feature.
>>
>> My basic question: is why not use idle (dynamic PM) instead of suspend
>> (static PM) for this?
>>
>
> We use suspend in addition to idle, not instead of. On some systems
> (msm) we can enter the same power state from idle as from suspend.
> This reduces the importance of suspend, but entering suspend still has
> benefits. The monotonic clock stops and all the periodic timers
> (user-space and kernel) that are based on it stop with it. It also
> reduces the amount of energy an untrusted application can waste since
> it will not be allowed to run when the system is suspended.
>
>> IOW, why not use CPUidle + PM QoS to achieve the same goal? =A0It seems
>> to me that you're trying to add some dynamic PM features onto a static
>> PM subsystem. =A0I could see PM QoS possibly needing some extending but
>> the basic abilities to constrain the low-power states are there.
>
> suspend blockers have no impact on this.
>
>> The one reason I can think of is that you can always have broken
>> drivers or apps that prevent you from hitting idle. =A0But with tools
>> like powertop, it's pretty easy to find these problems and fix them.
>>
> Tools allow you to find apps that waste power, but they do not fix them.
>
>> If that is the primary concern, it seems to me that we're introducing
>> a new kernel API to work around broken drivers and apps that should be
>> fixed instead.
>>
>> What am I missing?
>
> Suspend blockers allow you to use suspend. On platforms that cannot
> enter the same power state from idle this is essential. On platforms
> can enter the same power state from idle as suspend, suspend reduce
> the time spent running which in turn reduces the overall power draw.
> It also offers some protection against bad apps which is important on
> an open device.

Arve,

Thanks for the clarifications.  Like Mark, I feel like I have a better
grip on the motivation behind these changes.

Thanks,

Kevin
