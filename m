From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: discard duplicate OPP additions
Date: Thu, 15 May 2014 09:27:05 +0530
Message-ID: <CAKohpo=MFxUHL22TxXPk4B=JX9AD3RGdgXPPGK9sD3GD6AEV+g@mail.gmail.com>
References: <1399966890-22926-1-git-send-email-k.chander@samsung.com>
	<20140514150255.GA8330@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140514150255.GA8330@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "[Chander Kashyap" <chander.kashyap@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 14 May 2014 20:32, Pavel Machek <pavel@ucw.cz> wrote:
> Hmm. Would it be better to actually delete stale OPPs?

I wouldn't call them stale as dtb isn't going to change after boot
and we will always get the same list again, unless some arch has
added few more after boot.

So, there is no point freeing opp's once created. Just make sure
they aren't added again.
