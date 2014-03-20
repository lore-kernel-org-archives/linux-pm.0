From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC v3] cpufreq: Make sure frequency transitions are serialized
Date: Thu, 20 Mar 2014 15:20:00 +0530
Message-ID: <CAKohpo=WXwirP1y8f2HbSykhPaECCfUKD3XKSLVFty-Jarojvw@mail.gmail.com>
References: <2efc621827cbd96a05a3d34075154974b4816ecd.1394782795.git.viresh.kumar@linaro.org>
	<532840FD.308@linux.vnet.ibm.com>
	<CAKohpomhTJa06a1LSi9tK1+=6Y2MyidJSbYWuffAsU5KxVf7zw@mail.gmail.com>
	<53296870.5010505@linux.vnet.ibm.com>
	<CAKohpomr1s3SLs-K8+-BKguX4PyfHvSjyzd5PFjM4mJeyTj3-A@mail.gmail.com>
	<53298A7D.3080400@linux.vnet.ibm.com>
	<CAKohpon=VLfPiukzrtQOSVAQg-Z-Aq3+AkZ1myrE6XtVRMY8mQ@mail.gmail.com>
	<532AA7A8.3040508@linux.vnet.ibm.com>
	<CAKohpon-i7LUqALr3Bi1Sn02m93YZpBn3sjmDdo3VQCuW5bNYw@mail.gmail.com>
	<532AB3E7.3090503@linux.vnet.ibm.com>
	<CAKohpokiDYqpTj0AbR17KDbE26E=5usRuLWg0+pLR0xR5e5xTg@mail.gmail.com>
	<532AB8D7.5000608@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <532AB8D7.5000608@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Amit Daniel <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 20 March 2014 15:15, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> By the way, I'm also thinking of using a spinlock instead of a mutex.
> The critical section is tiny and we don't sleep inside the critical
> section - sounds like the perfect case for a spinlock.

Probably yes.
