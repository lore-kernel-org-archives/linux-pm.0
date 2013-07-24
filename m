From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3 v6] cpufreq: Add debugfs directory for cpufreq
Date: Wed, 24 Jul 2013 11:46:03 +0530
Message-ID: <CAOh2x==uh1y+9h0B0X+VbzDx9UDuNPu7OogwAoGqYwJ3CBg06g@mail.gmail.com>
References: <1374146275-5758-1-git-send-email-cw00.choi@samsung.com>
	<1374146275-5758-2-git-send-email-cw00.choi@samsung.com>
	<CAKohpo=oTsEjzi_51UaZ8ww8UEfZ6hwKAnu9rFgGBkt=TfHi8A@mail.gmail.com>
	<51EF2D06.7000704@samsung.com>
	<51EF70B4.2010806@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51EF70B4.2010806@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 24, 2013 at 11:44 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> I considered the parameter type of cpufreq_create_debugfs_symlink() and then
> I need following function declaration because this function didn't always need to
> create symbolic link to policy->cpu. This function declaration is capable of creating
> symbolic link as 'dest_cpu -> src_cpu'
>
>         +static int cpufreq_create_debugfs_symlink(unsigned int src_cpu,
>         +                                          unsigned int dest_cpu)

You need policy structure as well, right? And src_cpu is always going to
be policy->cpu. So you can have policy and cpu as two parameters.. cpu
is dest cpu btw.
