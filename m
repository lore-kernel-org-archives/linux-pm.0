From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Tue, 5 Feb 2013 16:56:03 +0530
Message-ID: <CAKohpomUsDr0YJmOxjymcAAJnfOxKfzxGL4iHuif1qCAvy0OYA@mail.gmail.com>
References: <20130204150511.GF13909@pd.tnic>
	<CAKohpokt0xtsj1eQDMw6JgvQVp4rgFyU-vUrtuuF+0jjOVNHRQ@mail.gmail.com>
	<20130204165057.GH13909@pd.tnic>
	<CAOh2x==fyfYwz+eXmPhBJTE+_q_fHyx2drXrM789XvCfEqPBUQ@mail.gmail.com>
	<20130205091532.GA4827@pd.tnic>
	<CAKohpo=6q+Bcgq0Re=3SXM6zwub5N=vJBO=sTeEgZZ9byFK7=g@mail.gmail.com>
	<20130205102721.GB4827@pd.tnic>
	<CAKohpo=_Qq-_Aqy7nZD+f28-B7DY8ioQ5fe8bYKTe64A0RXeGw@mail.gmail.com>
	<20130205110407.GC4827@pd.tnic>
	<CAKohponiiVO_P2EDDTUHeoo7j3FG-ELtP8oLwfdEQ3HkgOS77g@mail.gmail.com>
	<20130205111918.GD4827@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130205111918.GD4827@pd.tnic>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>
List-Id: linux-pm@vger.kernel.org

On 5 February 2013 16:49, Borislav Petkov <bp@alien8.de> wrote:
> On Tue, Feb 05, 2013 at 04:42:23PM +0530, Viresh Kumar wrote:
>> Tricky part is the name of this routine: add_additional_sysfs_entries().
>
> Now you're just being silly - this is just an example how to do it. If
> you want me to do it for ya, you need to send me your monthly salary.

Haha... I don't want you to do it. I don't want such routine to be exposed
to cpufreq drivers as this belongs to the core code.

Just some kind of indication from platform driver is required about
how/where it wants its governor directory to be present.
And the variable suits more here.

Lets discuss it more on the next patch i send :)

--
viresh
