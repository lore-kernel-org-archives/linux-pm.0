From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH V8 00/14] Add T210 support in Tegra soctherm
Date: Tue, 29 Mar 2016 18:19:44 +0800
Message-ID: <56FA56C0.4060000@nvidia.com>
References: <1458118571-29717-1-git-send-email-wni@nvidia.com> <56F4CE8D.5020108@nvidia.com> <20160329030440.GA2315@localhost.localdomain> <56FA0B45.70404@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56FA0B45.70404@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: thierry.reding@gmail.com, rui.zhang@intel.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8829=E6=97=A5 12:57, Wei Ni wrote:
>=20
>=20
> On 2016=E5=B9=B403=E6=9C=8829=E6=97=A5 11:04, Eduardo Valentin wrote:
>> On Fri, Mar 25, 2016 at 01:37:17PM +0800, Wei Ni wrote:
>>> Hi, Eduardo
>>> Will you take this series, it seems no more comments.
>>
>> Yeah, I am taking a look at it. Something is fishy about it. Patch 0=
4
>> does not apply cleanly. Also, why did you split the patches into two
>> email threads, one which is 1-4 and another one is 5-14?
>=20
> Sorry, what do you mean "split the patches into two email threads"? A=
nd what's
> the 1-4 and 5-14?
> I think I didn't split my patches into two email thread.

I think I knew what's your mean.
When I use "git send-email --to=3Dxxx *.patch" to send patches, I hit "=
 4.4.2
Message submission rate for this client has exceeded the configured lim=
it".
So I split them to send.
And I didn't realized it will cause problems before I sending out V9 se=
ries, so
I sent V9 patches one by one, they appear as individual emails on the m=
ailing
list, not as a thread.
I will check my email system and resend them.

Thanks.
Wei.

>=20
> Thanks.
> Wei.
>=20
>>
>> I have ammended patch 04 at my side, but you need to validate your
>> series is one piece (please check my tree and linux-next).
>>
>> BR,
>>
>> Eduardo Valentin
>>
>>>
