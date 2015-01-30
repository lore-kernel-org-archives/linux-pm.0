From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: fix another race between PPC notification and vcpu_hotplug()
Date: Fri, 30 Jan 2015 07:30:27 +0530
Message-ID: <CAKohpokOA2tje_yhXj7rrj-PT3Qs02u0w=JthAOWfMTW7NcLzA@mail.gmail.com>
References: <1422513761-8230-1-git-send-email-ethan.zhao@oracle.com>
	<CAKohpon-2rO7Rkr9juNXO+cOswoWmqiKHnnTr3aprW2y_Noh_w@mail.gmail.com>
	<54CAE219.8080102@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54CAE219.8080102@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ethan zhao <ethan.zhao@oracle.com>
Cc: santosh shilimkar <santosh.shilimkar@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ethan Zhao <ethan.kernel@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 30 January 2015 at 07:14, ethan zhao <ethan.zhao@oracle.com> wrote:
>  Please take a look at the code I composed, I thought of it whole night.

Santosh has already tested my patch and it worked for him. And that is
the right solution I believe.
