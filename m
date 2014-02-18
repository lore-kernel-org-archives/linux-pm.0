From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V5 0/7] cpufreq: suspend early/resume late: dpm_{suspend|resume}()
Date: Tue, 18 Feb 2014 13:31:24 -0700
Message-ID: <5303C31C.4070607@wwwdotorg.org>
References: <cover.1392273722.git.viresh.kumar@linaro.org>	<52FE71BD.3020103@wwwdotorg.org>	<52FE7AFD.2040203@wwwdotorg.org> <CAKohpo=JVUPV81hFmwpuweWrfoEGZ0S_pkb9Fd+-SCXy+O+QCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=JVUPV81hFmwpuweWrfoEGZ0S_pkb9Fd+-SCXy+O+QCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Kgene Kim <kgene.kim@samsung.com>, jinchoi@broadcom.com, Lan Tianyu <tianyu.lan@intel.com>, Sebastian Capella <sebastian.capella@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 02/16/2014 11:02 PM, Viresh Kumar wrote:
> On 15 February 2014 01:52, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> BTW, I also happened to test these on a Tegra114 system, on which there
>> is no cpufreq driver, and this series (applied on top of commit
>> 9398a10cd964 Merge tag 'regulator-v3.14-rc2') causes the following
>> during suspend:
> 
> Ahh, that's a obvious bug. Following would fix it, thanks:

Yes, I tested V6 of the patch series, which incorporates that change,
and it's OK.
