From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 8/8] PCC: Enable PCC only when needed
Date: Tue, 21 Jul 2015 00:04:25 +0200
Message-ID: <4609299.WWrJ4WHTsa@vostro.rjw.lan>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org> <f88f374b4e09f23d5601a2081d1d3d9322e3caf5.1436464513.git.ashwin.chaugule@linaro.org> <55AD042D.9040204@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <55AD042D.9040204@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, July 20, 2015 03:22:37 PM Sudeep Holla wrote:
> 
> On 09/07/15 19:04, Ashwin Chaugule wrote:
> > CPPC is the first client to make use of the PCC Mailbox channel. So
> > enable it only when CPPC is also enabled.
> >
> This sounds like a reverse dependency to me. So if there's some client
> unrelated to CPPC using PCC, CPPC_LIB needs to be selected to enable PCC ?

No.  The other client will need to select PCC too.

I requested that change, because I'm slightly bothered by the fact that we
build code used by no one by default.

Thanks,
Rafael

