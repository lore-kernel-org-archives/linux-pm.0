From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [linux-pm] cpuidle future and improvements
Date: Mon, 25 Jun 2012 15:10:57 +0200
Message-ID: <4FE86361.3050603@linaro.org>
References: <4FDEE98D.7010802@linaro.org> <4FDF2D58.9010006@ti.com> <CAMQu2gz8aGC1DeOvWNNPaaMD9eJLuiJ5HGoKe98EDtV73_QRTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAMQu2gz8aGC1DeOvWNNPaaMD9eJLuiJ5HGoKe98EDtV73_QRTQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Lists Linaro-dev <linaro-dev@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Amit Kucheria <amit.kucheria@linaro.org>, linux-next@vger.kernel.org, Colin Cross <ccross@android.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Rob Lee <rob.lee@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 06/25/2012 02:58 PM, Shilimkar, Santosh wrote:
> On Mon, Jun 18, 2012 at 7:00 PM, a0393909 <santosh.shilimkar@ti.com> =
wrote:
>> Daniel,
>>
>>
>> On 06/18/2012 02:10 PM, Daniel Lezcano wrote:
>>>
>>>
>>> Dear all,
>>>
>>> A few weeks ago, Peter De Schrijver proposed a patch [1] to allow p=
er
>>> cpu latencies. We had a discussion about this patchset because it
>>> reverse the modifications Deepthi did some months ago [2] and we ma=
y
>>> want to provide a different implementation.
>>>
>>> The Linaro Connect [3] event bring us the opportunity to meet peopl=
e
>>> involved in the power management and the cpuidle area for different=
 SoC.
>>>
>>> With the Tegra3 and big.LITTLE architecture, making per cpu latenci=
es
>>> for cpuidle is vital.
>>>
>>> Also, the SoC vendors would like to have the ability to tune their =
cpu
>>> latencies through the device tree.
>>>
>>> We agreed in the following steps:
>>>
>>> 1. factor out / cleanup the cpuidle code as much as possible
>>> 2. better sharing of code amongst SoC idle drivers by moving common=
 bits
>>> to core code
>>> 3. make the cpuidle_state structure contain only data
>>> 4. add a API to register latencies per cpu
>>>
>>> These four steps impacts all the architecture. I began the factor o=
ut
>>> code / cleanup [4] and that has been accepted upstream and I propos=
ed
>>> some modifications [5] but I had a very few answers.
>>>
>> Another thing which we discussed is bringing the CPU cluster/package
>> notion in the core idle code. Couple idle did bring that idea to som=
e
>> extent but in can be further extended and abstracted. Atm, most of
>> the work is done in back-end cpuidle drivers which can be easily
>> abstracted if the "cluster idle" notion is supported in the core lay=
er.
>>
> Are you considering the "cluster idle" as one of the topic ?

Yes, absolutely. ATM, I am looking for refactoring the cpuidle code and
cleanup whenever is possible.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
