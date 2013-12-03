From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [RFC v2 0/4] Add basic support for ASV
Date: Tue, 3 Dec 2013 20:16:12 +0530
Message-ID: <CAM4voak0QaseYoRM+rsx2Fa8qs1z=w9iVep1smxx73_SUhmkJQ@mail.gmail.com>
References: <1384515691-26299-1-git-send-email-sachin.kamat@linaro.org>
	<CAJ0PZbS8FxRA_sPTOnWbZcNfUMp=k5Jf_tZHLg1fh6gsAGJ=Gw@mail.gmail.com>
	<CAK9yfHzUAnBMB2Bp+eKzR3NH1iRguJn4K45gss5psWzG4Lc7tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAK9yfHzUAnBMB2Bp+eKzR3NH1iRguJn4K45gss5psWzG4Lc7tw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: MyungJoo Ham <myungjoo.ham@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Yadwinder Singh Brar <yadi.brar01@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Bresticker <abrestic@google.com>, Doug Anderson <dianders@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Yadwinder and Sachin,

On Mon, Nov 18, 2013 at 9:37 AM, Sachin Kamat <sachin.kamat@linaro.org>=
 wrote:
> Hi MyungJoo,
>
> On 18 November 2013 08:07, MyungJoo Ham <myungjoo.ham@samsung.com> wr=
ote:
>>
>> 2013. 11. 15. =BF=C0=C8=C4 8:44=BF=A1 "Sachin Kamat" <sachin.kamat@l=
inaro.org>=B4=D4=C0=CC =C0=DB=BC=BA:
>>
>>
>>>
>>> Original cover letter from Yadwinder:
>>> This series is to add basic common infrastructure for ASV.
>>>  Basically ASV is a technique used on samsung SoCs, which provides =
the
>>> recommended supply voltage for dvfs of arm, mif etc. For a given op=
erating
>>> frequency, the voltage is recommended based on SoC's ASV group.
>>> ASV group gets fussed on SoCs during process of mass production.
>>>
>>> This series includes:
>>>  - basic common infrastructue for ASV. It provides common APIs for =
user
>>> drivers
>>> like cpufreq & devfreq and and an interface for SoC specific driver=
s to
>>> register ASV members(instances)
>>>  - a common platform driver to register ASV members for exynos SoCs
>>>  - an example providing minimal support (only for ARM ASV) for exyn=
os5250
>>> chips
>>>
>>> Its just basic skelton which I wanted to get it reviewed or discuss=
ed in
>>> early stage, before going ahead on further development based on it.
>>>  Presently example is based on static ASV table provided in SoC spe=
cific
>>> file,
>>> which I expects to go into DT. But exactly how and where needs to b=
e
>>> discussed,
>>> may be in next revisions once we get through the basic skelton.
>>>  Also the location of driver in kernel may also seem odd to someone=
 and
>>> many more things :).
>>>
>>> Looking for your valuable reviews and suggestions.
>>
>> Hi,
>>
>> As I have commented on the previous thread of Yadwinder, please shar=
e the
>> directory woth AVS, which is conceptually a superset of ASV.
>>
>> Ultimately, it would be best if you can supply an infra that can be =
shared
>> with the current AVS, which does not have any currently.
>>
>
> Yadwinder has already replied to your suggestion about his concerns. =
Please
> share your comments.
>

CC'ing Doug and Andrew who have also worked on ASV.

I tested these patches on a 5250 Chromebook after modifying the
cpufreq code and a few other changes for booting the board. The driver
is retrieving the ASV fused group correctly. The behavior on an
unfused SMDK5250 is also fine.
I have a few minor comments on the patches.

Thanks
Abhilash
