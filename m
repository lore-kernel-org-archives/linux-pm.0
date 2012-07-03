From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: linux-next : cpuidle - could you add my tree please
Date: Tue, 3 Jul 2012 18:54:50 +0200
Message-ID: <201207031854.51163.rjw@sisk.pl>
References: <4FDEE98D.7010802@linaro.org> <20120703231948.33cca18e3cc3d6e497ab022d@canb.auug.org.au> <4FF2F2D3.4090200@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4FF2F2D3.4090200@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Lists Linaro-dev <linaro-dev@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Amit Kucheria <amit.kucheria@linaro.org>, linux-next@vger.kernel.org, Colin Cross <ccross@android.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Rob Lee <rob.lee@linaro.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 03, 2012, Daniel Lezcano wrote:
> On 07/03/2012 03:19 PM, Stephen Rothwell wrote:
> > Hi Daniel,
> > 
> > On Tue, 03 Jul 2012 14:56:58 +0200 Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >>> So do you have a branch in the cpuidle-next.git tree that isn't going to
> >>> be rebased?
> >>
> >> No. I am following Linus tree and adding the patches on top of it.
> > 
> > Please don't rebase your tree more than necessary - it just makes thing
> > hard for anyone using your tree as a base for further development and
> > throws away any testing you may have done.
> 
> Ok, let me sync with Len and Rafael about the best way to do that.

Please create a branch in your tree for me to pull from and let me know
which one it is.  Please note that this branch must not be rebased after I've
pulled from it and it's going to be included into my linux-next branch
automatically.

I'll include it into my v3.6 push, because I have a couple of cpuidle patches
queued up already.  We'll need to discuss the future of it after 3.6, though.

Thanks,
Rafael
