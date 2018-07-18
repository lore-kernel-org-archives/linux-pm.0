From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos platform
Date: Wed, 18 Jul 2018 14:54:30 +0530
Message-ID: <CANAwSgRFehdmYZvPL3yD1=Ng_w1Yhtij=nvZEOqkof7zj8fcwA@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
 <CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com> <CAJKOXPdXYz77Bqyjr3HK+EA0HpEABPqmPOD0f5ew-yq2SFVpVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000779809057142a212"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPdXYz77Bqyjr3HK+EA0HpEABPqmPOD0f5ew-yq2SFVpVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--000000000000779809057142a212
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof

On 18 July 2018 at 11:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 22:23, Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi Krzysztof
>>
>> On 17 July 2018 at 17:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> Hi Anand,
>>>
>>> Thanks for patch.
>>>
>>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>>> clk_summary do not show tmu_apbif clk enable, so replace
>>>> the clk_prepare with clk_prepare_enables to enable tmu clk.
>>>
>>> This is not valid reason to do a change. What is clk_summary does not
>>> really matter. Your change has negative impact on power consumption as
>>> the clock stays enabled all the time. This is not what we want... so
>>> please explain it more - why you need the clock to be enabled all the
>>> time? What is broken (clk_summary is not broken in this case)?
>>>
>>
>> Opps I could not explain some more in my commit message.
>>
>> Actually TMU sensor for Exynos process are controlled by so external clk
>>
>> Exynos4412 have VDD18_TS sensor which controls the CLK_SENSE tmu.
>> Exynos5422 have VDD18_TS01 / VDD18_TS23 / VDD18_TS4 sensor which
>> control the CLK_SENSE tmu.
>>
>> So as per my understanding tmu is clk driver which control the flow  PMIC.
>>
>> clk_prepare_enable combine clk_prepare and clk_enable
>> and clk_disable_unprepare combine clk_disable and clk_unprepare.
>>
>> most of the driver prefer clk_prepare_enable and clk_disable_unprepare.
>>
>> clk_summary is just a reference looking point where we could check the
>> clk is enable/disable.
>>
>> what is broken ?
>> I still few more parameter need to tuned to configure the tmu driver.
>
> I am sorry but I am still unable to see what is broken and what are
> you trying to fix. I asked what is broken and you replied that there
> is a sensor, there is a clock, drivers use clk_prepare_enable and some
> more parameter need to be tuned... None of these are answers to
> question - what is broken. How can I reproduce the problem?
>
> Best regards,
> Krzysztof

Basically I use thermal testing.

# git clone https://git.linaro.org/power/pm-qa.git
# cd pm-qa
# make -C thermal check

most of the testcase failed on Exynos5422 but some pass on Exynos4412.

Attach is the software overview from Exynos5422 user manual.

I am not able to explain in deep technically, but I have studied other thermal
driver to draw into conclusion that tmu clk's need to be enabled.

If you feel the we should not enable these clk, them I will drop the
clk_prepare_enable check
and resubmit the changes with better commit message.

Best Regards
-Anand

--000000000000779809057142a212
Content-Type: text/plain; charset="US-ASCII"; name="Exynos5422_software_tmu.txt"
Content-Disposition: attachment; filename="Exynos5422_software_tmu.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jjqx60gx0

