From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3 linux-next] cpufreq: conservative: Use an inline
 function to evaluate freq_target
Date: Wed, 6 Mar 2013 21:31:13 +0800
Message-ID: <CAKohponFw+nvzQAj58-gpxu8rUudm9gG+OQ8nK=Qi9BONcpAZw@mail.gmail.com>
References: <51366C77.3080309@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51366C77.3080309@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 6 March 2013 06:06, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> Use an inline function to evaluate freq_target to avoid duplicate code.
>
> Also, define a macro for the default frequency step and fix the
> calculation of freq_target when the max freq is less that 100.

s/that/than :)
