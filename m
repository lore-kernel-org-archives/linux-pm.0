From: Dirk Behme <dirk.behme@gmail.com>
Subject: Re: [PATCH] thermal: rcar_thermal: Fix priv->zone error handling
Date: Tue, 3 May 2016 19:46:22 +0200
Message-ID: <5728E3EE.6030506@gmail.com>
References: <1461234295-30521-1-git-send-email-dirk.behme@de.bosch.com>
 <CAMuHMdWDnHDrf8d1nY0M6bY_z1sJfHbTM15QoP+dpfTJkCDrWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWDnHDrf8d1nY0M6bY_z1sJfHbTM15QoP+dpfTJkCDrWA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Linux PM list <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-pm@vger.kernel.org

On 21.04.2016 15:00, Geert Uytterhoeven wrote:
> On Thu, Apr 21, 2016 at 12:24 PM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> In case thermal_zone_xxx_register() returns an error, priv->zone
>> isn't NULL any more, but contains the error code.
>>
>> This is passed to thermal_zone_device_unregister(), then. This checks
>> for priv->zone being NULL, but the error code is != NULL. So it works
>> with the error code as a pointer. Crashing immediately.
>>
>> To fix this, reset priv->zone to NULL before entering
>> rcar_gen3_thermal_remove().
>
> Alternatively, you could prevent a non-valid zone pointer from ever
> ending up in priv->zone by assigning the zone to a temporary variable,
> and only storing that in priv->zone after the error check.
>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>
> Regardless of the above
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>


Could this be applied, then?


Best regards

Dirk
