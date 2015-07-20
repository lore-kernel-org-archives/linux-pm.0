From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 8/8] PCC: Enable PCC only when needed
Date: Mon, 20 Jul 2015 15:22:37 +0100
Message-ID: <55AD042D.9040204@arm.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org> <f88f374b4e09f23d5601a2081d1d3d9322e3caf5.1436464513.git.ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <f88f374b4e09f23d5601a2081d1d3d9322e3caf5.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 09/07/15 19:04, Ashwin Chaugule wrote:
> CPPC is the first client to make use of the PCC Mailbox channel. So
> enable it only when CPPC is also enabled.
>
This sounds like a reverse dependency to me. So if there's some client
unrelated to CPPC using PCC, CPPC_LIB needs to be selected to enable PCC ?

Regards,
Sudeep
