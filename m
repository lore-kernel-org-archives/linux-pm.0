From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH v2 0/3] firmware: scpi: add device power domain support
Date: Thu, 16 Jun 2016 14:14:54 +0100
Message-ID: <1466082894.20208.1.camel@linaro.org>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2016-06-16 at 11:37 +0100, Sudeep Holla wrote:
> This series add support for SCPI based device device power state
> management using genpd.
> 
> Regards,
> Sudeep
> 
> v1[1]->v2:
> 	- Fixed the endianness handling in scpi_device_get_power_state
> 	  as spotted by Tixy
> 	- Renamed scpi_pd.c to scpi_pm_domain.c as suggested by Ulf

You seemed to also have made some changes to the contents of the file,
is that deliberate? This is the diff...

--- a/drivers/firmware/scpi_pm_domain.c
+++ b/drivers/firmware/scpi_pd.c
@@ -27,7 +27,7 @@ struct scpi_pm_domain {
        struct generic_pm_domain genpd;
        struct scpi_ops *ops;
        u32 domain;
-       char name[20];
+       char name[30];
 };
 
 enum scpi_power_domain_state {
@@ -51,7 +51,7 @@ static int scpi_pd_power(struct scpi_pm_domain *pd,
bool power_on)
        if (ret)
                return ret;
 
-       return (state == pd->ops->device_get_power_state(pd->domain));
+       return !(state == pd->ops->device_get_power_state(pd->domain));
 }
 
 static int scpi_pd_power_on(struct generic_pm_domain *domain)
