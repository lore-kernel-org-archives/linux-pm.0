From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
Date: Thu, 05 Jul 2018 17:52:08 -0700
Message-ID: <681dbd37f209a29be46e9c4ff102631cfa841ec0.camel@linux.intel.com>
References: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
         <20180702202151.GK533219@devbig577.frc2.facebook.com>
         <5493bfdb-14a9-a55d-f96e-b9c8a29f1d63@redhat.com>
         <ca753f719e123d8e3c2306b8d55f3d4a656cbd2f.camel@linux.intel.com>
         <fefe0ef4-e21f-72cc-18d6-a5a6693c21c6@redhat.com>
         <660d4e4b-361f-e6b1-ef21-3985c321183a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <660d4e4b-361f-e6b1-ef21-3985c321183a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mario.Limonciello@dell.com
List-Id: linux-pm@vger.kernel.org

Hi Hans,


[...]

> So digging a bit deeper I just realized that another important
> difference
> between med_power_with_dipm and min_power is that min_power by
> default
> set the ASP bits making the link go to the slumber state instead of
> to
> the partial (power-saving) state.
> 
> According to:
> https://www.intel.com/content/dam/doc/reference-guide/sata-devices-im
> plementation-recommendations.pdf
> 
> ASP defaults to off in the iRST drivers. But that is a document from
> before DEVSLP got introduced.
> 
> So we need to know if Windows and/or the iRST drivers use HIPM and
> ASP by default on these systems. If they do then using min_power
> is fine. If they don't use one or the other we are going to need
> a new policy reflecting those settings and use that.
Good point. In Windows there are various registry settings, so they can
be tuned. It is difficult to know what they mean.
Let me do some experiments to check impact of ASP on SLP_S0. Then I
will resubmit this patch.

Thanks,
Srinivas

> 
> Regards,
> 
> Hans
> 
