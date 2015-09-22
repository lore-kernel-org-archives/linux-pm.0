From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] power: print function name of callbacks
Date: Tue, 22 Sep 2015 10:38:26 -0700
Message-ID: <CAD=FV=V1NTm7HsBcvHkXUnkxGHj=VC9fWQZdn3g4aSe3OQxnNg@mail.gmail.com>
References: <1442942797-17433-1-git-send-email-dianders@chromium.org>
	<1A7043D5F58CCB44A599DFD55ED4C9484692486F@fmsmsx115.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C9484692486F@fmsmsx115.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Sep 22, 2015 at 10:33 AM, Brown, Len <len.brown@intel.com> wrote:
> have you used analyze_suspend?
> It used to parse this output, but that was abandoned
> when it cut over to using ftrace directly.
>
> https://01.org/suspendresume

Ah, good to know about.  In my case this output is enabled on shipping
devices and sometimes we get back bug reports with these prints in the
log, so I'm interested in making the prints more useful.  :)

-Doug
