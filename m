From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Return error if ->get() failed in cpufreq_update_policy()
Date: Mon, 17 Feb 2014 14:40:26 +0530
Message-ID: <CAKohpomHEjqN+qPF9_v95kG+1=Yzpm54mVoN-3Vn51X=QckbHw@mail.gmail.com>
References: <15ccc0609cb9ee3db0ad3a95b29bf69d11ea197c.1392375504.git.viresh.kumar@linaro.org>
	<4772234.6D4cUIJHX4@vostro.rjw.lan>
	<CAKohpo=uPbqMcDEHYEMahRF0rCO8KYscj2nocz81_OTKyU+Tfw@mail.gmail.com>
	<5301C605.3030205@linux.vnet.ibm.com>
	<CAKohpo=mQWxoKTduR8FrrB4Qz45qXQrJjSudq=FkCJtHBTbo2Q@mail.gmail.com>
	<5301CE86.9020105@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5301CE86.9020105@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pierre Ossman <pierre-list@ossman.eu>
List-Id: linux-pm@vger.kernel.org

On 17 February 2014 14:25, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Specifically, I'm referring to the problem where there _is_ a difference,
> but the ->get() is not reporting it properly, like returning a 0 for example.

I think get() returning zero isn't acceptable at all. How can current freq be
zero :) .. There has to be a bug somewhere and so we shouldn't really
try to get working here.. That's what I thought.
