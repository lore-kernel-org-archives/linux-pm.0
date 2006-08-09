From: david singleton <dsingleton@mvista.com>
Subject: Re: Powerop-core.patch
Date: Wed, 9 Aug 2006 08:27:34 -0700
Message-ID: <17d495bd455566f98fd42e21cc86cd08@mvista.com>
References: <ca336d7d3b5ccf11a06a76d8a732fbea@mvista.com>
	<20060807131812.e31665d7.vitalywool@gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060807131812.e31665d7.vitalywool@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


On Aug 7, 2006, at 2:18 AM, Vitaly Wool wrote:

> David,
>
> On Fri, 4 Aug 2006 19:31:40 -0700
> david singleton <dsingleton@mvista.com> wrote:
>
>> Here is the core patch for the PowerOp concept.  It adds the powerop
>> struct
>> for opertaing point support to linux/pm.h and adds support to
>> transition to supported operating points by
>> setting their name into /sys/power/state.
>>
>> The supported operating points are shown in a readonly sysfs file,
>> /sys/power/supported_states.
>
> your patch doesn't apply for me, and my guess would be that's due to =

> your mailer which a. converted tabs to spaces and b. wrapped up some =

> lines.
>
> Can you please resend it?

Vitaly,
	can you pick the patches up from the ftp site?    =

http://source.mvista.com/~dsingleton.

	This patch set allows for dynamic, on-the-fly, creation of operating =

points by passing the
frequency, voltage, and transition latency at module load time.

David
>
> Thanks,
>    Vitaly
