From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH v2 3/3] firmware: scpi: add device power domain support
 using genpd
Date: Thu, 16 Jun 2016 18:47:54 +0100
Message-ID: <1466099274.20208.65.camel@linaro.org>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
	 <1466073481-697-4-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466073481-697-4-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2016-06-16 at 11:38 +0100, Sudeep Holla wrote:
[...]
> +enum scpi_power_domain_state {
> +	SCPI_PD_STATE_ON = 0,
> +	SCPI_PD_STATE_OFF = 3,
> +};

The SCPI doc defines the meaning of these numbers (0 and 3) in the 'Juno
specifics' chapter. So does these values need to come from device-tree
to allow for other hardware or SCP implementations?

-- 
Tixy
