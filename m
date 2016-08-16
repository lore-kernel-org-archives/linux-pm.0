From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 5/5] acpi: bus: Enable HWP CPPC objects
Date: Tue, 16 Aug 2016 09:50:55 -0700
Message-ID: <1471366255.3745.45.camel@linux.intel.com>
References: <1470874646-70570-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1470874646-70570-6-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20160816143257.GA22533@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160816143257.GA22533@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Alexey,

On Tue, 2016-08-16 at 15:32 +0100, Alexey Klimov wrote:
> Hi Srinivas,
> 
> On Wed, Aug 10, 2016 at 05:17:26PM -0700, Srinivas Pandruvada wrote:
> > 
> > Need to set platform wide _OSC bits CPC version 1 and version 2
> > bits
> > so that BIOS presents CPPC objects.
> > Even though the cppc_acpi supports only version 2, need to set both
> > _OSC bits for version 1 and version 2, otherwise BIOS ignore _OSC
> > settings.
> Does such behaviour go against ACPI specs?
> If yes, it's better to add comment in the code.
I need to fix the commit description here. The bit 5 is generic CPPC
support and bit 6 is CPPC_V2 support capability. So if we set only bit
5 then we can support only CPPC v1. If we set bit 6, we also support
CPPC v2. So we have to set both bits for CPPC v2 (Table 6-176 Platform-
Wide _OSC Capabilities DWORD 2 ACPI 6.0 spec). 
 
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > ---
> >  drivers/acpi/bus.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 85b7d07..61643a5 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -330,6 +330,13 @@ static void acpi_bus_osc_support(void)
> >  	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
> >  	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
> >  
> > +#ifdef CONFIG_X86
> > +	if (boot_cpu_has(X86_FEATURE_HWP)) {
> > +		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
> > +		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
> > +	}
> > +#endif
> Just to check if I understand things correctly.
> I thought that OSC method is kind of 'handshake'. OS describes
> features
> that it supports and then platform indicates back what features it
> can
> provide/support.
> Here in this patch I see only first part and I don't see where you
> check
> confirmation from platform that it supports/enabled CPPC.
> You don't need that, do you?
Once we set these bits the BIOS will expose the CPPC tables. This will
result in acpi_cppc_processor_probe will be successful. Also _OSC
response will set bit 5 and 6 here to confirm the acceptance, but I
can't do any meaningful processing with that confirmation till
acpi_cppc_processor_probe() returns successfully, which is the
confirmation.
How the CPPC data is used in x86 as I indicated in the cover page will
be a separate series. I submitted CPPC ACPI changes before so that they
can be reviewed first.

Thanks,
Srinivas


> It will be nice to see explanation.
> 
> Best regards,
> Alexey.
> 
> > 
> >  	if (!ghes_disable)
> >  		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
> >  	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
