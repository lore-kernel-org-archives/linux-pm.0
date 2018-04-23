From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/2] regmap: include <linux/ktime.h> from
 include/linux/regmap.h
Date: Mon, 23 Apr 2018 16:07:10 +0200
Message-ID: <f4025431-be9a-32f9-06e1-9c6ac185c96a@gmail.com>
References: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
 <20180423100318.GA19834@sirena.org.uk>
 <d3e10dc5-55d3-40b8-a8de-d48aaaecf019@gmail.com>
 <20180423115043.GD19834@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423115043.GD19834@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: sean.wang@mediatek.com, rjw@rjwysocki.net, khilman@baylibre.com, ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256



On 04/23/2018 01:50 PM, Mark Brown wrote:
> On Mon, Apr 23, 2018 at 12:11:01PM +0200, Matthias Brugger wrote:
> 
>> On 04/23/2018 12:03 PM, Mark Brown wrote:
>>> On Mon, Apr 23, 2018 at 02:42:44PM +0800, sean.wang@mediatek.com
>>> wrote:
>>>> From: Sean Wang <sean.wang@mediatek.com>
> 
>>>> Similar to the readx_poll_timeout() macro calling ktime_* and using 
>>>> ktime_t type, which is declared in <linux/ktime.h>. So, make
> 
>>> I'm missing patch 2 here - what's the story, are there any
>>> dependencies?
> 
>> You can find the second patch here: 
>> https://patchwork.kernel.org/patch/10356237/
> 
> So it looks like there is a dependency here...?
> 

Yes, regmap_read_poll_timeout macro uses for example ktime_compare which is
defined in linux/ktime.h

That's my understanding.

Regards,
Matthias
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEiUuSfQSYnG8EMsBltDliWyzx00MFAlrd6IYACgkQtDliWyzx
00MiNQ/5ASP4bK0FTkrulj6hCQbOaDXQcYB6wmrZGeWse4PXhAaehGBjursRlE96
SjkAa/ZDXjDIhEDHNjO2QONdkDCBiUKp1/Mp8HJeeOTne5yy9V7mFrVxxLCIoqrk
nlu8I9AY608fjUMiWHtt/nNa91QCjjYUfz/S74FhO0bB4tKBvIQb3zV0HGmqM2s2
HSxPJhXhlfQIBO5rUcVPsrndfNMDMyCHdxWF7fjN8Gm9aSDIq/j0BvUlxJXm3CmP
P3AsW1Wdom86IoLJAwCo8dAaPsHos3u7kCK1IWLxDIxl0x9ruHSTKrML01e9o0M9
VlhqdM8GfoTG4cegRHiBQRVuHNbySpSw15WmuQtvPMKfHRpUThzHFiKawhpLvN5G
Q/lnNehJvLQ/L7vaiy4kkq4PkppBGutIGobRmG5WU0NwI3sGzrAGev5IBUgkMn5w
YfMyk/Yxn39aXdOZFSViA1zOYiEfjOnxkDQoxyW/TkyA5NCBG4tAn8Mz8qRH9Z5N
G8lQ2UiLzxvhe007Ce0PXofkO6TbYoup4YebyOh7RIo13L5xsmmyenQxDb0DqpXH
g1KDhz+hijenE6/ppEKBSFg8z1NMY+ZWjFWfTV6NB96WrG8Qh+EJ4gODIQCbvYY1
xEGs3TLuyPuXAz+2pFOK5FEExskrzLnlJ+Mg1wXrJfqs3OWS2EE=
=fHpR
-----END PGP SIGNATURE-----
