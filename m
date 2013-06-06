From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/3] cpufreq: ondemand: Change the calculation of
 target frequency
Date: Thu, 6 Jun 2013 15:27:57 +0530
Message-ID: <CAKohpo=g4Fn-wsgkmujZso_Du3XZHpwSvrFhcbXm72Ne828suw@mail.gmail.com>
References: <51AF60D5.3080605@semaphore.gr>
	<20130605161703.GA29958@pd.tnic>
	<51AF6E39.2080307@verisign.com>
	<20130606095526.GB21181@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130606095526.GB21181@pd.tnic>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: David C Niemi <dniemi@verisign.com>, Stratos Karafotis <stratosk@semaphore.gr>, "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 6 June 2013 15:25, Borislav Petkov <bp@suse.de> wrote:
> The correct "fix" for this whole deal is coupling cpufreq with
> the scheduler, as it has been said so many times before. You need
> "something" which can tell you whether raising the freq. is worth it or
> not (i.e. the process is waiting on IO or is executing instructions).

Linaro has got a blueprint in this direction but doesn't have any
proof of concept or RFC patches to share. But that will happen soon.
