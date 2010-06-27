From: Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>
Subject: Re: wait_for_completion_interruptible does not wait !!
Date: Sat, 26 Jun 2010 21:08:07 -0700
Message-ID: <AANLkTiktmoiyX4c8x1XtJ353sv0flV5NqIQrptrDXPnM__6809.70071484825$1277611771$gmane$org@mail.gmail.com>
References: <AANLkTikPOcNZk5ISX2WDHSmsPDw_a5_3Ic3owAbO4o0y@mail.gmail.com>
	<Pine.LNX.4.44L0.1006201120210.22272-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006201120210.22272-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: vivin uthappa <vivinuthappa@gmail.com>, Sudhakar R <sudhakar.raj@gmail.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 20, 2010 at 8:52 AM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
>
> What happens if the variable is completed while nobody is waiting for
> it? =A0The next time somebody tries to wait, won't the wait terminate
> immediately?
>

Haven't tested it but will reply with the answer once I get a chance to tes=
t it.


>> I tried wait_for_completion instead, but now the kernel refuses to suspe=
nd.
>>
>> I have tried wait queues and mutexs with no success.
>>
>> Could anyone please point me how I can resolve this issue? Is there
>> any construct which can block inside the kernel during suspend/resume?
>
> Yes: The freezer.
>
>> Can there be a blocking call active while we suspend?
>
> Yes, in theory. =A0In practice it's not a good idea, since the call
> wouldn't be able to distinguish between an actual signal and the onset
> of a suspend. =A0You might end up with a call that ignores all signals
> and hence cannot be interrupted.
>

Just for the information of others on the list, here is what we did to
solve this issue, we designed a freezer-friendly wrapper around
wait_for_completion_interruptible()

<SNIP>
#define wait_for_completion_freezable(ptr_completion)           \
({                                                              \
   int __retval;                                                \
   do {                                                         \
       __retval =3D wait_for_completion_interruptible(            \
                       ptr_completion);                         \
       if (__retval && !freezing(current))                      \
           break;                                               \
   } while (try_to_freeze());                                   \
   __retval;                                                    \
})

</SNIP>

Thanks
Suresh
