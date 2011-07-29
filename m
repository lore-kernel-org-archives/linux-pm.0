From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH v3 00/13] PM QoS: add a per-device
	latency constraints class
Date: Fri, 29 Jul 2011 10:37:52 +0200
Message-ID: <CAORVsuVoJ5-1hx2+6+gCuuWDd9A9h_RTS=U1228BM7EYiG=gxA__16322.9623380632$1311928729$gmane$org@mail.gmail.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<20110728131454.GA2579@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110728131454.GA2579@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: broonie@opensource.wolfsonmicro.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Mark,

On Thu, Jul 28, 2011 at 3:14 PM, mark gross <markgross@thegnar.org> wrote:
> On Thu, Jul 28, 2011 at 10:30:07AM +0200, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> This patch set is in an RFC state, for review and comments.
>>
>> High level implementation:
>>
...

>> 7. Misc fixes to improve code readability:
>> . rename of the PM QoS implementation file from pm_qos_params.[ch] to pm=
_qos.[ch]
> I picked the name for the file as pm_qos_params over pm_qos because I
> wanted to make it implicitly clear that this was not an full QOS
> implementation. =A0True QOS carries expectations similar to real time and
> as the infrastructure is closer to "good intentioned" than even "best
> effort" and offers no notification when the QOS request is not able to
> be met and really doesn't implement a true QOS at all, (it just provides
> the parameter interface for part of one its missing the notification
> interface when the service level is not met and I think a few other
> things.) So I wanted to have it named a bit different from just pm_qos.
>
> This said I'm not supper attached to the naming of the modules. =A0If
> folks want to change it I wouldn't complain (too much anyway;).
Ok got the idea. I do not know what name to chose though. As suggested
previously the name pm_qos_params does not reflect the implementation,
that is why I renamed it.

>
> --mark
> PS I'll look at the rest of the patches tomorrow, this time for real as
> I'm about to have more free time to focus on non-work stuff :)
Thanks you for reviewing!

> FWIW this write up sounds interesting.
Hope it is readable ;p

Regards,
Jean
