From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 0/7] DRA7: DT thermal support
Date: Mon, 06 Jan 2014 22:46:41 +0800
Message-ID: <1389019601.5853.17.camel@rzhang1-mobl4>
References: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389011811-13004-1-git-send-email-eduardo.valentin-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2014-01-06 at 08:36 -0400, Eduardo Valentin wrote:
> Hello all,
> 
> Now that the basic thermal DT support is merged into Rui's tree,
> I am resending this series, which introduces the DT node entries
> for DRA7 thermal limits representation.
> 
> The series adds two thermal zones, to represent IVA and DSPEVE,
> respectively. It also adds the support to tmp102 and a corresponding
> pcb thermal zone.
> 
> There are only cosmetic changes from v1. A couple of spaces and tabulations
> have been fixed, and minor changes in sentences present in commit log.
> One difference from V1 is the fact that now bandgap is introduced under
> OCP, which is also a minor diff.
> 
> This patch series has been runtime tested on DRA7-evm.
> 
> All best
> 
> Eduardo Valentin (7):
>   arm: dts: add dra7 DSPEVE thermal data
>   arm: dts: add dra7 IVA thermal data
>   arm: dts: dra7: add bandgap entry
>   arm: dts: add cooling properties on dra7 cpu node
>   arm: dts: dra7: add thermal data
>   arm: dts: add tmp102 i2c sensor node on dra7-evm
>   arm: dts: add thermal zones info on tmp102 for DRA7-EVM
> 
>  arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 28 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7-evm.dts             | 22 ++++++++++++++++++++++
>  arch/arm/boot/dts/dra7-iva-thermal.dtsi    | 28 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi                | 26 ++++++++++++++++++++++++++

I'm okay with this patch set. But as long as this patch set does not
change any code under drivers/thermal/, I prefer these patches to go to
your thermal-soc tree first.

thanks,
rui
>  4 files changed, 104 insertions(+)
>  create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
>  create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
