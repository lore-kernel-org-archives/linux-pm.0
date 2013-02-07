From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: exynos: Remove error return even if no soc found
Date: Thu, 7 Feb 2013 16:50:09 +0530
Message-ID: <CAOh2x=nAaVNZG-Dfe0v-Uy4zRxf+zmPhxGx+=1rC=cT787=Vbg@mail.gmail.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 7, 2013 at 1:09 AM, Amit Daniel Kachhap
<amit.daniel@samsung.com> wrote:
> This change is needed for adding different type of cpufreq driver
> and support single binary image.

That's not sufficient, we need more description of the problem you faced.