VGhlIGV4YW1wbGUgb2Ygc29mdHdhcmUgc2VxdWVuY2UgYXMgZm9sbG93czoNClRoZSBwYXJhbWV0
ZXIgbWF5IGJlIGNoYW5nZWQgYWNjb3JkaW5nIHRvIGFuIGFwcGxpY2F0aW9uLg0KLyogUmVhZCB0
aGUgbWVhc3VyZWQgZGF0YSBmcm9tIGUtZnVzZSAqLw0KVHJpbWluZm9fODUgPSBUUklNSU5GT1sx
NTo4XQ0KVHJpbWluZm9fMjUgPSBUUklNSU5GT1s3OjBdDQovKiBDYWxpYnJhdGVkIHRocmVzaG9s
ZCB0ZW1wZXJhdHVyZSBpcyB3cml0dGVuIGludG8gVEhSRVNfVEVNUF9SSVNFIGFuZCBUSFJFU19U
RU1QX0ZBTEwgKi8NCi8qIFJlZmVyIHRvIDEuNi4xICovDQpUSFJFU19URU1QX1JJU0UwID0gMHg0
MDsNClRIUkVTX1RFTVBfUklTRTEgPSAweDUwOw0KVEhSRVNfVEVNUF9SSVNFMiA9IDB4NjA7DQpU
SFJFU19URU1QX1JJU0UzID0gMHg3MDsNClRIUkVTX1RFTVBfRkFMTDAgPSAweDNBOw0KVEhSRVNf
VEVNUF9GQUxMMSA9IDB4NEE7DQpUSFJFU19URU1QX0ZBTEwyID0gMHg1QTsNCi8qIFBhcmFtZXRl
ciBmb3Igc2FtcGxpbmcgaW50ZXJ2YWwgaXMgc2V0ICovDQpTQU1QTElOR19JTlRFUlZBTCA9IDB4
MTsNCi8qIEludGVycnVwdCBlbmFibGUgKi8NCklOVEVOWzI0XSA9MHgxOyAvLyBmb3IgSU5URU5f
RkFMTDINCklOVEVOWzIwXSA9MHgxOyAvLyBmb3IgSU5URU5fRkFMTDENCklOVEVOWzE2XSA9MHgx
OyAvLyBmb3IgSU5URU5fRkFMTDANCklOVEVOWzhdID0weDE7IC8vIGZvciBJTlRFTl9SSVNFMg0K
SU5URU5bNF0gPTB4MTsgLy8gZm9yIElOVEVOX1JJU0UxDQpJTlRFTlswXSA9MHgxOyAvLyBmb3Ig
SU5URU5fUklTRTANCi8qIFRoZXJtYWwgdHJpcHBpbmcgbW9kZSBzZWxlY3Rpb24gKi8NClRIRVJN
X1RSSVBfTU9ERSA9IDB4NDsNCi8qIFRoZXJtYWwgdHJpcHBpbmcgZW5hYmxlICovDQpUSEVSTV9U
UklQX0VOID0gMHgxOw0KLyogQ2hlY2sgc2Vuc2luZyBvcGVyYXRpb24gaXMgaWRsZSAqLw0KdG11
X2lkbGUgPSAwOw0Kd2hpbGUodG11X2lkbGUmMSkgew0KdG11X2lkbGUgPSBUTVVfU1RBVFVTWzBd
Ow0KfQ0KLyogU3RhcnQgc2Vuc2luZyBvcGVyYXRpb24gKi8NClRNVV9DT05UUk9MIHw9IDE7DQoN
CklTUl9JTlRSRVFfVE1VICgpIHsNCi8qIFJlYWQgaW50ZXJydXB0IHN0YXR1cyByZWdpc3RlciAq
Lw0KaW50X3N0YXR1cyA9IElOVFNUQVQ7DQppZihpbnRfc3RhdHVzWzI0XSkgew0KSVNSX0lOVF9G
QUxMMigpOw0KfQ0KZWxzZSBpZihpbnRfc3RhdHVzWzIwXSkgew0KSVNSX0lOVF9GQUxMMSgpOw0K
fQ0KZWxzZSBpZihpbnRfc3RhdHVzWzE2XSkgew0KSVNSX0lOVF9GQUxMMCgpOw0KfQ0KRWxzZSBp
ZihpbnRfc3RhdHVzWzhdKSB7DQpJU1JfSU5UX1JJU0UyKCk7DQp9DQplbHNlIGlmKGludF9zdGF0
dXNbNF0pIHsNCklTUl9JTlRfUklTRTEoKTsNCn0NCmVsc2UgaWYoaW50X3N0YXR1c1swXSkgew0K
SVNSX0lOVF9SSVNFMCgpOw0KfQ0KZWxzZSB7DQokZGlzcGxheSgiU29tZSBlcnJvciBvY2N1cnJl
ZC4uISIpOw0KfQ0KSVNSX0lOVDAgKCkgew0KLyogUGVyZm9ybSBwcm9wZXIgdGFzayBmb3IgZGVj
cmVhc2UgdGVtcGVyYXR1cmUgKi8NCklOVENMRUFSWzBdID0gMHgxOw0KfQ==
--000000000000779809057142a212--
