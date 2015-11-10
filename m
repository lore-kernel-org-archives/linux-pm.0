From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Subject: Re: [PATCH 0/2] thermal: rcar_thermal: tidyup rebind issue
Date: Tue, 10 Nov 2015 11:27:08 +0900
Message-ID: <564155FC.3030900@jinso.co.jp>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
 <87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
 <87bnb2lhzv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87bnb2lhzv.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, cm-hiep@jinso.co.jp
List-Id: linux-pm@vger.kernel.org

Dear Mr Morimoto

we go to test rcar_thermal funstion with this patchs.
If result is good I will send Tested-by nv-dung

best regard
Nguyen Viet Dung

On 2015=E5=B9=B411=E6=9C=8810=E6=97=A5 11:18, Kuninori Morimoto wrote:
> Hi
>
> Actually, these issue are reported by Dung Hiep,
> but I didn't add their name on these patches.
> Thus, Dung, Hiep, can you please send Tested-by for these ?
>
>> rcar_thermal doesn't work after unbind/re-bind today.
>> These patches are cosmetic, and tidyup it
>>
>> Kuninori Morimoto (2):
>>        thermal: rcar_thermal: remove redundant operation
>>        thermal: rcar_thermal: use pm_runtime_put_sync()
>>
>>   drivers/thermal/rcar_thermal.c | 49 +++++++++++++++++++++---------=
-------------------
>>   1 file changed, 21 insertions(+), 28 deletions(-)
>>
>>
>> Best regards
>> ---
>> Kuninori Morimoto
