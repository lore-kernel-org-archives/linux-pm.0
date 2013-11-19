From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] power: Replace printks with dev_* and pr_* routines
Date: Tue, 19 Nov 2013 11:07:15 -0800
Message-ID: <1384888035.17783.45.camel@joe-AO722>
References: <1384886818-11861-1-git-send-email-shuah.kh@samsung.com>
	 <1384887205.17783.40.camel@joe-AO722> <528BB492.8090404@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <528BB492.8090404@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shuah.kh@samsung.com
Cc: len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, 2013-11-19 at 11:57 -0700, Shuah Khan wrote:
> On 11/19/2013 11:53 AM, Joe Perches wrote:
> > On Tue, 2013-11-19 at 11:46 -0700, Shuah Khan wrote:
> >> Replaced printks with dev_* and pr_* routines. Replacing printk in
> >> __suspend_report_result() will require passing in struct device *
> >> pointer from calling routines and this will require changes to
> >> external interface suspend_report_result() which is used by several
> >> drivers. Hence, this one instance is replaced by pr_err().
> > []
> >> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > []
> >> @@ -1308,9 +1308,8 @@ int dpm_prepare(pm_message_t state)
> >>   				error = 0;
> >>   				continue;
> >>   			}
> >> -			printk(KERN_INFO "PM: Device %s not prepared "
> >> -				"for power transition: code %d\n",
> >> -				dev_name(dev), error);
> >> +			dev_info("PM: not prepared for power transition: ",
> >> +				 "code %d\n", error);
> >
> > Shuah, you have to make sure the files modified by
> > your patches compile successfully before sending
> > patches like this.
> Oops. I did compile. Missed the warning. Sorry about that.

btw:

When you're doing patches like this, not bugfixes,
not something that's going to be applied to current
or stable, please make them against -next and not
against Linus' tree.

Also, I would make the larger change that modifies
all the drivers like I suggested.  What you've done
I think is a half-measure and is incomplete.

cheers, Joe
