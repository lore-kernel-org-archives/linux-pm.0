From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for May 10 (e_powersaver)
Date: Fri, 10 May 2013 11:27:38 -0700
Message-ID: <518D3C1A.2090500@infradead.org>
References: <20130510134333.e0fa4e2d811af4c82e21139a@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130510134333.e0fa4e2d811af4c82e21139a@canb.auug.org.au>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Rafal Bilski <rafalbilski@interia.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 05/09/13 20:43, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any v3.11 destined work to your linux-next included
> branches until after v3.10-rc1 is released.
> 
> Changes since 20130509:
> 

on i386:
CONFIG_ACPI_PROCESSOR=m
CONFIG_X86_E_POWERSAVER=y


drivers/built-in.o: In function `eps_cpu_init.part.8':
e_powersaver.c:(.text.unlikely+0x2243): undefined reference to `acpi_processor_register_performance'
e_powersaver.c:(.text.unlikely+0x22a2): undefined reference to `acpi_processor_unregister_performance'
e_powersaver.c:(.text.unlikely+0x246b): undefined reference to `acpi_processor_get_bios_limit'


X86_E_POWERSAVER should also depend on ACPI_PROCESSOR.



-- 
~Randy
