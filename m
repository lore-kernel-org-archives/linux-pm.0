From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: Alternative Concept
Date: Fri, 16 Mar 2007 16:06:38 +0300
Message-ID: <45FA965E.80503@gmail.com>
References: <44ECFF94.3030506@gmail.com>
	<45F9179D.2090706@gmail.com>	<1173963890.12614.27.camel@Dogbert.NOE.nokia.com>
	<200703151921.55310.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703151921.55310.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> On Thursday 15 March 2007 6:04 am, Igor Stoppa wrote:
>> On Thu, 2007-03-15 at 12:53 +0300, ext Eugeny S. Mints wrote:
>>>> On Wednesday 14 March 2007 3:43 am, Eugeny S. Mints wrote:
>>>>>> Would this involve replacing the clock framework, or are they going =
to coexist?
>>>>> parameter framework would eventually replace clock framework.
>>>> That seems to be the wrong answer.  Especially since nothing has
>>>> been shown to be wrong with the clock interface; much less to be
>>>> unfixably wrong (hence justifying replacement).
>>> a cherry-picking on clk fw API:
>>>
>>> - clk_set_rate() sticks to an individual clock - no way to set rates fo=
r number =

>>>   of clocks at once instead of having series of clk_set_rate() calls.
>
> This isn't "wrong", it's a "lack of feature".  The normal process for
> addressing such things is to improve working/deployed software interfaces,
> not throw them out and try to create and deploy something new.  :)
David,

Eugeny didn't say he suggest deploying something new just to address
only this issue. Also, the key word in his sentence is "eventually" that
assumes
"evolutionary", if you read all Eugeny's responses you've seen he suggest
starting with existing clock framework.

The actual reason to deploy something new is to organize a mess around
Power Management in Linux kernel... and not only in kernel. I bet you
are also
thinking on how to make order in this area, and I surprised you didn't
comment
on original Matthew's post since it contains so many points to discuss.

For example,

> - PM resource representation
>   Similar to the device abstraction available today. =


IIUC, the framework will use some platform-independent entities to
represent
clock and voltage subsystems of a platform, entities similar for 'struct
device'
which is used to represent normal devices in the system. I.e. one entity
(node) corresponds
to one real clock(voltage) device. What's the worth of
platform-independent representing?
Perhaps it will help to organize clock and voltage subsystems of various
platforms.
The elementary entity (a node),
may store information of clock/voltage device state (active, idle,
off...), a value of
provided frequency/voltage(MHz/mV), a latency needed for transitioning
from one state
for another(ms), also the node may store lists of dependent devices,
info of dependencies
the node is involved to, also the node may contain platform-specific info.
Considering clock framework, it means 'struct clk' becomes
arch-independent but having
a pointer to platform-specific data.
Also, the node may have a dedicated driver which performs
hardware-specific operations
(programms PLL or just sets dividers), some of
this operations may be the same among some platforms or even among
different archs.


Thanks,
Dmitry
