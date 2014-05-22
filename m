From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 3/7] driver/core: cpu: initialize opp table
Date: Thu, 22 May 2014 09:41:44 +0530
Message-ID: <CAKohpokQFU3NMrSibaW2sVgVRT5diixwbuAUA2Tby9LMdgaSBQ@mail.gmail.com>
References: <cover.1400670427.git.viresh.kumar@linaro.org>
	<b59df199b373191791afcccd627d900ce07afa71.1400670427.git.viresh.kumar@linaro.org>
	<537CE1C4.9050008@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <537CE1C4.9050008@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arvind Chauhan <Arvind.Chauhan@arm.com>, "inderpal.s@samsung.com" <inderpal.s@samsung.com>, "nm@ti.com" <nm@ti.com>, "chander.kashyap@linaro.org" <chander.kashyap@linaro.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "len.brown@intel.com" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 21 May 2014 22:56, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Sorry I missed this earlier, main idea of this wrapper is not to have any
> config dependency and hide error handling details for non-DT platforms.
> Since
> of_init_opp_table has dummy implementation, you really don't need this dummy
> implementation again here.

x-( (That's my angry face ..)

I still added it so that the next few conditional statements (error checking)
also go away for non-DT platforms.. So, lets keep for now. We may have
more additions into it in future..
