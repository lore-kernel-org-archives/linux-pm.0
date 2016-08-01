From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v5] Force cppc_cpufreq to report values in KHz to fix user
 space reporting
Date: Mon, 1 Aug 2016 14:07:25 -0600
Message-ID: <3ab83afa-1c91-4dcc-9206-a7a6dc3cfe83@redhat.com>
References: <1469049004-19069-1-git-send-email-ahs3@redhat.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469049004-19069-1-git-send-email-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Prashanth Prakash <pprakash@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 07/20/2016 03:10 PM, Al Stone wrote:
> When CPPC is being used by ACPI on arm64, user space tools such as
> cpupower report CPU frequency values from sysfs that are incorrect.
> 
> What the driver was doing was reporting the values given by ACPI tables
> in whatever scale was used to provide them.  However, the ACPI spec
> defines the CPPC values as unitless abstract numbers.  Internal kernel
> structures such as struct perf_cap, in contrast, expect these values
> to be in KHz.  When these struct values get reported via sysfs, the
> user space tools also assume they are in KHz, causing them to report
> incorrect values (for example, reporting a CPU frequency of 1MHz when
> it should be 1.8GHz).
> [snip...]

Ping?  If anyone has sent comments, I have not received them.

Thanks in advance for the time and effort.  I know merge window can be
a very busy time.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
