From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: intel_soc_dts_thermal binding issues
Date: Fri, 6 Mar 2015 01:37:13 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092630149275F@SHSMSX101.ccr.corp.intel.com>
References: <CA+5PVA7SZ+csY8WwMkwRa-nOmsHP8SdVe4v=mUmq38RJ4LSsyA@mail.gmail.com>
	<744357E9AAD1214791ACBA4B0B90926301491FCF@SHSMSX101.ccr.corp.intel.com>
 <CA+5PVA58q==ieDyfoMEsJ=TxLXXRdNPoKC5gNWAg0MdTv4Eq+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+5PVA58q==ieDyfoMEsJ=TxLXXRdNPoKC5gNWAg0MdTv4Eq+g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

Please attach the acpidump output.

Thanks,
rui

-----Original Message-----
From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-owner@vger.kernel.org] On Behalf Of Josh Boyer
Sent: Thursday, March 5, 2015 10:30 PM
To: Zhang, Rui
Cc: Eduardo Valentin; Linux PM list; Linux-Kernel@Vger. Kernel. Org
Subject: Re: intel_soc_dts_thermal binding issues
Importance: High

On Wed, Mar 4, 2015 at 8:55 PM, Zhang, Rui <rui.zhang@intel.com> wrote:
> What kernel are you using?
> I think it should be fixed by commit 014d9d5d0cc1da79bbe48fbc5e1068c5616238d2, which is merged in 3.19-rc5.

The reporter with the ASUS machine was running 3.18.7.  However, on my NUC machine I still see this with 4.0-rc2 and the latest Linus tree:

[jwboyer@nuc-celeron ~]$ uname -a
Linux nuc-celeron 4.0.0-0.rc2.git1.1.fc23.x86_64 #1 SMP Thu Mar 5
08:37:23 EST 2015 x86_64 x86_64 x86_64 GNU/Linux [jwboyer@nuc-celeron ~]$ dmesg | grep request_threaded
[   11.187239] intel_soc_dts_thermal: request_threaded_irq ret -22
[   11.261738] intel_soc_dts_thermal: request_threaded_irq ret -22
[jwboyer@nuc-celeron ~]$ cat /proc/cpuinfo | grep "model name"
model name    : Intel(R) Celeron(R) CPU  N2820  @ 2.13GHz
model name    : Intel(R) Celeron(R) CPU  N2820  @ 2.13GHz
[jwboyer@nuc-celeron ~]$

The 4.0.0-rc2.git1.1 above corresponds to Linux v4.0-rc2-150-g6587457b4b3d in mainline.  We aren't carrying any patches that would impact this.

The commit you pointed to seems to imply that either INT340X_THERMAL or INTEL_SOC_DTS_THERMAL could be set, but not both.  In Fedora, we have them both enabled as modules:

[jwboyer@nuc-celeron ~]$ grep _THERMAL=m
/boot/config-4.0.0-0.rc2.git1.1.fc23.x86_64
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_THERMAL=m
CONFIG_INT340X_THERMAL=m
[jwboyer@nuc-celeron ~]$

Maybe the commit should be checking for INTEL_SOC_DTS_THERMAL unconditionally, and not as an #elfi?

josh

>
> Thanks,
> rui
>
> -----Original Message-----
> From: jwboyer@gmail.com [mailto:jwboyer@gmail.com] On Behalf Of Josh 
> Boyer
> Sent: Wednesday, March 4, 2015 10:05 PM
> To: Zhang, Rui; Eduardo Valentin
> Cc: Linux PM list; Linux-Kernel@Vger. Kernel. Org
> Subject: intel_soc_dts_thermal binding issues
> Importance: High
>
> Hi All,
>
> We've seen a number of reports where people see:
>
> [   20.499427] intel_soc_dts_thermal: request_threaded_irq ret -22
> [   20.519160] intel_soc_dts_thermal: request_threaded_irq ret -22
> [   20.532660] intel_soc_dts_thermal: request_threaded_irq ret -22
>
> in their boot logs.  They view this as a kernel bug and report is as such.  The above log came from an ASUS x200ma machine, which has a quad core Baytrail-M Pentium CPU (N3530).
>
> I can't tell if the issue is because the driver is trying to bind to all 4 cores and only CPU0 works, or what other issue would cause this.
> I personally have a Celeron based NUC with a N2820 that gets the error above for both cores and the driver doesn't load at all.
>
> Is there something else the driver should be doing to bind to the various CPUs?  If there's nothing else it can key off of, can we drop the pr_err so it stops showing up in dmesg?
>
> josh
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
