From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Mon, 2 Aug 2010 22:06:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008022203470.6545__38789.6086475395$1280812133$gmane$org@asgard.lang.hm>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801204026.GH31324@thunk.org>
	<20100802030304.GU2470@linux.vnet.ibm.com>
	<20100801210548.23f77ff6@infradead.org>
	<alpine.DEB.2.00.1008012153300.25170@asgard.lang.hm>
	<20100802140933.GB2405@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008021627290.29820@asgard.lang.hm>
	<AANLkTi=1kBuyPS_P+eNLcnRu1mJH6BzpzQW_sENZuL1L@mail.gmail.com>
	<alpine.DEB.2.00.1008022121430.6545@asgard.lang.hm>
	<AANLkTikhcYzNp8CPp8cqrV7Ey5CLMWu1sJTNxUtEi2as@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1883130008-1280811970=:6545"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikhcYzNp8CPp8cqrV7Ey5CLMWu1sJTNxUtEi2as@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1883130008-1280811970=:6545
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o73577eC019151

On Mon, 2 Aug 2010, Arve Hj?nnev?g wrote:

> 2010/8/2  <david@lang.hm>:
>> On Mon, 2 Aug 2010, Arve Hj?nnev?g wrote:
>>
>>> On Mon, Aug 2, 2010 at 5:08 PM, =A0<david@lang.hm> wrote:
>>>>
>>>> On Mon, 2 Aug 2010, Paul E. McKenney wrote:
>>>>
>>>>
>>>> you are close, but I think what I'm proposing is actually simpler
>>>> (assuming
>>>> that the scheduler can be configured to generate the appropriate sta=
ts)
>>>>
>>>> my thought was not to move applications between cgroups as they
>>>> aquire/release the suspend-block lock, bur rather to say that any
>>>> application that you would trust to get the suspend-block lock shoul=
d be
>>>> in
>>>> cgroup A while all other applications are in cgroup B
>>>>
>>>> when you are deciding if the system shoudl go to sleep because it is
>>>> idle,
>>>> ignore the activity of all applications in cgroup B
>>>>
>>>> if cgroup A applications are busy, the system is not idle and should=
 not
>>>> suspend.
>>>>
>>>
>>> Triggering suspend from idle has been suggested before. However, idle
>>> is not a signal that it is safe to suspend since timers stop in
>>> suspend (or the code could temporarily be waiting on a non-wakeup
>>> interrupt). If you add suspend blockers or wakelocks to prevent
>>> suspend while events you care about are pending, then it does not mak=
e
>>> a lot of sense to prevent suspend just because the cpu is not idle.
>>
>> isn't this a matter of making the suspend decision look at what timers=
 have
>> been set to expire in the near future and/or tweaking how long the sys=
tem
>> needs to be idle before going to sleep?
>>
>
> You are describing low power idle modes, not suspend. Most timers stop
> in suspend, so a timer set 10 seconds from now when entering suspend
> will go off 10 seconds after resume so it should have no impact on how
> long you decide to stay in suspend.

so what is the fundamental difference between deciding to go into=20
low-power idle modes to wake up back up on a given point in the future an=
d=20
deciding that you are going to be idle for so long that you may as well=20
suspend until there is user input?

David Lang
--680960-1883130008-1280811970=:6545
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--680960-1883130008-1280811970=:6545--
