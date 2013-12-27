From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: intel_pstate divide error with v3.13-rc4-256-gb7000ad
Date: Fri, 27 Dec 2013 12:24:22 +0000
Message-ID: <20131227122422.62857cec@alan.etchedpixels.co.uk>
References: <CA+5PVA6YpKc6kYK5UiTnGLZpB8uts=-QPtyhotAyZ2kuoG8PPQ@mail.gmail.com>
	<CAKohpomqHApogDEXA5LyWk-+B-Y1mwNQ63-wL3PPGz64s_3Dmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomqHApogDEXA5LyWk-+B-Y1mwNQ63-wL3PPGz64s_3Dmw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 24 Dec 2013 21:36:01 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Adding Dirk..
> 
> On 24 December 2013 20:06, Josh Boyer <jwboyer@fedoraproject.org> wrote:
> > Hi All,
> >
> > We've had a report [1] that the pstate driver causes KVM guests to
> > fail to boot because of a divide error.  See the backtrace below.
> >
> >     4.839784] Intel P-state driver initializing.
> > [    4.859972] Intel pstate controlling: cpu 0
> > [    4.867653] cpufreq: __cpufreq_add_dev: ->get() failed
> 
> After a call to ->init(), ->get() is supposed to work.
> @Dirk: Any idea why it failed?
> 
> And then I don't know what made this divide by zero to happen :)

> > [    4.878127] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011

Emulator bug perhaps ?

